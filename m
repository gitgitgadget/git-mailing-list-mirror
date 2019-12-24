Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A8BC2D0CF
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BE920643
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bc1WNmEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfLXLGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:06:08 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37554 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfLXLGC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 06:06:02 -0500
Received: by mail-qv1-f68.google.com with SMTP id f16so7361615qvi.4
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 03:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Orhsbl7UW5kzoTvVCex4pVPAyfm4BNosFr2OoqF3ox4=;
        b=Bc1WNmEdqVGr6g2H5Hdtli4g30gMLuUEEhPF6KKHH0rUYIH5I4GHLtOTs7Yex8cy5n
         NfGOgOU9UznjfxpYNvIUY5HcDmp9daovhx50U3CbTBVz4t2bTqBgZHmbzBsRnRocGmuz
         5hCRigy/v4g+DeOv805grpxx179j+/O/O9lJ4wdH0TDBmym4dbFu234T7Gwn1UQHk6hS
         coiqaLynOVkEJjxKCuyiBSG5OkO2lrwAwoH82TU6nllG3Rhf4FsqR0xpT+TqZIvOItc0
         t9kq0d99aFD9aaHeeOEuCf7eM6/HCG90Teoji6376ygv2JqZXzMmEevDmKPnddciKJfw
         R/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Orhsbl7UW5kzoTvVCex4pVPAyfm4BNosFr2OoqF3ox4=;
        b=j/grJTuh3S/gWFCK9dbCOWX/dPQGgloW+eDrI1dz1NO0BV3nh5Zu169lAnEtgN6VMB
         h2iOvk3YVroQe+qvsZwzuMhUMy0Rh7wi5lgKuKcc6TfitkFthnqubYQwfYjYxlqn0/Sf
         0Rwr+ycqvWd3wM9+/jjOhDZ9/ReNK13DUMytOurqx5X/1h/Ki9Tucg2YAaF/yZaXb2ng
         qllDDY/JGMm4ktctooIAdTVRIfHcIM4qVK6D/Ghvvdrubg+EKjktFPbqQ5HwdyDo5cWy
         KMXtrOitYwlAe/ZP3OOjq5mkCvVZuQVXMRcw11+sm3aANgdGaGvfAvoo2rE7xrHFhKu+
         Q/Qg==
X-Gm-Message-State: APjAAAUUqD7Bcrn0vBt4yNE2fQS7S93edhcQg+a1X/Hv95qlYKWxZ98p
        cwc6Xg5V1OxcIDrK4rQW+aIO1Qs0
X-Google-Smtp-Source: APXvYqx0MVaT0LgrfFl1gyUMNPxnBa2RT6CJjuDa5Mmioa8XO7eCqZy7jfRUE8sLG7sBhosMVtjFMw==
X-Received: by 2002:a0c:ef0f:: with SMTP id t15mr28475374qvr.123.1577185559703;
        Tue, 24 Dec 2019 03:05:59 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id o19sm7446944qtb.43.2019.12.24.03.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 03:05:59 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 14/17] sequencer: unlink autostash in apply_autostash()
Date:   Tue, 24 Dec 2019 06:05:11 -0500
Message-Id: <2b167116802c7130e4cdecd0ecd5df501fe9a6e0.1577185374.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577185374.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com> <cover.1577185374.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Explicitly remove autostash file in apply_autostash() once it has been
applied successfully.

This is currently a no-op because the only users of this function will unlink
the state (including the autostash file) after this function runs.
However, in the future, we will introduce a user of the function that
does not explicitly remove the state so we do it here.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sequencer.c b/sequencer.c
index ba04ee2de8..cc0391ca35 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3834,6 +3834,7 @@ int apply_autostash(const char *path)
 				  " \"git stash drop\" at any time.\n"));
 	}
 
+	unlink(path);
 	strbuf_release(&stash_sha1);
 	return ret;
 }
-- 
2.24.1.810.g65a2f617f4

