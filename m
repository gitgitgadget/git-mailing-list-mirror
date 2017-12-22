Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0C991F406
	for <e@80x24.org>; Fri, 22 Dec 2017 19:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756218AbdLVTeQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 14:34:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59171 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752224AbdLVTeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 14:34:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30EC0BBEA0;
        Fri, 22 Dec 2017 14:34:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/rZXc1uA60DS4Pvkc5Nr6s4DwIA=; b=QEoWLp
        GCJfjQtjEGDpY+3id67TrNp5/qQX1AnO33Y/SBYpBn5F7MlPGlFsHQLJC/Ejpcjy
        OsmvxGdsQ2F/8I4WCNnDTQIHlxEKmmaJkp4hSR6j2LRm5j69CwR+3L68gBwEJgdg
        ZRWv8Ittyx99ln6Lz2tWpWhtxCwDeCHZpQRMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iM96m1HYJuccVcKGDweSpfwoN+W+WQqu
        7Xgicyv0ye9RfrbqPC7+g6Ed6OKDCo2kWj6XvJU48Cs5W3VuWDJcq7PZMbuhHFhr
        zvYyOq5KwuHmF8dJO27rZHeMmL1S0mIeb4pLzN7XzFNmrS22Mgtwzx3xV1A2bI3/
        1LVwWCHVSxo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28214BBE9F;
        Fri, 22 Dec 2017 14:34:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A0A11BBE9E;
        Fri, 22 Dec 2017 14:34:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH 2/5] t/lib-submodule-update.sh: Fix test ignoring ignored files in submodules
References: <20171219222636.216001-1-sbeller@google.com>
        <20171219222636.216001-3-sbeller@google.com>
Date:   Fri, 22 Dec 2017 11:34:13 -0800
In-Reply-To: <20171219222636.216001-3-sbeller@google.com> (Stefan Beller's
        message of "Tue, 19 Dec 2017 14:26:33 -0800")
Message-ID: <xmqq7etesgju.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17DA6F24-E74F-11E7-A49A-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> It turns out that this buggy test passed due to the buggy implementation,
> which will soon be corrected.  Let's fix the test first.

Please clarify "buggy test".  Without the original discussion (I am
imagining there is something that happened on the list recently),
here is my guess:

    We tried to make sure that an ignored file is $distimmed by
    $gostak, but forgot to tell the exclude mechanism that the path
    'sub1'ignored' we use for the test is actually ignored, so the
    fact that the file was not $distimmed when $gostak did its thing
    meant nothing---mark any path whose name is 'ignored' as ignored
    to really test the condition we want to test.

but I do not exactly know what verb to replace $distim and what noun
to replace $gostak above ;-)

Also, wouldn't this expose a bug in the implementation if that is
the case?

Thanks.

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/lib-submodule-update.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index d7699046f6..fb0173ea87 100755
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -885,6 +885,7 @@ test_submodule_switch_recursing_with_args () {
>  		(
>  			cd submodule_update &&
>  			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
> +			echo ignored >.git/modules/sub1/info/exclude &&
>  			: >sub1/ignored &&
>  			$command replace_sub1_with_file &&
>  			test_superproject_content origin/replace_sub1_with_file &&
