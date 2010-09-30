From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 14/16] send-email: send_message die on $!, not $?
Date: Thu, 30 Sep 2010 13:43:07 +0000
Message-ID: <1285854189-10240-15-git-send-email-avarab@gmail.com>
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
	id 1P1JRY-0001Uu-8Q
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 15:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756093Ab0I3Nop convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 09:44:45 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56177 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078Ab0I3Nop (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 09:44:45 -0400
Received: by ewy23 with SMTP id 23so718253ewy.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 06:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=wIViLyYf2oJgpldrjyqJG64eRK/fEYMwFx/ytJ7ugXw=;
        b=lBnJdSMFrC6HTCamvuLP2crVOCiMwuhMSP07g0Ika8bhShZGEvnxp5HMGfS+4FZaVb
         AJu8kS5cQS6Mhmo5uQTTwgrixFQIhlu/dUGVopjYBvr3dHqO+TIY71fpXPqybD2etdO+
         UzPI4tF2wJetF5uKyUKPr/rssosSaba1dDQPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qPwZoh9UgOQsHi869BwC7TD/lgzXlHuU459/hwKfXVGXXihT/GjrNzIhPvv5qaxN2D
         VVk42hX6dVS9HBOJHti8eYuNUmfSeqspCGln/9JuOhkt91MR6NeDtOhM4JJAwsqQRrX/
         kv2a9BTDHEzck9wH7cLPN6PbG2cVZKPXrf1Vs=
Received: by 10.216.159.129 with SMTP id s1mr3016123wek.42.1285854283813;
        Thu, 30 Sep 2010 06:44:43 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e56sm6328567wer.46.2010.09.30.06.44.42
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 06:44:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157663>

If close fails we want to emit errno, not the return code of whatever
happened to be the child process run.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 47d86ad..9cb6aa6 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1035,7 +1035,7 @@ X-Mailer: git-send-email $gitversion
 			exec($smtp_server, @sendmail_parameters) or die $!;
 		}
 		print $sm "$header\n$message";
-		close $sm or die $?;
+		close $sm or die $!;
 	} else {
=20
 		if (!defined $smtp_server) {
--=20
1.7.3.159.g610493
