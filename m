Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B23CC433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 20:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537B86103D
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 20:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbhDOUWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 16:22:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57427 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbhDOUWI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 16:22:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 838D91237ED;
        Thu, 15 Apr 2021 16:21:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RNx6d5WKIX2jc2V4vDMGemr+I2k=; b=OVoOuk
        /i91smMWKq9T5MBmQkA1g/UrwDJfITcbVBu2kv7Dy7adB0OsEQ9ZfNNuA7WN/CEr
        Pyl2ItzMmUxZD84xyUk7sJ7knv9okeK3FnqH37l68QVsbFjDhoUuAM8jQpKo9DXF
        NNirxa98kdlqT4xzUVIbZztdFcG/7gG+NB11s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kmuFRc17aICa3pNHW6/BeQwlEb6Rclqb
        fy8MaKAgtndGHLFhwn9BqyX1qoNv5RwFMwHOwk95ns0UJzFo82849djMEoXd27e5
        20/+qbpPNjcoC6M+lOdoFr9R+y7rQY8UqoAJh5jo5GGEFTQSpWTzFzDjc3HQFgTq
        Yk/nWBCu2Uk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C0BC1237EC;
        Thu, 15 Apr 2021 16:21:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C37961237EB;
        Thu, 15 Apr 2021 16:21:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 4/5] diff-merges: introduce log.diffMerges config
 variable
References: <20210407225608.14611-1-sorganov@gmail.com>
        <20210413114118.25693-1-sorganov@gmail.com>
        <20210413114118.25693-5-sorganov@gmail.com>
Date:   Thu, 15 Apr 2021 13:21:40 -0700
In-Reply-To: <20210413114118.25693-5-sorganov@gmail.com> (Sergey Organov's
        message of "Tue, 13 Apr 2021 14:41:17 +0300")
Message-ID: <xmqqpmyvpacr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 31502474-9E28-11EB-B790-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 04ce884ef5ac..4d732d6d4f81 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -2306,6 +2306,7 @@ test_expect_success 'git config - variable name' '
>  	test_completion "git config log.d" <<-\EOF
>  	log.date Z
>  	log.decorate Z
> +	log.diffMerges Z
>  	EOF
>  '
>  
> @@ -2327,6 +2328,7 @@ test_expect_success 'git -c - variable name' '
>  	test_completion "git -c log.d" <<-\EOF
>  	log.date=Z
>  	log.decorate=Z
> +	log.diffMerges=Z
>  	EOF
>  '
>  
> @@ -2348,6 +2350,7 @@ test_expect_success 'git clone --config= - variable name' '
>  	test_completion "git clone --config=log.d" <<-\EOF
>  	log.date=Z
>  	log.decorate=Z
> +	log.diffMerges=Z
>  	EOF
>  '

$ sh ./t9902-completion.sh -i -v

ends like the attached.  Is there a prerequisite patch I am missing,
or something?


ok 195 - git config - section

expecting success of 9902.196 'git config - variable name':
        test_completion "git config log.d" <<-\EOF
        log.date Z
        log.decorate Z
        log.diffMerges Z
        EOF

--- expected    2021-04-15 20:20:09.652861741 +0000
+++ out_sorted  2021-04-15 20:20:09.660862400 +0000
@@ -1,3 +1,2 @@
 log.date
 log.decorate
-log.diffMerges
not ok 196 - git config - variable name
#
#               test_completion "git config log.d" <<-\EOF
#               log.date Z
#               log.decorate Z
#               log.diffMerges Z
#               EOF
#
:
