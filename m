Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5652C433FE
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 21:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380450AbiDDVVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380328AbiDDTe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 15:34:59 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C6F2124E
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 12:33:02 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E7AE18DFAC;
        Mon,  4 Apr 2022 15:33:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JPBLRcJEMSikBQ59CePca5XlQpZV9HEkAXxAvH
        Hauog=; b=jbEy0Fem/tgZYKPwRbV2xI9L6qAReTY26yY1F9cWC1+JIF+Tklt/RP
        i+WBkYCO4pxLuhQbr4zIhYfa18N7vmsdA8n4aQ4GkQVaptMeizbEndkvQKpSW7FY
        X2yIQ2uFgItFg4UNOcKxyEzCaPbLm2yLs+y3b+fKfQk2+EpeUQva8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4814F18DFAB;
        Mon,  4 Apr 2022 15:33:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A2D8018DFA7;
        Mon,  4 Apr 2022 15:32:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     whydoubt@gmail.com, Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] blame: report correct number of lines in progress
 when using ranges
References: <20220404182129.33992-1-eantoranz@gmail.com>
        <CAOc6etaY8enMF0nmhaqA2+Oi6JmYFY-bPqsUFTXE=K8aFoXDnQ@mail.gmail.com>
Date:   Mon, 04 Apr 2022 12:32:58 -0700
In-Reply-To: <CAOc6etaY8enMF0nmhaqA2+Oi6JmYFY-bPqsUFTXE=K8aFoXDnQ@mail.gmail.com>
        (Edmundo Carmona Antoranz's message of "Mon, 4 Apr 2022 20:25:59
        +0200")
Message-ID: <xmqqy20kprth.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 093928FE-B44E-11EC-AF60-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> On Mon, Apr 4, 2022 at 8:21 PM Edmundo Carmona Antoranz
> <eantoranz@gmail.com> wrote:
>>
>> When using ranges, use their sizes as the limit for progress
>> instead of the size of the full file.
>>
>>  '
>>
>> +test_expect_success 'blame progress on a full file' '
>> +       cat >progress.txt <<-\EOF &&
>> +       a simple test file
>> +
>> +       no relevant content is expected here
>> +
>> +       If the file is too short, we cannot test ranges
>> +
>> +       EOF
>> +       git add progress.txt &&
>> +       git commit -m "add a file for testing progress" &&
>
> I wonder if the preceding section should be kept in a
> separate 'setup test'?

I actually wonder why we need a *new* test file to run this test,
instead of reusing what we already use in the existing test.

>
>> +       GIT_PROGRESS_DELAY=0 \
>> +       git blame --progress progress.txt > /dev/null 2> full_progress.txt &&

Style:

	git blame --progress progress.txt >/dev/null 2>full_progress.txt &&
