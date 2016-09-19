Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE,STOX_REPLY_TYPE_WITHOUT_QUOTES shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FA441FCA9
	for <e@80x24.org>; Mon, 19 Sep 2016 10:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753245AbcISK44 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 06:56:56 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:57386 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752809AbcISK4z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 06:56:55 -0400
Received: from PhilipOakley ([92.22.33.116])
        by smtp.talktalk.net with SMTP
        id lwFobyVLLY8RwlwFobHz9X; Mon, 19 Sep 2016 11:56:53 +0100
X-Originating-IP: [92.22.33.116]
X-Spam: 0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=7PoCAWDTb98b1EGiAsJI/w==:117
 a=7PoCAWDTb98b1EGiAsJI/w==:17 a=8nJEP1OIZ-IA:10 a=Vf10gz7hqFkv3s2VqOcA:9
 a=wPNLvfGTeEIA:10
Message-ID: <2AD952BD65034D25BF26C7F138D24F25@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Git List" <git@vger.kernel.org>
Subject: clarification of `rev-list --no-walk ^<rev>`?
Date:   Mon, 19 Sep 2016 11:56:54 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfKypzCcix3YumbKFFQHCmo2fRKL6PxbbWUR6oPVZENGi83VjYzWwQpnS4czLe1WYbKHDmFtud+Nl9jVosVeUd+WpO0PHE6V0gP37lmhpxvYGnpxN9r53
 NDtD10vrOi4NEn8kDzewQLIszw69evhGWUXdOhmlIRkKgIotO0e3foDx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A question came up on the Git user list regarding cherry-pick that got me
reading the manual (again), in this case regarding --no-walk ranges.

Essentially my question is: If --no-walk is given to rev-list (e.g. via
charry-pick), and the user includes a caret prefixed rev, when does that
range definition take effect on the command line, especially in light of
the --do-walk option?

In rev-list(1) there are only 8 references to  'range', with only
the --no-walk option saying "This has no effect if a range is specified."
but leaving open the decision as to what does (and does not) comprises the
specification of a range on the cli.

The two and three dot notations are fairly obvious ranges from
gitrevisions(7) as they are complete strings, while the caret prefix is an 
implied range (it needs additional parameters to complete the range, and 
there-in lies the issue).

It can be read that

$ git cherry-pick maint next

would pick two single commits, while

$ git cherry-pick maint next ^master

could implicitly be read as

$ git cherry-pick maint next --do-walk ^master

because the ^ caret starts the range that cancels the --no-walk.

Clearly that's not what is intended, which is

$ git cherry-pick --do-walk maint next ^master

but it is open to interpretation as to where in the command line the caret
range prefix's --do-walk (to countermand the --no-walk) should applied.

If the user did want just the single commit at the tip of maint, and then
the range master..next, what would be their command line, and also, how
would the man page warn against false expectations?

--

Philip





