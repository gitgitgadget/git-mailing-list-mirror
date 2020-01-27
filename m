Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05DEC2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 14:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DC920716
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 14:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WX0BWIdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgA0OWc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:22:32 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:53695 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0OWb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 09:22:31 -0500
Received: by mail-wm1-f45.google.com with SMTP id s10so3427081wmh.3
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 06:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YFhfrmiz1MnC+KIqE9EAXW0EFA0b04wlw/SNyc4qGWA=;
        b=WX0BWIdCT0u9LxDmJEnFO4Er6mCD0VOWNsf+rswUZhb6jJMs6fU8U1aOGD+RjWfDK9
         ZUIEa5L6xifbTuuYE6aMN2jB4JEGvyH+IAaumHzYU9uoH4J4q8B1y3VvmrI7/Eb5bSI9
         bB1ItkVSIyTlzvY4SvI3DC38pW5+ASCOquPBUDlMovt9MEuv4p0RE6otFXlh9Oc6fI2p
         JMR5YqcHcjrQbt1SNdKcKfp3v7r0ahW1C9Prl5MgNTP7/bJQk1duXu0j3m+0P7Xsn22Q
         Fem4D0uHaqGvP4H3GZy9gocu+UsIt68nqAmKnwruYio/nFJ3Ve6hCWSYAEFu1FA+IU0r
         N5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YFhfrmiz1MnC+KIqE9EAXW0EFA0b04wlw/SNyc4qGWA=;
        b=IzhsZ3zICLDBuMvRxzIXyMwbiIAZeBwQFSl35siJ6f1hA91lQXj1isAS9IpKIBh4Zn
         TFNYrw1Z8Ww87laTNZqz4i6xwiblzOqdWJVy1iDc5aAOjkJdlU1twIIHDn7UaiCb64uc
         T/kldB/FfwVXYUMcRpa7H0pULyfgOYRGEKBVRZRSPdzxZg2fJVapw/mp9e232cTfcemw
         2vm86n3hdt6utrOew+DlXl2Aiy+aXS9JadLAZkP2zf9svEIvZ5SO5ymzP/Jd8PhByPzS
         +woiYXqJ2vvBPWsKQvODKIsrKRE5JTKn1MrVf0fBWpKWSCA3ZO+JWWJ2ETqy1gHxE4eX
         eFLw==
X-Gm-Message-State: APjAAAUiVlzpeX27xjwL1mlSQBpR1cqIJpWLLp7wt+uetGj01yg2kXyk
        d0bxZXRq0ska1Jhn5kNQ7k0eMsfQ
X-Google-Smtp-Source: APXvYqw2f445YSV5dlodJ1pK2ouT4IGXhd8kHfMMs5axauJaCZZx3G7Je/VslSoHcxiY6JVGAGuVaQ==
X-Received: by 2002:a05:600c:54b:: with SMTP id k11mr14095879wmc.63.1580134949085;
        Mon, 27 Jan 2020 06:22:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z21sm19952561wml.5.2020.01.27.06.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 06:22:28 -0800 (PST)
Message-Id: <9cf185b51f45f2df0016d7b69351ec2a7656dac2.1580134944.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
        <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jan 2020 14:22:22 +0000
Subject: [PATCH v2 3/5] Document how ref iterators and symrefs interact
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Change-Id: Ie3ee63c52254c000ef712986246ca28f312b4301
Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/refs-internal.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index ff2436c0fb..fc18b12340 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -269,6 +269,9 @@ int refs_rename_ref_available(struct ref_store *refs,
  * to the next entry, ref_iterator_advance() aborts the iteration,
  * frees the ref_iterator, and returns ITER_ERROR.
  *
+ * Ref iterators cannot return symref targets, so symbolic refs must be
+ * dereferenced during the iteration.
+ *
  * The reference currently being looked at can be peeled by calling
  * ref_iterator_peel(). This function is often faster than peel_ref(),
  * so it should be preferred when iterating over references.
-- 
gitgitgadget

