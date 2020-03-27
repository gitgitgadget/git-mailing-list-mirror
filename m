Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5EDC2D0E5
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 17:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C83206E6
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 17:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AilpElGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgC0Roi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:44:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59249 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbgC0Roi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 13:44:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E3864B6A8A;
        Fri, 27 Mar 2020 13:44:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3QyZyhTKzY52lWozMAbf3cT9CWU=; b=AilpEl
        GZ38/ohNDCQpunCyq2YTBmJ2OVpJegeRddW0eACdCZBIJq4dFWicvV17mybWOzF0
        7WnV10KlewBlNWA5mZweHXOSPC28pGpdiiMfbleHg1loTF54nnIbxe03KyA5BdHr
        OmSdFTcAbhE8ls3LoNkXRHutTPlS8yz7PkoP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Jol/3m1lOys+8ShiR2//CSpmZSG0NKaL
        Xeo2Y2PY0HnT/Ev2jXr629dI4i+BsVJwn48Fpcboj/Iqd/VmiLR1XndARiCqvYtl
        4UK9RzcJpOYTl4OZ3zq8BZ7Zw4n6ADix5YMfibYixFx30P8rW5/seRor3cwapfN+
        N2fzRUtXLEk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C9A41B6A89;
        Fri, 27 Mar 2020 13:44:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 11CC4B6A83;
        Fri, 27 Mar 2020 13:44:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/5] tests: turn GPG, GPGSM and RFC1991 into lazy prereqs
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
        <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
        <85457a7b61874e8e9f3af9c231451df0aba7a7b5.1585114881.git.gitgitgadget@gmail.com>
        <20200326083519.GD2200716@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2003261450590.46@tvgsbejvaqbjf.bet>
        <20200327091004.GA610157@coredump.intra.peff.net>
Date:   Fri, 27 Mar 2020 10:44:27 -0700
In-Reply-To: <20200327091004.GA610157@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 27 Mar 2020 05:10:04 -0400")
Message-ID: <xmqqr1xdhev8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BBF91FA-7052-11EA-9F48-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So my perspective was the opposite of yours: "return" is the officially
> sanctioned way to exit early from a test snippet, and "exit" only
> happens to work because of the undocumented fact that lazy prereqs
> happen in a subshell. But it turns out neither was documented. :)

Good miniproject to document them, I presume.  A rough draft
attached.  I do not mind adding "exit 1 also works in this and that
case, but not in that other case" if the rule can be given succinct
enough, but I opted for simplicity (mostly because I couldn't come
up with such a clear rule for "exit 1").  

As long as we are consciouly ensuring that "return 1" consistently
works everywhere, I didn't see much point offering multiple ways to
do the same thing.

> Yes. Part of the reason I kept mine as it was is because it matched the
> original behavior better (and I was really only using a lazy prereq
> because we didn't have a non-lazy version). But there's really no reason
> _not_ to be lazy, so as long as it isn't breaking anything I think
> that's a better way forward. (And if it is breaking something, that
> something should be fixed).

Yup, I too liked that part of Dscho's version better.

-- >8 --
Subject: [PATCH] t/README: suggest how to leave test early with failure

Over time, we added the support to our test framework to make it
easy to leave a test early with failure, but it was not clearly
documented in t/README to help developers writing new tests.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * A tangent.  441ee35d (t/README: reformat Do, Don't, Keep in mind
   lists, 2018-10-05) added these lines

    Here are the "do's:"
    And here are the "don'ts:"

   Is the placement of the colons on these lines right?  I am
   tempted to chase them out of the dq pair and move them at the end
   of their lines, but obviously that is outside of the scope of
   this patch.

 t/README | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/t/README b/t/README
index 369e3a9ded..08c8d00bb6 100644
--- a/t/README
+++ b/t/README
@@ -546,6 +546,61 @@ Here are the "do's:"
    reports "ok" or "not ok" to the end user running the tests. Under
    --verbose, they are shown to help debug the tests.
 
+ - Be careful when you loop
+
+   You may need to test multiple things in a loop, but the following
+   does not work correctly:
+
+	test_expect_success 'git frotz on various versions' '
+	    for revision in one two three
+	    do
+		    echo "frotz $revision" >expect &&
+		    git frotz "$revision" >actual &&
+		    test_cmp expect actual
+	    done &&
+	    test something else
+	'
+
+   If the output from the "git frotz" command did not match what is
+   expected for 'one' and 'two', but it did for 'three', the loop
+   itself would not fail, and the test goes on happily.  This is not
+   what you want.
+
+   You can work it around in two ways.  You could use a separate
+   "flag" variable to carry the failed state out of the loop:
+
+	test_expect_success 'git frotz on various versions' '
+	    failed=
+	    for revision in one two three
+	    do
+		    echo "frotz $revision" >expect &&
+		    git frotz "$revision" >actual &&
+		    test_cmp expect actual ||
+		    failed="$failed${failed:+ }$revision"
+	    done &&
+	    test -z "$failed" &&
+	    test something else
+	'
+    
+    Or you can fail the entire loop immediately when you see the
+    first failure by using "return 1" from inside the loop, like so:
+
+	test_expect_success 'git frotz on various versions' '
+	    for revision in one two three
+	    do
+		    echo "frotz $revision" >expect &&
+		    git frotz "$revision" >actual &&
+		    test_cmp expect actual || return 1
+	    done &&
+	    test something else
+	'
+
+    Note that this is only possible in our test suite, where we
+    arrange to run your test <script> wrapped inside a helper
+    function to ensure that return values matter; in your own script
+    outside any function, this technique may not work.
+
+
 And here are the "don'ts:"
 
  - Don't exit() within a <script> part.
