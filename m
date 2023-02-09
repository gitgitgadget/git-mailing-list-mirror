Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A4FC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 17:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjBIRKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 12:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBIRKx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 12:10:53 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83C660B9B
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 09:10:38 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id f15-20020a17090ac28f00b00230a32f0c9eso2985708pjt.4
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 09:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DMzc4ZmwydGDGmwNQ7oIxSMMukQ53q8oC84KEBiTH4=;
        b=i76LwAV05PlmVh1AtlTk9tpuKU9wU2G+b13tz4omUf8pqjELU+eZUdVlShufbk9uuc
         stSSlp2Zy8HzewbtqHAKpfbqG/PodDEyPqymh9q2oQRh/ainJBl71tnVBenG2nG0TRXd
         3E9UULAcSFvtfXo19hUQQRNxOEC3NeSeqrjib1JriSbIhdZ1LSow5jLRwl6exLmp9Olj
         4wPgZlHw5GCibm/dkyu5hR7WPSMhqnFH3AgXg/1wTuN29Rczn6IBc8g3JMBzqdLjbxjd
         1Yj+oFFIzm4+3cfY6eK2nLuqU+28g9b+t4Tr/83umcMpZj6cR9HAFtkYZaH37eKds90b
         xRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8DMzc4ZmwydGDGmwNQ7oIxSMMukQ53q8oC84KEBiTH4=;
        b=5/BOur/dyL3XnPbohBzsyb1dp+ethLLMvG826MdmLF9BhuklM6Dy8BgQklHwQF2udv
         B7aEXeNFArA0Oc667eB4X34htlzSh91ufPuHpTw67RQ9Bs/EufcMIaYgGsWfO1UjR09S
         Brh8sUE1nohrkU4Z4WMR6U6QPuRtKUDVU/sNEQtziqC3fLzqY7k66JrXWlx3A881mGKw
         lpCExAaYJix5UxYp45Ni0pT0guA1fFuyxsAcngR+jgnPjHiqS9uEFMojKCRu/Yn6YRPQ
         Z4WHp6v6ygidRYt2HypL3tMFTSi73NL+KWeHRgs6FIR6u7Fs5ozabBAKO0Elq2xaNdVH
         ZedQ==
X-Gm-Message-State: AO0yUKUE4wExGOkoRX2Rk0X3JdSdKnMLmexw1xzz0cp4GJhOxVFbZq9m
        PJmKAxiJ4C3SZcq2usWGM26X8/JQL1g=
X-Google-Smtp-Source: AK7set/8Xn0C67X/mtuOahJgphV/1AHNsFm5FRD7lRRtv7VeChnUbVcxN9Tcb+WrXh1DaZaputthag==
X-Received: by 2002:a17:903:234a:b0:199:2353:1eff with SMTP id c10-20020a170903234a00b0019923531effmr14283530plh.21.1675962638114;
        Thu, 09 Feb 2023 09:10:38 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id jg12-20020a17090326cc00b001994fb4a9dbsm1758641plb.130.2023.02.09.09.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 09:10:37 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3] name-rev: fix names by dropping taggerdate workaround
References: <pull.1468.v2.git.1675751527365.gitgitgadget@gmail.com>
        <pull.1468.v3.git.1675933906906.gitgitgadget@gmail.com>
Date:   Thu, 09 Feb 2023 09:10:37 -0800
In-Reply-To: <pull.1468.v3.git.1675933906906.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Thu, 09 Feb 2023 09:11:46
        +0000")
Message-ID: <xmqqilgaojci.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -	/*
> -	 * When comparing names based on tags, prefer names
> -	 * based on the older tag, even if it is farther away.
> -	 */
> +	/* If both are tags, we prefer the nearer one. */
>  	if (from_tag && name->from_tag)
> -		return (name->taggerdate > taggerdate ||
> -			(name->taggerdate == taggerdate &&
> -			 name_distance > new_distance));
> +		return name_distance > new_distance;

OK.

> -	/*
> -	 * We know that at least one of them is a non-tag at this point.
> -	 * favor a tag over a non-tag.
> -	 */
> +	/* Favor a tag over a non-tag. */
>  	if (name->from_tag != from_tag)
>  		return from_tag;

The removed sentence is not something whose validity has changed due
to the code change.  We still know at this point one of from_tag or
name->from_tag is false, thanks to the previous check, whose
condition did not change (only what is returned when the condition
holds changed).  But it may be obvious to readers, so, ... OK.
