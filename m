Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A7B92090A
	for <e@80x24.org>; Mon, 20 Mar 2017 20:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756083AbdCTTsh (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 15:48:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51753 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756106AbdCTTsG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 15:48:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5ED747F45B;
        Mon, 20 Mar 2017 15:42:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KW8Z5z2Wx5LyPqrPm5WjiELVYW0=; b=h0WBJa
        UGThalZpXj2m+UqVe0az8Dl1We1upwYt5vwkEhslszgB2jr7se5qNopyhp8qLlsB
        UTQuJYtg+FFMbjlKqV4OQXr5TUhjX7jHjs6tNdP3luvOoPlDqeQIw6UTwJH5jQBd
        3qwqjd2S/1HRyND7EJ7lcjmdVe6lgtinhwW64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mvY5rM238FtYAlKDWwTHpeCegkQJEfQc
        7W3CXovGa7b8jfSrdvI1hkjRL1KJplrNDCVpXMmvBn34qgKRT0jsI0P3rhrd9U1K
        9Xe/Ovgp3pKJ6g5MBbp3rguoId6LdREMAASQOkPjAxIZXFoBLTqFBoR1ccdHT0ib
        tZPmKzf4wso=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 579327F45A;
        Mon, 20 Mar 2017 15:42:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF8A97F457;
        Mon, 20 Mar 2017 15:42:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH/RFC 1/3] stash: show less information for stash push -- <pathspec>
References: <20170318183658.GC27158@hank>
        <20170319202351.8825-1-t.gummerer@gmail.com>
        <20170319202351.8825-2-t.gummerer@gmail.com>
        <xmqqk27jx2ej.fsf@gitster.mtv.corp.google.com>
        <20170320184855.x7m2gxwdqdt3lnet@sigill.intra.peff.net>
Date:   Mon, 20 Mar 2017 12:42:18 -0700
In-Reply-To: <20170320184855.x7m2gxwdqdt3lnet@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 20 Mar 2017 14:48:55 -0400")
Message-ID: <xmqqtw6nvip1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54960EF2-0DA5-11E7-B4F3-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Mar 20, 2017 at 10:51:16AM -0700, Junio C Hamano wrote:
>
>> > diff --git a/git-stash.sh b/git-stash.sh
>> > index 9c70662cc8..59f055e27b 100755
>> > --- a/git-stash.sh
>> > +++ b/git-stash.sh
>> > @@ -299,10 +299,10 @@ push_stash () {
>> >  	then
>> >  		if test $# != 0
>> >  		then
>> > -			git reset ${GIT_QUIET:+-q} -- "$@"
>> > +			git reset -q -- "$@"
>> >  			git ls-files -z --modified -- "$@" |
>> >  			git checkout-index -z --force --stdin
>> > -			git clean --force ${GIT_QUIET:+-q} -d -- "$@"
>> > +			git clean --force -q -d -- "$@"
>> >  		else
>> >  			git reset --hard ${GIT_QUIET:+-q}
>> >  		fi
>> 
>> Yup, we only said "HEAD is now at ..." in the non-pathspec case (and
>> we of course still do).  We didn't report changes to which paths
>> have been reverted in (or which new paths are removed from) the
>> working tree to the original state (and we of course still don't).
>> 
>> The messages from reset and clean that reports these probably do not
>> need to be shown by default to the users (they can always check with
>> "git stash show" when they are curious or when they want to double
>> check).
>
> I'm not sure if you are arguing here that the non-pathspec case should
> move to an unconditional "-q", too, to suppress the "HEAD is now at"
> message.  But I think that is a good suggestion. It would make the two
> cases consistent, and it is not really adding anything of value (it is
> always just HEAD, and if you do not provide a custom message, the
> short-sha1 and subject are already in the "Saved..." line above).

I wasn't suggesting it (I was just saying that these extra messages
are not something we found necessary for consistency with the
original codepath when we added the pathspec support).  I wasn't
even thinking about what the original codepath did, i.e. when the
command is run without pathspec.

I too suspect that most of the ${GIT_QUIET:+-q} can just become an
unconditional -q as you do.


