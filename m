Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F12C43461
	for <git@archiver.kernel.org>; Wed,  5 May 2021 17:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A6B61157
	for <git@archiver.kernel.org>; Wed,  5 May 2021 17:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbhEER2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 13:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239522AbhEERLu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 13:11:50 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B451C061353
        for <git@vger.kernel.org>; Wed,  5 May 2021 09:44:45 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id g13so1685955qts.4
        for <git@vger.kernel.org>; Wed, 05 May 2021 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nPtgt+K8QZNv3QeBO3JfPuAK4GollMdsva6d10bEWNY=;
        b=rvHi1zRKx3Ee7FfUPzNKLSCvgGRYkE96aTYJB3OUPdV1tKfaeziv/xSCFaUOgaGcEu
         poVS5rZR0DZTr1k99aXYwBIjsJWp+cUZWN9HMAAvXH4kriaNahaOTWCEpxPinHTj/2vT
         sCXWtsaZGgd2kLUTDJzju9HFZ9XQRlvuHfd80dbZxwPwrRBhb41z+Cgl18CyiWofzVBq
         YE3kZewWBWtige4dr/ZFaN0TmpvI2rAwGacdA2aVTxz66zBYupz0ZMbg8QmwzQkQGhQ6
         z+cxr2nJMoNgDrZ95Dd6uNpD1tFgSgJ/S6BnVN10NuTNPrWOhsyuHM9bp3GOw7udCqoe
         zaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nPtgt+K8QZNv3QeBO3JfPuAK4GollMdsva6d10bEWNY=;
        b=JuqK3wjV4snE4YHcbEOjO6/jzadKyOibg4KL68UCrkDSMAuRtZiwlNdE300vW55vWc
         FF6zyjKL24zrn5T3vkNrO0ANcSJPUwSKjRbxeMkO3C7Z6hI144ujYWy6ned8640LtBRV
         dmOQskxuxmBzCPZ7qk5KAKgFK2ER7ThRM40rnFtkpSiUId8A5hxcv1ap8/l4fMbtstGQ
         UjRh7++FacZBDZB+6+sGdRq1jHvE1U8h7f4d+K2jHrPYQmiRhnFfdfRRLZF81+9Vy8pq
         nP/pPyx1oSPp9ZO3aArGhJ6XxfDurnH7YJssJ4yajBTR+Pt+C0H3QIlmLfUDFwr7Q/c0
         G1iA==
X-Gm-Message-State: AOAM532EjYWMfBNwn4xrFqjPPcOvYR+cZ3xHLJI09Zjcns7qTwzTHUcW
        /6S8fgY+UwufMKqbDYmnEQI=
X-Google-Smtp-Source: ABdhPJwynuaFmjLMvoy1WfJeZO6HNGFaE3UKS6TPomm0uXdAUuncPa/h6fjgVTeizCsTz7N4iElP4A==
X-Received: by 2002:ac8:d83:: with SMTP id s3mr28507304qti.333.1620233084692;
        Wed, 05 May 2021 09:44:44 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:ecd5:a409:e9b9:b043? ([2600:1700:e72:80a0:ecd5:a409:e9b9:b043])
        by smtp.gmail.com with ESMTPSA id w6sm13922164qkw.109.2021.05.05.09.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 09:44:44 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] fetch: teach independent negotiation (no packfile)
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <cover.1617929278.git.jonathantanmy@google.com>
 <cover.1620162764.git.jonathantanmy@google.com>
 <1de34a6dced3f5477162dd675615342bc2dec05f.1620162764.git.jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f2acf884-8930-a3fd-ec4d-601652b2ec24@gmail.com>
Date:   Wed, 5 May 2021 12:44:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1de34a6dced3f5477162dd675615342bc2dec05f.1620162764.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/4/2021 5:16 PM, Jonathan Tan wrote:

> +void negotiate_using_fetch(const struct oid_array *negotiation_tips,
> +			   const struct string_list *server_options,
> +			   int stateless_rpc,
> +			   int fd[],
> +			   struct oidset *acked_commits)
> +{
> +	struct fetch_negotiator negotiator;
> +	struct packet_reader reader;
> +	struct object_array nt_object_array = OBJECT_ARRAY_INIT;
> +	struct strbuf req_buf = STRBUF_INIT;
> +	int haves_to_send = INITIAL_FLUSH;
> +	int in_vain = 0;
> +	int seen_ack = 0;
> +	int last_iteration = 0;
> +	timestamp_t min_generation = GENERATION_NUMBER_INFINITY;

...

> +		/* Process ACKs/NAKs */
> +		process_section_header(&reader, "acknowledgments", 0);
> +		while (process_ack(&negotiator, &reader, &common_oid,
> +				   &received_ready)) {
> +			struct commit *commit = lookup_commit(the_repository,
> +							      &common_oid);
> +			if (commit) {
> +				timestamp_t generation;
> +
> +				parse_commit_or_die(commit);
> +				commit->object.flags |= COMMON;
> +				generation = commit_graph_generation(commit);
> +				if (generation < min_generation)
> +					min_generation = generation;
> +			}
> +			in_vain = 0;
> +			seen_ack = 1;
> +			oidset_insert(acked_commits, &common_oid);
> +		}
> +		if (received_ready)
> +			die(_("unexpected 'ready' from remote"));
> +		else
> +			do_check_stateless_delimiter(stateless_rpc, &reader);
> +		if (can_all_from_reach_with_flag(&nt_object_array, COMMON,
> +						 REACH_SCRATCH, 0,
> +						 min_generation))
> +			last_iteration = 1;

I'm just chiming in to confirm that this use of min_generation is
correct. Thanks!

-Stolee
