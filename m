From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/43] check-ref-format: use RUN_SETUP_GENTLY
Date: Mon,  5 Apr 2010 20:40:55 +0200
Message-ID: <1270492888-26589-11-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:42:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrFg-0005ZJ-FI
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755825Ab0DESmO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:42:14 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:62876 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755930Ab0DESmI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:42:08 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1250782fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=0jkmoP2Vw+uHLloeMggKyrmKbK3SoA3wAMfN0zQo7zY=;
        b=L7sXMQGbK1/dgQ5JDXO2aIcCVCbl2adQNR6AsFk4io5P4QwN2w9rrcuJIYD4UzMUh7
         8vGApZicQiuAMYlks7QxXACNe8b4cq5YkiQrEHVBKqdiW0Rf54bxLKx2u2MR0t63Dmj2
         KhMbTmu1Ns5wOsE0dgWOsj2excWEE+IiuVTdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Elg7G0I4tpkxncVXYfYOdEfdOm53yy1YcgL4epnuiFxUIV6OwotzYh+PmOxh+1epai
         p5ilh+2skcCnsoxPtlE4ZVV7jRp/tRivOwYRS5ZF4/wjeaIR94XOGtO6N1kl0FIEo7bT
         UxXIbRpJmxXn8ctlubkBI9xjLR/8LrCPUHVFc=
Received: by 10.86.124.35 with SMTP id w35mr9431001fgc.49.1270492927185;
        Mon, 05 Apr 2010 11:42:07 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id 13sm2834690fks.30.2010.04.05.11.42.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:42:06 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:42:04 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144012>

When --branch is used, check-ref-format will look into repository for
branch name. Therefore repository search is needed.

The call flow is:
 - cmd_check_ref_format
 - strbuf_check_branch_ref
 - strbuf_branchname
 - interpret_branch_name
 - branch_get
 - read_config
 - resolve_ref

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 326f7c7..a8660f4 100644
--- a/git.c
+++ b/git.c
@@ -304,7 +304,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
 		{ "checkout-index", cmd_checkout_index,
 			RUN_SETUP | NEED_WORK_TREE},
-		{ "check-ref-format", cmd_check_ref_format },
+		{ "check-ref-format", cmd_check_ref_format, RUN_SETUP_GENTLY },
 		{ "check-attr", cmd_check_attr, RUN_SETUP },
 		{ "cherry", cmd_cherry, RUN_SETUP },
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
--=20
1.7.0.rc1.541.g2da82.dirty
