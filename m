Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D48C433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 22:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B5564DA1
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 22:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhBOWfg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 17:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhBOWfg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 17:35:36 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B011C061574
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 14:34:56 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id c3so7192239qkj.11
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 14:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/Mcqk4lFgf1wIPeF11ERQf94AJxrtrs6w62o+9D0J1c=;
        b=qYeWxEm0fZI9IhR6DPoc6Ft7fylVh6cf48dfrwYm+NksZpWPpUyTZNXxFFytj1UzqN
         TKru/zqu+9+IteXUQ4DVK2llFKVpTQA3g3U1yFutBEQnIFp5NcCg+5G4s0J6zQw7mUjq
         /j7zFWqocVQ3t09YzHDMxOdN7IH9utWH8G6tMw20e8JvLiYA/JIcwNLIP0VYDjtRYIGW
         Y752/EniUqYTzNorKzHDLrNnDd4PesDo7hAohty0LLBlui4Ki14LL5I5ZGvhBxPXA9O7
         P4t8ev/p8wJ+Q5DffaXiphP90ggDnztuxAkLB42DkvuHInRqrDnhynmvYKJXjvL9FnoR
         ymeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/Mcqk4lFgf1wIPeF11ERQf94AJxrtrs6w62o+9D0J1c=;
        b=FBur1rFY8WNsBogd3t8zS8axe6QSDWv36Cud2NIf2uFCgENBM4mUUGeIUn3FmfvufL
         b+nDEhUOqK1apzVVcrhpFSPxEF3UtrfdUzOB8czf2Ki5rZheT62WvQMdQuXNg3y7ekUI
         4OBVyOKNyI9ZNnadIh6/oSqOHF1vvpthPa863ZtBPabAvDtevakchjBVGSJnHqaJixfa
         QwngiSSIeRMpy+Ul9CTA+E/voXZp35VTpr9CRbPIETQuEnfH7fXexehO4DaRLFt0usBG
         XqlJ6ADmms8kur2B3/gDnH5ylh9ttX6g6iaXmpncc0rMo5DcZ9tnt507hTM+tFtulund
         hu+Q==
X-Gm-Message-State: AOAM533ejxtDJ4E3q+zvTtShrPLB5Sw5WOAzRibHi7FSpzrQfAq2ZcqO
        PxoYkya8aeq4o9K3zSGa/MsnDQ==
X-Google-Smtp-Source: ABdhPJxQN3eRkkP/XdjpHSLm+1Zii0hNfCgQNvMPIvuT0UbxUNqWqWdZ6McuuV/zyON5fJXmQIv0/A==
X-Received: by 2002:a37:bcc6:: with SMTP id m189mr16772480qkf.88.1613428495150;
        Mon, 15 Feb 2021 14:34:55 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:c1ff:146e:b5:8cba])
        by smtp.gmail.com with ESMTPSA id b7sm799963qkj.115.2021.02.15.14.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 14:34:54 -0800 (PST)
Date:   Mon, 15 Feb 2021 17:34:53 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, szeder.dev@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 4/4] builtin/multi-pack-index.c: split sub-commands
Message-ID: <YCr3DY5gawPC+G38@nand.local>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <cover.1613422804.git.me@ttaylorr.com>
 <16f33e41388ed431f70e09ef68717bd30fbee67f.1613422804.git.me@ttaylorr.com>
 <877dn9atew.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877dn9atew.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 15, 2021 at 10:54:31PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Mon, Feb 15 2021, Taylor Blau wrote:
>
> >  	trace2_cmd_mode(argv[0]);
>
> Not a new issue, but curious that in the commit-graph.c code we'll first
> validate, but here write garbage into the trace2_cmd_mode() before
> potentially dying.

Yeah, that's a good catch.

> I realize this is the existing behavior, but let's just make this die()
> be the usage_with_options() we emit above in this case?
>
> So maybe this on top?

I split this into two patches: one to move the trace2_cmd_mode() calls
around, and another to replace the final 'die()' with the usage text.

Like I said in my review of your patches to the commit-graph builtin
here:

    https://lore.kernel.org/git/YCrDGhIq7kU57p1s@nand.local/

I don't find the 'if (argc && ...)' style more readable, so the second
patch looks like this instead:

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 5ab80bc722..ce4f1a0bcb 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -165,5 +165,6 @@ int cmd_multi_pack_index(int argc, const char **argv,
        else if (!strcmp(argv[0], "expire"))
                return cmd_multi_pack_index_expire(argc, argv);
        else
-               die(_("unrecognized subcommand: %s"), argv[0]);
+               usage_with_options(builtin_multi_pack_index_usage,
+                                  builtin_multi_pack_index_options);
 }

Is it OK if I use your Signed-off-by on both of those two new patches?

Thanks,
Taylor
