From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Git GSoC 2014
Date: Thu, 13 Feb 2014 18:17:17 -0500
Message-ID: <CALkWK0mR=9ZD256bHx9d=W9ayqn5bOETWBQLW_kvRSy-GeQK4Q@mail.gmail.com>
References: <20140213091037.GA28927@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Shawn Pearce <spearce@spearce.org>,
	Thomas Rast <tr@thomasrast.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 14 00:18:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE5Xk-0004wk-S7
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 00:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbaBMXSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 18:18:01 -0500
Received: from mail-qc0-f169.google.com ([209.85.216.169]:44439 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbaBMXSA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 18:18:00 -0500
Received: by mail-qc0-f169.google.com with SMTP id w7so19092667qcr.14
        for <git@vger.kernel.org>; Thu, 13 Feb 2014 15:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jgualN90p//i5/UpTpxoPOBQWO0iEDmxQk4QOIA4PzE=;
        b=dsV02sgwww352oSbbG3vrw4YSZv4O+EQyxfQJiCNJ/MmOW6/oTvRk/9VscNs/D6MZI
         p2UGAWJvPe5Un19J/1FRLdBaoFaExTwgJON6sNKP0FmWQRF1gcPXhbwV28/T3SfVJ6J7
         Z8ZCIUGdtFr1BYWASrV0YvAtIvBDs5Y6G3JJTHiLZ/hQg4OsBrYIX58QEE5CHeIemu6r
         Hmn0iGgI42Gt2GmWz/JVSOiokCIdhnKXoTfOwxjxDOopNW89AciE08tZ3iWSXU4lC3gF
         U7ZZOzo73jVFFwTntv0cj62QZGU47J9jfGk5rH9ZQUdfSPE/tSP8uJNOdtsDZ+I2EHyQ
         UU6g==
X-Received: by 10.224.115.143 with SMTP id i15mr7415094qaq.57.1392333479556;
 Thu, 13 Feb 2014 15:17:59 -0800 (PST)
Received: by 10.96.126.198 with HTTP; Thu, 13 Feb 2014 15:17:17 -0800 (PST)
In-Reply-To: <20140213091037.GA28927@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242087>

Jeff King wrote:
>   - ideas ideas ideas

I'll throw in a few ideas from half-finished work.

1. Speed up git-rebase--am.sh

Currently, git-rebase--am.sh is really slow because it dumps each
patch to a file using git-format-patch, and picks it up to apply
subsequently using git-am. Find a way to speed this up, without
sacrificing safety. You can use the continuation features of
cherry-pick, and dump to file only to persist state in the case of a
failure.

Language: Shell script, C
Difficulty: Most of the difficulty lies in "what to do", not so much
"how to do it". Might require modifying cherry-pick to do additional
work on failure.

2. Invent new conflict style

As an alternative to the diff3 conflict style, invent a conflict style
that shows the original unpatched segment along with the raw patch
text. The user can then apply the patch by hand.

Language: C
Difficulty: Since it was first written, very few people have touched
the xdiff portion of the code. Since the area is very core to git, the
series will have to go through a ton of iterations.

3. Rewrite git-branch to use git-for-each-ref

For higher flexibility in command-line options and output format, use
git for-each-ref to re-implement git-branch. The first task is to grow
features that are in branch but not fer into fer (like --column,
--merged, --contains). The second task is to refactor fer so that an
external program can call into it.

Language: C
Difficulty: fer was never written with the idea of being reusable; it
therefore persists a lot of global state, and even leaks memory in
some places. Refactoring it to be more modern is definitely a
challenge.

4. Implement @{publish}
(I just can't find the time to finish this)

@{publish} is a feature like @{upstream}, showing the state of the
publish-point in the case of triangular workflows. Implement this
while sharing code with git-push, and polish it until the prompt shows
publish-state.

Language: C, Shell script
Difficulty: Once you figure out how to share code with git-push, this
task should be relatively straightforward.
