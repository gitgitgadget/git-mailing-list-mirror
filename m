Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F58C636D4
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 23:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjBMXTV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 18:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjBMXTU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 18:19:20 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95C220543
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 15:19:15 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id h7so3934961pfc.11
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 15:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fo6Oizg5GUn2rnKH0uGyuTXgERdxu7Bw9/UcyJLSmyg=;
        b=H4JaJTICSFTGNmBPoub4YdauUYjLXs9ZLYYnvsAXUDVJeWK+jABvzrxUQOd50kzuJ6
         cRN1EIBMWXUKYE2Qgg5bJckhbnZ1w9XMo10PAH3Og+4i5mohEvptxSXHwbdGVPJl95YJ
         X4520T2C2NOxd9ECgi6wsva+bvq3duD13R6w2WkyeQPKicdJuqZzypI+sEbYe7PTY+rb
         Zj9l6oVaETnswTcEAAKbiQi9Sr1mPxdB6cmXoe5sz66sP+82H2jeePZD5z538iDj75ax
         CJyc1vYpQ8SSPLqF8VDSj8onqK2Eqocbd2/87pJmAk/gespO3GMUFzHXKmUguXFHfga1
         FqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fo6Oizg5GUn2rnKH0uGyuTXgERdxu7Bw9/UcyJLSmyg=;
        b=bud0GDsgGr22r2KR11W2FCUArfmLR8mc5oIcW0tYCI88sltnz3yLsKM6duumfAoUxq
         xIFpU8t4No1CXs2oZF97T0hTjqOp/gMnZ2CTMmeVRBwiUw+whK5GczEccDhcuYtEvWfE
         Gl7Y2U6emrf5cxPiJAAnwYpC7e3Vrxub8bArs+mSqUf45uHqjZKW1DGOs8WvsfoqPv5P
         iwiUcQJN0/soBeVZElcV3eR55UjKhj75SJAKsVTZXo0Uy1CGtPdmkmQjPcxRP8lxFNq/
         XJa2qZrAaiwRMvjXweVebDnurKPOlB9pTb5/1zydpXZnUBmhRZ0Z77s09FgATI9bHmrD
         QBzA==
X-Gm-Message-State: AO0yUKWQppEtigG10buYZK5zmrxwYGGxx2fx5udBpP3LUlwpUqg22QSz
        x3RGe1lAczjMypw38SBy6KQ=
X-Google-Smtp-Source: AK7set//cHy2Byfrl5/KhTIVD1VaMuNHHff8BnLmu5JCnBibjUe3BYDuordE69XYV/t5Qg2/RuGjpg==
X-Received: by 2002:aa7:8f37:0:b0:5a8:bd67:156d with SMTP id y23-20020aa78f37000000b005a8bd67156dmr186815pfr.6.1676330355225;
        Mon, 13 Feb 2023 15:19:15 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id c17-20020aa78e11000000b005813f365afcsm6915195pfr.189.2023.02.13.15.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 15:19:14 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
Subject: Re: [RFC PATCH 4/6] tests: use `git submodule add` and fix expected
 diffs
References: <20230213182134.2173280-1-calvinwan@google.com>
        <20230213182134.2173280-5-calvinwan@google.com>
        <xmqqy1p188rj.fsf@gitster.g>
Date:   Mon, 13 Feb 2023 15:19:14 -0800
In-Reply-To: <xmqqy1p188rj.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        13 Feb 2023 15:07:12 -0800")
Message-ID: <xmqqttzp887h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Calvin Wan <calvinwan@google.com> writes:
>
>> From: Josh Steadmon <steadmon@google.com>
>>
>> This commit continues the previous work of updating the test suite to
>> use `git submodule add` to create submodules instead of using `git add`
>> to include embedded repositories. Specifically, in this commit we update
>> test cases where expected diffs must change due to the presence of a
>> .gitmodules file.
>
> Good that these "same" tasks are split into two steps, ones that
> don't notice the additional presence of .gitmodules (i.e. the
> previous step) and the result that do.
>
> Strictly speaking, gitlink support in the index and trees does not
> have to be used to record submodules, and changing all "git add" to
> "git submodule add" is somewhat a sad change that closes the door to
> those folks who want to use the mechanism for implementing "better
> submodules" that do not depend on a separate .gitmodules files, for
> example.  To leave the door open, "git add" may need to learn an
> overriding mechanism allow adding a gitlink to the index without
> anything else.  And then this step could use "git add -f" (or
> whategver the overriding mechanism) instead of "git submodule add",
> without changing the expected diff output.
>
> Would such a tweak make this step better?  I dunno.

The other side of the coin is that the tests that were touched by
the previous step were not testing half of what "submodule add" is
doing.  Not all the "let's add submodule here" test may not have to
verify the resulting .gitmodules file (e.g. ones that want to see
the low-level diff machinery works correctly by taking output from
"git diff --cached --raw" would be primarily interested in what
happens to the index and not to .gitmodules at all), but some of
them should.  A rough rule of thumb might be that the tests that are
about "submodules" should care what ".gitmodules" has, while the
tests tare are about "gitlink" should not.  It might even make sense
to use "add -f" (or whatever override to allow adding a gitlink only
to the index without touching .gitmodules and other things), not
"submodule add", for the latter class of tests.

Thanks.


