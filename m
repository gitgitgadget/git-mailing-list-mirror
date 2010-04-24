From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Sat, 24 Apr 2010 16:40:25 -0500
Message-ID: <20100424214024.GA8044@progeny.tock>
References: <20100422155806.GC4801@progeny.tock>
 <87wrvzs590.fsf@frosties.localdomain>
 <alpine.LFD.2.00.1004221445310.7232@xanadu.home>
 <87sk6n4426.fsf@frosties.localdomain>
 <alpine.LFD.2.00.1004221651590.7232@xanadu.home>
 <87vdbitu9v.fsf@frosties.localdomain>
 <25441792-181D-456D-8182-F33B49209EFF@wincent.com>
 <87aastx6sa.fsf@frosties.localdomain>
 <alpine.LFD.2.00.1004231639180.7232@xanadu.home>
 <8739yktuvs.fsf@frosties.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Wincent Colaiuta <win@wincent.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Goswin von Brederlow <goswin-v-b@web.de>
X-From: git-owner@vger.kernel.org Sat Apr 24 23:39:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5n4u-00075p-Er
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 23:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838Ab0DXVjv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 17:39:51 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:61729 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228Ab0DXVju (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 17:39:50 -0400
Received: by ywh32 with SMTP id 32so6411843ywh.33
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 14:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=mINgZXkWh+VErYYZ5DTwSCIUu1VMWDSc99S3j+ihjAk=;
        b=oJhejI5pW4YLr6ehcncPAhPhobDQyTOariAo7KRAdHfnTu4G+rQJR5KHDzYw6cfvX7
         Vl2MMCvTsc0sfQGFSc8QHJH7R8m4cM+9DygamVYvhJKAp2CO+ie2Zp52THl2WaKQmnXd
         QJGOR9G6pBsWZx4U2yiqT65sdaCXMb3NCbJow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Uj/kv6ypO6EBEW99oUu8gedDJ2VDBeHdaBdjnPBq8k6XjmZGV4f40DYx6rW3PTCTVB
         O2jAcvTabt47Gj/XMjhGSkhfCBkdv4hMPoBVTcuCNQxgrw3ifBE42xrvfh0NsbZRlXQ4
         wjPK2LqY06+ESd5a4qg9LAWTDQn8wr3MOkatY=
Received: by 10.150.94.3 with SMTP id r3mr1894446ybb.13.1272145189556;
        Sat, 24 Apr 2010 14:39:49 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm1791157iwn.0.2010.04.24.14.39.48
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 14:39:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8739yktuvs.fsf@frosties.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145706>

Hi again,

Goswin von Brederlow wrote:

> so far two people have suggested an alias
> for this and both have completly failed to achived the desired result=
=2E

I had thought Adam already suggested using =E2=80=98git diff-index --ca=
ched
--quiet HEAD=E2=80=99 [1].

You can do so like this:

cat <<-EOF >$HOME/bin/git-ci
#!/bin/sh
cleanindex() { git diff-index --cached --quiet HEAD; }

if test "$1" !=3D "-h"
then
	echo >&2 usage: git ci &&
	exit 129
fi
if test "$#" !=3D 0
then
	echo >&2 Please use git commit directly.
	if cleanindex
	then
		echo >&2 '(no staged changes)'
	else
		git diff --cached --name-status
	fi
	exit 129
fi
if cleanindex
then
	exec git commit -a
else
	exec git commit
fi
EOF
chmod +x $HOME/bin/git-ci

But dense as I am, I still can=E2=80=99t imagine why

echo '[alias] ci =3D commit -a' >>$HOME/.gitconfig

wouldn=E2=80=99t be better in every way (especially if Jakub=E2=80=99s
commit.preserveindex is enabled).

> If you know of a test to check if an index exists or not, preferably =
one
> that does consider new files being added or files being removed as
> "index exists", then please do speak up.

test -e .git/index

I know, not what you meant.  But the condition you are looking for is
=E2=80=9Cstaged content does not match the last commit=E2=80=9D, not =E2=
=80=9Cthe tool has
suddenly entered a different mode=E2=80=9D.

Hope that helps,
Jonathan

[1] Well, he did:
http://thread.gmane.org/gmane.linux.debian.devel.bugs.general/698001/fo=
cus=3D145581
