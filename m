Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEB3C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 23:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbiEUXFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 19:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbiEUXFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 19:05:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B793CA75
        for <git@vger.kernel.org>; Sat, 21 May 2022 16:05:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DE6BB1A4FE2;
        Sat, 21 May 2022 19:05:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iHkZZWfSRDPIc3rPLSu3VrrWwnO4TA62nJUe0I
        MH/xc=; b=wf8f5S5Xwiaav0GedEmsa2AR6kZhGdC4xJSucG1AgnLcoKqvNIEQg9
        qsQ4AU6hCBvPYnToUZEobshiFcONvb6aRdDFI6ni61LqRv1tnBxgHgk82bhVMZcf
        anIgF0wfvfkhTNla8HJO/BnrGy+lo7RmIWiAM8PO4jirKZOX5oUu4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D5FC21A4FE1;
        Sat, 21 May 2022 19:05:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 77AA61A4FDC;
        Sat, 21 May 2022 19:05:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Cc:     Victoria Dye <vdye@github.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
        <6b83bb83-32b9-20c9-fa02-c1c3170351c3@github.com>
        <nycvar.QRO.7.76.6.2205212307090.352@tvgsbejvaqbjf.bet>
Date:   Sat, 21 May 2022 16:05:01 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2205212307090.352@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sat, 21 May 2022 23:42:58 +0200 (CEST)")
Message-ID: <xmqq35h2cwrm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7208357E-D95A-11EC-B368-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> * print the verbose logs only for the failed test cases (to massively cut
>>   down on the size of the log, particularly when there's only a couple
>>   failures in a test file with a lot of passing tests).
>
> That's an amazingly simple trick to improve the speed by a ton, indeed.
> Thank you for this splendid idea!
>
>> * skip printing the full text of the test in 'finalize_test_case_output'
>>   when creating the group, i.e., use '$1' instead of '$*' (in both passing
>>   and failing tests, this information is already printed via some other
>>   means).
>>
>> If you wanted to make sure a user could still access the full failure logs
>> (i.e., including the "ok" test results), you could print a link to the
>> artifacts page as well - that way, all of the information we currently
>> provide to users can still be found somewhere.
>
> That's a good point, I added that hint to the output (the link is
> unfortunately not available at the time we print that advice).

https://github.com/git/git/runs/6539786128 shows that all in-flight
topics merged to 'seen', except for the ds/bundle-uri-more, passes
the linux-leaks job.  The ds/bundle-uri-more topic introduces some
leaks to commands that happen to be used in tests that are marked as
leak-checker clean, making the job fail.

Which makes a great guinea pig for the CI output improvement topic.

So, I created two variants of 'seen' with this linux-leaks breakage.
One is with the js/ci-github-workflow-markup topic on this thread.
The other one is with the ab/ci-github-workflow-markup topic (which
uses a preliminary clean-up ab/ci-setup-simplify topic as its base).
They should show the identical test results and failures.

And here are their output:

 - https://github.com/git/git/runs/6539835065
 - https://github.com/git/git/runs/6539900608

If I recall correctly, the selling point of the ab/* variant over
js/* variant was that it would give quicker UI response compared to
the former, but other than that, both variants' UI are supposed to
be as newbie friendly as the other.

When I tried the former, it reacted too poorly to my attempt to
scroll (with mouse scroll wheel, if it makes a difference) that
sometimes I was staring a blank dark-gray space for a few seconds
waiting for it to be filled by something, which was a bit jarring
experience.  When I tried the latter, it didn't show anything to
help diagnosing the details of the breakage in "run make test" step
and the user needed to know "print test failures" needs to be looked
at, which I am not sure is an inherent limitation of the approach.
After the single extra click, navigating the test output to find the
failed steps among many others that succeeded was not a very pleasant
experience.

Those who are interested in UX experiment may want to visit these
two output to see how usable each of these is for themselves.

Thanks.



