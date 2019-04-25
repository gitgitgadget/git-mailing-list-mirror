Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2C951F453
	for <e@80x24.org>; Thu, 25 Apr 2019 03:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388810AbfDYDK6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 23:10:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58397 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388690AbfDYDK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 23:10:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0856314DECD;
        Wed, 24 Apr 2019 23:10:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ln1PUyiEMTfRDrlW3GK9RnGe+1E=; b=dTKXiZ
        +tY+Tg/cXsMGp8E5qI1a0/mDTiU/WZDIQW8OOnwiTOq1Dw9AHBM8p7RB9ULsvFp6
        gj0IIdOJbk5UmV/kB76ImuaAJv2DazaRiNsb9E9at1HimoT1TErF23kAJiSTV+Ue
        XhggFyS5HxX53EdLYnDkUwkbqbjgOVJm5YK7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OmyI9SyuO4bEkEvgxrn8N3jDWOC2lntQ
        x6SjwVml5s/B5ktqqUIitpTUe7Ne5UdqyqxO7ZnKh1Jp9CcivK2otTxvsm7+vpua
        +Ej0gJFDdNMZ6u0VvSwmAG9a/zzdSK53+qLEsipq8ytKhRaowN7TfYfurHOGom2e
        jCkXXfqmzwk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00BA514DECC;
        Wed, 24 Apr 2019 23:10:56 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6362B14DECB;
        Wed, 24 Apr 2019 23:10:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 6/6] difftool: fallback on merge.guitool
References: <cover.1556009181.git.liu.denton@gmail.com>
        <cover.1556142510.git.liu.denton@gmail.com>
        <f39b15efbd5c765953737f99aa032230f066c074.1556142510.git.liu.denton@gmail.com>
Date:   Thu, 25 Apr 2019 12:10:54 +0900
In-Reply-To: <f39b15efbd5c765953737f99aa032230f066c074.1556142510.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 24 Apr 2019 15:47:04 -0700")
Message-ID: <xmqq36m6zsn5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD8ED9DA-6707-11E9-AA8F-1646B3964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> @@ -734,8 +728,8 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
>  	if (use_gui_tool + !!difftool_cmd + !!extcmd > 1)
>  		die(_("--gui, --tool and --extcmd are mutually exclusive"));
>  
> -	if (use_gui_tool && diff_gui_tool && *diff_gui_tool)
> -		setenv("GIT_DIFF_TOOL", diff_gui_tool, 1);
> +	if (use_gui_tool)
> +		setenv("GIT_MERGETOOL_GUI", "true", 1);
>  	else if (difftool_cmd) {
>  		if (*difftool_cmd)
>  			setenv("GIT_DIFF_TOOL", difftool_cmd, 1);

So unless difftool_cmd is given explicitly, we'll let the scripted
difftool--helper to let merge_tool=$(get_merge_tool) to pick the
tool, which will use the same logic you wrote in the step 2/6.

OK, that makes sense.

What was preventing the get_configured_merge_tool updated in step
2/6 from getting called in difftool was the exporting of
GIT_DIFF_TOOL we see abovethat was removed by this step.

Which also makes sense.

> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 107f31213d..ae90701a12 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -279,11 +279,27 @@ test_expect_success 'difftool + mergetool config variables' '
>  	echo branch >expect &&
>  	git difftool --no-prompt branch >actual &&
>  	test_cmp expect actual &&
> +	git difftool --gui --no-prompt branch >actual &&
> +	test_cmp expect actual &&
>  
>  	# set merge.tool to something bogus, diff.tool to test-tool
>  	test_config merge.tool bogus-tool &&
>  	test_config diff.tool test-tool &&
>  	git difftool --no-prompt branch >actual &&
> +	test_cmp expect actual &&
> +	git difftool --gui --no-prompt branch >actual &&
> +	test_cmp expect actual &&
> +
> +	# set merge.tool, diff.tool to something bogus, merge.guitool to test-tool
> +	test_config diff.tool bogus-tool &&
> +	test_config merge.guitool test-tool &&
> +	git difftool --gui --no-prompt branch >actual &&
> +	test_cmp expect actual &&
> +
> +	# set merge.tool, diff.tool, merge.guitool to something bogus, diff.guitool to test-tool
> +	test_config merge.guitool bogus-tool &&
> +	test_config diff.guitool test-tool &&
> +	git difftool --gui --no-prompt branch >actual &&
>  	test_cmp expect actual
>  '
