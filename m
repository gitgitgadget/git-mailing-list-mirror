Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E336EB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 20:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjFZUDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 16:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjFZUD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 16:03:28 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BBF26B3
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 13:03:00 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4A9F03507B;
        Mon, 26 Jun 2023 16:02:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RydPX+XfONhTnCMwwWVmuUW9S8YZAj03Vm3vQA
        xOjQw=; b=WfLU8dZFhkqxK5VNxR1f2rCGFbB2xXdGRbwxkdldCnx8mxNdqYmpbg
        HgNjunWAimHQKvGa55sn0MadUU4RDzfay4RzYU8QdV/V3mUuV0epOOfrWocDBdqA
        I8MWGS8y9D1cFDtaGBOP3RFnhoyZWUb6fowJLw7xRdpNVs9stkydA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 353B63507A;
        Mon, 26 Jun 2023 16:02:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 50BB035079;
        Mon, 26 Jun 2023 16:02:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 7/7] var: add config file locations
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
        <20230626190008.644769-1-sandals@crustytoothpaste.net>
        <20230626190008.644769-8-sandals@crustytoothpaste.net>
Date:   Mon, 26 Jun 2023 13:02:29 -0700
In-Reply-To: <20230626190008.644769-8-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 26 Jun 2023 19:00:08 +0000")
Message-ID: <xmqqpm5i3sbu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61AED55A-145C-11EE-9F4D-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>  struct git_var {
>  	const char *name;
>  	char *(*read)(int);
> +	int multivalued;
>  };
>  static struct git_var git_vars[] = {
>  	{
>  		.name = "GIT_COMMITTER_IDENT",
>  		.read = committer,
> +		.multivalued = 0,
>  	},
> ...
> +	{
> +		.name = "GIT_CONFIG_GLOBAL",
> +		.read = git_config_val_global,
> +		.multivalued = 1,
>  	},

As the majority of the variables are singletons and multi-valued
variables are expected to be in minority even in the future, we
would probably want to leave ".multivalued = 0" out of these array
elements and instead let the default zero initialization to take
place, which would make the resulting source less noisy.

Other than that, looks good.

Thanks.
