Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01074C4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 08:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB96E233FE
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 08:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgLQIcJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 03:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgLQIcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 03:32:09 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C7EC061794
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 00:31:29 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id j12so26482014ota.7
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 00:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=mXLLMm4EJ6qQ/GY3Wp/+C2LXRcl4az5d/O7G8CjkSzk=;
        b=VLZMt64v62TQ9o3qJ3Rk7sKGJmJiEreR+x/JKgeGVBE0SohHTNd7D1F/5dUjh8hJPF
         USAteHt6zkPCGCZYZDiwwe8tmSA34i7TPNtpBELyygy3OTPapNmuRpuxVK9t9+N81XSm
         u3oPGsU06kI2HmMxSgAOseI+huhcnQPeg/5UU0y+FpsaAu1z4GygwuV7Vz1YdW3Fmsqi
         HK88gcBzBnYdM9lXMUUYNC9/rEKnt6muSq4NbDk9PnMJO1nVHcBJX+UYd64bT3zv5J+t
         BmqsVFgLSx0gs2a44JEHJiucjFhghTlXlwjJRd2BNh+M30kZZcq29RZg43pCMSi5rMxR
         r3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=mXLLMm4EJ6qQ/GY3Wp/+C2LXRcl4az5d/O7G8CjkSzk=;
        b=lDE0ESVPSUHCm+SudGIwnvTn4soxGrItzFEmw/chJiZh4/0707UssOcOw7uNEMJyF0
         E/FUuzMBDR7aaNTagCW+QOY2fsRN1riXxq8kPxRFRYi/I0LIg00FfNoQgqFBna9CYX/l
         /bqGPewGUrNaTdZbAinAy7bXXfXMKZLhTiQeYx2SZDdmMJ08Lle+ZoP0pMDwvNFsslXK
         YqdzxFt24/OLKcXFriCS0HGYggYpPMWRW+EbiRd7wCGRbidLWPCcRVbViIzv3MUnkPTN
         lUs0ZNaF7OlgDv79PM+co1VGHdqR4n45i8mU0jSsU9HqscgxzBhm0XT0DGheoL3WIV/m
         K+2A==
X-Gm-Message-State: AOAM533lj3ZWkx/nO9cY9oKXLFOaE7w+5JoQvIPVosbdqWZKWdOpO7xO
        HtQ1BoaWYzl2oZYXohKwark=
X-Google-Smtp-Source: ABdhPJyR8exkphExHQfjH/28YK1RnPHaN0lTF3NUvjtGiWKU+vIjaC3gokNFIEuWZ6OWAug9LbywUA==
X-Received: by 2002:a9d:62d7:: with SMTP id z23mr22987269otk.353.1608193888499;
        Thu, 17 Dec 2020 00:31:28 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id r133sm988729oia.17.2020.12.17.00.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 00:31:27 -0800 (PST)
Date:   Thu, 17 Dec 2020 02:31:26 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>,
        git@vger.kernel.org
Message-ID: <5fdb175e79748_d35b620823@natae.notmuch>
In-Reply-To: <769774cf-a55f-c9ba-c33d-233d070bb3f1@kdbg.org>
References: <20201217054524.856258-1-felipe.contreras@gmail.com>
 <769774cf-a55f-c9ba-c33d-233d070bb3f1@kdbg.org>
Subject: Re: [PATCH v3] mergetool: add automerge configuration
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt wrote:
> Am 17.12.20 um 06:45 schrieb Felipe Contreras:
> > It doesn't make sense to display easily-solvable conflicts in the
> > different views of all mergetools.
> > 
> > Only the chunks that warrant conflict markers should be displayed.
> > 
> > In order to unobtrusively do this, add a new configuration:
> > mergetool.autoMerge.
> > 
> > See Seth House's blog post [1] for the idea, and the rationale.
> > 
> > [1] https://www.eseth.org/2020/mergetools.html
> > 
> > Original-idea-by: Seth House <seth@eseth.com>
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  Documentation/config/mergetool.txt |  3 +++
> >  git-mergetool.sh                   | 10 ++++++++++
> >  t/t7610-mergetool.sh               | 18 ++++++++++++++++++
> >  3 files changed, 31 insertions(+)
> > 
> > diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
> > index 16a27443a3..43af7a96f9 100644
> > --- a/Documentation/config/mergetool.txt
> > +++ b/Documentation/config/mergetool.txt
> > @@ -61,3 +61,6 @@ mergetool.writeToTemp::
> >  
> >  mergetool.prompt::
> >  	Prompt before each invocation of the merge resolution program.
> > +
> > +mergetool.autoMerge::
> > +	Automatically resolve conflicts that don't require user intervention.
> 
> As I hinted in an earlier message, some tools do know how to deal with
> unconflicted changes. This should be a setting in the tool driver, not a
> user-visible setting.

It could be done in both. We first should find a mergetool that is
negatively affected by this, which WinMerge doesn't seem to be one of
them:

 1. Before: https://snipboard.io/8JA5Oz.jpg
 2. After: https://snipboard.io/HUXnOg.jpg

That's a positive effect after the patch.

-- 
Felipe Contreras
