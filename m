From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2/pu] perl/Makefile: Unset INSTALL_BASE when making perl.mak
Date: Thu, 12 Aug 2010 02:48:40 +0000
Message-ID: <1281581320-4235-1-git-send-email-avarab@gmail.com>
References: <1280831411-4511-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 12 04:48:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjNqe-0008Ao-Cv
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 04:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759437Ab0HLCsr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 22:48:47 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:32987 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759385Ab0HLCsq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 22:48:46 -0400
Received: by wyb32 with SMTP id 32so876983wyb.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 19:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=zrm0d8hs7Lyv3hnAl6TD98L+zCp6LdPVq4XElPFOFGw=;
        b=GGzqh0pSthymTipGUTp/Kn4HW2Nx6qN1/ZkZDpUS1XRyjWA0lQLwQiOAzKsGjPcR0m
         v9S3wRhBs80X8x+CLkh9w8ADQyEGiaQ0sW758T9xXpFV2dx8VDjlfMQRYXzPk+BSb4fX
         kWsTzm27DJVU00UAuWxk+qi5pimdD3yl5+xYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xwbayJaNNlbmsgQ8+ctTrkdK4GVQ2ecgoTBBdPzNi2dt9vdic2rBsKZL64GHvnqjqs
         GbAW0mz/VmqqhEdjRrK1UV30yE7075vDMexubKuYyehcwC3/EUCtccK8xnPgizr6X2a/
         WwLIVV5Bcc05yrxfF35uVbSo8dZ/fQG0scj7k=
Received: by 10.227.142.84 with SMTP id p20mr17426234wbu.182.1281581325179;
        Wed, 11 Aug 2010 19:48:45 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id a1sm746400wbb.2.2010.08.11.19.48.44
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 19:48:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.327.gfb40
In-Reply-To: <1280831411-4511-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153327>

PREFIX and INSTALL_BASE are mutually exclusive. If both are supplied
by INSTALL_BASE being set in PERL_MM_OPT ExtUtils::MakeMaker will
produce an error:

    $ echo $PERL_MM_OPT
    INSTALL_BASE=3D/home/avar/perl5
    $ make -C perl  PERL_PATH=3D'/usr/bin/perl' prefix=3D'/home/avar' p=
erl.mak
    make: Entering directory `/home/avar/g/git/perl'
    /usr/bin/perl Makefile.PL PREFIX=3D'/home/avar'
    Only one of PREFIX or INSTALL_BASE can be given.  Not both.
    make: *** [perl.mak] Error 255
    make: Leaving directory `/home/avar/g/git/perl'

Change the perl Makefile to work around this by explicitly unsetting
INSTALL_BASE.

INSTALL_BASE is set in PERL_MM_OPT by e.g. the popular local::lib
package, from its documentation:

    eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib 2>/dev/null)

Many other environments might also have set PERL_MM_OPT before
building Git. This change enables us to build in these environments.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

Here's a patch on top of pu instead. This change conflicted with the
gettext series.

 perl/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/perl/Makefile b/perl/Makefile
index 4e624ff..b2977cd 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -39,7 +39,7 @@ $(makfile): ../GIT-CFLAGS Makefile
 	echo '	echo $(instdir_SQ)' >> $@
 else
 $(makfile): Makefile.PL ../GIT-CFLAGS
-	$(PERL_PATH) $< PREFIX=3D'$(prefix_SQ)' --localedir=3D'$(localedir_SQ=
)'
+	$(PERL_PATH) $< PREFIX=3D'$(prefix_SQ)' INSTALL_BASE=3D'' --localedir=
=3D'$(localedir_SQ)'
 endif
=20
 # this is just added comfort for calling make directly in perl dir
--=20
1.7.2.1.327.gfb40
