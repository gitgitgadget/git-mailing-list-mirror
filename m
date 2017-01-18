Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 382F01F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 23:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751199AbdARXb6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 18:31:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61825 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751383AbdARXb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 18:31:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7257261A77;
        Wed, 18 Jan 2017 17:15:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/G8hkx8KlkMBCNfywR4GqA+VXU0=; b=oJvDnY
        h757d9MY8UokRBOV0YvbQ6T5MamI79m6XRkc/tvchyrYgcZD3sp58cSaiwHiDZK+
        egr6Xrlqt8kwQI9HKr5MS1dOqMQCHHKoP3//HwExn7178lYwCpMXjgwG+0Dub5JN
        gLlUFx2rgk86DPl8ULq6mmKKHrZRgUnjnsu9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v5DP0nGq/DO2o5BUaGTTmyVHt/sazb5F
        Pf2urG/YlvZ7XfZqnqUCIV/I45o1Cwbfusi8JIBFrmFlNBjtgu/0c+4qF4Q7Wp/j
        0CwlI32ra33tvQ5vfyZoletonEJgKD62Et83UByZIxg5TRXk+bqZdp84LSZwDlmB
        sczjjWImt0w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AE7E61A76;
        Wed, 18 Jan 2017 17:15:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B720761A75;
        Wed, 18 Jan 2017 17:15:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
Subject: Re: "git diff --ignore-space-change --stat" lists files with only whitespace differences as "changed"
References: <1484704915.2096.16.camel@mattmccutchen.net>
        <20170118111705.6bqzkklluikda3r5@sigill.intra.peff.net>
        <xmqqvatc3x3r.fsf@gitster.mtv.corp.google.com>
        <20170118210821.xugr6jnvzgoxpynb@sigill.intra.peff.net>
Date:   Wed, 18 Jan 2017 14:15:40 -0800
In-Reply-To: <20170118210821.xugr6jnvzgoxpynb@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 18 Jan 2017 16:08:21 -0500")
Message-ID: <xmqqtw8w2ewj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A630B938-DDCB-11E6-83C8-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jan 18, 2017 at 12:57:12PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > So I dunno. A sensible rule to me is "iff -p would show a diff header,
>> > then --stat should mention it".
>> 
>> True but tricky (you need a better definition of "a diff header").
>> 
>> In addition to a new and deleted file, does a file whose executable
>> bit was flipped need mention?  If so, then "diff --git" is the diff
>> header in the above.  Otherwise "@@ ... @@", iow, "iff -p would show
>> any hunk".
>> 
>> I think the patch implements the latter, which I think is sensible.
>
> I would think the former is more sensible (and is what my patch is
> working towards).

Doh (yes, "diff --git" was what I meant).  As a mode-flipping patch
does not have hunk but does show the header, it wants to be included
in "git diff --stat" output, I would think, independent of -b issue.
In fact

	chmod +x README.md
	git diff --stat

does show a 0-line diffstat.


> Doing:
>
>   >empty
>   git add empty
>   git diff --cached
>
> shows a "diff --git" header, but no hunk. I think it should show a
> diffstat (and does with my patch).
>
> I was thinking the rule should be something like:
>
>   if (p->status == DIFF_STATUS_MODIFIED &&
>       !file->added && !file->deleted))
>
> and otherwise include the entry, since it would be an add, delete,
> rename, etc, which carries useful information.
>
> Though a pure rename would not hit this code path at all, I would think
> (it would not trigger "!same_contents"). And a rename where there was a
> whitespace only change probably _should_ be omitted from "-b".
>
> Ditto for a pure mode change, I think. We do not run the contents
> through diff at all, so it does not hit this code path.
>
> -Peff
