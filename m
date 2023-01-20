Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684BAC25B4E
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 17:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjATRxT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 12:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjATRxS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 12:53:18 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391D872B8
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 09:52:40 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id g23so5952034plq.12
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 09:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i37LUY87Z7ylQvVzquQapwQ8qZX4W60wWciZGlZ5254=;
        b=M6ePgF3kiRodu9+Nx0fc8TlP20aZO1pfwqQw35bc4qWPB3qwG5+nYjGIGFYNS45dPl
         uymXvWMAL+hN00Ic0T/gum7yRNl3pFaEBDXD9Dv0qkoqD34rlQeQIW3c4jTF7TlFUBxS
         4+T7WjvkkP9wK6DSe1gAQrHYMTgEDv80akOBe34sUyjNgaZS+NMlsiJCnVbs4e87jhxC
         KptxfIzNLTjcBolzvyEnElhD60kIggF820eGTC6vMe1BTlbob3OvZNZUrH8V35JQqiOM
         Lm66hCL0B9PeqNaF7QSQ5pDscDUuVb0/H41lSFskXW05WrWEOdk03cPSK5mTjV4ZkonW
         2bxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i37LUY87Z7ylQvVzquQapwQ8qZX4W60wWciZGlZ5254=;
        b=MslGQcWZKgIQUCCk7bZfXfroJcqxWTwsrj5pjDnFg/W1+ItPR3tFTLzg0Hdo+ildoc
         OkEOGMkOJmfkK9aYzeJ3YTqf0sExj/J7whd7RtCXeB4cdnlou/ypJvCcqLzOwJd17PbV
         8nEJq+i9EYlo19GPEkjJPdBrbX7EvrSImg/FJxjtau+WYNSiz4n1eudnVasf1huOb6EK
         vOJ9r1bCQ5TrblXiweALa5FSDgJBX7Y2Esn9tvuuoOgBfWeJY4tp455r7r+oT0awveiA
         rA8TztbaPTCzC0uf89nZil6kGrOrzyIinCWmy2qr1G4Sq9dClETlGiwulgI1urK9oSCN
         Vzig==
X-Gm-Message-State: AFqh2koFLtqcopvYww4pAnujDAIOME7XyO5w2ERGA76TZveXDxXJUKyb
        rMiKAe0KXbBhqyBwNNZ0N+Y=
X-Google-Smtp-Source: AMrXdXvbWgAZNcHcRt97k2G7Ho1mLgfSY/cL+T9aVNY4IDzlOt7WJkiS2wEUlXkO4SZJlZQLOoWolQ==
X-Received: by 2002:a17:90a:67c2:b0:226:c364:2d1d with SMTP id g2-20020a17090a67c200b00226c3642d1dmr16094400pjm.41.1674237159272;
        Fri, 20 Jan 2023 09:52:39 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id fv23-20020a17090b0e9700b0022bae5c3e1esm1599151pjb.9.2023.01.20.09.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:52:38 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Rose via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH v2] fsm-listen-darwin: combine bit operations
References: <pull.1437.git.git.1673990756466.gitgitgadget@gmail.com>
        <pull.1437.v2.git.git.1673992448371.gitgitgadget@gmail.com>
        <021ab1ab-b90a-5a24-23c4-44e46d87c476@jeffhostetler.com>
Date:   Fri, 20 Jan 2023 09:52:38 -0800
In-Reply-To: <021ab1ab-b90a-5a24-23c4-44e46d87c476@jeffhostetler.com> (Jeff
        Hostetler's message of "Fri, 20 Jan 2023 10:48:51 -0500")
Message-ID: <xmqqwn5hw0t5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

>>     static int ef_is_dropped(const FSEventStreamEventFlags ef)
>>   {
>> -	return (ef & kFSEventStreamEventFlagMustScanSubDirs ||
>> -		ef & kFSEventStreamEventFlagKernelDropped ||
>> -		ef & kFSEventStreamEventFlagUserDropped);
>> +	return (ef & (kFSEventStreamEventFlagMustScanSubDirs |
>> +		      kFSEventStreamEventFlagKernelDropped |
>> +		      kFSEventStreamEventFlagUserDropped));
>>   }
>
> Technically, the returned value is slightly different, but
> the only caller is just checking for non-zero, so it doesn't
> matter.
>
> So this is fine.

But is it worth the code churn and reviewer bandwidth?  Don't we
have better things to spend our time on?

I would not be surprised if a smart enough compiler used the same
transformartion as this patch does manually as an optimization.

Then it matters more which one of the two is more readable by our
developers.  And the original matches how we humans would think, I
would imagine.  ef might have MustScanSubdirs bit, KernelDropped
bit, or UserDropped bit and in these cases we want to say that ef is
dropped.  Arguably, the original is more readble, and it would be a
good change to adopt if there is an upside, like the updated code
resulting in markedly more efficient binary.

So, this might be technically fine, but I am not enthused to see
these kind of code churning patches with dubious upside.  An
optimization patch should be able to demonstrate its benefit with a
solid benchmark, or at least a clear difference in generated code.

In fact.

Compiler explorer godbolt.org tells me that gcc 12 with -O2 compiles
the following two functions into identical assembly.  The !! prefix
used in the second example is different from the postimage of what
Seija posted, but this being a file-scope static function, I would
expect the compiler to notice that the actual value would not matter
to the callers, only the truth value, does.


* Input *
int one(unsigned int num) {
    return ((num & 01) ||
            (num & 02) || (num & 04));
}

int two(unsigned int num) {
    return !!((num) & (01|02|04));
}

* Assembly *
one(unsigned int):
        xor     eax, eax
        and     edi, 7
        setne   al
        ret
two(unsigned int):
        xor     eax, eax
        and     edi, 7
        setne   al
        ret
