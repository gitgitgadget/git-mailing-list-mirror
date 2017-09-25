Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0174E20A26
	for <e@80x24.org>; Mon, 25 Sep 2017 05:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753215AbdIYFdR (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 01:33:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55765 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752886AbdIYFdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 01:33:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77244B349F;
        Mon, 25 Sep 2017 01:33:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RwBwEuuvgj/vj8prW/NS26l6xqQ=; b=OSF+Qm
        aaNE6nse3Ivj6yRsSRC9KfiGdfIwRDtCzw/zZb0G3118C3j9YFGdit/22Dtbnagg
        nP4/2PnN3TBw3piKDlFWjb/dtyBNMsqnuJf4LSoR2RulsUhAUy72TejOJaYLJ0gt
        qeDSvQ57j68xuNA3c4/QR5lnwiVDNpNRQt02E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GsZLkC7oQoNT5weQqZlK05fqN9Kf+AQA
        jqW8WqEDBbAj0oUPHPUlIPt7W1dxxcR3xeWUkRUf9dx3LwXvSWYSgwZM+TqidaBa
        m8HxXeds36ffpqgLiOhXBnFbbNFuw2FLFv0pl/vptr8bCzO+V6njlCcLo0xlmpm1
        iLy2wWo/CPo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6ED20B349E;
        Mon, 25 Sep 2017 01:33:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C04FBB349D;
        Mon, 25 Sep 2017 01:33:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re* BUG: merge -s theirs  is not in effect (does the same as -s ours)
References: <20170925000213.rilmsczdbi3jqkta@hopa.kiewit.dartmouth.edu>
        <xmqqwp4nfuv1.fsf@gitster.mtv.corp.google.com>
        <20170925031751.lg7zk6krt65dxwas@hopa.kiewit.dartmouth.edu>
Date:   Mon, 25 Sep 2017 14:33:13 +0900
In-Reply-To: <20170925031751.lg7zk6krt65dxwas@hopa.kiewit.dartmouth.edu>
        (Yaroslav Halchenko's message of "Sun, 24 Sep 2017 23:17:51 -0400")
Message-ID: <xmqqmv5je412.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0713500C-A1B3-11E7-AE8E-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yaroslav Halchenko <yoh@onerussian.com> writes:

> d'oh, indeed there is no git-merge-theirs  neither in debian pkg or a freshly
> built git  and I found a rogue script in the PATH (which did nothing
> apparently, sorry!). BUT I was originally mislead by the --help/manpage:

Ahh, you're right.  The text does make readers expect "-s theirs" to
exist.

-- >8 --
Subject: merge-strategies: avoid implying that "-s theirs" exists

The description of `-Xours` merge option has a parenthetical note
that tells the readers that it is very different from `-s ours`,
which is correct, but the description of `-Xtheirs` that follows it
carelessly says "this is the opposite of `ours`", giving a false
impression that the readers also need to be warned that it is very
different from `-s theirs`, which in reality does not even exist.

Clarify it a bit to avoid misleading readers.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I hope this should help things a bit.

   It is a different matter to resurrect the age old discussion that
   happend in the summer of 2008 if '-s theirs' should or should not
   exist.  In short, the previous discussion can be summarised to
   "we don't want '-s theirs' as it encourages the wrong workflow".

   https://public-inbox.org/git/alpine.DEB.1.00.0807290123300.2725@eeepc-johanness/
   https://public-inbox.org/git/7vtzen7bul.fsf@gitster.siamese.dyndns.org/
   https://public-inbox.org/git/20080720192130.6117@nanako3.lavabit.com/

   It is OK for people to come with new perspective and bring new
   ideas to the table.  We learned from experience while using Git
   for longer and are wiser than what we were back then, and might
   be able to make a better decision ;-)

 Documentation/merge-strategies.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 2eb92b9327..a09d597463 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -39,7 +39,8 @@ even look at what the other tree contains at all.  It discards everything
 the other tree did, declaring 'our' history contains all that happened in it.
 
 theirs;;
-	This is the opposite of 'ours'.
+	This is the opposite of 'ours'; note that, unlike 'ours', there is
+	no 'theirs' merge stragegy to confuse this merge option with.
 
 patience;;
 	With this option, 'merge-recursive' spends a little extra time
