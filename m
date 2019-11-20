Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C470FC432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0BB2245B
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0WziuK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfKTAv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:51:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34134 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfKTAv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 19:51:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id n13so13312528pff.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 16:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uIk0AuEf51FJ19lDn9HIZlidRidM0qjcDi4gTEZfexs=;
        b=d0WziuK4rfF3OnZkBVz6dgLVMXBfsa9ugwvI08FwtDg20hJeOpNXJXS4nnniYGPJA+
         +j1b4Yi5VaG6WIMkVgb7pSYF3wqyjCAVC79yEmHGuEJqlABKTH+p/Gbe6dI30Xun5f06
         kIRBJ0vsbwyhfIk7o0nv2zZlMYGQXOM2nYq4Hwa9Do9T9pf8O5cURO2LEcSzrZntmYxZ
         Wh2lPqg9qbAAzMjN8/bW9yhkVGmWTG78AJK9LsmwqOktt4VFdIVoDBgpfxN9G9e1a84e
         RTj29T1vlkqE1ydw7rcZIuiEGjNS7Gz57h9FFqjAnnJzVGQobxXCeM5nBgnWciUqHNBt
         bVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uIk0AuEf51FJ19lDn9HIZlidRidM0qjcDi4gTEZfexs=;
        b=dtsG/Cimu7Q7/hQlzI5VtVoqe8uiquttbeDIBYgBptli/dhzYxayxHGWyU8QNNegLe
         W5iBkGA2jZRIbZYulbPTowxAIvdNfyUgR1yh5+a87ADtinz4fQUyQe3ql/OPOA0b2C+L
         8eWheIz5cLyixnDZPYa2vYI800Fwtcv4f2euyyeoPsQP3NQOQR69bCAhzhNT4fLRHtH2
         k3gaRaf2wawbZBZP2VU61WYGxIuoFCLpjf6w/pxRjKn5qT6lt/gXfMZb08IWJFlJvWPr
         Tt/nTWkDr8KniiTxaqT1VSb9xwYPY36l06fbEXIUiVw7exaSC6k5OOjh0Nh0lCleTl5e
         JxAg==
X-Gm-Message-State: APjAAAWsgMfES0jLAJXAA/0JcoVPWfjVr16Y67920fKDsSRfzIeJa1RZ
        35o93OFvM0UrNkamsPJjBz2pDTqh
X-Google-Smtp-Source: APXvYqxgoS5LzebZeek7SwVBW+5siCMmSUkk2gVtSgP592TTrEpuzupisPIZNKIFX+xBq180WChiMw==
X-Received: by 2002:a62:ce41:: with SMTP id y62mr631602pfg.34.1574211085542;
        Tue, 19 Nov 2019 16:51:25 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id h185sm11127750pgc.87.2019.11.19.16.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 16:51:25 -0800 (PST)
Date:   Tue, 19 Nov 2019 16:51:23 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v5 09/11] pretty: add struct
 cmt_fmt_map::default_date_mode_type
Message-ID: <ec05907b6202b07733c02ca4af55de2d01681b7e.1574211027.git.liu.denton@gmail.com>
References: <cover.1574122784.git.liu.denton@gmail.com>
 <cover.1574211027.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574211027.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, we plan on having a pretty format which will use a
default date format unless otherwise overidden. Add support for this by
adding a `default_date_mode_type` member in `struct cmt_fmt_map`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 pretty.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/pretty.c b/pretty.c
index 61014cc25a..63fa600276 100644
--- a/pretty.c
+++ b/pretty.c
@@ -20,6 +20,7 @@ static struct cmt_fmt_map {
 	int is_tformat;
 	int expand_tabs_in_log;
 	int is_alias;
+	enum date_mode_type default_date_mode_type;
 	const char *user_format;
 } *commit_formats;
 static size_t builtin_formats_len;
@@ -181,6 +182,8 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 	rev->commit_format = commit_format->format;
 	rev->use_terminator = commit_format->is_tformat;
 	rev->expand_tabs_in_log_default = commit_format->expand_tabs_in_log;
+	if (!rev->date_mode_explicit && commit_format->default_date_mode_type)
+		rev->date_mode.type = commit_format->default_date_mode_type;
 	if (commit_format->format == CMIT_FMT_USERFORMAT) {
 		save_user_format(rev, commit_format->user_format,
 				 commit_format->is_tformat);
-- 
2.24.0.420.g9ac4901264

