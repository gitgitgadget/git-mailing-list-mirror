Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28DE320756
	for <e@80x24.org>; Fri, 20 Jan 2017 21:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbdATV6G (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 16:58:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60817 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752484AbdATV6F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 16:58:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79D09623A2;
        Fri, 20 Jan 2017 16:58:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/ShAnbCNWiWaAW/ajWG/cqB26HY=; b=kba3Kq
        kxK5+uPQ737MpyuTsuT00AggAmmlLxk1dVsii2DmTHVdY8sKHbBpikmWNHsniiCE
        f5TDsqDivTrftAOGKTkS6wXA77G9CbyOsAxVnhgCicFYRHmzhCrc6raLTrYXq0rR
        jSVEr2gONbg8uCX4ZMTch2uZosW1nyn+DzgQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Eq99zkAri2YqV5xK5B34o4LjKxNtDXXb
        r/2xagqXCn0U8wdriz03qBrH4DwaQC7pTURudKms/al9iat5w3il3LqJ8P4UvvJR
        cGVEiOZuJbrUPcJ4sWBMG6OMMUUI3nm/ipjtGOF1SSgqPf+17T8NUfG/QD/35fWG
        mD+wfBZfqeo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 718FC623A1;
        Fri, 20 Jan 2017 16:58:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D0154623A0;
        Fri, 20 Jan 2017 16:58:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] Disallow commands from within unpopulated submodules.
References: <20170119193023.26837-1-sbeller@google.com>
        <20170120191728.l3ne5tt5pwbmafjh@sigill.intra.peff.net>
        <CAGZ79kaJQefSDkV-LKxRCTtSepsNsX7U+AZqy3Z_YCd1xsmTxQ@mail.gmail.com>
        <20170120194224.vikzovupwqx53x2c@sigill.intra.peff.net>
        <CAGZ79kYKY=hDVjUx7AkeWZ=3V8Fy2hqQMFPZcoxT4NvXTFgG=Q@mail.gmail.com>
        <20170120200041.hefg44stddqe344z@sigill.intra.peff.net>
        <xmqq37gdxvbx.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 20 Jan 2017 13:58:02 -0800
In-Reply-To: <xmqq37gdxvbx.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 20 Jan 2017 13:41:54 -0800")
Message-ID: <xmqqy3y5wg0l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84756442-DF5B-11E6-A8CC-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>> And in my current understanding of submodules the check in
>>> .gitmodules ought to be enough, too.
>>
>> Yeah, that probably makes sense. You can have a gitlink without a
>> .gitmodules file, but I don't quite know what that would mean in terms
>> of submodules (I guess it's not a submodule but "something else").
>
> That may be a lot better than reading the index unconditionally, but
> I'd rather not to see "git rev-parse" read ".gitmodules" at all.  It
> would discourage scripted use of Git for no good reason.

Thinking about this more, I suspect that

	cd sub && git anything

when the index of the top-level thinks "sub" must be a submodule and
the user is not interested in "sub" (hence it hasn't gone through
"git submodule init" or "update") should get the same error as you
would get if you did

	cd /var/tmp/ && git anything

when none of /, /var, /var/tmp/ is controlled by any Git repository.
I.e. "fatal: Not a git repository".

Perhaps we can update two things and make it cheap.

 - checking out the top-level working tree without populating the
   working tree of a submodule learns to do a bit more than just
   creating an empty directory.  Instead, it creates the third kind
   of ".git" (we currently support two kinds of ".git", one that is
   a repository itself, and another that is points at a repository),
   that tells us that there is not (yet) a repository there.

 - the "discovering the root of the working tree" logic learns to
   notice the third kind of ".git" and stop with "Not a git
   repository".


