Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97BCF1F404
	for <e@80x24.org>; Sat, 21 Apr 2018 03:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbeDUDpo (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 23:45:44 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35440 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeDUDpk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 23:45:40 -0400
Received: by mail-pl0-f65.google.com with SMTP id w21-v6so6244869plq.2
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 20:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VG8Z5P4ObdipaqJEEhwvMfYVFAzBlDwexkbcPWkXt0M=;
        b=yIJwIGIlcR+H9TrlkTzXYYVwGLrdherfHhJpzagtOORI653Fc6y0/jglxptxWgOLsn
         6ezzp0Pc8UBIKGwIvdVdi3Fva8EqlSJv5yG3EiE+bYvM4Wzem0r3tqUPLmwu6cL+XPs6
         KXmLqwCLog1CEcwY9lfnsLQyHTzdJyFFrmP9zz1pu1voPLr1HhIrB51BNeG+Rch0AKYo
         B+4gcMPaNJOpk/LoWXnFWA65mE5PDB0vNgz2rJje1ejN3f48X4mND7lipQz3mLay7OnA
         0nm3zy98FSG+q8LkP2OmjyvP7LfZtiXfVCri0Krl2zJiW7l8C7TdT7a6XPKqI3W6Mc0I
         jiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VG8Z5P4ObdipaqJEEhwvMfYVFAzBlDwexkbcPWkXt0M=;
        b=R218GIJBsfg7dBqjxZH8P6wQz1Sw9iuTojuqEihQYaDg/eReVkFyhMRq6wkhzTxY/s
         jHgqDbgUsdcm2fA7IbjqDW6hs3rN9iJQbo1Qa0hyzn3gyVXYmhI5YmZehEKrKb0Dvg2K
         ngKr/DwpOKZXndBHcqJSqVrdOa+DKBxFfbzCmXV8LHmDPpHcCiKJbatmtQRjE68IGflk
         hrpPmFEfVAUUftMzO54ozuf6DgmQENNeaxfhcGADhWS9+cttfQvFWz5MYp3Lnx9wZWaM
         5BPHX44Db0y01niqPFAm+O+lGNGzU3MXoL1etXFrnDRG3XZkpHPWlrXdSgnWEnmw2rv5
         vrxA==
X-Gm-Message-State: ALQs6tC/AJ5iIKBTu0NCD6c0LSa9lgaEtyBNsv6eRnYvOCsXncOm/KwQ
        Yb22XnP3MueUhh8w061R3B6dBdbJpS0=
X-Google-Smtp-Source: AIpwx4/ZyCLitZnqsPuHqh7cNdo2OIk0KDjlrDwDVEaGI/nPhc6LWMzYgi2zCCjFVoHtpD2e56Ndwg==
X-Received: by 2002:a17:902:6ac3:: with SMTP id i3-v6mr12523767plt.142.1524282339486;
        Fri, 20 Apr 2018 20:45:39 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:ddb8:3db2:8ad2:955])
        by smtp.gmail.com with ESMTPSA id j9sm5040606pff.46.2018.04.20.20.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Apr 2018 20:45:38 -0700 (PDT)
Date:   Fri, 20 Apr 2018 20:45:37 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, l.s.r@web.de, peff@peff.net
Subject: [PATCH 4/6] grep.c: display column number of first match
Message-ID: <20180421034537.GE24606@syl.local>
References: <cover.1524281843.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524281843.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
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
index 7872a5d868..5aeb893263 100644
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

