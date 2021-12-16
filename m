Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78D8C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 23:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbhLPXWT convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 16 Dec 2021 18:22:19 -0500
Received: from elephants.elehost.com ([216.66.27.132]:58308 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbhLPXWS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 18:22:18 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1BGNMBDE088345
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 16 Dec 2021 18:22:12 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Emily Shaffer'" <emilyshaffer@google.com>, <git@vger.kernel.org>
Cc:     <jrnieder@gmail.com>, <jonathantanmy@google.com>,
        <steadmon@google.com>, <chooglen@google.com>,
        <calvinwan@google.com>
References: <YbvBvch8JcHED+A9@google.com>
In-Reply-To: <YbvBvch8JcHED+A9@google.com>
Subject: RE: Review process improvements
Date:   Thu, 16 Dec 2021 18:22:06 -0500
Organization: Nexbridge Inc.
Message-ID: <00b901d7f2d3$c0d2ca20$42785e60$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQItkT9BstFYkV2EjR48HE458GxTtKuKgEyg
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 16, 2021 5:46 PM, Emily Shaffer wrote:
> 1. Draft a MAINTAINERS file
> Since the Git codebase isn't modularized into subsystems as plainly as the
> kernel is, I don't think that the MAINTAINERS list needs to be machine-
> parseable yet, although it would be a nice goal.

I am not sure about separate mailing lists. That gets really cumbersome as things get large. Perhaps some prefix in email based on the list.

I think starting with a YAML-style MAINTAINERS file might be better than the artificial tag structure proposed even as a starting point.

Somewhat like:

Submodules:
 Prefix: SUBM
 Files:
     submodule.[ch], git-submodule.sh, builtin/submodule.c,
     Documentation/git-submodule.txt
 Reviewers:
   git-submodules@example.com
   emilyshaffer@google.com

etc.

> It would be extremely useful to hear other suggestions from the mailing list
> about subsystems which deserve a MAINTAINERS line and possibly a
> subsystem mailing list.

Some suggestions:

Platform:
 Linux:
  Prefix: LINUX
  Reviewers: etc.
 NonStop:
  Prefix: NS
  Reviewers:
   rsbecker@nexbridge.com (a.k.a. me!)
 etc.

Compat-Layer
 Prefix: COMPAT
Perl
Python
P4
SVN
Gitk
Signing
Future-Plans
Etc.

> 2. Draft a ReviewingPatches doc
> Another theme we discussed was the general ambiguity around the act of
> performing code review. How detailed should the review be? Who should be
> examining interoperability with the rest of the codebase? Is it OK to reply
> with only "I don't know what you're trying to do, rewrite your commit
> message please"?

People learn what they see, so it is important to keep review style consistent both for the actual review and to keep the review culture consistent. In some places, I have seen review "Body of Knowledge" documents as the review culture evolves outlining what should be in a review beside the code style guidelines.

> 3. Google Git team will review cover letters and commit messages
>    internally before sending series to the list I often find that when I send a
> patch to the list, reviewers reply without understanding the point of what I
> was trying to achieve in the patch. It sounded like this happens to some
> other Google Gitters as well. Luckily, that's fixable by the patch author.
> 
> To try and make sure we're sending patches that are easy to understand and
> decide whether to review, we're adding a step to our process ASAP to
> require commit messages, cover letters, and "---" notes to be reviewed and
> approved by at least one other Googler before a topic goes to the mailing list.
> Those reviews don't need to be formal, but do need to happen for every
> reroll of a series. We also will intentionally *not* review the diff of changes in
> this private setting - reviews for code correctness, etc. should continue to
> happen upstream, in public.
><snip>
> 4. Documentation changes to encourage commit message quality Commit
> messages are important, but one comment I hear a lot from new
> contributors to the Git project is: "why do these people care about the
> commit message so much? The commit message doesn't compile!"

This is leading down a major git enhancement RFE, which may have general applicability. One great power of git is the idempotency of the commit across files. I realize that the current style for git itself is separate commits, but I think that partly is a limitation of the commit capability itself.

Suppose the cover letter is essentially a headline, with the subject being the headline headline of the commit. The commit comment could (the RFE) vary depending on the file being committed - an attribute of the node in the Merkel Tree perhaps. So the main commit node has the headline, the cover letter contents, while the file node has the main headline and the file-specific comment. In git log, you would see the headline, then the cover letter, then the file comment (if specifying a path). Just a thought. It might significantly reduce the size of history.

Just some ramblings,
-Randall

