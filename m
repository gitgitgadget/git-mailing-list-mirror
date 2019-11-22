Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AC7C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 11:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B88B2070E
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 11:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF3l87/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfKVLJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:09:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35581 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731115AbfKVLJx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 06:09:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id s5so8146501wrw.2
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 03:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uA/Dm1E6RE4RJqeIABikS8ebahO+jgbbk6TXEabhZRM=;
        b=bF3l87/RdHg9H20cX1EmklzssaVhnOVPAyHeozSc0qv/Dw5ZdMDZq0EKrlZ7VTvy8O
         Hlcg7IzNLpD5ONd6dmSISNrSF+AqUmK0+l3pjAXAAdOWUe/rkalAnxsbMZO+pRvvZt5R
         9nYEjI7d5GO/cBY0PUX57IVcakIv8FeaHjjPSCFQjT6xKrGoP6nYDNHKuZ3Z2Tv0Yr5p
         S+4UKNob4H1Sw49vulbKwp4Dh1aKg8fbZQoFkViPWK76+360C/36Ggs6gsKemVR2rpR2
         q7D/rxVWhpkZDQdOMcawvRkrRuHcwA6GK2wzZ+aTlalaH2kZw+QLn2d4aOxIBgJea/2P
         UVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uA/Dm1E6RE4RJqeIABikS8ebahO+jgbbk6TXEabhZRM=;
        b=tiz3MB9++/FzEtgku9tMEeFS5vitW6/QL1X7IM+vwUHmwWC9P9JEeRLlN0yqK0o1CS
         gFYuNwpaQ0YJoTSYqsaA+/4HFNnEIFF8c8C7edCh+hcLHF4/0w3OcS8V/yWfcvEUKWia
         rtivoNXLc97xRXzLYK4OYJBmhIekb9E49Bc4P0osI91uoYQXoXxqe8eMnMfi8Qld2c/s
         rzEcvj8sjdVA1epkDiQkK1LSg7Gm4Kr8LpLbs8uvbwmt0amgYqyI9czBmoIA4x0O+jNr
         quOA3D7eMPm3N9rkpoYqjpX92bZ6vcJqakb9AtV9f7Tc4LKA12zpo9zLuaLU6uU4YE28
         Takw==
X-Gm-Message-State: APjAAAXnTQEbLTj6485k+FkApNCM5GGoVK5FNjEVOTavC41QUiOdgFL/
        yzG5SGfXl5DkhJpgz8pQvck=
X-Google-Smtp-Source: APXvYqzSgoTk8Ioi6DjuHClZzwYiwnXk7Kq8qEmfMcyrOmaIFJM/vY348r10xEJq2DLo3HGDWI30yw==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr16632105wrt.229.1574420992334;
        Fri, 22 Nov 2019 03:09:52 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-28-211.as13285.net. [92.22.28.211])
        by smtp.gmail.com with ESMTPSA id c9sm2855467wmb.42.2019.11.22.03.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2019 03:09:51 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] sequencer: fix empty commit check when amending
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.467.git.1574345181.gitgitgadget@gmail.com>
 <7d34c0ff805b8637b23d0ef0045370dfc931a3af.1574345181.git.gitgitgadget@gmail.com>
 <xmqqblt44d3h.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b314c0b1-0e01-c8ea-bef2-7d1191b9080a@gmail.com>
Date:   Fri, 22 Nov 2019 11:09:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqblt44d3h.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

(sorry dscho I forgot to CC you on this patch)

On 22/11/2019 06:52, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +	if (!(flags & ALLOW_EMPTY)) {
>> +		struct commit *first_parent = current_head;
> 
> I would have used first_parent_tree variable instead here.  That
> way, you did not have to have an overlong ternary expression down
> there, I expect.

But current_head may be NULL so we'd end up with the equivalent of the 
ternary expression up here or an if/else to handle it. I thought it was 
clearer to find the parent we want to use and then get the tree from it.

> 
>> +		if (flags & AMEND_MSG) {
>> +			if (current_head->parents) {
>> +				first_parent = current_head->parents->item;
>> +				if (repo_parse_commit(r, first_parent)) {
>> +					res = error(_("could not parse HEAD commit"));
>> +					goto out;
>> +				}
>> +			} else {
>> +				first_parent = NULL;
>> +			}
>> +		}
>> +		if (oideq(first_parent ? get_commit_tree_oid(first_parent) :
>> +					 the_hash_algo->empty_tree, &tree)) {
> 
> Style.  It often makes the code much easier to read when you strive
> to break lines at the boundary of larger syntactic units.  In this
> (A ? B : C, D) parameter list, ternary A ? B : C binds much tighter
> than the comma after it, so if you are breaking line inside it, you
> should break line after the comma, too, i.e.
> 
> 	oideq(first_parent
> 	      ? get_commit_tree_oid(first_parent)
> 	      : the_hash_algo->empty_tree,
> 	      &tree)

I agree that's a clearer way of writing it. I'll re-roll with that

Best Wishes

Phillip

> to avoid appearing if C and D have closer relationship than B and C,
> which your version gives.
> 
> But I hope that it becomes a moot point, if we computed first_parent_tree
> inside the new "if (flags & AMEND_MSG)" block to leave this oideq()
> just
> 
> 	if (oideq(first_parent_tree, &tree)) {
> 
