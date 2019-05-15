Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDA671F461
	for <e@80x24.org>; Wed, 15 May 2019 02:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfEOCwH (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 22:52:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59467 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfEOCwH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 22:52:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D78E699E7;
        Tue, 14 May 2019 22:52:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=h49sxjIu4bIP
        8Qe1uaLD90Z16m4=; b=XxazbmeRCBa6B3E++Wm7fmvRurvUwo3yVZK/CIhG2hRS
        9DDWUxLRC4EOT2tdpk2TrKcUKp7jYOv8AwzJ7qOu8n2bYCyPrJEF0eqanevnqEYC
        yDFMOArSp79i2glu7bszeZF25g+EfrFTSgm6vf1kcR0M7pRhvwh3YmXBXLguA9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=x6/AUd
        ix8h81blG2CN8U1YDtZewIy6g9j/tXOLhRfHsTJq2qdQGiyuXmdaTGv/85wcUE9b
        2riKbH+AZ/cajFIEFqE+8bK0xfp9TGeB+uDHKymZ2X48UEY2rEiLOH1EANp9jpIO
        OdTLbGFkvWUY8TKSWJqRj+IJMdFXsIgHkgtR4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 76C62699E6;
        Tue, 14 May 2019 22:52:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A6CC2699E5;
        Tue, 14 May 2019 22:52:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] merge: add --quit
References: <20190509101028.24656-1-pclouds@gmail.com>
        <20190514091322.12427-1-pclouds@gmail.com>
        <20190514091322.12427-3-pclouds@gmail.com>
Date:   Wed, 15 May 2019 11:52:00 +0900
In-Reply-To: <20190514091322.12427-3-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Tue, 14 May 2019 16:13:22 +0700")
Message-ID: <xmqqpnok77lb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6AAA6FC6-76BC-11E9-B04B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 106148254d..d453710ef6 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -822,4 +822,18 @@ test_expect_success EXECKEEPSPID 'killed merge can=
 be completed with --continue'
>  	verify_parents $c0 $c1
>  '
> =20
> +test_expect_success 'merge --quit' '
> +	git reset --hard c2 &&
> +	test_must_fail git -c rerere.enabled=3Dtrue merge master &&
> +	test_path_is_file .git/MERGE_HEAD &&
> +	test_path_is_file .git/MERGE_MODE &&
> +	test_path_is_file .git/MERGE_MSG &&
> +	test_path_is_file .git/MERGE_RR &&
> +	git merge --quit &&
> +	test_path_is_missing .git/MERGE_HEAD &&
> +	test_path_is_missing .git/MERGE_MODE &&
> +	test_path_is_missing .git/MERGE_MSG &&
> +	test_path_is_missing .git/MERGE_RR
> +'

I'd appreciate to see test_when_finished used in this test so that
later tests, possibly added by another topic in parallel, would
start in a more-or-less reasonable state.


