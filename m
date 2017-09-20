Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D74CE2047F
	for <e@80x24.org>; Wed, 20 Sep 2017 02:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbdITCuL (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 22:50:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52942 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750733AbdITCuK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 22:50:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BF9A94795;
        Tue, 19 Sep 2017 22:50:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pYTVrki6rfCh
        mjm/DDMxOXEHdSo=; b=CnYZRWC69FOqdiqRu6kvmkCfeZQgXNFFqtP1e1ewG7/4
        +b0rd/4TVDoip3OPb0j9csSc5Xio0fYZjRTTZoQI9iwMrOCG/7XSlWztLB2pBHIf
        IaqEba1VP6mHzvmFizMdB+fDXOq2Axkka11TEokdmSOdYavoruPPDyn998EOoRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=M5WTTe
        ubgOHtQLuZ9nQUGZ8IPLeuVrMtjf4K9Yav+o0PtTlLbsayCzmtyKQbXC/gKpzuRD
        QC3e1oxujzbGsvKBAUms48KInMD7O1YK09dLZ5vXn+tdoPnvgXyIV8UVHdF4vs1b
        3cH7/qkW7qPj262+Q03obAKuJ11tVwPWmrfys=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8543E94794;
        Tue, 19 Sep 2017 22:50:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB47C94792;
        Tue, 19 Sep 2017 22:50:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t4014: strengthen search patterns
References: <0102015e9a2d5d25-e34b7c98-1662-4cfe-9eb8-50dc56c36240-000000@eu-west-1.amazonses.com>
Date:   Wed, 20 Sep 2017 11:50:07 +0900
In-Reply-To: <0102015e9a2d5d25-e34b7c98-1662-4cfe-9eb8-50dc56c36240-000000@eu-west-1.amazonses.com>
        (Kaartic Sivaraam's message of "Tue, 19 Sep 2017 12:46:57 +0000")
Message-ID: <xmqqingeozhc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6A3406EE-9DAE-11E7-977C-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> The regex patterns for some failing test cases were a bit loose
> giving way for a few incorrect outputs being accepted as correct
> outputs.

If these were part of scripted Porcelain that needs to take any
end-user input, then having '.' that are meant to match only a dot
is a bug, but I personally do not think it is worth the patch noise
to quote them, when we _know_ (after all, we are in control of the
data we use for these tests) there is no other lines that would
match these patterns.



> To avoid such incorrect outputs from being flagged as correct ones
> use fixed string matches when possible and strengthen regex when
> it's not.
>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  t/t4014-format-patch.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 482112ca339f0..7dff7996c9e1f 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -163,7 +163,7 @@ test_expect_failure 'additional command line cc (rf=
c822)' '
>  	git config --replace-all format.headers "Cc: R E Cipient <rcipient@ex=
ample.com>" &&
>  	git format-patch --cc=3D"S. E. Cipient <scipient@example.com>" --stdo=
ut master..side | sed -e "/^\$/q" >patch5 &&
>  	grep "^Cc: R E Cipient <rcipient@example.com>,\$" patch5 &&
> -	grep "^ *\"S. E. Cipient\" <scipient@example.com>\$" patch5
> +	grep "^ *\"S\. E\. Cipient\" <scipient@example\.com>\$" patch5
>  '
> =20
>  test_expect_success 'command line headers' '
> @@ -191,13 +191,13 @@ test_expect_success 'command line To: header (asc=
ii)' '
>  test_expect_failure 'command line To: header (rfc822)' '
> =20
>  	git format-patch --to=3D"R. E. Cipient <rcipient@example.com>" --stdo=
ut master..side | sed -e "/^\$/q" >patch8 &&
> -	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" patch8
> +	grep -F "To: \"R. E. Cipient\" <rcipient@example.com>" patch8
>  '
> =20
>  test_expect_failure 'command line To: header (rfc2047)' '
> =20
>  	git format-patch --to=3D"R =C3=84 Cipient <rcipient@example.com>" --s=
tdout master..side | sed -e "/^\$/q" >patch8 &&
> -	grep "^To: =3D?UTF-8?q?R=3D20=3DC3=3D84=3D20Cipient?=3D <rcipient@exa=
mple.com>\$" patch8
> +	grep "^To: =3D?UTF-8?q?R=3D20=3DC3=3D84=3D20Cipient?=3D <rcipient@exa=
mple\.com>\$" patch8
>  '
> =20
>  test_expect_success 'configuration To: header (ascii)' '
> @@ -211,14 +211,14 @@ test_expect_failure 'configuration To: header (rf=
c822)' '
> =20
>  	git config format.to "R. E. Cipient <rcipient@example.com>" &&
>  	git format-patch --stdout master..side | sed -e "/^\$/q" >patch9 &&
> -	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" patch9
> +	grep -F "To: \"R. E. Cipient\" <rcipient@example.com>" patch9
>  '
> =20
>  test_expect_failure 'configuration To: header (rfc2047)' '
> =20
>  	git config format.to "R =C3=84 Cipient <rcipient@example.com>" &&
>  	git format-patch --stdout master..side | sed -e "/^\$/q" >patch9 &&
> -	grep "^To: =3D?UTF-8?q?R=3D20=3DC3=3D84=3D20Cipient?=3D <rcipient@exa=
mple.com>\$" patch9
> +	grep "^To: =3D?UTF-8?q?R=3D20=3DC3=3D84=3D20Cipient?=3D <rcipient@exa=
mple\.com>\$" patch9
>  '
> =20
>  # check_patch <patch>: Verify that <patch> looks like a half-sane
>
> --
> https://github.com/git/git/pull/406
