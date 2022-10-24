Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295B2FA373F
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 20:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiJXUtx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbiJXUtF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 16:49:05 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5982B6902
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:56:31 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id i9so5653564ilv.9
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iqe77xsVoSYKACIEl4ZI0FSatz/GG7p2xIG+FFeF39E=;
        b=xKFeVhUpKti2uytYrueRVBXzdr3dyelghMGtC8gL4H+d2cIT/Je6l41HlEbesZgdz0
         m+eOe9+CNa8I1QwlRCxPqHOyvm8bf9zEDngifbYOZCBwMbyk1RQO9EYv5tpY55iKrwQ9
         uw2+3e//oW2y86HFGerhx+0zTqOXTcZgJet+3nWcHC2voCv0ECT6dCELHwu5C/LBsc57
         IKfffSXf7ARpH5CFow4WSXLrn7zcyuW7unWeh+hPzCe3U1AclgRH6mRZ8YhRiaWP45c9
         TBC0XNj3GtHPrf01a3dAzloCIiwj8D5boiv7SfKJvyW8aNK/jPDSZJhxqbGrh1IsR+sG
         NUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqe77xsVoSYKACIEl4ZI0FSatz/GG7p2xIG+FFeF39E=;
        b=WI9JDDfzHKzG6xy7zvLEHAZleVpy/Q2YnHh+0+H6Qyio3/+Ir55V2jUsFD7L3Lo2/2
         mVTVyIwV1bwTrmxyfASUS0W4Y0fZkJ1stcpAskmcvP4GdzvGxIDFU9IRlNo/eK4rLmba
         whsMCgWKXxC6uo8TTJNbOUY41ot8v4FX3B3b8c/SgvT14tGbFAxX7aNyP4NOIcjb9E4E
         64fkvFv8fanPEJPbUg0ykq1tih0peH1c4Zj38Vpvp0bP9QLZtLrGEsDaiHCavSpjMqnt
         3F9WvgUrMWGdS1VihrkgulneJpddIyJaGf1cgCa0Oz7r/QIfZdhW7b1eKiUCzBT+7hpF
         y1FQ==
X-Gm-Message-State: ACrzQf1qH4/EnWTzjGv18+Uu0j3cCGLGoMZCu7+2ptu44gVDfKoF/1Vi
        asz5iJ8jGNX7+k1W8rJ3D8uIzCnDijczHTrz
X-Google-Smtp-Source: AMsMyM6TSwF9N0ZIXISv16Rm7L79kr6nlBoCgE6sa5wCBEb2PKobtTgF6gqN3RlkIuwXzTgnxGKpCA==
X-Received: by 2002:a05:6e02:158a:b0:2d3:f198:9f39 with SMTP id m10-20020a056e02158a00b002d3f1989f39mr22997001ilu.206.1666637737450;
        Mon, 24 Oct 2022 11:55:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a95-20020a029468000000b00363bd76184esm81900jai.162.2022.10.24.11.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:55:36 -0700 (PDT)
Date:   Mon, 24 Oct 2022 14:55:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jacob Stopak <jacob@initialcommit.io>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 3/7] shortlog: extract `--group` fragment for translation
Message-ID: <987a8484ac457cf16aa07e0411dcc4bbca83b06b.1666637725.git.me@ttaylorr.com>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666637725.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666637725.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The subsequent commit will add another unhandled case in
`read_from_stdin()` which will want to use the same message as with
`--group=trailer`.

Extract the "--group=trailer" part from this message so the same
translation key can be used for both cases.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/shortlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 18f0800c82..d0645769d7 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -132,7 +132,7 @@ static void read_from_stdin(struct shortlog *log)
 		match = committer_match;
 		break;
 	case SHORTLOG_GROUP_TRAILER:
-		die(_("using --group=trailer with stdin is not supported"));
+		die(_("using %s with stdin is not supported"), "--group=trailer");
 	default:
 		BUG("unhandled shortlog group");
 	}
-- 
2.38.0.16.g393fd4c6db

