From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Re* [GIT PULL] sh updates for 2.6.25
Date: Wed, 16 Apr 2008 22:22:18 +0200
Message-ID: <200804162222.18827.jnareb@gmail.com>
References: <20080415172333.GA29489@linux-sh.org> <20080416084435.GJ8387@genesis.frugalware.org> <7v3aplr2pt.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 22:32:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmE9s-0006QZ-6f
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 22:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbYDPUWX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Apr 2008 16:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbYDPUWX
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 16:22:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:43765 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbYDPUWW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 16:22:22 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2548893fgb.17
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 13:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=9GreUIm/uyEnQcZ0oLSb2EX4iE9t3x/r6RlSNgTB7Wg=;
        b=SrjoTrF8E9POE5XPqFfQKbKjRN/Wu91Kkb6k7ja8ru3APClLsPR5vh0l4lIuH6Li8emFHqTfza/NuX7pk0AVtCOW2NO1ynA0CnqNUu6aYPqnsBg90rMaOIfYOejyYmUZnW7SrDKhl4DMiidLrcoXyy10XRnIN9Cs+yXdMX/FY8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lA9ocHiur7z42C5qSouTdu1ARFkZmuvv0zdWp0WclbCIRAfKbzw/K7iXFLKc8HyaOVtDugm/j7Obh1x3dTjlleK16MToVvzrRobuvjBCZIY9VrRs8Fu/af9S4ujjmLm+AWA5eYEEFhE1NUkhaQH20dBJImNR3IVbpTLsBVO+t+M=
Received: by 10.86.4.2 with SMTP id 2mr839815fgd.49.1208377341224;
        Wed, 16 Apr 2008 13:22:21 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.234.183])
        by mx.google.com with ESMTPS id z33sm13839998ikz.0.2008.04.16.13.22.17
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Apr 2008 13:22:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v3aplr2pt.fsf_-_@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79744>

Junio C Hamano wrote:
[cut]

> So in short, when you use "am", it by design unfolds the "Subject: " =
line
> and there is no bug there. =A0"rebase" being implemented in terms of
> "format-patch piped to am" does mangle the message because of this, b=
ut
> if anything that is a bug in rebase, and not "am".
>=20
> And this is a potential fix to the issue, which was made possible onl=
y
> because recently "rebase" started passing an extra option to "am".
>=20
> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Wed, 16 Apr 2008 12:50:48 -0700
> Subject: [PATCH] rebase: do not munge commit log message
>=20
> Traditionally git-rebase was implemented in terms of "format-patch" p=
iped
> to "am -3", to strike balance between speed (because it avoids a rath=
er
> expensive read-tree/merge-recursive machinery most of the time) and
> flexibility (the magic "-3" allows it to fall back to 3-way merge as
> necessary). =A0However, this combination has one flaw when dealing wi=
th a
> nonstandard commit log message format that has more than one lines in=
 the
> first paragraph, because such a "first line" is formatted as logicall=
y a
> single line, and unfolded at the applying end.
>=20
> This teaches "git am --rebasing" to take advantage of the fact that t=
he
> mbox message "git rebase" prepares for it records the original commit
> object name, and that such a commit _is_ available locally. =A0It rea=
ds the
> log message from the original commit object instead.

IIRC there was alternate patch which made git-format-patch to add extra
email header meant for git-am to "obey the (encoded) commit message
formatting."

But this solution is simpler, and I think better.

--=20
Jakub Narebski
Poland
