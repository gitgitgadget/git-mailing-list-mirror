Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04F7C433E0
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D78207B7
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbhAYXmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 18:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732892AbhAYXih (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 18:38:37 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC52C06178A
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:37:37 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id l27so3898204qki.9
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qlHVhEYX5cqJqldP2f83BYJJb/dO87xV8oTauLhAP6A=;
        b=dhiFhq9q5mZaNl16/69dv3H9S/34KGNDBCuJUswQk/Zk1oensaw6poMoWEJWgIw9iu
         PWxfhSjl6vSfJK+zed857tA4Up8y23EuPrUgav3YSi92ReAvZZqSpqXX3FdZBm9gl4nw
         EKpZZXby/BorZgGClfhhm6qZJPip4HO5DFSfrPDN555QUzzaSQ84tyHCd4wdGYYfNsFm
         Mo7zLIHt0Lm+f+PVVJwyq8ahS3mjHMYWFhdd9mrMnyIVXuoQ9hEElV/pSe8H5npsZw/1
         BVylFKvWqzR/AMuXuocx3353y5q2C5tQX+NtASw2T8SfhXWOpM5EQyMuoRkDJGLfqv4s
         9HaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qlHVhEYX5cqJqldP2f83BYJJb/dO87xV8oTauLhAP6A=;
        b=CLyWfkTftu5ErBBZrPvPyZdwqc6Dg4ex+Muk367TZKG5B0EPHVrskaxH5NfnELqcAP
         rdtH45eg3CoGn94PNrF1GgQ2A7kWYAUwb3fnTCuBpxVVVAsf6wNNMsM/3+e/ug5J/BHz
         Wdpd4ifY37c9obSRQb5nb9JOsXOqjasq3FbS7tRNik5iBvUr6x/jk85zdo+4WBoHF20g
         lHzb4l4lJ3at4f6/tm63r22oRpUkI7r2KQE+5NYWs/rSS8ZnNu4DH+5FvyGFsebDqpcs
         q9d//sRRYgHRsoG1ABhTQVk4LO4jvq7zNKIA0jdqA5g0WpH6G0XYkkRuTTR4TFleINdI
         aVeQ==
X-Gm-Message-State: AOAM532wcM1MVrhoYXotYg1Zw3SnBEGsHbnl7NSzrrMO98RByrUhDRwN
        pyVK2HucVt1c5OjtUL/votpnkM3c48xwFA==
X-Google-Smtp-Source: ABdhPJxpMX4Ifj7WmYQ4ByI4KYhC8ir3SS5WE/gzG1XD48PTNcrcbiss0EXtgf1ykyOQtAnMjyy67Q==
X-Received: by 2002:a05:620a:1fb:: with SMTP id x27mr3190510qkn.456.1611617857000;
        Mon, 25 Jan 2021 15:37:37 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5e9f:a2e5:e7ac:394d])
        by smtp.gmail.com with ESMTPSA id a189sm2215775qkc.133.2021.01.25.15.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 15:37:36 -0800 (PST)
Date:   Mon, 25 Jan 2021 18:37:34 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v3 06/10] Documentation/config/pack.txt: advertise
 'pack.writeReverseIndex'
Message-ID: <7e29f2d3a08c42b1e8368c4a2f52a11cc47ee959.1611617820.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611617819.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that the pack.writeReverseIndex configuration is respected in both
'git index-pack' and 'git pack-objects' (and therefore, all of their
callers), we can safely advertise it for use in the git-config manual.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/pack.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index 837f1b1679..3da4ea98e2 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -133,3 +133,10 @@ pack.writeBitmapHashCache::
 	between an older, bitmapped pack and objects that have been
 	pushed since the last gc). The downside is that it consumes 4
 	bytes per object of disk space. Defaults to true.
+
+pack.writeReverseIndex::
+	When true, git will write a corresponding .rev file (see:
+	link:../technical/pack-format.html[Documentation/technical/pack-format.txt])
+	for each new packfile that it writes in all places except for
+	linkgit:git-fast-import[1] and in the bulk checkin mechanism.
+	Defaults to false.
-- 
2.30.0.138.g6d7191ea01

