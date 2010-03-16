Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 15807 invoked by uid 107); 16 Mar 2010 17:54:24 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Tue, 16 Mar 2010 13:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938186Ab0CPRxt (ORCPT <rfc822;peff@peff.net>);
	Tue, 16 Mar 2010 13:53:49 -0400
Received: from mailgw1.uni-kl.de ([131.246.120.220]:42500 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937249Ab0CPRxr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 13:53:47 -0400
Received: from dfki.uni-kl.de (dfki-1002.dfki.uni-kl.de [131.246.195.2])
	by mailgw1.uni-kl.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o2GHr4il004680;
	Tue, 16 Mar 2010 18:53:04 +0100
Received: from serv-2100.kl.dfki.de (serv-2100.kl.dfki.de [192.168.21.180])
	by dfki.uni-kl.de (8.13.8+Sun/8.11.4) with ESMTP id o2GHr3qG002292;
	Tue, 16 Mar 2010 18:53:03 +0100 (CET)
Received: from pc-2163.kl.dfki.de (pc-2163.kl.dfki.de [192.168.21.153])
	by serv-2100.kl.dfki.de (8.13.8+Sun/8.13.8) with ESMTP id o2GHr269018875;
	Tue, 16 Mar 2010 18:53:03 +0100 (CET)
Received: (from hendeby@localhost)
	by pc-2163.kl.dfki.de (8.14.3/8.14.3/Submit) id o2GHqwS2009803;
	Tue, 16 Mar 2010 18:52:58 +0100
From:	Gustaf Hendeby <hendeby@isy.liu.se>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH v2] Improve error messages from 'git stash show'
Date:	Tue, 16 Mar 2010 18:52:37 +0100
Message-Id: <1268761957-9769-1-git-send-email-hendeby@isy.liu.se>
X-Mailer: git-send-email 1.7.0.2.274.gba5d.dirty
In-Reply-To: <7v4okgfbrt.fsf@alter.siamese.dyndns.org>
References: <7v4okgfbrt.fsf@alter.siamese.dyndns.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The previous error message "fatal: Needed a single revision" is not
very informative.

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
---

On 03/16/2010 05:53 PM, Junio C Hamano wrote:
>>>> +	b_commit=$(git rev-parse --quiet --verify "$w_commit^") ||
>>>> >>>  +		die 'Stash not found'
>>>> >>>  +
>>> >>  
>>> >>  Because you checked have_stash upfront, an error detected here cannot be
>>> >>  "stash not found".  It is something else, isn't it?
>> >
>> >  This case occurs when you do something like git stash foo, where foo is
>> >  no appropriate stash to show.  Would something like this be more
>> >  informative in the case of git stash foo:
>> >
>> >  Stash entry 'foo' could not be found
> That is more like "'foo' is not a stash", isn't it?

I find your suggestion much clearer.  Thank you!

/Gustaf

 git-stash.sh |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index aa47e54..59db3dc 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -210,14 +210,18 @@ list_stash () {
 }
 
 show_stash () {
+	have_stash || die 'No stash found'
+
 	flags=$(git rev-parse --no-revs --flags "$@")
 	if test -z "$flags"
 	then
 		flags=--stat
 	fi
 
-	w_commit=$(git rev-parse --verify --default $ref_stash "$@") &&
-	b_commit=$(git rev-parse --verify "$w_commit^") &&
+	w_commit=$(git rev-parse --quiet --verify --default $ref_stash "$@") &&
+	b_commit=$(git rev-parse --quiet --verify "$w_commit^") ||
+		die "'$*' is not a stash"
+
 	git diff $flags $b_commit $w_commit
 }
 
-- 
1.7.0.2.274.gba5d.dirty

