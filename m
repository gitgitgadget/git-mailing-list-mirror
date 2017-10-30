Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C259D202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 02:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbdJ3CNo (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 22:13:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55176 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751310AbdJ3CNo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 22:13:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E033BAC38;
        Sun, 29 Oct 2017 22:13:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JmnXcBBcvvNw60Mh4TUxGdFKwhc=; b=W2yM6P
        GDU2GpI3HVHJXc3ZsF4pjIrtxzXy0v/H26Zz3MPfESG5t3Dye7X371DhOyqmLA0t
        ZsiOCyI/rH6OfvYjAUmclul0YjxcIehe4uTAFEPeqTRgFedqeo36oUUhoKg2Yctg
        m7GoWrKfcRRz84IZeybVfEVN5iAycxLWwM7Gg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hgoE+rHaxHUZRbwEnNdcMEC8Khmr+Yb7
        4n/hrUFA4sbLnLxLfmcZbIGciy4HFHjFOTxkH53dzQC6fGLciK/a51+fYyiwkyul
        rWMSd7dzQeGJnB4nAWjfLvovo5r9CqH+Bl+L7kZKqYuo7mj7rfA+g3leJcOQHXcJ
        prwf4alHWYI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4520FBAC37;
        Sun, 29 Oct 2017 22:13:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B3603BAC36;
        Sun, 29 Oct 2017 22:13:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 3/4] Integrate hash algorithm support with repo setup
References: <20171028181239.59458-1-sandals@crustytoothpaste.net>
        <20171028181239.59458-4-sandals@crustytoothpaste.net>
        <CAPig+cTrAxWczJ5qX2qE-hqoo6hA2QCom25HYB7v48rVnPgTow@mail.gmail.com>
        <20171029175712.ijqirnghcgeufqae@genre.crustytoothpaste.net>
        <CAPig+cRtexDJYMCUR1rGZjJOBRuDbhxP==US2VdNPhSWzeL6LA@mail.gmail.com>
        <20171029193327.uqkj6w3ypfwqwm7b@genre.crustytoothpaste.net>
Date:   Mon, 30 Oct 2017 11:13:41 +0900
In-Reply-To: <20171029193327.uqkj6w3ypfwqwm7b@genre.crustytoothpaste.net>
        (brian m. carlson's message of "Sun, 29 Oct 2017 19:33:28 +0000")
Message-ID: <xmqq7evd8jsa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3A2E3D6-BD17-11E7-BF56-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Sun, Oct 29, 2017 at 03:02:20PM -0400, Eric Sunshine wrote:
>> On Sun, Oct 29, 2017 at 1:57 PM, brian m. carlson
>> <sandals@crustytoothpaste.net> wrote:
>> > I can do CURRENT_HASH_ALGO or CURRENT_HASH instead if you think that's
>> > an improvement.  I originally omitted the "algo" portion to keep it
>> > short.
>> 
>> I don't have strong feelings about it aside from worrying about a
>> "current_hash" name clash or a reader misunderstanding what it
>> represents.
>> 
>> Does "current" need to be in the name? What about HASH_ALGO or REPO_HASH_ALGO?
>> 
>> > Alternatively, we could have a current_hash() (or current_hash_algo())
>> > inline function if people like that better.
>> 
>> hash_algo() or repo_hash_algo()?
>
> Those are also fine, and shorter to boot.  I'll wait to see if anyone
> has strong opinions on the direction we should go before making a
> change.

Is the plan to allow running with multiple hash algorithms in
parallel?  I thought what we want to see in the future codebase was
to have the default hash algorithm used for everything except for a
select few codepaths, and assumed that the way we achieve it is to

 - allow very low level helper functions (e.g. read_sha1_file(),
   write_sha1_file_prepare(), etc.) to take a pointer to the hash
   algorithm structure;

 - have higher level helper functions to call these low level
   helpers with a fixed singleton instance of hash algorithm
   structure that represents that default one (SHA2-something?); and

 - a few selected codepaths (e.g. index-pack that reads SHA-1 stream
   and converts it into NewHash pack/index while building the object
   name mapping) use an additional singleton instance of hash
   algorithm structure that represents the SHA-1 hash, and the way
   they use it is *NOT* by replacing "the current" one with SHA-1,
   but by explicitly passing the instance to the low level helpers
   as parameter.

So, "current" does indeed sound quite wrong, as it makes it sound as
if you can swap it anytime and ask "which one is in effect now?".
If we do not want to call the default instance "SHA-2" because we
want to prepare for migrating again by not having the name of a
concrete hash algorithm sprinkled in the codebase all over like we
currently do, why not call the instance "the_hash_algo"?

