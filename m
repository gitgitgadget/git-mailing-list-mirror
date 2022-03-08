Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140F9C433FE
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 17:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349023AbiCHRVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 12:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349020AbiCHRUt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 12:20:49 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33031C138
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 09:19:39 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EEA0016ADD8;
        Tue,  8 Mar 2022 12:19:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ptrv/z5Yudl0kRp1osITUUI6hDe7/7W1m5I0q6
        WJH5k=; b=h6J/adtrlGV8ra2Xlk/v8sqqt+8hESlzG22gHhx0cVP/fcajgNyUM4
        xJ5QIHTwMF534vfAKCF3xI9IQByQSq2bzcEOAnIrJvqupRAKWiNfTkbp0HiT6dkf
        kC+E101aVp2pvsI18Dxd3Oets1u9X8LxUOVpl3jDfJtTGT0DjlSYA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D2EE316ADD7;
        Tue,  8 Mar 2022 12:19:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2510016ADD6;
        Tue,  8 Mar 2022 12:19:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH v3 12/12] clone: fail gracefully when cloning filtered
 bundle
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
        <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
        <805e1d1172210c6a39b33edcb2cd6d21b754f821.1646750359.git.gitgitgadget@gmail.com>
        <d9e6e3bb-b2ef-dbf4-6969-620b58727115@github.com>
Date:   Tue, 08 Mar 2022 09:19:34 -0800
In-Reply-To: <d9e6e3bb-b2ef-dbf4-6969-620b58727115@github.com> (Derrick
        Stolee's message of "Tue, 8 Mar 2022 11:10:42 -0500")
Message-ID: <xmqqilsonyzd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED021B28-9F03-11EC-B6A9-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 3/8/2022 9:39 AM, Derrick Stolee via GitGitGadget wrote:
>
>> +	if (is_bundle) {
>> +		struct bundle_header header = { 0 };
>> +		int fd = read_bundle_header(path, &header);
>> +		int has_filter = header.filter.choice != LOFC_DISABLED;
>
> Of course, as I was sending an email replying to What's Cooking, I
> realized that I missed one of the suggestions, which is fixed with
> this diff:
>
> --- >8 ---
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 623a5040b1..e57504c2aa 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1140,7 +1140,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	transport->cloning = 1;
>  
>  	if (is_bundle) {
> -		struct bundle_header header = { 0 };
> +		struct bundle_header header = BUNDLE_HEADER_INIT;
>  		int fd = read_bundle_header(path, &header);
>  		int has_filter = header.filter.choice != LOFC_DISABLED;

Let me squash it into 12/12, then.

Thanks.

