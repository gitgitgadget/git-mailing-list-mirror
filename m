Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 6793 invoked by uid 107); 24 Aug 2009 08:10:04 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 24 Aug 2009 04:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbZHXIJo (ORCPT <rfc822;peff@peff.net>);
	Mon, 24 Aug 2009 04:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbZHXIJo
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 04:09:44 -0400
Received: from karen.lavabit.com ([72.249.41.33]:49149 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240AbZHXIJn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 04:09:43 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 08C4511B8B7;
	Mon, 24 Aug 2009 03:09:45 -0500 (CDT)
Received: from 6854.lavabit.com (200.223.181.44)
	by lavabit.com with ESMTP id BKCNJC0ZND25; Mon, 24 Aug 2009 03:09:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=yuRY0JoC0lEF/DSPBKRBKJwafUvZ+Svc8MzKt3YyK07elMsH4hazyw2mSz8sNtFjnqGhFwfO/186/MaU2a7cuOzub55HiPCP0FVOnGaWXnyIKOVbX291HTS1K655Q4s1Ycv+bbzmwFyvP69F+r5IkpkLrLnIHMiYjPkDH43hEnU=;
  h=From:To:Cc:Subject:X-Draft-From:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
From:	Nanako Shiraishi <nanako3@lavabit.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] Teach mailinfo to ignore everything before -- >8 -- mark
X-Draft-From: ("nnml:git" 118184)
References: <1250999285-10683-1-git-send-email-git@tbfowler.name>
	<1250999357-10827-3-git-send-email-git@tbfowler.name>
	<7vvdkfx8rl.fsf@alter.siamese.dyndns.org>
	<20090823171819.6117@nanako3.lavabit.com>
	<7v1vn2yklo.fsf@alter.siamese.dyndns.org>
	<20090824060708.6117@nanako3.lavabit.com>
	<alpine.DEB.2.00.0908231705200.29625@GWPortableVCS>
	<7v7hwurwmu.fsf@alter.siamese.dyndns.org>
	<20090824041608.GC3526@vidovic>
	<20090824141623.6117@nanako3.lavabit.com>
In-Reply-To: <20090824141623.6117@nanako3.lavabit.com>
Date:	Mon, 24 Aug 2009 17:09:06 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20090824170906.6117@nanako3.lavabit.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Quoting myself...

> A scissors mark doesn't have to be at the beginning. The line has to
> contain the mark, and it has to consist of only the mark, '-' minus, the
> phrase "cut here", and whitespaces.

Junio, perhaps you want to squash some documentation, too.

-- 8< -- cut here -- 8< -- cut here -- 8< --
Subject: [PATCH] Documentation: describe the scissors mark support of "git am"

Describe what a scissors mark looks like, and explain in what situation
it is often used.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 Documentation/git-am.txt |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index fcacc94..fecd5ac 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -128,10 +128,18 @@ the commit, after stripping common prefix "[PATCH <anything>]".
 The "Subject: " line is supposed to concisely describe what the
 commit is about in one line of text.
 
-"From: " and "Subject: " lines starting the body (the rest of the
-message after the blank line terminating the RFC2822 headers)
-override the respective commit author name and title values taken
-from the headers.
+A line that contains a scissors mark (either ">8" or "8<") and does not
+have anything other than scissors, dash (-), whitespaces or a phrase "cut
+here" is called a scissors line. If such a line appears in the body of the
+message before the patch, everything before it (including the scissors
+line itself) is ignored. This is useful if you want to begin your message
+in a discussion thread with comments and suggestions on the message you
+are responding to, and to conclude it with a patch submission, separating
+the discussion and the beginning of the proposed commit log message with a
+scissors line.
+
+"From: " and "Subject: " lines starting the body override the respective
+commit author name and title values taken from the headers.
 
 The commit message is formed by the title taken from the
 "Subject: ", a blank line and the body of the message up to

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

