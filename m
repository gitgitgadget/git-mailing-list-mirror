Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD51CC433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 15:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiGJPQv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 11:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJPQt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 11:16:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDAACE25
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 08:16:48 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id dn9so5018538ejc.7
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 08:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Q2ipaIc24+FLVRLwGVnq7YL35lFioywc3R1Z5lLwHRc=;
        b=Fn+8o+208QyuCx3uuPv54NHPZRCuAGJftCxRYNABC7jD9ofrwTx5hndrxipzsXvW3X
         SrIK5dmOwSKD0D+1gHAFhiLTyrMQCZCSTZZQuGVbKjLmkHE3itC/RhG4hbgi9M/wwBlC
         pfvmOcxiHOLiABbcRi2O3E4EtWEce1CzEkTmmN6Bf9l3zFBh2Vejxr0rRj7+FU/ZTo7R
         Opys47V0PbuZ5TSJrWAnGs4ZwuNuWqh1iqKlX4Cyfg6USHfj3rMiTTkO4gDi1TZ02Ofj
         BoTMu8HffJ7dDqkFS/6p5v73gT061UIm8yh4eYZleihRSKAi+D6hhfnDhIkxQ0RMd4+a
         U2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Q2ipaIc24+FLVRLwGVnq7YL35lFioywc3R1Z5lLwHRc=;
        b=bYPr4D04dG2UbGWBu+9qkNSeR2c96pjiK2t2oMhn6MR/FeiL4UlYbd4ObtIdnQIkSh
         xSLDK4SPnk7DnzNTUEydfg6u3+zbxJoSZQ9u89pUHWym1J60T1QOqPzx3pLdPB7MhK9Y
         ld0bjRHSD7IorFo+RKHo9+DT2ld06EWNMLWzxE73diqW6Qg0CyddmerEhDt1FChbJqxw
         UHZ6X6bWMqm2wMgUulNIvtfNr/TKE71UwrXsv0SEmfxV3IwX/y7WfJ6S0PJafSo/ApQn
         ikupSpwPp0ThlRZvOPrDiUTh7DwoPi7vBhV4jgbrlMFZEWdf4LFoKHZ4iW9sPdFLsXBH
         HjJw==
X-Gm-Message-State: AJIora/PcfGi2+E6S0MGIk3IR0ghtFtzekXlxpbZ1Ui84OWxt4wstDW1
        7ZNmjO+bgvBBY5Avu0nzPfA=
X-Google-Smtp-Source: AGRyM1sErOPotFQ3oIMbI6CWiMdTIsNYYtgLPhWObsGQaVHGOpwy+DrNtPNdBKrVnAOLxVsPofI+vQ==
X-Received: by 2002:a17:907:75e9:b0:72b:2ddb:41fe with SMTP id jz9-20020a17090775e900b0072b2ddb41femr12341364ejc.329.1657466207188;
        Sun, 10 Jul 2022 08:16:47 -0700 (PDT)
Received: from localhost (94-21-146-223.pool.digikabel.hu. [94.21.146.223])
        by smtp.gmail.com with ESMTPSA id j11-20020a50ed0b000000b0043a6b86f024sm2844264eds.67.2022.07.10.08.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 08:16:46 -0700 (PDT)
Date:   Sun, 10 Jul 2022 17:16:45 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] multi-pack-index: simplify handling of unknown --options
Message-ID: <20220710151645.GA2038@szeder.dev>
References: <20220708202847.662319-1-szeder.dev@gmail.com>
 <xmqqh73ruxc8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqh73ruxc8.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 08, 2022 at 02:08:07PM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > Although parse_options() can handle unknown --options just fine, none
> > of 'git multi-pack-index's subcommands rely on it, but do it on their
> > own: they invoke parse_options() with the PARSE_OPT_KEEP_UNKNOWN flag,
> > then check whether there are any unparsed arguments left, and print
> > usage and quit if necessary.
> 
> The existing code check if there are any unparsed arguments or
> options.  
> 
> Omitting PARSE_OPT_KEEP_UNKNOWN allows parse_options() to deal with
> unknown options by complaining, but it happily leaves non-options on
> the command line and reports how many of them there are.
> 
> Doesn't this patch make
> 
> 	$ git multi-pack-index write what-is-this-extra-arg-doing-here
> 
> silently ignore the extra argument instead of barfing on it?
> 
> > Let parse_options() handle unknown options instead, which, besides
> > simpler code, has the additional benefit that it prints not only the
> > usage but an "error: unknown option `foo'" message as well.
> 
> Yes, I agree that getting rid of KEEP_UNKNOWN is a very good idea
> for this reason.  But I suspect that we still need the "did we get
> an extra argument we do not know what to do with?" check.

Uh, indeed.  I got too trigger-happy with deleting lines.
Updated patch below.

  ---  >8  ---

Subject: multi-pack-index: simplify handling of unknown --options

Although parse_options() can handle unknown --options just fine, none
of 'git multi-pack-index's subcommands rely on it, but do it on their
own: they invoke parse_options() with the PARSE_OPT_KEEP_UNKNOWN flag,
then check whether there are any unparsed arguments left, and print
usage and quit if necessary.

Drop that PARSE_OPT_KEEP_UNKNOWN flag to let parse_options() handle
unknown options instead, which has the additional benefit that it
prints not only the usage but an "error: unknown option `foo'" message
as well.

Do leave the unparsed arguments check to catch any unexpected
non-option arguments, though, e.g. 'git multi-pack-index write foo'.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/multi-pack-index.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 5edbb7fe86..8f24d59a75 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -134,7 +134,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
 		opts.flags |= MIDX_PROGRESS;
 	argc = parse_options(argc, argv, NULL,
 			     options, builtin_multi_pack_index_write_usage,
-			     PARSE_OPT_KEEP_UNKNOWN);
+			     0);
 	if (argc)
 		usage_with_options(builtin_multi_pack_index_write_usage,
 				   options);
@@ -176,7 +176,7 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv)
 		opts.flags |= MIDX_PROGRESS;
 	argc = parse_options(argc, argv, NULL,
 			     options, builtin_multi_pack_index_verify_usage,
-			     PARSE_OPT_KEEP_UNKNOWN);
+			     0);
 	if (argc)
 		usage_with_options(builtin_multi_pack_index_verify_usage,
 				   options);
@@ -202,7 +202,7 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv)
 		opts.flags |= MIDX_PROGRESS;
 	argc = parse_options(argc, argv, NULL,
 			     options, builtin_multi_pack_index_expire_usage,
-			     PARSE_OPT_KEEP_UNKNOWN);
+			     0);
 	if (argc)
 		usage_with_options(builtin_multi_pack_index_expire_usage,
 				   options);
@@ -232,7 +232,7 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv)
 	argc = parse_options(argc, argv, NULL,
 			     options,
 			     builtin_multi_pack_index_repack_usage,
-			     PARSE_OPT_KEEP_UNKNOWN);
+			     0);
 	if (argc)
 		usage_with_options(builtin_multi_pack_index_repack_usage,
 				   options);
-- 
2.37.0.340.g5e8d960d32

