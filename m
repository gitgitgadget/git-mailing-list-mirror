Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5B2820985
	for <e@80x24.org>; Sun, 25 Sep 2016 23:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035024AbcIYXJs (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 19:09:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60581 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1035015AbcIYXJp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 19:09:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A00AC42038;
        Sun, 25 Sep 2016 19:09:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wO2KIb81cZyvXTYUivGXTJY2Ef4=; b=hDSU6U
        CtqJA7QMyFfX8ygHVKSFJ2neBHmbttS5/wgJqzC6jD+zkBCh1JC4Xu5+3C7Is52X
        0QYvX78E2UsE4ecWiydKCSlXkJ+3+n5xmE01AnPEt0bCq45LVmsWzwldSZjXAA3k
        ATD2iNQ5ySmOVdTIFU/HuYpujnExt5JumflBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wOd2oKIv8OCd2AJfvNmvq2UtkckbwFWi
        hgoanpi/KlWdvJqmfY7CommvCPfyRVDb60R/XkCCSCrGdq+da0/1jKf7rExc84HT
        ktGczmQT955Md5ze53C8U+7zmyEpBXkdsghSspTVn2FSI/0Mzhf90ps8Oy/Nwgoo
        cAa8a9xcU18=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 981F942037;
        Sun, 25 Sep 2016 19:09:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1EBCD42036;
        Sun, 25 Sep 2016 19:09:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 05/11] i18n: add--interactive: mark message for translation
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
        <1472646690-9699-6-git-send-email-vascomalmeida@sapo.pt>
Date:   Sun, 25 Sep 2016 16:09:35 -0700
In-Reply-To: <1472646690-9699-6-git-send-email-vascomalmeida@sapo.pt> (Vasco
        Almeida's message of "Wed, 31 Aug 2016 12:31:24 +0000")
Message-ID: <xmqqbmzby3tc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24227FD6-8375-11E6-BEB3-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> -		print colored $prompt_color, $patch_mode_flavour{VERB},
> -		  ($hunk[$ix]{TYPE} eq 'mode' ? ' mode change' :
> -		   $hunk[$ix]{TYPE} eq 'deletion' ? ' deletion' :
> -		   ' this hunk'),
> -		  $patch_mode_flavour{TARGET},
> -		  " [y,n,q,a,d,/$other,?]? ";

I hate to say this but expanding this single-liner into if/elsif/
cascade of uncountable number of arms is simply a disaster.

> +		if ($patch_mode eq 'stage') {
> +			if ($hunk[$ix]{TYPE} eq 'mode') {
> +			  print colored $prompt_color,
> +			    sprintf(__("Stage mode change [y,n,q,a,d,/%s,?]? "), $other);
> +			} elsif ($hunk[$ix]{TYPE} eq 'deletion') {
> +			  print colored $prompt_color,
> +			    sprintf(__("Stage deletion [y,n,q,a,d,/%s,?]? "), $other);
> +			} else {
> +			  print colored $prompt_color,
> +			    sprintf(__("Stage this hunk [y,n,q,a,d,/%s,?]? "), $other);
> +			}
> +		} elsif ($patch_mode eq 'stash') {
> + ...
> +			}
> +		}

I wonder if you can make a simple helper function so that the caller
here can still be a single-liner:

	print_colored $prompt_color,
             sprintf(patch_update_prompt_string($patch_mode, $hunk[$ix]{TYPE}), $other);
 
where the patch_update_prompt_string helper function would look up
these messages from a table that is looked up by patch-mode and TYPE
and the run __() on it, or something?
