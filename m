Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D124120899
	for <e@80x24.org>; Fri, 18 Aug 2017 02:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932116AbdHRCNm (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 22:13:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58176 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932092AbdHRCNm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 22:13:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 104ED93FBA;
        Thu, 17 Aug 2017 22:13:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K0HbjgITLYiTnpOpBKjeVJf7378=; b=bZLCFa
        3j2qoGAS5qzNPnmEBA9wNuF0fIod5bKqAnrcODmVyo1Fv1MtzCGQBxQIa7gu/Yje
        jAJONvj56BZ1YC+si1cDw1FuqVMAr1pHE0u63qkSQXgMo+sge5w02Dp9tBLn3Z9W
        C3Rmm0Vha9eiNm5OcgI4ASKiBj3QevtaR63Oc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cR3VYEyyEr/yakqps/8FhuIgOJv394FP
        n/COUhDFcEVHV5fHYrNzxM3o7S0NvqJNljCjARPF0nuM9we4mwJH+FbVOsV/pKPo
        UaRRpqQ7AqMVBCHzBRucZnnKgCtrGL9ot3pc4fLEeiZY4adcSCosy2ShJOM7QZ06
        aSsk+yq3Sac=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 00E2E93FB8;
        Thu, 17 Aug 2017 22:13:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C05A93FB7;
        Thu, 17 Aug 2017 22:13:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Submodule regression in 2.14?
References: <4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com>
        <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com>
        <FCB6097F-9F8D-4FDD-A8CE-D936C9CE62E7@gmail.com>
        <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com>
Date:   Thu, 17 Aug 2017 19:13:33 -0700
In-Reply-To: <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com>
        (Stefan Beller's message of "Thu, 17 Aug 2017 14:55:27 -0700")
Message-ID: <xmqqd17tei7m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D67FC95E-83BA-11E7-9378-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Are you saying this might be a design mistake and
> the .update ought to be respected by all the other
> commands? For example
>     git reset --recurse-submodules
> should ignore the .update= none?

I have been under the impression that that has been the traditional
desire of what .update ought to mean.  I personally do not have a
strong opinion---at least not yet.

> When designing these new recursive submodule functionality
> outside the "submodule" command, I'd want submodules
> to behave as much as possible like trees.

I think that is sensible as long as the user does not explicitly say
"this and that submodule behave differently" by giving configuration
variables.  Perhaps .update is one of those that should countermand
the default behaviour of "--recurse-submodules"?
