Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FDDC433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 23:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiBXX1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 18:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbiBXX1L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 18:27:11 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8A034BB2
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 15:26:40 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id mn16-20020a17090b189000b001bc2315d75cso2206714pjb.3
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 15:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=eWkq687khPu2c+Cjxhkkwh/Mv0uToHuvk9u+uOHDoSo=;
        b=bA9FXIfRSFdrxzppz9rwuV5t1cIyopOAzAqGODADHTqoi6u00zlE8SlEoeaMyEQTPe
         OFO+T8X/SXXDXXLZEJc1Ts0fVfWACNnOWwJaguqNA+LKjifnlaDuvPUC75iaas4Lpj9q
         +5j3fu0dWIz77y4v9baxVsoyxrg3RUkGYmSk2Yc5wBmurV43jYfJbGHoA+vnhaUyblX0
         PhTygmG65JSHZ4VI1LxumngbCyXa6b0lEbpRjUS1t+AtWSVGQyEKSB1iwwSk4Jv2kw0+
         nx2Gq6rTlJ4Ul6KRQxL4OLLAALPhofn1prAc+6F+ObhSjhqRfbNHBswFO9oUlPJIF3Sf
         HAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=eWkq687khPu2c+Cjxhkkwh/Mv0uToHuvk9u+uOHDoSo=;
        b=Nxhizcx3H64xtClwSanQCC2mnfKPge2D+sQ27nws6rFemrJAbJSOqGett+gdjltiIw
         VIoMAmXndqaeeqOaMKMeS/3XgAfyDgz5DUBVV44C/FABwzEZ7XE5MrQRs6QWh6+8FFNP
         4zss/7sOFlIjfu3Vu2BhXKeMnkEpasBddJSuYh057V7/R0fFbvA/EnWYet0kvLs3kxZp
         8iJFzNGSiQ9/NjfMriXozFnMjbJRnWQITr5HeNAVW03xxx9aaQUpPK9C/Dcg71mEBomj
         PiOjPSlmKIrv41olZagKReiT0YhBG1BvoIaPm615UI68EZxTTUa67iTyVO/Ve93gaww0
         EFyQ==
X-Gm-Message-State: AOAM533ehmELGdFK8MlUQDIdHRae2QFUvC9NJdaFmZCw5PvhvrMGRpqh
        WILwT1ucMSV1HeJ7nMXV+pcArbO68apXNkq4XvG9
X-Google-Smtp-Source: ABdhPJyKl58PbQ7Vrv1aL0Veqn29zDpDmnrA/Q9KeHSX1gwU5qtXmpTKNqOWKPJXsfCrW9/JHp8iUzj5wXHH6sgVC5Hi
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:b185:b0:14f:2d94:184 with
 SMTP id s5-20020a170902b18500b0014f2d940184mr4702811plr.56.1645745200113;
 Thu, 24 Feb 2022 15:26:40 -0800 (PST)
Date:   Thu, 24 Feb 2022 15:26:34 -0800
In-Reply-To: <20220224100842.95827-8-chooglen@google.com>
Message-Id: <20220224232634.2881796-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: Re: [PATCH v3 07/10] submodule: extract get_fetch_task()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> @@ -1389,6 +1389,7 @@ struct fetch_task {
>  	struct repository *repo;
>  	const struct submodule *sub;
>  	unsigned free_sub : 1; /* Do we need to free the submodule? */
> +	const char *default_argv;
>  
>  	struct oid_array *commits; /* Ensure these commits are fetched */
>  };

I preferred the other way of passing default_argv in parallel, because
it is only used for the interaction in between get_fetch_task() and
get_next_submodule(), but I don't feel too strongly about this. In any
case, up to and including this patch looks good.
