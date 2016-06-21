Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 279DE1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 14:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbcFUONM (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 10:13:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:63472 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbcFUOMu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 10:12:50 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LlESk-1bqLea2Msg-00b3ia; Tue, 21 Jun 2016 16:12:14
 +0200
Date:	Tue, 21 Jun 2016 16:12:12 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Paul Tan <pyokagan@gmail.com>
cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/9] Let log-tree and friends respect diffopt's `file`
 field
In-Reply-To: <CACRoPnRvp7oguE2w2mcsEZfaX_fni8UhFCdsGQ3ZaijQprSHog@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1606211555380.22630@virtualbox>
References: <cover.1466420060.git.johannes.schindelin@gmx.de> <cover.1466505222.git.johannes.schindelin@gmx.de> <CACRoPnRvp7oguE2w2mcsEZfaX_fni8UhFCdsGQ3ZaijQprSHog@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lkQcBhzpKbsLFfD151SI2x0Y4qoWk6GXberWdAUcknykpZ6rqav
 d9UbwnUrnmC6AvXK+fBTW+ysClWZ6je1ffNQis3pLbfETl/nncW0vbPfFEGtY/vSLqWlXhY
 SyQweUOKntzvBBg88+wGm4etaCC7gBstuLoTDrtDuR/FsjQkj1w8qmA+OLQbBb9ad2YTEmJ
 0UI62s7bfu11xLGR5muaQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:mw+sCbn25UE=:ArPFdZTcxa3DnTncXdK+BV
 r43MwFU3S8X77mcv/GHWL9/nLgplz71uPC2fMpXHPymmrOGwRtBUpwuIR27ADDefUlRJeGhVn
 7M92KdAgouE0cUENnpASX/DDQeRTjwyVTZfhGRJYeoC/nsNXzg5yppUoTf7fPkmbwAA1Lkgfs
 dA5gvne9ewd9BBegFN38YzdRY25khQFZo9PpioedoGR5SHajwcMOPTRptVL0Pqu7+iAyp7hyd
 dQpROQ76dM66ObB94Vfkec/Iu2dQwTwbXL1uxmH+IRElD6HxOBZBv5zodQJ5u8Jt42BdW7s1I
 nI7Q33wWC6yLOQFftrNFS46Pj5HhNId7Ugr1pOBbOi1WcU8KMSV18ZC1XvaiwgYvl2sYGHemh
 gPbVcfFgXnOy1bL7uvewry+z3fGjmIveH7pzuPbAwdzHbBp//treQIj2/nLEQMp27bKnhlUCa
 tt/6couXTFjdzBI8kfFeXRzlyjrqb2LS0F4KLPSOpy0o7LBIohIswfuVQoTywqzN9mAUZJl7c
 aCs1NnE7SC5JR2T7y5y/njf8LjeBXbSLbrluXc6m0yj4gi+2NTfzKmC0IcN5dnCW2woYQFk3z
 2CUcCJOHWb2dm4lSf6FPLb9EBxgrjtWhKF/rg1bTP55T8mP+vln/JO/qPr5nOyzqU81kwBb5j
 Xv6LGhLqAFyGdyu33poISB5hBULDJIR7X2QqmzlniB/ym/CDZsjVM1O9KY1a0SR/p9L8gE035
 uxP/nQpopN71HOycMH3G9gM8dEZ0w8eA5wlDFZGkS/JAfWixEJlfbsDnc6U+YaHR2sPjnNxmO
 WAqbgTg
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Paul,

On Tue, 21 Jun 2016, Paul Tan wrote:

> On Tue, Jun 21, 2016 at 6:34 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > - this uncovered a problem with builtin am, where it asked the diff
> >   machinery to close the file stream, but actually called the log_tree
> >   machinery (which might mean that this patch series inadvertently fixes
> >   a bug where `git am --rebasing` would write the commit message to
> >   stdout instead of the `patch` file when erroring out)
> 
> Please correct me if I'm wrong: looking at log-tree.c, the commit
> message will not be printed when no_commit_id = 1, isn't it?
> This is because we do not hit the code paths that write to stdout since
> show_log() is not called.

Why does builtin/am.c use log_tree_commit(), then? Why not simply run
things through the diff machinery?

> Also, the return value of log_tree_commit() is actually a boolean
> value, not an error status value, isn't it?

It is not really a boolean, no. Sure, at the moment, it happens to return
either 0 or 1. You can figure that out by following the call paths all the
way to do_diff_combined() or line_log_print().

The key words are: at the moment.

We do find more and more places where library functions call die() in case
of errors, and it hurts us. Badly. That is why I, among others, try to
remedy the situation by converting these calls to "return error()"
statements.

The log_tree functions are prepared for that: they return non-negative
values in case of success.

The callers are not really prepared for that, hence my complaints.

> > This last point is a bigger issue, actually. There seem to be quite a
> > few function calls in builtin/am.c whose return values that might
> > indicate errors are flatly ignored. I see two calls to run_diff_index()
> > whose return value then goes poof unchecked,
> 
> Thanks, future-proofing the builtin/am.c code is good, in case
> run_diff_index() is updated to not call exit(128) on error in the
> future.

And run_diff_cache(). And read_ref_at(). And rerere(). And
setup_revisions(). And get_sha1().

> > and several calls to write_state_text() and write_state_bool() with
> > the same issue.
> 
> These functions will die() on error

Indeed. And I do not think that is a good practice.

> > And I did not even try to review the code to that end, all I wanted
> > was to verify that builtin am only has the close_file issue once (it
> > does use it a second time, but that one is okay because it then calls
> > run_diff_index(), i.e. the diff machinery).
> >
> > I am embarrassed to admit that these builtin am problems demonstrate
> > that I, as a mentor of the builtin am project, failed to help make the
> > patches as good as I expected myself to do.
> 
> Sorry to disappoint you :-(

You misunderstood. I am not disappointed in you. *I* did a lousy job. Not
only mentoring, but I also obviously failed to make things fun enough for
you.

My apologies,
Dscho
