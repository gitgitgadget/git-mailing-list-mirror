Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF846C19F2B
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 22:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiHCWkE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 18:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHCWkC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 18:40:02 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2C524F00
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 15:40:01 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g12so17762609pfb.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 15:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc;
        bh=TYvkwehnJCWNoeNvlhVjtGDwSAkbSvy5DZX8V4SYtAo=;
        b=C3zIwnabfIOHM+jN6C7SbBd1bC041XeHTCFqjJP808T1OiiwhNIfSqLszZg5m4HQ6V
         00yVr+O6QnckIK12Lin+NXLRTflXNuHSKzzy+s/F8X5rWfsfisgWkXFCpFdoKK5dKVgN
         wOiaA3P724JjGd6N8TdPT7lZd6m/Bkl2VbCkSj27pyBWk0KRLmuCDGCE6NnFG2nXDgxh
         w73bBnd8fGuUHVjVZXVNMROiyprqN+PWbZb2a7MKTW1NfPXBksM9CMcvSsitIwM0YnTS
         CPs6kJHzWSwHOX4epkN8RcoSMrk1pVbm5fLDrsT7F6Muz/vNl8sWjNxyAsvEyFfIvYR5
         2JrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=TYvkwehnJCWNoeNvlhVjtGDwSAkbSvy5DZX8V4SYtAo=;
        b=kS+aPbCd7jpj1gjZtMJb9a6hhS9SfZbpCD/ckDxKoMU4cZlT1dCzdkWJVpnjuLw4Rg
         HSJtOfvC3Y1YLyJW2UprD6sV1kHS+kWDjBPK8GCJrPVvVRKhxZ0WK+KetaM66E9K3Ve4
         c1+h/KZ1hh1YkwSpGdRN23Pixjxkn0hmyXKP34nzC/yFKShvi88TSzzYVcMOncq0NE5t
         tAqSt2wOzUwcgHXf7P49Jp1PqWvknbKDcQ3c3uDlgToXndoE+oGtKY4Pzf/XtvkTEqG+
         f3wK1EgxXlhsPuDgZXcj//vw/q4R+u5Y1ZyVKxc+5uOm5VRH7clL+/85Cgl1WfD+Uni6
         SoIQ==
X-Gm-Message-State: ACgBeo2ZnGzDWADojyHS1uKFbIcco39JRgDTFe7SnPWh9hXG5Fnz/Dl+
        u8XjusDVQeOzLSlv1e/TC90jKQ==
X-Google-Smtp-Source: AA6agR5AZeYJvjbvgV7JpVC+Uh92aaSWe9+zbxmNufGwA6XXTDbwcIgSez7lE/9prW5Etl717rtOCg==
X-Received: by 2002:a63:d652:0:b0:41c:45e9:abee with SMTP id d18-20020a63d652000000b0041c45e9abeemr10894767pgj.110.1659566401157;
        Wed, 03 Aug 2022 15:40:01 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:8993:c42:1e1d:1a70])
        by smtp.gmail.com with ESMTPSA id oj11-20020a17090b4d8b00b001ef81574355sm2165651pjb.12.2022.08.03.15.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 15:40:00 -0700 (PDT)
Date:   Wed, 3 Aug 2022 15:39:54 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 03/10] refs: add array of ref namespaces
Message-ID: <Yur5OmTAYDx0ifsp@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <d7486390d57849971ee6a4ac27a0a784c41623ee.1659122979.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7486390d57849971ee6a4ac27a0a784c41623ee.1659122979.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.07.29 19:29, Derrick Stolee via GitGitGadget wrote:
> diff --git a/refs.h b/refs.h
> index 47cb9edbaa8..94e8dedf939 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -2,6 +2,7 @@
>  #define REFS_H
>  
>  #include "cache.h"
> +#include "commit.h"
>  
>  struct object_id;
>  struct ref_store;
> @@ -930,4 +931,49 @@ struct ref_store *get_main_ref_store(struct repository *r);
>  struct ref_store *get_submodule_ref_store(const char *submodule);
>  struct ref_store *get_worktree_ref_store(const struct worktree *wt);
>  
> +/*
> + * Some of the names specified by refs have special meaning to Git.
> + * Organize these namespaces in a comon 'ref_namespaces' array for
> + * reference from multiple places in the codebase.
> + */
> +
> +struct ref_namespace_info {
> +	char *ref;
> +	enum decoration_type decoration;
> +
> +	/*
> +	 * If 'exact' is true, then we must match the 'ref' exactly.
> +	 * Otherwise, use a prefix match.
> +	 *
> +	 * 'orig_ref' is for internal use. It represents whether the

s/orig_ref/ref_updated/ here I think.


> +	 * 'ref' value was replaced from its original literal version.
> +	 */
> +	unsigned exact:1,
> +		 ref_updated:1;
> +};
> +
> +enum ref_namespace {
> +	NAMESPACE_HEAD,
> +	NAMESPACE_BRANCHES,
> +	NAMESPACE_TAGS,
> +	NAMESPACE_REMOTE_REFS,
> +	NAMESPACE_STASH,
> +	NAMESPACE_REPLACE,
> +	NAMESPACE_NOTES,
> +	NAMESPACE_PREFETCH,
> +	NAMESPACE_REWRITTEN,
> +
> +	/* Must be last */
> +	NAMESPACE__COUNT
> +};
> +
> +/* See refs.c for the contents of this array. */
> +extern struct ref_namespace_info ref_namespaces[];
> +
> +/*
> + * Some ref namespaces can be modified by config values or environment
> + * variables. Modify a namespace as specified by its ref_namespace key.
> + */
> +void update_ref_namespace(enum ref_namespace namespace, char *ref);
> +
>  #endif /* REFS_H */
> -- 
> gitgitgadget
> 
