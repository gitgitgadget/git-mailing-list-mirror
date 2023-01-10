Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7718CC46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 10:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237948AbjAJKfe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 05:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbjAJKfb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 05:35:31 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E5F4C718
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 02:35:29 -0800 (PST)
Received: from 97e1b4bd.skybroadband.com ([151.225.180.189] helo=[192.168.0.6])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pFByZ-0009ks-9L;
        Tue, 10 Jan 2023 10:35:28 +0000
Message-ID: <f2e69f51-ae92-4383-d86d-4d5d29c684a6@iee.email>
Date:   Tue, 10 Jan 2023 10:35:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/5] sparse-index API: fix TODO, BUG() out on NULL
 ensure_full_index()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
 <patch-3.5-d96388acef6-20230110T060340Z-avarab@gmail.com>
Content-Language: en-US
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <patch-3.5-d96388acef6-20230110T060340Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/01/2023 06:17, Ævar Arnfjörð Bjarmason wrote:
> Make the ensure_full_index() function stricter, and have it only
> accept a non-NULL "struct index_state". This function (and this
> behavior) was added in [1].
>
> The only reason it needed to be this lax was due to interaction with
> repo_index_has_changes(). See the addition of that code in .

Missing reference. Should this be [2]?

> This
> fixes one of the TODO comments added in 0c18c059a15, the other one was
> already removed in [3].
>
> The other reason for why this was needed dates back to interaction
> with code added in [4]. In [5] we started calling ensure_full_index()
> in unpack_trees(), but the caller added in 34110cd4e39 wants to pass
> us a NULL "dst_index". Let's instead do the NULL check in
> unpack_trees() itself.
>
> 1. 4300f8442a2 (sparse-index: implement ensure_full_index(), 2021-03-30)
> 2. 0c18c059a15 (read-cache: ensure full index, 2021-04-01)
> 3. d76723ee531 (status: use sparse-index throughout, 2021-07-14).
> 4. 34110cd4e39 (Make 'unpack_trees()' have a separate source and
>     destination index, 2008-03-06)
> 5. 6863df35503 (unpack-trees: ensure full index, 2021-03-30)
>
> Signed-off-by: Ævar Arnfjörð Bjarmason<avarab@gmail.com>
--
Philip
