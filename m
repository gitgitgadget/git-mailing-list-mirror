From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/4] commit: reload cache properly
Date: Thu, 30 May 2013 06:58:53 -0500
Message-ID: <1369915136-4248-2-git-send-email-felipe.contreras@gmail.com>
References: <1369915136-4248-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 14:00:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui1XG-0001Ib-7T
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 14:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633Ab3E3MAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 08:00:44 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:62102 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab3E3MAn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 08:00:43 -0400
Received: by mail-yh0-f45.google.com with SMTP id z6so24436yhz.18
        for <git@vger.kernel.org>; Thu, 30 May 2013 05:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=olFSwv/nkq792pnjQSFrCFe5qar2JpuKc6K+5b98A7s=;
        b=PMYPBBKiL09XmiurcIxQa0X5pQzpj8oACdGfpPMDeVyEpahq/UhALpCIa5OxuI3J8Q
         UrI6lzvszJV8gMoWEdf1J+K68XljHdoKKgRUEiAVH4MF04JgzvLPb1PnlB1ZdxYBitHW
         vQ9CxUu/bnkLwKf9A7IBJOCmMBiTGn34CktebxhvR3h3DIRRPV7yIXFOilLX8NnbzodK
         VhXR+02WvZwawTYxpU4iEEC9Y/SddjblTUltGhQwZkM57usNbYjPs2Q1rgWtaAZJmsYk
         WS5EE7fLEAmzJKC1c+qSIBIJMawq9UWqr53JZtxDFAJYC9/lMFSH+iIBoM/HXuHMn+lS
         FzNg==
X-Received: by 10.236.135.206 with SMTP id u54mr3488074yhi.31.1369915242196;
        Thu, 30 May 2013 05:00:42 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id y24sm59371183yhn.20.2013.05.30.05.00.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 05:00:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369915136-4248-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225969>

We are supposedly adding files, to to which cache if 'the_index' is
discarded?

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/commit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index d2f30d9..092b49e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -244,6 +244,8 @@ static void create_base_index(const struct commit *current_head)
 
 	if (!current_head) {
 		discard_cache();
+		if (read_cache() < 0)
+			die(_("cannot read the index"));
 		return;
 	}
 
-- 
1.8.3.rc3.312.g47657de
