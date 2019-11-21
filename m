Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E57DC43141
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93E0206CB
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhcIA+gb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfKUWUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:20:31 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38315 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfKUWUa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:20:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id z19so5504191wmk.3
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N7BpB5RWCvP7cXCsjV2ky6XQsXuoft0O5Ooe0jhkmsw=;
        b=nhcIA+gb5uMqYxZHu/4SbyEIqYqnSwkLsyB4KbU0BjbvwprtVIK+Plc9IVeE/K4wQb
         utp6FC/3aY2YT/6RQyiLTZKul4WwgIg+knkSBCidUGNptiYjnMvvBj55mgd+RhkKzkDO
         Ge2X70rnUIgpBN2cB+a+5OJ5q5L/IFkjBqGtYqP/XvfeREgIoKhTECGTd7ltLi4M8C5x
         Lmgxb0V0xgrzKjBfcYN0Hyt4uAubAyGiCjNzl1UD9e8kf9lGnXC6au+eKcegbQm4UgDY
         TwvkLsmPEoZewe2x1NMNxdGe3HRYL2LgIeX3mGckqdUzsw+/40FOxtR8OLVUCl8TBGiY
         6NhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N7BpB5RWCvP7cXCsjV2ky6XQsXuoft0O5Ooe0jhkmsw=;
        b=fR7rrxAA0E8TCmX/J6/zhjBjtRDZGH1YtefcsQxbCIFfFGsiCxw70wxL+QH+zrDgO/
         wUeAdPCOteYViyOCBaEqwPrbaG/HCaoNqwiFo/6s7I/sWXXq7Js60cg/0DKmMk87QHqk
         YHCbn3qzO0IbSlp3VX/STnfjE9viHe/rRd+hgK4ZdI4tcHgKkpMz/2N2iTEfa+6i+avL
         2vIC3mAgAXSmz+XGPz5eNqo1HDIme87kl0+tePP5HHmJ4hKvO0mQahQVIXVOYU/2jhci
         i4R9FvPzL9IkIY6Q4wYsoCPCCRQ4uKxgBYeZrbKcbLgl8nRbGA/+A1Wndnidha/FKgxf
         nfCA==
X-Gm-Message-State: APjAAAXZAH12okaRjY0inWNAqqWWK/3cY53OsvMX7oL4/rsz0oKaCEpA
        DXOpj7ANaKocCYFNce+hy81RzSxI
X-Google-Smtp-Source: APXvYqyt5c8IWcKU5c9ApJBN+wnhsQF+ycWy9urg1iFqK2vV2UKoQwKc949W9sxS2Yw2xEHEbmrbMw==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr12502753wmj.32.1574374828748;
        Thu, 21 Nov 2019 14:20:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm4719968wrr.19.2019.11.21.14.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:20:28 -0800 (PST)
Message-Id: <245cc1b2cc778de486b1ae5177baac3ae3fb93c5.1574374826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.466.git.1574374826.gitgitgadget@gmail.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:20:17 +0000
Subject: [PATCH 02/11] fsmonitor: do not output to stderr for tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

t0003-attributes.sh

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t7519/fsmonitor-watchman | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
index d8e7a1e5ba..06312876aa 100755
--- a/t/t7519/fsmonitor-watchman
+++ b/t/t7519/fsmonitor-watchman
@@ -94,7 +94,6 @@ sub launch_watchman {
 	my $o = $json_pkg->new->utf8->decode($response);
 
 	if ($retry > 0 and $o->{error} and $o->{error} =~ m/unable to resolve root .* directory (.*) is not watched/) {
-		print STDERR "Adding '$git_work_tree' to watchman's watch list.\n";
 		$retry--;
 		qx/watchman watch "$git_work_tree"/;
 		die "Failed to make watchman watch '$git_work_tree'.\n" .
-- 
gitgitgadget

