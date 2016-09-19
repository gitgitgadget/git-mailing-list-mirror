Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 503C72070F
	for <e@80x24.org>; Mon, 19 Sep 2016 18:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932676AbcISSen (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 14:34:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59992 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932392AbcISSei (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 14:34:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 65A533FE59;
        Mon, 19 Sep 2016 14:34:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x2P8ypC9xBYNoqAi446P65geWNs=; b=IEixH6
        Jg9PhQdY0C3t5+a57bN0BxqQZycnXKE834uamK0mN+1Lz2m/Vl0Yw0mfGqXq381n
        EagdhiguXIS73yPhXbeieQ5X8smjtgBcAE1npqLtPWaGdBLtItJJ8X9AhMbnIseV
        nFeUnqF0a1b0BI9xZlFPcEt36wYZ7qu+bLw9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TCrmICVtk/RQEoOByCPzSfsku2U0U0X8
        zeviWqxT1LQ5lDlcs5c4q8urDWvWwKAuatCXG8RVfBjdO9ADiAP4DjiJqniSQcQq
        5C360kNXM1VoLYK62Rl168QN8an1Ky/r0N6KBvlluNPB8CtKxV57EEwi/yxUQ9+H
        UsC3QSdaPMc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DFCB3FE58;
        Mon, 19 Sep 2016 14:34:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D54AF3FE57;
        Mon, 19 Sep 2016 14:34:35 -0400 (EDT)
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
        <xmqqshsveomv.fsf@gitster.mtv.corp.google.com>
        <CAKoko1rULusRdcw7_u0QRfn590uTAZyOTk4JS6b8oopaSDLNDQ@mail.gmail.com>
Date:   Mon, 19 Sep 2016 11:34:33 -0700
In-Reply-To: <CAKoko1rULusRdcw7_u0QRfn590uTAZyOTk4JS6b8oopaSDLNDQ@mail.gmail.com>
        (Brandon Williams's message of "Mon, 19 Sep 2016 11:30:03 -0700")
Message-ID: <xmqqoa3jeo1y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B71FF6CA-7E97-11E6-B808-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> side question if the answer is short:  Any reason as to why all of the
> pathspec matching code lives inside of dir.c and not pathspec.c?

Hysterical Raisins.

A pathspec used to be just a "const char **" in simpler times, which
was no more elaborate than "argv + i" (i.e. after parsing options
and revisions out, the remainders are pathspec elements).  Major
part of the matching was done inside dir.c and we haven't had chance
to look at the larger picture to move the code around.
