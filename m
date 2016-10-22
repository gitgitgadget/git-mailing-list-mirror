Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25E4320986
	for <e@80x24.org>; Sat, 22 Oct 2016 16:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935724AbcJVQTg (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 12:19:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56028 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934425AbcJVQTf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 12:19:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 19D1F466A9;
        Sat, 22 Oct 2016 12:19:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GJPUZ0qcFg3IRCIPvTWafqnSHa0=; b=btvzN1
        nRRm29bUbpUDP2rKpca7KaCSTbdpGoHgW0fRs4MAR1OAqAY//cyEtNYJthK+D2nu
        3PQe1Hmm3EyZrNcU3NoVXpKKNtd5AtWt3gTjLXiRWXoA7UwA3t5mlCKbTxKiM1kX
        FsW4EI37OHXK5gMLajSfIec7sj4xRrMPqVydE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k5S/mQfIVxtVXBI86ueCUZHpy0IGYFnH
        n/f35Fx7mcbgIVwYju+YwyCBrkDMsc5bfDzTDi6gDQMEKAAeqY9Ocl6gxJ7tmNAx
        yn7wqakRAgMjIVyBp79TkTt0tUDfjgDWZ7R9zCdGFoXmsWxj2DJesxoLUmU8+Jlf
        2Q0C31EuQPU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11E18466A6;
        Sat, 22 Oct 2016 12:19:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85AE6466A5;
        Sat, 22 Oct 2016 12:19:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 5/8] trailer: clarify failure modes in parse_trailer
References: <cover.1476232683.git.jonathantanmy@google.com>
        <cover.1476998988.git.jonathantanmy@google.com>
        <8aa456a551bf5cf44cea5ea7e33f32e190c45658.1476998988.git.jonathantanmy@google.com>
        <CAGZ79kYi=+JUqmFyR+Xapwy2bLHtmCX7ZFxd9bGkNHS5tjEdOw@mail.gmail.com>
        <xmqqvawmekhk.fsf@gitster.mtv.corp.google.com>
        <22e4b88b-5273-99c9-bcb3-0748c17a7229@google.com>
        <xmqqr37aej26.fsf@gitster.mtv.corp.google.com>
        <5656444f-14ba-b58c-4ad6-e72cc15a13cb@google.com>
        <xmqqeg3aeeqe.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD0XvNx6Brio9muDhOj5+dr=HRbhK_Lmr+k4LUPKrAVC9Q@mail.gmail.com>
Date:   Sat, 22 Oct 2016 09:19:31 -0700
In-Reply-To: <CAP8UFD0XvNx6Brio9muDhOj5+dr=HRbhK_Lmr+k4LUPKrAVC9Q@mail.gmail.com>
        (Christian Couder's message of "Sat, 22 Oct 2016 15:07:25 +0200")
Message-ID: <xmqqd1is9x0s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 516582E6-9873-11E6-8772-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Oct 21, 2016 at 2:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> If I were guiding a topic that introduce this feature from scratch
>> today, I would probably suggest a pattern based approach, e.g.  a
>> built-in "[-A-Za-z0-9]+:" [*1*] may be the default prefix that is
>> used to recognize the beginning of a trailer, and a user or a
>> project that wants "Bug #538" would be allowed to add an additional
>> pattern, e.g. "Bug *#", that recognises a custom trailer line that
>> is used by the project.
>
> When we designed the separator mechanism, we had the following discussions:
>
> https://public-inbox.org/git/xmqqa9a1d6xn.fsf@gitster.dls.corp.google.com/
> https://public-inbox.org/git/xmqqmwcuzyqx.fsf@gitster.dls.corp.google.com/
>
> They made me think that you were against too much flexibility, so I
> removed functionality that allowed to put separators into the ".key"
> config options, and now you are saying that we botched the thing and
> that you would like more flexibility of this kind back.

Correct.  Pay attention to the fact that I said _we_ botched.

If an initial design made by a topic author is crappy, that may be
author's botch.  Once a topic goes through a review cycle by getting
reviewed, rerolled, re-reviewed, ... to the point that those
involved accept the result, and we later realize that it was not
good, the botch no longer is author's alone.  If it is shipped as
part of a release, then it is not just the authors and the reviewers
but everybody.  We collectively stopped at a place that was not
ideal and share the blame ;-).

> Anyway I think it is still possible to add back such kind of
> functionality in a backward compatible way for example by adding
> ".extendedKey" config options.

Yup, or with trailer.keyPattern that is multi-values, or with any
number of alternatives.
