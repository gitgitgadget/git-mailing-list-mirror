Return-Path: <SRS0=OLpm=ZL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653F9C432C0
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBE322419
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWYn3ywi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfKSXzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:55:35 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45320 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfKSXzf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 18:55:35 -0500
Received: by mail-pf1-f193.google.com with SMTP id z4so13206896pfn.12
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 15:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uVjlPm4JBgDmcrAyXP7uuBo7N3qIr+ork05MojMW6Fk=;
        b=VWYn3ywijEW5pt/Psl7kdDElnqd+3+19B14S2eOAtPjSoHsj/mywso0TK+l7+zNthT
         6bSaSNZWeLUOPx9Okgca6qWh6anE8wzm4LjA5Kge2gf5rssbC5zfgyKWQeGZ+Tl3EIcE
         BxBL52xmco5Hl0/mm7QSTtw+uEmARit9gDQsq5T9rDOz3ka3Bi3XJjk+2QmztkePutaf
         v0IVOUBhirR7mnPb/sxLtIaWJnrAXo3rmYnAvK5RIUygJK979GLEmJgf0vaEzJFeUwun
         DrzmRLQJDR7AiztGskw2+Zd3Xa9Zlv5QWKFaurXBKzHXzOlaHGqsJxGKLLcFmi5IsdF6
         r52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uVjlPm4JBgDmcrAyXP7uuBo7N3qIr+ork05MojMW6Fk=;
        b=UXHiJ+AlZXY9b4kssQftLr096O1A+23ys8QC1wHiHuegsjRQ3JKjHiV4WX1Ofs7SvX
         Dz7VCcW0Re0cU3BrmWcaJ9qhupJOkwf9oo9AOG021yR3Urv5Ee1ZXsxKrFBMBMWeDwvq
         U4BrOnIZZ28otYfeMWHUvoikZfySt92WgnJROw6JeYJw6eual1Ju0UDWh4DENlKAdKEY
         /p547DECedNlAOx7OgAHQd4Q9CCX64LtunTjmuO4qfnKGbNZw9MQTzDQys9ojanVs15O
         8YTt6Nrkzl+AdEMdC1eTn0mhDNW3VrgS7vXur46eWlwFYbeTLeYIS/qd6/amNvAW7QRS
         3/9w==
X-Gm-Message-State: APjAAAWfE6s8u/Lek/5MSq4Cd7tJKmlOeIb0ei+MlJlX+XoulKTJ71z/
        MqhGZq5hc15zF0B/2Zu4lsA2vuoE
X-Google-Smtp-Source: APXvYqxzq++NBH4OctJOvG4w8T9rLtNvC9iNPYgpdYhCgEGd2OAEQz6CC+zO4089baMpihy/p8Uxiw==
X-Received: by 2002:a63:e145:: with SMTP id h5mr8174106pgk.387.1574207734409;
        Tue, 19 Nov 2019 15:55:34 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id z62sm29906949pfz.135.2019.11.19.15.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 15:55:33 -0800 (PST)
Date:   Tue, 19 Nov 2019 15:55:32 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/8] rev-list-options.txt: remove reference to --show-notes
Message-ID: <e1b023a6fc2818f871e3033bd21f72a2de7b7a21.1574207673.git.liu.denton@gmail.com>
References: <cover.1574125554.git.liu.denton@gmail.com>
 <cover.1574207673.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574207673.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In ab18b2c0df ("log/pretty-options: Document --[no-]notes and deprecate
old notes options", 2011-03-30), the `--show-notes` option was
deprecated. However, this reference to it still remains. Change it to
reference the replacement option: `--notes`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/rev-list-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 90ff9e2bea..311bc06a9b 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -58,7 +58,7 @@ endif::git-rev-list[]
 	`--all-match`).
 ifndef::git-rev-list[]
 +
-When `--show-notes` is in effect, the message from the notes is
+When `--notes` is in effect, the message from the notes is
 matched as if it were part of the log message.
 endif::git-rev-list[]
 
-- 
2.24.0.420.g9ac4901264

