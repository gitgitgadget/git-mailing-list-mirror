Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B59D156EE
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8531CCC
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 03:09:02 -0700 (PDT)
Received: (qmail 15386 invoked by uid 109); 20 Oct 2023 10:09:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Oct 2023 10:09:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12684 invoked by uid 111); 20 Oct 2023 10:09:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Oct 2023 06:09:06 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Oct 2023 06:09:01 -0400
From: Jeff King <peff@peff.net>
To: Michael Strawbridge <michael.strawbridge@amd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/3] doc/send-email: mention handling of "reply-to" with
 --compose
Message-ID: <20231020100901.GA2673716@coredump.intra.peff.net>
References: <20231020100343.GA2194322@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231020100343.GA2194322@coredump.intra.peff.net>

The documentation for git-send-email lists the headers handled specially
by --compose in a way that implies that this is the complete set of
headers that are special. But one more was added by d11c943c78
(send-email: support separate Reply-To address, 2018-03-04) and never
documented.

Let's add it, and reword the documentation slightly to avoid having to
specify the list of headers twice (as it is growing and will continue to
do so as we add new features).

If you read the code, you may notice that we also handle MIME-Version
specially, in that we'll avoid over-writing user-provided MIME headers.
I don't think this is worth mentioning, as it's what you'd expect to
happen (as opposed to the other headers, which are picked up to be used
in later emails). And certainly this feature existed when the
documentation was expanded in 01d3861217 (git-send-email.txt: describe
--compose better, 2009-03-16), and we chose not to mention it then.

Signed-off-by: Jeff King <peff@peff.net>
---
Just something I noticed since a later commit touches the same list.

 Documentation/git-send-email.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 492a82323d..021276329c 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -68,11 +68,11 @@ This option may be specified multiple times.
 	Invoke a text editor (see GIT_EDITOR in linkgit:git-var[1])
 	to edit an introductory message for the patch series.
 +
-When `--compose` is used, git send-email will use the From, Subject, and
-In-Reply-To headers specified in the message. If the body of the message
-(what you type after the headers and a blank line) only contains blank
-(or Git: prefixed) lines, the summary won't be sent, but From, Subject,
-and In-Reply-To headers will be used unless they are removed.
+When `--compose` is used, git send-email will use the From, Subject,
+Reply-To, and In-Reply-To headers specified in the message. If the body
+of the message (what you type after the headers and a blank line) only
+contains blank (or Git: prefixed) lines, the summary won't be sent, but
+the headers mentioned above will be used unless they are removed.
 +
 Missing From or In-Reply-To headers will be prompted for.
 +
-- 
2.42.0.980.g8b5f6199be

