Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE29C7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 17:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238979AbjEKRhn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 13:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238967AbjEKRhk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 13:37:40 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616F89EC9
        for <git@vger.kernel.org>; Thu, 11 May 2023 10:37:24 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5304913530fso2800389a12.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 10:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683826643; x=1686418643;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OXCdqNiqCISko4sa8jQTo426Wbcz2QjiSx2POJYdQmM=;
        b=T7hE7aqt7NcrqHENbUvY99mLjX6czuVCVBnHh965VCxyZVZcvXc65fEXc1mV/mwv6d
         nPEn7vzGImgqz7yi0MwtVDmtLfKb0yuiDCXmiVN14uT+dGAhi8p5+P5QYy6q28nBEejm
         IKYJztztTSFwdXHnYMOx1rX4zqxD8GKJG6CH1sZNUtGPij/UgDFTcYy9NUYBAFOz1ZaC
         QnQ8DRCtG5pi8wJgBBG251iRD7SXkPTqMGwrn8mfj+V59nKesTHEMX6JsyqqyvEGsOaU
         DNKKLZl06m/Bn8CzR2r6psMKQ98+zAvkBnR6iCuPiLJOjHgWUiWoZBmeJVOPDGTpmJ8+
         vPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683826643; x=1686418643;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OXCdqNiqCISko4sa8jQTo426Wbcz2QjiSx2POJYdQmM=;
        b=EkGWHEFjnfy74A04s0UIaRNo3dTzGTvGdefWQYv60NqUCRdHJj0Nrq86JkCKTMmYXi
         +atbDwiPQVn9alpG4xMjNrtQvbRqNcJdmKz5JysKmRz5wCcs52gwwBkibTUfPfnbdxP/
         34DYbkrrc6YsllqVAuL+NcyJT4yXlcYZb/9IgURbeH1re9nwbrZwW10MrxDT5xXPuEGx
         Zvr6hOwcUKmVNwhTebMp7M+GB1cbH/xlKhbF3h/BVOu/vxgkUstLLMflHJq0IQWHOb7Q
         UHaGraBkUQ0vuFvhENFAa7SSNv1pq/6Ac39zG5dj8GBdknwFMO1tRmUWWRnEo+MwQROQ
         52Uw==
X-Gm-Message-State: AC+VfDzpM8nkyV3VVlTInZzVpUFBWfQncTeL+m6EoxyA1rGCUCTBTeBl
        R4BW4zoHUUHA5WN+QVJsfz/klI7qIrY=
X-Google-Smtp-Source: ACHHUZ6i8FwBNfzTnp8mUNl98UE4j4RBQrtCsne9Hoqji2YnpiWaIBLRv01PsBqg8Bo7RPMslAw85g==
X-Received: by 2002:a17:903:234c:b0:1ab:109e:a553 with SMTP id c12-20020a170903234c00b001ab109ea553mr28023966plh.62.1683826643373;
        Thu, 11 May 2023 10:37:23 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id l11-20020a170903244b00b001aaed55aff3sm6195822pls.137.2023.05.11.10.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 10:37:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Subject: Re: Can we clarify the purpose of `git diff -s`?
References: <645c5da0981c1_16961a29455@chronos.notmuch>
        <871qjn2i63.fsf@osv.gnss.ru>
Date:   Thu, 11 May 2023 10:37:22 -0700
In-Reply-To: <871qjn2i63.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
        11 May 2023 14:59:00 +0300")
Message-ID: <xmqqwn1ewyzx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> I entirely agree with your conclusion: obviously, -s (--silent) and
> --no-patch are to be different for UI to be even remotely intuitive, and
> I'd vote for immediate fix of --no-patch semantics even though it's a
> backward-incompatible change.

I forgot to write about this part.

tl;dr.  While I do not think the current "--no-patch" that turns off
things other than "--patch" is intuitive, an "immediate" change is
not possible.  Let's do one fix at a time.

The behaviour came in the v1.8.4 days with a series that was merged
by e2ecd252 (Merge branch 'mm/diff-no-patch-synonym-to-s',
2013-07-22), which

 * made "--no-patch" a synonym for "-s";

 * fixed "-s --patch", in which the effect of "-s" got stuck and did
   not allow the patch output to be re-enabled again with "--patch";

 * updated documentation to explain "--no-patch" as a synonym for
   "-s".

While it is very clear that the intent of the author was to make it
a synonym for "-s" and not a "feature-wise enable/disable" option,
that is what we've run with for the past 10 years.  You identified
bugs related the "-s got stuck" problem and we recently fixed that.

"Should --no-patch be changed" can be treated as a separate issue,
and whenever we can treat two things separately, I want to do so, to
keep the potential blast radius smaller.  That way, if an earlier
change turns out OK but the other change causes severe regression,
we can only revert or rework the latter.  An exception is if
committing to one change (e.g. "fix '-s'") makes the other change
(e.g. "redefine --no-patch") impossible, but we all know it is not
the case here. I gave an outline of how to go about it in the log
message of that "fix '-s'" patch.

I do not think it will break established use cases too badly to fix
the behaviour of "-s" so that it does not get stuck.  We saw an
existing breakage in one test, but asking the owners of scripts that
make the same mistake of assuming "-s" gets stuck for some but not
other options to fix that assumption based on an earlier faulty
implementation is much easier.

But "git diff --stat --patch --no-patch", which suddenly starts
showing diffstat after you make "--no-patch" no longer a synonym for
"-s", has a much larger potential to break the existing workflows.
And I do not think asking the users who followed the documented
"--no-patch is a synonym for -s" to change their script because we
decided to make "--no-patch" no longer a synonym is much harder.

So, no, I do not think we can immediately "fix".  I do not think
anybody knows if it can be done "immediately" or needs a careful
planning to transition, and I offhand do not know if it is even
possible to transition without fallout.

THanks.

