Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1470A20899
	for <e@80x24.org>; Sun, 20 Aug 2017 16:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753128AbdHTQ2Y (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 12:28:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62974 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753101AbdHTQ2X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 12:28:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23FA7A264B;
        Sun, 20 Aug 2017 12:28:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hZZtXxgXtblDFck8RSibOd+89oQ=; b=dgPc57
        zlGzgZGrMfeIxuhobn8hq48QtdrurNz5Bs/w2ByxYW4WtFPLkrzfUP7IigxtcE4R
        lykGl+zlhom/LU1BzbdUCwNwP61XH5/tieO05nYaiFQCUJi5d/jOUjoeLKcLBpY1
        K6NIvXZ8LuVmLkGnOHMAsBRut9r3QEpV+GKUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D8mnw89+P804l72sH6LVGWQ+X5EQ5BY0
        EOtv2zv3f+fl5X7mK/Kc7Tm/wXoLFkzUThZHpljqnn48CAokvMQVaYRDNZJIeFbQ
        maZHa9BJJ1Dtn66mxCmt/XF5cMrqH/TXkprwhAQmAU+WLfZI+Ta4LZDMNzJtcpMg
        zHv38N37TXc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 19C56A264A;
        Sun, 20 Aug 2017 12:28:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 676B8A2648;
        Sun, 20 Aug 2017 12:28:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Tom G. Christensen" <tgc@jupiterrise.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] http: handle curl with vendor backports
References: <030356f8-0472-7400-c9f6-7492788dd2d0@jupiterrise.com>
        <cover.1502462884.git.tgc@jupiterrise.com>
        <xmqq1sohzr85.fsf@gitster.mtv.corp.google.com>
        <20170820084725.ce5inn5jzkyor4zk@sigill.intra.peff.net>
Date:   Sun, 20 Aug 2017 09:28:20 -0700
In-Reply-To: <20170820084725.ce5inn5jzkyor4zk@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 20 Aug 2017 04:47:25 -0400")
Message-ID: <xmqqziau6w63.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94C99600-85C4-11E7-B5FB-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Aug 11, 2017 at 03:15:06PM -0700, Junio C Hamano wrote:
>
>> "Tom G. Christensen" <tgc@jupiterrise.com> writes:
>> 
>> > The curl packages provided by Red Hat for RHEL contain several
>> > backports of features from later curl releases.
>> > This causes problems with current version based checks in http.c.
>> >
>> > Here is an overview of the features that have been backported:
>> > 7.10.6 (el3) Backports CURLPROTO_*
>> > 7.12.1 (el4) Backports CURLPROTO_*
>> > 7.15.5 (el5) Backports GSSAPI_DELEGATION_*
>> >              Backports CURLPROTO_*
>> > 7.19.7 (el6) Backports GSSAPI_DELEGATION_*
>> >              Backports CURL_SSL_VERSION_TLSv1_{0,1,2}
>> > 7.29.0 (el7) Backports CURL_SSL_VERSION_TLSv1_{0,1,2}
>> >
>> > This patch series will update the current version based checks for
>> > protocol restriction and GSSAPI delegation control support to ones
>> > based on features to properly deal with the above listed backports.
>> > The fine grained TLS version support does not seem to be
>> > distinguishable via a preprocessor macro so I've left that alone.
>> 
>> Thanks; these feature macros ought to be more dependable, and I
>> think this moves things in the right direction (regardless of which
>> features we might later pick as mandatory and cut off supports for
>> older versions).
>
> Yes, I agree that these are an improvement regardless. If we follow
> through on the cut-off to 7.19.4, then the CURLPROTO ones all go away.
> But I don't mind rebasing any cut-off proposal on top of this work.

Yeah I came to a similar conclusion and was about asking if you feel
the same way that your series should be made on top of Tom's fixes.

The aspect of that series I do like the most is to base our
decisions on features, not versions, and I also wonder if we can do
similar in your "abandon too old ones" series, too.

Thanks.
