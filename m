Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710B3C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 20:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 435DB2067D
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 20:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="akO4/yNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgGGUId (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:08:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54373 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgGGUId (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 16:08:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E759961C92;
        Tue,  7 Jul 2020 16:08:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ikbH4uzHtZhZrYAiCfb/YOchvxs=; b=akO4/y
        NmRHL7vtfStaYV5lnr4OSvefUKwlacJzRLEmXXtKhkPt+c4xstH9HXOXx/OHt3k8
        /4epH3JgUifSfqWBr5MLiOWHm/eMvdsBgKlDjY1rDVf+hhv3/OLFuKYn5++uaWAt
        7lSICHxk8ivuzGNP4vvM8E9hmc+O/pT8rlY0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K7226l/NcC4cQD+z79aLxXkM3isB+/CK
        Nq+bgI2q0nfW2X7Xmry7fiTz1SzuP6wPlMUGBq6KaG5sY+00g0F95lED5ByQu2NN
        zzNYNK5d8hnydmvOvr/IbVDPnPd/WssBrW8LDs/gw+SIgmep5orIR/GSJmeeGgnz
        sDgSF9JMYrc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DEBD961C91;
        Tue,  7 Jul 2020 16:08:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5CAC861C90;
        Tue,  7 Jul 2020 16:08:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RESEND PATCH v2 0/5] t: replace incorrect test_must_fail usage (part 6)
References: <cover.1593576601.git.liu.denton@gmail.com>
        <cover.1594101831.git.liu.denton@gmail.com>
Date:   Tue, 07 Jul 2020 13:08:29 -0700
In-Reply-To: <cover.1594101831.git.liu.denton@gmail.com> (Denton Liu's message
        of "Tue, 7 Jul 2020 02:04:33 -0400")
Message-ID: <xmqqblkr3x6q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0812C04-C08D-11EA-B849-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> The overall scope of these patches is to replace inappropriate uses of
> test_must_fail. IOW, we should only allow test_must_fail to run on `git`
> and `test-tool`. Ultimately, we will conclude by making test_must_fail
> error out on non-git commands. An advance view of the final series can
> be found here[1].
>
> This is the sixth and final(!) part. It cleans up instances of
> `test_must_fail` that were introduced since the effort began. In
> addition, it finally flips the switch and makes test_must_fail only
> allow a whitelist of commands.
>
> This series is based on the merge of 'master' and
> 'dl/test-must-fail-fixes-5'. In addition, this series was tested by
> merging with 'seen~1' (to ignore the reftable failures) to ensure no
> in-flight topics will require more changes.
>
> The first part can be found here[2]. The second part can be found
> here[3]. The third part can be found here[4]. The fourth part can be
> found here[5]. The fifth part can be found here[6].
>
> Changes since v1:
>
> * Add a code comment to force_color()
>
> * Do not allow nested env's in test_must_fail_acceptable()
>
> * Clean up the env-processing case code
>
> * Give an example on how to use `!`.

Thanks for a resend.  Now part #5 is in 'master', I can queue these
directly on top.
