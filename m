Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB1D5202A0
	for <e@80x24.org>; Mon, 20 Nov 2017 01:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbdKTBsT (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 20:48:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56454 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751020AbdKTBsS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 20:48:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AA3CA738C;
        Sun, 19 Nov 2017 20:48:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rW50Bwzeo0EE8HYcrQT68P9kgwM=; b=SoX0CZ
        Rr7lb8tucmiqmHtMF3YIoFfWIrKIdL4IV29UUqaFIwGeeVKim2uGJUgLyHEGV4Vi
        vvJEKqmXYXNzy06fhVXG6GjwQpdxrbGhvQI86juFxa9O0DM3g7gbxHvaQmezG/0V
        eAdWc5v9Ltcphll8y3Nophbu+atAIRkMRfmTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MuC776s2WgXgRX6QzIV6uLOUTR8zUneD
        LDPCKkLjrVzN+1nxVHGZTggKMWzo/49UZ4Y6TWmoMR9Bx6IoRexBHZrlPqURW5te
        nrdqq4Ae68Yop23Esmrgz3RG0d8M7Yyp8zSRAU91K942BmX+n1/I7Jw18koeWXWx
        C+XfD5433VQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9221FA738B;
        Sun, 19 Nov 2017 20:48:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 105DDA738A;
        Sun, 19 Nov 2017 20:48:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ann T Ropea <bedhanger@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 3/6] diff: diff_aligned_abbrev: remove ellipsis after abbreviated SHA-1 value
References: <20171113223654.27732-1-bedhanger@gmx.de>
        <83D263E58ABD46188756D41FE311E469@PhilipOakley>
        <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>
        <20171113223654.27732-3-bedhanger@gmx.de>
        <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
        <20171119173838.8820-1-bedhanger@gmx.de>
Date:   Mon, 20 Nov 2017 10:48:15 +0900
In-Reply-To: <20171119173838.8820-1-bedhanger@gmx.de> (Ann T. Ropea's message
        of "Sun, 19 Nov 2017 18:38:38 +0100")
Message-ID: <xmqqtvxpn2jk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E0F0B6F4-CD94-11E7-A5F3-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ann T Ropea <bedhanger@gmx.de> writes:

>> Notice the name of the function.  We no longer even attempt to align
>> the output, and in general the output column length of each line
>> would be shorter than the original.  I am wondering if the change
>> would be of less impact if we try to abbreviate to len+3 and then
>> chomp the result at the right hand side to len+3 (only if the result
>> is unique) when print_sha1_ellipsis is false.  Of course, once we go
>> that path, the code structure this patch introduces (not the one I
>> mentioned in the previous paragraph) would be necessary.  Essentially
>> you would be enhancing the "else" clause.
>
> Sorry, but you've lost me there.

After diff_aligned_abbrev(const struct object_id *oid, int len)
returns the full-size result when asked, it does this:

	abbrev = diff_abbrev_oid(oid, len);
	abblen = strlen(abbrev);

	if (abblen < GIT_SHA1_HEXSZ - 3) {
		static char hex[GIT_MAX_HEXSZ + 1];
		if (len < abblen && abblen <= len + 2)
			xsnprintf(hex, sizeof(hex), "%s%.*s", abbrev, len+3-abblen, "..");
		else
			xsnprintf(hex, sizeof(hex), "%s...", abbrev);
		return hex;
	}

When asked to abbreviate to 4, which is shorter than 40-3=37, and
the unique abbreviation results in "dead" (iow, no other object that
shares that prefix), then len=4, abblen=4, so we get "dead..." as
the output.  If the unique abbreviation is "deadb" (iow, some other
object shares "dead" prefix and we require one more hexdigit for
uniqueness), len=4, abblen=5, and abblen <= len + 2, so we get
"deadb.." as the output.  Either codepath yields 7 hexdigits, and
this is because the function wants to help the user of its output
to produce lines that are as aligned as possible.

Of course, the leeway we have ... that can be reduced is small and
limited.  For a len that is too small in a repository with many
objects that share the same prefix, we cannot fit the result in 7
(i.e. len+3) columns and may have to return a longer result.

But the point is that the existing callers that ask for len=7 are
expecting output that is "7+3=10 output columns most of the time,
even though it might yield a string longer than 10 output columns
when the object names cannot be uniquely shown with that output
width".  

And that was why I was wondering if it gives less negative impact to
callers if we abbreviate to (len+3) hexdigits and return the result.

Note that this was not (and is not) "I think yours is wrong
because..." but was (and is) "I am wondering if doing it differently
is better because...".  Asking for 7 and getting 10 feels strange
and that is one valid reason to "correct" the existing behaviour by
abbreviating to len and just dropping the padding with dots, and it
may be worth a bit of surprise to existing users.  I dunno, and that
is why it was "I wonder...".



