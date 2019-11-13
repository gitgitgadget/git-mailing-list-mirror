Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D38E1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 03:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfKMDyg (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 22:54:36 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51369 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfKMDyg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 22:54:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5E2BC997A2;
        Tue, 12 Nov 2019 22:54:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XLdztCeuxfGDzoJKg2BwIJ87h70=; b=M+Xk4v
        HcRd/OEXbfgFCh5nqkLoa1L2kyaXiyDy1amGprbLat+2ZxoefKxozi9SkdrPAWlb
        zbESAVk5ss8+LFu8hcLPLlrkZ3sPIr+aUBPir4/3WpWhc2rskmwikTClyQimjcJg
        2/dwFRrbHsUgi9XtdezrikccXbUG/46Ue8U2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nsyx0+3jVkTmX4RrBeiA2PGorsFfPxAl
        vOnlfMHnAfduK1GNdKD+gVT50yXSyHwiuy/B7TMtr+jN1Ys1Bi2mSIWCU8yclYL7
        nx5T54wRq9+SggE8t0OxqOyPgHJJGWIDz5mzsZxYTwautIHAYMnGRLIjjEpgoVPI
        KgTlnY997Jg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 55C8C997A1;
        Tue, 12 Nov 2019 22:54:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7FE789979A;
        Tue, 12 Nov 2019 22:54:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 1/9] Start to implement a built-in version of `git add --interactive`
References: <pull.170.v4.git.gitgitgadget@gmail.com>
        <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
        <ff59d2d0b3b8b591a806ef71b4bcfd350000b06e.1572869729.git.gitgitgadget@gmail.com>
        <xmqqh83fnfah.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1911091154550.46@tvgsbejvaqbjf.bet>
        <xmqqtv7cjj2n.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1911110949590.46@tvgsbejvaqbjf.bet>
        <xmqqeeyehawj.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1911121459270.46@tvgsbejvaqbjf.bet>
Date:   Wed, 13 Nov 2019 12:54:29 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1911121459270.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 12 Nov 2019 16:03:45 +0100 (CET)")
Message-ID: <xmqqd0dwbfd6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C54946A-05C9-11EA-9662-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Regardless of the language the scripted version was written in, I
>> think the '--helper' approach is always the poorer choice between
>> the two [*1*].  It limits the modular decomposition to what suits the
>> original language, the impedance mismatch between the original and
>> target language forces us to unnatural style of inter module
>> communication, and the unnatural interface layer, which we know has
>> to be discarded at the end, must be written [*2*].
>>
>> So, I'd prefer to see "because this is a better way in the longer
>> term" over "because the --helper approach would not work".
>
> Hmm. I feel distinctly unheard.

The feeling is mutual ;-)

> It may appear compelling, conceptually, to shun the `--helper` approach,
> but the more important reality is that it is the only one that makes an
> incremental conversion possible at all.
>
> It took an entire month of 60-hour weeks to complete the conversion of
> `git add -i`/`git add -p` to C, and only at the very end was I able to
> run the test suite with `GIT_TEST_ADD_I_USE_BUILTIN=true` and see it
> pass.

Yeah, that is developer comfort, and of course it is nice to have
than not to have it.

But compared to the downside impact to the quality of end result
that is inherent to the '--helper' approach, I'd prioritize the
quality of the end result over developer comfort.

> It is indeed _in spite of_ the success of the `--helper` approach that
> we cannot use it here.

As I do not see those past '--helper' ones necessarily successes, we
must agree to disagree here.

In any case, the log message needs to express why _you_ ended up
taking the non-helper approach.  Even though it is far less
relevant, compared to that, what other approach you instead wanted
to take, I do not veto you from having your own opinion.

>> [Footnote]
>>
>> *1* In only one case I would recommend using "--helper" approach,
>>     though.  When you are not expecting the developer to be able to
>>     come up with a better split of the program into modules than how
>>     the scripted version is, and you want to ensure that the
>>     developer have something to show when they faild to complete the
>>     project after N weeks.  You are a more experienced developer
>>     than an average GSoC student, and there is no pencils-down time,
>>     so the exception would not apply.
>>
>> *2* In "git submodule" for example it was quite natural for the
>>     module that gives a list of submodules with its traits the
>>     program cares about to be written as a shell function that
>>     writes the data to its standard output.  And consuming modules
>>     sit at the downstream of a pipe, accepting its output.  When you
>>     are writing these modules both in C, you wouldn't connect them
>>     with pipe to carry the list of submodules, but a piecemeal
>>     conversion using the "--helper" approach meant that there always
>>     remained _some_ consumer that wants to read from the pipe, so
>>     long after the module lister was rewritten in C, it still needed
>>     to support a mode where it sends its output to the pipe, instead
>>     of just passing an array of structures.
>>
