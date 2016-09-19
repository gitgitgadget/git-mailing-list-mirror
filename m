Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 424CE2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 18:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932392AbcISSWF (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 14:22:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56254 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932237AbcISSWE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 14:22:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DF7B3F8AB;
        Mon, 19 Sep 2016 14:22:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zvWLutKCSjs950Jsci5XOXbamMk=; b=wkURcg
        wJddLsYPuk6KSFKjT5IogjJfmR27ig9rZnNdXa96znMh8+a9FBU2P3eBVN2jCTfr
        HQS8B1ohC20QfvT6mWXrjEHiTqXfltrOW56QtyiWvzwJd9Py54JaV4wEg882oNxG
        XTOg4103q787DAaimbmc5g6857WU/qRRYEkLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b/afECzU5+aAAC+rOKUDxkLPLChXY3HJ
        rQn8TFsKmz/8DRWdscHPxPqsZ2tjOsPq6JFDlnHW+iEq+6HS9WDpukkes4qDSutG
        cCkm+ZiKxZuHVMrW7bIvP0JzGVuDoeDT4YV32rS5ow8H7F71wzFSQuX2/FGfTBrc
        MkNA09bN9C0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05E663F8AA;
        Mon, 19 Sep 2016 14:22:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D1993F8A9;
        Mon, 19 Sep 2016 14:22:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] ls-files: add pathspec matching for submodules
References: <CAKoko1pewoxD4=_9M45pchdDg03K8fc73raJOsf4A+=KKw_EMw@mail.gmail.com>
        <1474073981-96620-1-git-send-email-bmwill@google.com>
        <xmqqtwdfgpd0.fsf@gitster.mtv.corp.google.com>
        <CAKoko1r6cfv-2HVCJPgGbXyCVe-wdUBS+2nXtaTHO3jshVg8MA@mail.gmail.com>
        <xmqqvaxrg6zt.fsf@gitster.mtv.corp.google.com>
        <CAKoko1r_WATxJzxQrQW2VBkhuKquv=yQv6sB_eCMgH6qavS__Q@mail.gmail.com>
        <xmqq1t0fg417.fsf@gitster.mtv.corp.google.com>
        <CAKoko1oSvBF3=-hvSGVMQYpZkUvnwAEYg=U-g8927F6dt4Q8mA@mail.gmail.com>
Date:   Mon, 19 Sep 2016 11:22:00 -0700
In-Reply-To: <CAKoko1oSvBF3=-hvSGVMQYpZkUvnwAEYg=U-g8927F6dt4Q8mA@mail.gmail.com>
        (Brandon Williams's message of "Mon, 19 Sep 2016 11:20:19 -0700")
Message-ID: <xmqqshsveomv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6162BBC-7E95-11E6-A4EA-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Yes in that case it wouldn't have passed ps_strncmp()...but we should have never
> made it there in the first place due to a piece of logic in match_pathspec_item:

Ah, OK.

Thanks for clarifying.
