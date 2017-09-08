Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B88FB20286
	for <e@80x24.org>; Fri,  8 Sep 2017 02:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbdIHCkY (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 22:40:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55292 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752157AbdIHCkX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 22:40:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CED0CAF6CB;
        Thu,  7 Sep 2017 22:40:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bnb8SFCk/Rc1Ec+losTkX/WrRUI=; b=iavsw+
        rA5dzKq/4jcddYR0ZuvwFxQaZ89qtuyZqqmVXRLYyD7FOWw/CgycbhHVuZPL566L
        lvFwhgaiBzNPWLX6tq2W3kxkZa3y2OXw2DFeQ2XYVYk+lsSDCZc2rKSy3/4BpGjx
        LuXxYHhG2hiyPd/p87RLMWNjRanKyfHQh7b1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lV+sfmVSuVoavBpVR4kNNx1BSz2cH6oe
        sgMBuYllzxkLipX9+vaq05YGcBL8IPW5mQHLwACiNlQyQ0usHjwWMyQAYU+XLIFW
        Sfag0WCcIdN1797TufJCkY4gYUORJ2Nc5LsSjGHvQHDFyYv2l3G9uZAsmNf/QL5J
        HNWkKHMSWig=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7D78AF6CA;
        Thu,  7 Sep 2017 22:40:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2F482AF6C9;
        Thu,  7 Sep 2017 22:40:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        jonathantanmy@google.com, Jeff King <peff@peff.net>,
        David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
        <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
        <20170307001709.GC26789@aiede.mtv.corp.google.com>
        <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 08 Sep 2017 11:40:21 +0900
In-Reply-To: <xmqqa828733s.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 06 Sep 2017 15:28:23 +0900")
Message-ID: <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F8B4BE4-943F-11E7-9157-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> One thing I still do not know how I feel about after re-reading the
> thread, and I didn't find the above doc, is Linus's suggestion to
> use the objects themselves as NewHash-to-SHA-1 mapper [*1*].  
> ...
> [Reference]
>
> *1* <CA+55aFxj7Vtwac64RfAz_u=U4tob4Xg+2pDBDFNpJdmgaTCmxA@mail.gmail.com>

I think this falls into the same category as the often-talked-about
addition of the "generation number" field.  It is very tempting to
add these "mechanically derivable but expensive to compute" pieces
of information to the sha3-content while converting from
sha1-content and creating anew.  

Because the "sha1-name" or the "generation number" can mechanically
be computed, as long as everybody agrees to _always_ place them in
the sha3-content, the same sha1-content will be converted into
exactly the same sha3-content without ambiguity, and converting them
back to sha1-content while pushing to an older repository will
correctly produce the original sha1-content, as it would just be the
matter of simply stripping these extra pieces of information.

The reason why I still feel a bit uneasy about adding these things
(aside from the fact that sha1-name thing will be a baggage we would
need to carry forever even after we completely wean ourselves off of
the old hash) is because I am not sure what we should do when we
encounter sha3-content in the wild that has these things _wrong_.
An object that exists today in the SHA-1 world is fetched into the
new repository and converted to SHA-3 contents, and Linus's extra
"original SHA-1 name" field is added to the object's header while
recording the SHA-3 content.  But for whatever reason, the original
SHA-1 name is recorded incorrectly in the resulting SHA-3 object.

The same thing could happen if we decide to bake "generation number"
in the SHA-3 commit objects.  One possible definition would be that
a root commit will have gen #0; a commit with 1 or more parents will
get max(parents' gen numbers) + 1 as its gen number.  But somebody
may botch the counting and records sum(parents' gen numbers) as its
gen number.

In these cases, not just the SHA3-content but also the resulting
SHA-3 object name would be different from the name of the object
that would have recorded the same contents correctly.  So converting
back to SHA-1 world from these botched SHA-3 contents may produce
the original contents, but we may end up with multiple "plausibly
looking" set of SHA-3 objects that (clain to) correspond to a single
SHA-1 object, only one of which is a valid one.

Our "git fsck" already treats certain brokenness (like a tree whose
entry has mode that is 0-padded to the left) as broken but still
tolerate them.  I am not sure if it is sufficient to diagnose and
declare broken and invalid when we see sha3-content that records
these "mechanically derivable but expensive to compute" pieces of
information incorrectly.

I am leaning towards saying "yes, catching in fsck is enough" and
suggesting to add generation number to sha3-content of the commit
objects, and to add even the "original sha1 name" thing if we find
good use of it.  But I cannot shake this nagging feeling off that I
am missing some huge problems that adding these fields and opening
ourselves to more classes of broken objects.

Thoughts?


