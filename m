Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2174CC43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 21:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbiGGVwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 17:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbiGGVwq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 17:52:46 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8287C59258
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 14:52:45 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 01D251B0213;
        Thu,  7 Jul 2022 17:52:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dSgCFaZZS0oV8col6j2vXUWDwLpkfy0p/bjKwJ
        GGVwQ=; b=vitrob8kABoOWzB+0WjKjtdFH0mriThhAKscrs6uPUNlLlOsBzXmVg
        AEw3A7IItjgS4aRrDQYhoVjr5MdP983Wf6uKiFIIJHFcFdYNry/ayhxgxZW0FSX7
        f6Zr5eawnjCJpjblnNxW5vnPCfC4DlcJcxSqb0udU5dVAB0Wu+wZM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EE62B1B0212;
        Thu,  7 Jul 2022 17:52:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E561F1B0211;
        Thu,  7 Jul 2022 17:52:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/4] revision: improve commit_rewrite_person()
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
        <20220707161554.6900-1-siddharthasthana31@gmail.com>
        <20220707161554.6900-2-siddharthasthana31@gmail.com>
Date:   Thu, 07 Jul 2022 14:52:38 -0700
In-Reply-To: <20220707161554.6900-2-siddharthasthana31@gmail.com> (Siddharth
        Asthana's message of "Thu, 7 Jul 2022 21:45:51 +0530")
Message-ID: <xmqq4jzszj2x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F1583DA-FE3F-11EC-AEC0-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> @@ -3835,8 +3859,8 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
>  		if (!buf.len)
>  			strbuf_addstr(&buf, message);
>  
> -		commit_rewrite_person(&buf, "\nauthor ", opt->mailmap);
> -		commit_rewrite_person(&buf, "\ncommitter ", opt->mailmap);
> +		const char *commit_headers[] = { "author ", "committer ", NULL };

This is decl-after-statement our codebase avoids.

> +		commit_rewrite_person(&buf, commit_headers, opt->mailmap);
>  	}
>  
>  	/* Append "fake" message parts as needed */
