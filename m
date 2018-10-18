Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E12FA1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 00:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeJRIpy (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 04:45:54 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:37900 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeJRIpy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 04:45:54 -0400
Received: by mail-pg1-f202.google.com with SMTP id e6-v6so21337298pge.5
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 17:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GlgvzzyXHj4lt+6Oo51oqln/iR5VbB+pfiXMI1bm1k8=;
        b=OAgPo4OYpHyBmaMJSWlQf5Zpnj5eWJQXL+F5yTIF8vBqpYRh2O2IXAxOREV6fq/BA8
         Ooj4yPhv4iySq+JAQ0Ei2h4ann3ZUuNi1yc1y8H/buUhLx55lFtjTT2ecnHmhQ9EmVOx
         eWN1L30exA0WPjCGU+9xLo1RfxYgX9aznNfXmyJ8dOsWmBcTFVwEkWYc2B9x9etz8ji3
         W/Y4KUfD43BmQ+LkVgr6vTViIQ0kXttbv4Wx22mDNM/FGhZs4/SHzzVxU/M0hiz9wlzM
         7plx5ElSYXHz+8woH4SVqcJrtyDv4irJaj7+9RPckbu3j+S9dXYXambOmjq1KWLfF3tv
         1u0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GlgvzzyXHj4lt+6Oo51oqln/iR5VbB+pfiXMI1bm1k8=;
        b=ZIS3R1mcrbvryHG+3IOxRTwvEDmJR/gx74ZVGPyY2Mw+CANXVDklV2022CwRWUcPc+
         Xb1N8DIufqoECoork3bMXjqdUXobcsU1eDORvvGzVVuZHSJtIZzyoccxJ398xwKHqp9e
         pn4r6RfT5Wf24lIFax1V3XnXjCUcM0v9wVeDqI4P9ESDAHCwe7czDBvESD5bxVf/1WCC
         U77Qy3uA33/gQC7EW+Z2qivzDv0gym+P0QQRv5iwyojrLxnrvMXhtOgcBrko8COZr4/g
         OScP/mP8zo01xXbmHXNxaHyP406ox2hveUX6QhK25VfJptrz1plk8ahYpo2l/cwlC50c
         I4NA==
X-Gm-Message-State: ABuFfoiFm9cKgHQBBgHwHvqcfCAR50CmyqtsdyRqWgd3v5c7D1GQO89+
        iXwCxF1JX2dxTuI64wFTuaZZzDFLj47IInt8beGs
X-Google-Smtp-Source: ACcGV630+oU5Z7u/5AU1o4ZlisNBRHgW6bINNdQ3278h1tWzdFr960I71P9aMJco6iqO2d/KhDBAxpSWkdddLiHjORrn
X-Received: by 2002:a62:4853:: with SMTP id v80-v6mr14195297pfa.10.1539823655876;
 Wed, 17 Oct 2018 17:47:35 -0700 (PDT)
Date:   Wed, 17 Oct 2018 17:47:32 -0700
In-Reply-To: <20181016181327.107186-10-sbeller@google.com>
Message-Id: <20181018004732.141825-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181016181327.107186-10-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 9/9] builtin/fetch: check for submodule updates for non
 branch fetches
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -887,11 +887,14 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  				rc |= update_local_ref(ref, what, rm, &note,
>  						       summary_width);
>  				free(ref);
> -			} else
> +			} else {
> +				check_for_new_submodule_commits(&rm->old_oid);

Does this need to be guarded with a recurse_submodules check, just like
in update_local_ref()?

Also, this warrants a comment - this is here because there is some code
later that requires the new submodule commits to be registered, and the
other branch does not require it only because update_local_ref() calls
it.

> @@ -615,7 +615,7 @@ test_expect_success "fetch new commits on-demand when they are not reachable" '
>  	git update-ref refs/changes/2 $D &&
>  	(
>  		cd downstream &&
> -		git fetch --recurse-submodules --recurse-submodules-default on-demand origin refs/changes/2:refs/heads/my_branch &&
> +		git fetch --recurse-submodules origin refs/changes/2 &&
>  		git -C submodule cat-file -t $C &&
>  		git checkout --recurse-submodules FETCH_HEAD
>  	)

I think there should be a new test - we can tell from the code that just
because fetching to FETCH_HEAD works doesn't mean that fetching to a ref
works, and vice versa.

Also, can you make the test fetch 2 refs? So that we know that it works
with more than one.
