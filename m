Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF04C433DF
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 17:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C8842071B
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 17:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aFf4Q5Au"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgGPRtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:49:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63785 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPRtF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 13:49:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 331D1E773A;
        Thu, 16 Jul 2020 13:49:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E1JcyCng/Jut+VGMXiUgztkIWyY=; b=aFf4Q5
        Au7jiLbQf/UHwk8Vk1wmaEm7J+dtM62zB88qditYewD2g61YQZSU5v9B7LCjMVqQ
        kjbHAWC5rqYJbL2hu3K4h3buoevvfXQzphx6CDzYZ/7doaZ7OHg0A7dVLgtAL7+V
        YJ9Lgmq5wvAj8LAnTpJ4iz8DurxIEV1QcvbGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pAzgXLJilqOy2LVd84zuThqXgFo2orHs
        6yQcYamsw3uO0CfL1UhQCdDYrWnM1VgDXOHBCZwYOMetFjoGKbbZnuKsCPyHdSvK
        JKKdTYtnIHSOvroK1iILdFhgfMFLv5hjDvJ2T68BrtsvFAiao0BG5xlaNitSwH7/
        MWJRVCoicrk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D3D7E7738;
        Thu, 16 Jul 2020 13:49:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 60EB3E7735;
        Thu, 16 Jul 2020 13:49:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 0/3] Add support for %(contents:size) in ref-filter
References: <20200710164739.6616-1-chriscool@tuxfamily.org>
        <20200716121940.21041-1-chriscool@tuxfamily.org>
Date:   Thu, 16 Jul 2020 10:48:58 -0700
In-Reply-To: <20200716121940.21041-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 16 Jul 2020 14:19:37 +0200")
Message-ID: <xmqq8sfjgxkl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1528064-C78C-11EA-A84A-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> The range diff is:
>
> 1:  f750832fc7 = 1:  f750832fc7 Documentation: clarify %(contents:XXXX) doc
> 2:  51c72e09d2 = 2:  51c72e09d2 t6300: test refs pointing to tree and blob
> 3:  c2ed3e228b ! 3:  cf6a60036e ref-filter: add support for %(contents:size)
>     @@ t/t6300-for-each-ref.sh: test_atom() {
>      +  # Automatically test "contents:size" atom after testing "contents"
>      +  if test "$2" = "contents"
>      +  then
>     -+          case "$1" in
>     -+          refs/tags/signed-*)
>     ++          case $(git cat-file -t "$ref") in
>     ++          tag)
>      +                  # We cannot use $3 as it expects sanitize_pgp to run
>      +                  expect=$(git cat-file tag $ref | tail -n +6 | wc -c) ;;
>     -+          refs/mytrees/* | refs/myblobs/*)
>     ++          tree | blob)
>      +                  expect='' ;;
>     -+          *)
>     ++          commit)
>      +                  expect=$(printf '%s' "$3" | wc -c) ;;
>      +          esac
>      +          # Leave $expect unquoted to lose possible leading whitespaces
>      +          echo $expect >expected
>     -+          test_expect_${4:-success} $PREREQ "basic atom: $1 $2:size" "
>     -+                  git for-each-ref --format='%($2:size)' $ref >actual &&
>     -+                  test_cmp expected actual
>     -+          "
>     ++          test_expect_${4:-sucess} $PREREQ "basic atom: $1 contents:size" '
>     ++                  git for-each-ref --format="%(contents:size)" "$ref" >actual &&
>     ++                  test_cmp expect actual
>     ++          '
>      +  fi
>       }

Ah, I almost forgot about this topic X-<, but the above reminds me
and it does read more clearly, at least to me.

Thanks, will replace.
