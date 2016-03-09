From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 05/48] builtin/apply: move 'options' variable into cmd_apply()
Date: Wed,  9 Mar 2016 18:48:33 +0100
Message-ID: <1457545756-20616-6-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:52:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiHT-0007US-4M
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933651AbcCIRwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:52:16 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35366 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933576AbcCIRwN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:52:13 -0500
Received: by mail-wm0-f48.google.com with SMTP id l68so190190412wml.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DhvF7NQxoioOs9Vr6i07pRvTZks6hyX3q0X/WoFTO0Q=;
        b=veJyOxqu6hBaW5t2gBmaqHQMuf8JinDltB5tl4tgb3YujeWRzwws1z1cLVQWzodCQ6
         WjTtbVvhK4u+JiV/OuqSehgOtAtqA7GUbFwzKkyNxNLPAb8BZI95KijZQPMHFaVukdSN
         7tzFS/PGjanTPFJMPtJ+yAdMW7+pmZH2vRkgLLcV+qHskO1kgxTThFUXPJoNIJfRvYXp
         joTtz80d2cdTySgFU2KnlG3I1UgRWlO8fWPaXhB0zHLZgchrnsXvGJ8AoNOFnX8E7up+
         JOu+RiSQ1OI8I4kJ4CBDFyg2LESX0Es693xkrcR4Qc6Oq8imLGMaNm3Bnlkj6dRhayb0
         0P5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DhvF7NQxoioOs9Vr6i07pRvTZks6hyX3q0X/WoFTO0Q=;
        b=PgHXRUmGpeXyytgni5icosDE6cJEyxnObz4vdyNepBJ/QzJ1ojr3Gv2hQt2NjhXVeY
         JEQcj6ggBxZDvyLnmY1dKecMoOU3BQyRaA2d/QdcOz7AVRDEzY0UUnsstoE3+sSxZESc
         K8joemIzkHBPBJuWGrhDzP45dr0mYxQ1p7X4BqDLLVfa1GT8YPFZpOK0e9lWzHjWVJKI
         GD75x9aVzmigj1bLKWA+7GQlzlvk66liSfCaRwWe2/Ka1XXBnr84O319YYJzvPHqUzEN
         dEc5+DX1JryFOi7nEu7wkEQB9i4WAI8aV6ujNgHjfOSDSQ8heGStSlIQ6KufXQgZeoz4
         RFrw==
X-Gm-Message-State: AD7BkJLZkkzNi8jDj0FY2/Ysr+2P6NPCK59ofukchrdn/CCU1W0yMno9IFBWrxAuXtEJbw==
X-Received: by 10.28.146.209 with SMTP id u200mr331848wmd.59.1457545931823;
        Wed, 09 Mar 2016 09:52:11 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.52.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:10 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288493>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 7d7a8ab..838e46a 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -79,7 +79,6 @@ static enum ws_ignore {
 static const char *patch_input_file;
 static struct strbuf root = STRBUF_INIT;
 static int read_stdin = 1;
-static int options;
 
 static void parse_whitespace_option(const char *option)
 {
@@ -4516,6 +4515,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	int errs = 0;
 	int is_not_gitdir = !startup_info->have_repository;
 	int force_apply = 0;
+	int options = 0;
 
 	const char *whitespace_option = NULL;
 
-- 
2.8.0.rc1.49.gca61272
