X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Move --pretty options into Documentation/pretty-formats.txt
Date: Sat, 18 Nov 2006 11:39:43 -0800
Message-ID: <7virhccznk.fsf@assigned-by-dhcp.cox.net>
References: <11638310552964-git-send-email-chris@syntacticsugar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 19:39:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <11638310552964-git-send-email-chris@syntacticsugar.org> (Chris
	Riddoch's message of "Fri, 17 Nov 2006 23:24:15 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31795>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlW2W-0001rC-WB for gcvg-git@gmane.org; Sat, 18 Nov
 2006 20:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756402AbWKRTjp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 14:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756403AbWKRTjp
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 14:39:45 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:28916 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1756402AbWKRTjo
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 14:39:44 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061118193944.RBOY4817.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Sat, 18
 Nov 2006 14:39:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id oKfG1V0061kojtg0000000; Sat, 18 Nov 2006
 14:39:16 -0500
To: Chris Riddoch <chris@syntacticsugar.org>
Sender: git-owner@vger.kernel.org

Chris Riddoch <chris@syntacticsugar.org> writes:

> This describes all the pretty-formats currently listed in the cmit_fmt
> enum in commit.h, and also briefly describes the presence and format
> of the 'Merge: ' line in some pretty formats.

Thanks.  Getting much warmer.

> @@ -0,0 +1,56 @@
> +--pretty[='<format>']::
> +
> +        Pretty-prints the details of a commit.  The default format is
> +        'medium'.  If the commit is a merge, and the pretty-format is
> +        not 'oneline', 'email' or 'raw', an additional line is
> +        inserted before the 'Author:' line.  This line begins with

> +        "Merge: " and the sha1s of each parent commit are printed,
> +        separated by spaces.  These sha1's are abbreviated to 8
> +        characters; use the --abbrev or --no-abbrev options to alter
> +        this behavior.

The default abbreviation depends on the command.  Porcelain-ish
commands default to abbreviate but plumbing commands tend to
show unabbreviated.

A few other things to note.

 - When --parents option is in effect, you will see the list of
   parent commits on "commit" line after the commit itself.

 - The list of parents shown on "Merge:" may be different from
   the true parents when the command's revision traversal is
   limited with paths parameters; they show simplified parents.
   This rule also applies to the parents on the "commit" line
   under --parents option.

 - The history simplification does not affect "parent" line of
   "--pretty=raw" format.  You can use this to find the
   simplified parents from "commit" line and the true parents
   from "parent" lines with --pretty=raw.

Here are some examples from git.git repository to illustrate
differences between various combinations.

    C=2a54323

    git diff-tree -s -m --pretty=$format $C
    git diff-tree -s -m --pretty=$format --abbrev $C
    git diff-tree -s -m --pretty=$format --abbrev --abbrev-commit $C

    git log --pretty=$format --parents -n 1 --abbrev-commit $C

    git log --pretty=$format --parents -n 1 $C
    git log --pretty=$format --parents -n 1 $C -- t/

