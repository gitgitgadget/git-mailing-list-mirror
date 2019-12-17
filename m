Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3C2C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 19:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695492082E
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 19:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lSvQaIxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfLQTBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:01:30 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63557 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLQTBa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 14:01:30 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8183E9AE96;
        Tue, 17 Dec 2019 14:01:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4E6zQLJAvtP6VV8JJvLpq0+eI20=; b=lSvQaI
        xeZsmzCdnK9bmO4xT0IMIA9FCI+5Tz/YjOLDthz1Okr5tlHDd2/eIBXGA5rSnKLo
        wZ8vrUMSw/aQYs4KkdCQ6NuwKK4LrmcQ7/9HeKZRdcxxN8MtZJB/jp7xQb5V0wF7
        a3Hi9YXscajGWyQKepuMJjjlkQ/JPu4/WOQqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KCtGXqc6iyq9nUiP8RnFGCJGqnhQI1WZ
        5XyVZLm3NIwnFNfWw7WBx1x0/hRp3cFP51vtUOgAXwMZ2LEj/vY5NEGUOY+XB0Ma
        HaSz8wXOr5Ba5KIFWPl94Zhgr9QpCuND9lkLcOVxZiQ05LQkVXhY/eQo8fwxEKON
        91V1r8ixVeE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7ACB69AE95;
        Tue, 17 Dec 2019 14:01:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AEE689AE92;
        Tue, 17 Dec 2019 14:01:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 13/15] t1409: use test_path_is_missing()
References: <cover.1576583819.git.liu.denton@gmail.com>
        <27b32962427e5b74569b08dc4c0de40b67388615.1576583819.git.liu.denton@gmail.com>
Date:   Tue, 17 Dec 2019 11:01:23 -0800
In-Reply-To: <27b32962427e5b74569b08dc4c0de40b67388615.1576583819.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 17 Dec 2019 04:01:38 -0800")
Message-ID: <xmqqbls6hj3w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FC2F118-20FF-11EA-99E9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> The test_must_fail() function should only be used for git commands since
> we should assume that external commands work sanely. Replace
> `test_must_fail test -f` with `test_path_is_missing` since we expect
> these files to not exist.

s/these files/these paths/; 

"! test -f FOO" allowed FOO to be a directory, but by using
test_path_is_missing we are no longer allowing FOO to exist in any
form.  I think the changes are correct, but rephrasing "files" to
"paths" would emphasize the reason why it is a good change, I would
say.

Thanks.


> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/t1409-avoid-packing-refs.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
> index f74d890e82..be12fb6350 100755
> --- a/t/t1409-avoid-packing-refs.sh
> +++ b/t/t1409-avoid-packing-refs.sh
> @@ -27,15 +27,15 @@ test_expect_success 'setup' '
>  '
>  
>  test_expect_success 'do not create packed-refs file gratuitously' '
> -	test_must_fail test -f .git/packed-refs &&
> +	test_path_is_missing .git/packed-refs &&
>  	git update-ref refs/heads/foo $A &&
> -	test_must_fail test -f .git/packed-refs &&
> +	test_path_is_missing .git/packed-refs &&
>  	git update-ref refs/heads/foo $B &&
> -	test_must_fail test -f .git/packed-refs &&
> +	test_path_is_missing .git/packed-refs &&
>  	git update-ref refs/heads/foo $C $B &&
> -	test_must_fail test -f .git/packed-refs &&
> +	test_path_is_missing .git/packed-refs &&
>  	git update-ref -d refs/heads/foo &&
> -	test_must_fail test -f .git/packed-refs
> +	test_path_is_missing .git/packed-refs
>  '
>  
>  test_expect_success 'check that marking the packed-refs file works' '
