From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: global hooks - once again
Date: Fri, 2 Jul 2010 15:53:49 -0500
Message-ID: <20100702205348.GA8134@burratino>
References: <AANLkTikXJS5QCXMXgsOfkYn9cMBQV6o23tds5YG3A_OI@mail.gmail.com>
 <7v630x1yl8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 22:54:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUnFk-0004W3-4Z
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 22:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757030Ab0GBUyV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 16:54:21 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51657 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756401Ab0GBUyU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 16:54:20 -0400
Received: by iwn7 with SMTP id 7so3644593iwn.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 13:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4OcDbX1HfQ5fmzIyPkDSqZQQceI5O0Ro08yFeBxJjY0=;
        b=bvT1DZrjOnl7YLDORBF9JK8GVZAHHDwxJ0eVj7aszY6HpPwG7TBoFXE/ZkWz1QjRWT
         4gJO4YuWyVivVlzimLn9fgEKdbcM1Av9vp+eEZlQMM9p5in0ZUpwwm0RMfAEnbq8MCUi
         iGqjx64vpAzYBnw4EuEKSmmA3i13a02Hw8NAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=n2VQrfdOomn3Q0uNFg+xxHGmUbpwhjuHeui/xV+IPwTVdYJTL2o5L5csKb/7iLKQ1F
         cZ9VTacO/mxczjkaZFQOyWWdUaoOaiBn1+jDcV0NL808eIqmVeBvp/rjhc53Lo/H7byv
         HDQ6/7+lURq+XI96n7iYfB0wpxbDJ0PDwNmEk=
Received: by 10.231.161.68 with SMTP id q4mr1387429ibx.76.1278104059065;
        Fri, 02 Jul 2010 13:54:19 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm4656335ibk.21.2010.07.02.13.54.18
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 13:54:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v630x1yl8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150164>

Junio C Hamano wrote:

> Now, as long as the "do once per repository" action that you need to =
do is
> simple enough, it doesn't necessarily have to be "git config".  Perha=
ps
>=20
>     [alias]
>     set-hooks =3D !"sh -c 'rm -fr .git/hooks && ln -s $1 .git/hooks' =
-"

It is not difficult to set up hook scripts when initializing a
repository.  In fact git clone --template=3D and the =E2=80=9C[init]
templatedir=E2=80=9D configuration work pretty well.  What is more diff=
icult
is to change the list of hook scripts later.

If I symlink the entire hooks dir like you describe, I cannot override
a couple of hooks per-repository without teaching the hook scripts to
handle that themselves.  (something like:

	hook=3D$(basename "$0")
	! test -e "$GIT_DIR/local-hooks/$hook.disable" || exit 0
	! test -e "$GIT_DIR/local-hooks/$hook" ||
		exec "$GIT_DIR/local-hooks/$hook"

)  Maybe that is the simplest solution.
