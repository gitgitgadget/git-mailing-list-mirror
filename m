Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6300207EC
	for <e@80x24.org>; Thu, 22 Sep 2016 12:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752913AbcIVM4D (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 08:56:03 -0400
Received: from sdaoden.eu ([217.144.132.164]:39320 "EHLO sdaoden.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752003AbcIVM4C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 08:56:02 -0400
Received: by sdaoden.eu (Postfix, from userid 1000)
        id E45C51604A; Thu, 22 Sep 2016 14:55:57 +0200 (CEST)
Date:   Thu, 22 Sep 2016 14:57:04 +0200
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: v2.10.0: ls-tree exit status is always 0, this differs
 from ls(1)
Message-ID: <20160922125704.Fo9_J-ezS%steffen@sdaoden.eu>
References: <20160921132655.h49HMsHbp%steffen@sdaoden.eu>
 <xmqqr38d9ova.fsf@gitster.mtv.corp.google.com>
 <20160921194004.QOizfyGm8%steffen@sdaoden.eu>
 <xmqqeg4d6l7k.fsf@gitster.mtv.corp.google.com>
 <20160921224616.GuR6adBwB%steffen@sdaoden.eu>
 <68354d78-fa7a-ee99-2e6e-7ffdcf1a568e@drmicha.warpmail.net>
In-Reply-To: <68354d78-fa7a-ee99-2e6e-7ffdcf1a568e@drmicha.warpmail.net>
Mail-Followup-To: Steffen Nurpmeso <steffen@sdaoden.eu>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Michael J Gruber <git@drmicha.warpmail.net>
User-Agent: s-nail v14.9.0-pre1-42-g7211cd5
OpenPGP: id=95F382CE;
 url=https://www.sdaoden.eu/downloads/steffen.asc
X-BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors
 in the world can make no bugs.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Michael J Gruber <git@drmicha.warpmail.net> wrote:
 |Steffen Nurpmeso venit, vidit, dixit 22.09.2016 00:46:
 |> Junio C Hamano <gitster@pobox.com> wrote:
 |>|Steffen Nurpmeso <steffen@sdaoden.eu> writes:
 ...
 |>|I think this issue does not need a separate bullet point.  The
 |>|existing text says:
 |>  ..
 |>|and what caused your surprise is already covered by the first bullet
 |>|point, if the reader knows what "patterns to match" means in Git's
 ...
 |>|How about rewriting the first bullet point like so instead:
 ...
 |>|    of the arguments does not matter, and a '<path>' argument that
 |>|    does not match any path is not an error (i.e. if there is no
 |>|    path that matches any pattern, nothing is shown in the output).
 |> 
 |> Not an error would have been an enlightenment to me.
 ...
 |> 
 |> But now i'm even getting nervous to read about patterns.
 ...
 |> We have patterns for tags/remotes/branches, author/committer/grep
 |> patterns, (most of those, maybe all today, with fixed string,
 |> extended or basic regex), the git-grep patterns ("leading paths
 |> match and glob(7) patterns are supported").  Is that all?
 |> I would assume glob-style for ls-tree:
 ...

 |Maybe "git ls-files" is the command that you are looking for, really.
 |
 |That and others have glob pathspec enabled by default, see "git help git".

Please rollback all of that, i have only reported something that
seemed odd to me.  What i really need is instead

  if `git cat-file -e ${relbr}:NEWS 2>/dev/null`; then

and that is what i will end up with.
_But_, now that i am here again, "git help cat-file" says

  -e
      Suppress all output; instead exit with zero status if <object>
      exists and is a valid object.
and
  OUTPUT
...
    If -e is specified, no output.

But this is not what happens if "output" includes stderr:

  ?0[steffen@wales ]$ git cat-file -e HEAD:NEWS                                                                                                
  ?0[steffen@wales ]$ git cat-file -e HEAD:NEWSS                                                                                                 
  fatal: Not a valid object name HEAD:NEWSS
  ?128[steffen@wales ]$ 

I would also not expect $?=128 as an counterpart to EXIT_SUCCESS=0
when performing a qualified "test" action, but EXIT_FAILURE=1 is
just an as-bad non-0 exit status code, anyway.  To me
EX_NOINPUT=66 obtrudes itself as the right status, but my own
projects don't adhere to this from a-z or not at all, so what i am
talking about?  I mean, some things take time and are eventually
and temporarily a bit odd, so what?  That is just how it is.  Even
Sparta declined some day, and then it crushed, iirc.

Thanks for git, just yesterday evening i did rebasing and cherry
picking and commit amending and garbage collection and it saved me
days of work, or, to be more exact, i never have been able to work
the way i would work before.  Really.
Ciao.

--steffen
