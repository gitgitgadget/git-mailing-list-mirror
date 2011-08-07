From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: test z$foo = zbar (and Re: [PATCH 1/3] bisect: relax requirement for a working tree.)
Date: Sun, 7 Aug 2011 15:04:59 +0200
Message-ID: <201108071505.00762.stefano.lattarini@gmail.com>
References: <1312714240-23647-1-git-send-email-jon.seymour@gmail.com> <1312714240-23647-2-git-send-email-jon.seymour@gmail.com> <20110807124150.GA20046@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 07 15:05:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq32d-0001Xr-MM
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 15:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735Ab1HGNFO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Aug 2011 09:05:14 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57928 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619Ab1HGNFN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Aug 2011 09:05:13 -0400
Received: by wwf5 with SMTP id 5so825670wwf.1
        for <git@vger.kernel.org>; Sun, 07 Aug 2011 06:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        bh=1gwiQz+EWHmAwR5aq4iKs+N9qJldudozgxeXCF8umdM=;
        b=OSj2Y9Q/QwTYjJa0w70utOhHpBLSjxQrUqAcQVPlXL7pKXdOvZslxDimupYLvaRAo6
         RgZ72XrEEy9y7bLJPPfrFuSyWt42TUyVVCFZc3Ow6DmW026GNsJmSWXs5D0GckFcI7on
         eeMgKZ8DILy6XVJVQwjCMQFWAjlUXrikYQ6+0=
Received: by 10.227.10.73 with SMTP id o9mr3091754wbo.6.1312722311501;
        Sun, 07 Aug 2011 06:05:11 -0700 (PDT)
Received: from bigio.localnet (host112-93-dynamic.7-79-r.retail.telecomitalia.it [79.7.93.112])
        by mx.google.com with ESMTPS id o19sm3737692wbh.9.2011.08.07.06.05.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 07 Aug 2011 06:05:10 -0700 (PDT)
User-Agent: KMail/1.13.3 (Linux/2.6.30-2-686; KDE/4.4.4; i686; ; )
In-Reply-To: <20110807124150.GA20046@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178910>

On Sunday 07 August 2011, Jonathan Nieder wrote:
> Am I the only one who finds this
>=20
> 	test "z$foo" =3D "zbar"
>=20
> style to be impossibly ugly?  It means every time someone considers
> using the "test" utility, they decide "is this expression likely to
> looks like an operator" and each time someone reads a use of the
> "test" utility, there is a lingering question of whether that choice
> was made correctly.  By contrast, if one follows the following simple
> rules, everything works fine with the shells git supports:
>=20
>  - _Do_ use the "z$foo" trick when using expr.
>  - Do not use test's '(', '),' -a and -o operators; use && and ||
>    instead.
>=20
> The Autoconf manual says
>=20
> 	Posix also says that =E2=80=98test ! "string"=E2=80=99, =E2=80=98tes=
t -n "string"=E2=80=99 and
> 	=E2=80=98test -z "string"=E2=80=99 work with any string, but many sh=
ells (such
> 	as Solaris, AIX 3.2, UNICOS 10.0.0.6, Digital Unix 4, etc.)
> 	get confused if string looks like an operator:
>=20
> Notice that none of the mentioned shells is close enough to POSIX eve=
n
> to support $( / ).  This is an area in which early POSIX work improve=
d
> shells immensely (the "-e" primary was introduced around the same
> time).
>
While this is true, some problems with the `test' builtin persists also
with in more "posixy" shells.  For example, with Solaris /bin/ksh and
/usr/xpg4/bin/sh (the latter expected to be the default POSIX-compliant
shell on the system, since as you've noticed /bin/sh is defintely not
compliant there), one sees:

  $ /usr/xpg4/bin/sh -c 'test -z ")"'; echo $?
  0
  $ /bin/ksh -c 'test -z ")"'; echo $?
  0

This will be documented in the next version of the Autoconf manual BTW.

Regards,
  Stefano
