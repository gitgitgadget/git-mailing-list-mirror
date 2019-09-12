Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 728271F463
	for <e@80x24.org>; Thu, 12 Sep 2019 18:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfILSCs (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 14:02:48 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55566 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfILSCr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 14:02:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5707E8AAEE;
        Thu, 12 Sep 2019 14:02:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ymDKFP0s/Bqc2PLLandsb9khv+4=; b=iZpFnW
        pyleHeChB76EIStxStQeJTCtVyuDwMyoVdTKybPywvPegl0KC/JeWHqjCQP4A22a
        Og/6NLUHwcrx/t9cS+LfndaKAH2m2vK6h9tSyXD1Do36KSlnV2RGUJGAbYJcifU6
        34p2IiNj8m1L8nxoxpvYwYNgjkLzachEmStPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gXpBbF9+ChSyjfrNwHSp6yaIx0EiNTZG
        LyVN7s0vFCSkkuj907zVi45BCFeTszkqCzQh0bYn3Qv11mxptPo68+iQDoHA+pnR
        DlLvTB7DAgSUUSKqTjOkt+nhIWxw0CxzSsSgayi9DBnusyWGzwsm9Oz8F1NhDXlT
        QthAdRzw5/o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E2958AAED;
        Thu, 12 Sep 2019 14:02:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 74A918AAEC;
        Thu, 12 Sep 2019 14:02:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>, git@vger.kernel.org
Subject: Re: pd/fetch-jobs, was Re: What's cooking in git.git (Sep 2019, #01; Sat, 7)
References: <xmqqd0gcm2zm.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1909111359150.5377@tvgsbejvaqbjf.bet>
Date:   Thu, 12 Sep 2019 11:02:42 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1909111359150.5377@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 11 Sep 2019 14:01:14 +0200
        (CEST)")
Message-ID: <xmqq8sqtgzp9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85480B02-D587-11E9-8A3C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> * pd/fetch-jobs (2019-08-13) 5 commits
>>  . fetch: make --jobs control submodules and remotes
>>  . fetch: add the --submodule-fetch-jobs option
>>  . fetch: add the fetch.jobs config key
>>  . fetch: add the "--fetch-jobs" option
>>  . fetch: rename max_children to max_children_for_submodules
>>
>>  "git fetch --jobs" is getting taught to also run fetch jobs in
>>  parallel when fetching from multiple remote repositories.
>>
>>  Comments?
>
> I still stand by my suggestion that it is undesirable (and makes the
> code much more complicated than necessary) to end up with three options.
> Having only `--jobs=<n>` would be the ideal solution.

I think exposing "--jobs" as the primary UI element is a good longer
term goal; the approach taken in the intermediate step would be a
necessary one for backward compatibility.

I stopped carrying it in 'pu' some weeks ago (I suspect it had some
interactions with other topics in flight, by causing either test
failures or textual conflicts).  Perhaps somebody interested enough
in the topic can resurrect it.





