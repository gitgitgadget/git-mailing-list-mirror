X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Apply obvious numerical cast for stupid C compilers.
Date: Sat, 04 Nov 2006 23:06:52 -0800
Message-ID: <7v3b8ywewj.fsf@assigned-by-dhcp.cox.net>
References: <20061105053544.GA4193@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 07:07:13 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061105053544.GA4193@spearce.org> (Shawn O. Pearce's message of
	"Sun, 5 Nov 2006 00:35:44 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30951>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggc5w-0004A6-8P for gcvg-git@gmane.org; Sun, 05 Nov
 2006 08:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161173AbWKEHGy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 02:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbWKEHGx
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 02:06:53 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:46729 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1161173AbWKEHGx
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 02:06:53 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061105070652.OIFX16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Sun, 5
 Nov 2006 02:06:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id iv6x1V00M1kojtg0000000 Sun, 05 Nov 2006
 02:06:57 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

"Shawn O. Pearce" <spearce@spearce.org> writes:

> At least one (older) version of the Solaris C compiler won't allow
> 'unsigned long x = -1' without explicitly casting -1 to a type of
> unsigned long.  As annoying as it may be to explicitly perform the
> cast the compiler is right; -1 is not an unsigned value.

Is the compiler really _right_?  The usual integral promotion
rules should apply if it claims to be a C compiler, I would
think.

But I think the code actually wants ULONG_MAX there.  Is that
symbolic constant available at the point of offending
initialization with the header files we already include, I
wonder.

In other words, how about this patch instead?

-- >8 --

diff --git a/builtin-apply.c b/builtin-apply.c
index db7cdce..aad5526 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -43,7 +43,7 @@ static int apply_verbosely;
 static int no_add;
 static int show_index_info;
 static int line_termination = '\n';
-static unsigned long p_context = -1;
+static unsigned long p_context = ULONG_MAX;
 static const char apply_usage[] =
 "git-apply [--stat] [--numstat] [--summary] [--check] [--index] [--cached] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [--reverse] [--reject] [--verbose] [-z] [-pNUM] [-CNUM] [--whitespace=<nowarn|warn|error|error-all|strip>] <patch>...";
 
