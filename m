Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6B5208CD
	for <e@80x24.org>; Wed, 23 Aug 2017 10:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753794AbdHWKJJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 06:09:09 -0400
Received: from zm-mta-out-1.u-ga.fr ([152.77.200.56]:59092 "EHLO
        zm-mta-out-1.u-ga.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753786AbdHWKJE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 06:09:04 -0400
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Aug 2017 06:09:04 EDT
Received: from zm-mta-out.u-ga.fr (zm-mta-out.u-ga.fr [152.77.200.58])
        by zm-mta-out-1.u-ga.fr (Postfix) with ESMTP id 3072FA0546;
        Wed, 23 Aug 2017 12:02:17 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps.univ-grenoble-alpes.fr [152.77.1.30])
        by zm-mta-out.u-ga.fr (Postfix) with ESMTP id 8458EE0097;
        Wed, 23 Aug 2017 12:02:19 +0200 (CEST)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id EBC46125EBA;
        Wed, 23 Aug 2017 12:02:17 +0200 (CEST)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>, johan@kernel.org,
        Git mailing list <git@vger.kernel.org>
Subject: Re: git send-email Cc with cruft not working as expected
References: <CA+P7+xrtZYUjPcVMkA+x8B57w+LxjjU8YSKcE77DrWne7449rg@mail.gmail.com>
        <CAGZ79kZW_+GEKyP4+8agZ7nyjGEZ9p5d3N99W6sC3GTY_4Cm-g@mail.gmail.com>
        <CA+P7+xpCJ8jwBQp9Ze=J955CaxnbVPc69ThXht2e=6TUMBq_UQ@mail.gmail.com>
        <CAGZ79kbYWJmru_o48+8iH4_MVEtODFuicRY=23+BM+_q2ZJsaw@mail.gmail.com>
Date:   Wed, 23 Aug 2017 12:02:17 +0200
In-Reply-To: <CAGZ79kbYWJmru_o48+8iH4_MVEtODFuicRY=23+BM+_q2ZJsaw@mail.gmail.com>
        (Stefan Beller's message of "Tue, 22 Aug 2017 16:36:54 -0700")
Message-ID: <vpqo9r6lhzq.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via submission-587 ACL (111)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +cc people from that thread
>
> On Tue, Aug 22, 2017 at 4:30 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Tue, Aug 22, 2017 at 4:18 PM, Stefan Beller <sbeller@google.com> wrote:
>>> On Tue, Aug 22, 2017 at 4:15 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> I recently found an issue with git-send-email where it does not
>>>> properly remove the cruft of an email address when sending using a Cc:
>>>> line.
>>>>
>>>> The specific example is with a commit containing the following Cc line,
>>>>
>>>> Cc: stable@vger.kernel.org # 4.10+
>>>
>>> Please see and discuss at
>>> https://public-inbox.org/git/20170216174924.GB2625@localhost/
>>
>> I read that thread, and it addressed the problem of
>>
>> Cc: <stable@vger.kernel.org> # 4.10+
>>
>> but did not fix this case without the <> around the email address.

Indeed. It detects garbage as "everything after >".

I feel really sorry that we need so many iterations to get back to a
correct behavior :-(.

>> Additionally I just discovered that the behavior here changes pretty
>> drastically if you have Email::Validate installed, now it splits the
>> address into multiple things:

(I'm assuming you mean Email::Address, there's also Email::Valid but I
don't think it would modify the behavior)

Hmm, I think we reached the point where we should just stop using
Email::Address.

Patch series follows and should address both points.

-- 
Matthieu Moy
http://matthieu-moy.fr
