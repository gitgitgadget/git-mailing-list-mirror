Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53B8C3F2D1
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 17:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A803724658
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 17:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qARE9hMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgCDRSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:18:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52306 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgCDRSe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 12:18:34 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09F6B5BEC8;
        Wed,  4 Mar 2020 12:18:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gapx/b1MEllhvmj8SdxoYb/71lI=; b=qARE9h
        MIT35UgUsIymOTOtNvZ0W68+GflLfMzs8J5fef6VjJZEaozT95hyf4z13u2iLlj2
        XQBdT/gJTTk7aL4P4SD9CnV5/u9bkrsnRcvObN5QTRlGDzGPwzeFJt2P0WthSuui
        G+EYPGA8xmiH+5qN00Wqr+smuUKo2bmMoDJPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eqlgwnWrtSFrm0+KepNAVxGCDgVo06+P
        oiaXxfG3u23TKaE47uX3lAtt7d2f1KZEvEf7Q8HoHtHbwYAFqzZBMoriXqY0dpEI
        jYprToCMQYH93xWMuTcMHhqZtL/hL0+TIPp7Yk+BOzXYBGabV7v49EdBX3w/sMyr
        PG1Rj/LnIvI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01F055BEC7;
        Wed,  4 Mar 2020 12:18:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 632885BEC5;
        Wed,  4 Mar 2020 12:18:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, rcdailey.lists@gmail.com, newren@gmail.com,
        rsbecker@nexbridge.com, annulen@yandex.ru, tytso@mit.edu
Subject: Re: [PATCH v4] pull: warn if the user didn't say whether to rebase or to merge
References: <20200304022931.2469455-1-alexhenrie24@gmail.com>
Date:   Wed, 04 Mar 2020 09:18:30 -0800
In-Reply-To: <20200304022931.2469455-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Tue, 3 Mar 2020 19:29:31 -0700")
Message-ID: <xmqq4kv45995.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BCEB0F6-5E3C-11EA-BBEE-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> - Revise warning message based on Junio's feedback
> - Consistently wrap warning lines to 75 characters for easy viewing in
> PO files

Nice to see attention to such a detail ;-)

> - Fix test failures

Ah, OK, hmmm.  

For --quiet test, that wants to ensure that "pull --quiet" does not
say anything, it certainly stops the test from failing if we set the
configuration before executing such a test, but I wonder if that is
in line with the spirit of the feature the test tries to protect in
the first place.  I would imagine those who write "pull --quiet" in
automation would not want to see any non-error message, and because
this is not an error, they do not want to see any output.  Shouldn't
such a use of "pull --quiet" bypass this warning, too?

> ---
>  builtin/pull.c          | 15 +++++++++++++++
>  t/t5521-pull-options.sh |  3 ++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 3e624d1e00..351b933c4d 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -327,6 +327,21 @@ static enum rebase_type config_get_rebase(void)
>  	if (!git_config_get_value("pull.rebase", &value))
>  		return parse_config_rebase("pull.rebase", value, 1);
>  
> +	if (!opt_ff || strcmp(opt_ff, "--ff-only")) {

If we want to squelch the warning under "--quiet", I think we can do
this.

	if (0 < opt_verbosity &&
	    (!opt_ff || strcmp(opt_ff, "--ff-only"))) {

and ...


> +		warning(_("Pulling without specifying how to reconcile divergent branches is\n"
> ...
> diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
> index ccde8ba491..6e890ec936 100755
> --- a/t/t5521-pull-options.sh
> +++ b/t/t5521-pull-options.sh
> @@ -8,7 +8,8 @@ test_expect_success 'setup' '
>  	mkdir parent &&
>  	(cd parent && git init &&
>  	 echo one >file && git add file &&
> -	 git commit -m one)
> +	 git commit -m one) &&
> +	git config pull.rebase false

... this change can safely go.

If we agree that "git pull --quiet" should stay quiet in an
environment where the user has been happy with the default choice,
that is.  I am raising this issue to invite others to think about
it, and I am on the fence, but I am leaning towards saying "yes".

>  '

Regardless of what the resolution for "pull --quiet" would be,
shouldn't we have a test for this change to ensure that we do warn
under the condition we should, and that we do not do so when we
should not?

Thanks.

