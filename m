From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 15/16] send-email: make_message_id use "require" instead of "use"
Date: Thu, 30 Sep 2010 13:43:08 +0000
Message-ID: <1285854189-10240-16-git-send-email-avarab@gmail.com>
References: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ryan Anderson <rda@google.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 15:45:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1JRY-0001Uu-P8
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 15:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756096Ab0I3Nou convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 09:44:50 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42011 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078Ab0I3Nor (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 09:44:47 -0400
Received: by mail-wy0-f174.google.com with SMTP id 28so1858034wyb.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 06:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=AF7/Tgce9LXa1wH2t6wNavaEmkIYawDUv+sAUp+NrUM=;
        b=OLKw+msTEA0gycHef6s+84YTLsJJF01FARMMp6JPB9OxTjfz3E2jr/hp0VtxVYl/CZ
         f0zkwUPRLFQzOBpgTbpiJlPAo8jgPZew5zWoN4mSUhWO6SQVhWPNnXu/Jle8AhgJY0yA
         KxSAiOFbnUWfnCLAgdOZM++BEk85igcMm+CEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=LwAVqN2XTkcm7x1inewA7M7MiViqTpX3NwaJmgh2BttlNyWVxLxnfgc63KJhOmQNzg
         YwSexrpU1gJb4lnoT3NYRVR5odE8Jdvjl1Km0j0+/z0l3gnVPQRT94dy8vX1ngYPLZY6
         mLElCq9TD5GdkQ3N3W/frJJjNuW1URiZCeuKA=
Received: by 10.227.136.69 with SMTP id q5mr2926120wbt.202.1285854286741;
        Thu, 30 Sep 2010 06:44:46 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e56sm6328567wer.46.2010.09.30.06.44.45
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 06:44:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157665>

Change the use of Sys::Hostname from a "use" to a "require". The
former happens in an implicit BEGIN block and is thus immune from the
if block it's contained in, so it's always loaded.

This should speed up the invocation of git-send-email by a few
milliseconds.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 9cb6aa6..5a19d3d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -819,7 +819,7 @@ sub make_message_id {
 		last if (defined $du_part and $du_part ne '');
 	}
 	if (not defined $du_part or $du_part eq '') {
-		use Sys::Hostname qw();
+		require Sys::Hostname;
 		$du_part =3D 'user@' . Sys::Hostname::hostname();
 	}
 	my $message_id_template =3D "<%s-git-send-email-%s>";
--=20
1.7.3.159.g610493
