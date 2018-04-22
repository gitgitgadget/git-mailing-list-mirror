Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF84E1F424
	for <e@80x24.org>; Sun, 22 Apr 2018 20:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbeDVUri (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 16:47:38 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42955 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753646AbeDVUrg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 16:47:36 -0400
Received: by mail-pf0-f196.google.com with SMTP id o16so7498267pfk.9
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 13:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OjDfuuQCvsBuBfNV4FmQXSXzow19h/naObv9THN0qRg=;
        b=bvJHdf0i3iXm7nbbSC8C/51wkFF5k3hvUWlBi26AnAZLu2fgmj9y9UsywJoa0YEabN
         em5R+0W6T8Ixl36mk81oceRVFuIImZERGZE+bzjyGI6VYAyAP7uAzJvX4Ewg8T3uz4zl
         0JMM3wZM26BVkIJjotK0NOitkn56pjY1B8/EbWYMKk2Or1YBVA1KKiBxmuSzThRSOBLy
         Uep6KomWjHU3xLdWnvgjmvs2/SQMOQPKKZqTWxN9pbWfY0v+SNF5+8hPicG3emwYhZAc
         +XTSoe7Tn8XoxMqDCs9VsGVANaLX1488c50jzXKqvRyv7iDbmYofBGe3R+MTSSLzzJNs
         iK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OjDfuuQCvsBuBfNV4FmQXSXzow19h/naObv9THN0qRg=;
        b=aHx9Ao4hyCbFA/4H/iWAd8cJEkyEK/uxNd8Xi/nzMBHaQExxGDxh+RIlAqxDlT6ehO
         QxPXsfVyZri82Rmjnrb24GCc6nuk90lM/YPvnLFBIWGkX80h7PoZHX39ADNq4wiRuVr9
         iiR2HZTYzWfePFdH5QHJGfsfJlc5M3S5+tWT/O7v9MhjUx6PXWV+fmEev3sTvLB5mv1s
         aoOgNypGCkL2cUSuHwgoMx47iLU9hqZm/kvNEwBeKJmVz6wrbgmtt5AVJu0yWnhq9Y51
         uzAzhHucyWMjD/VIl1Wa/tfH027UZ/5xSGP2pEOKr7fNIkl4o4Ssjio41mURCw9PSsf6
         bjIw==
X-Gm-Message-State: ALQs6tCR5G8PStyM8yn8I/B2L0UOms0wbSvPqMbuBg/8DwwyQ+KXI0TD
        +Od/L0pQtQ43xfyc5qbzBJPYykmCVzw=
X-Google-Smtp-Source: AIpwx497oKpHRVgzsePGxNKXPcJIzgXrFtUbzOjRMZfQWr9Wfh2oM/pe4QNdqpL9LSZtLItVw0u+gg==
X-Received: by 2002:a17:902:be18:: with SMTP id r24-v6mr18286176pls.275.1524430055453;
        Sun, 22 Apr 2018 13:47:35 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e8b3:eaad:c134:baec])
        by smtp.gmail.com with ESMTPSA id p11sm8892880pff.41.2018.04.22.13.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 13:47:34 -0700 (PDT)
Date:   Sun, 22 Apr 2018 13:47:33 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, martin.agren@gmail.com,
        peff@peff.net
Subject: [PATCH v2 4/6] grep.c: display column number of first match
Message-ID: <4531659687de87b1bc143cb5cb364b691a58c6c9.1524429778.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1524429778.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524429778.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Building upon our work in the previous commit to add members 'columnnum'
and 'color_columno' to 'grep_opt', we teach show_line() how to respect
those options.

When requested, show_line() will display the column number of the first
match on a non-context line. show_line() differentiates between context
and non-context lines through the '&& cno' check. 'cno' will be equal to
zero if and only if show_line() is invoked on a context line. It will be
a non-zero value otherwise.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 grep.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/grep.c b/grep.c
index 922ab92eff..23250e60d0 100644
--- a/grep.c
+++ b/grep.c
@@ -1404,6 +1404,12 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		output_color(opt, buf, strlen(buf), opt->color_lineno);
 		output_sep(opt, sign);
 	}
+	if (opt->columnnum && cno) {
+		char buf[32];
+		xsnprintf(buf, sizeof(buf), "%d", cno);
+		output_color(opt, buf, strlen(buf), opt->color_columnno);
+		output_sep(opt, sign);
+	}
 	if (opt->color) {
 		regmatch_t match;
 		enum grep_context ctx = GREP_CONTEXT_BODY;
-- 
2.17.0

