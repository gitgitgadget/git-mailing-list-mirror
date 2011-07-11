From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [GSoC update] Sequencer for inclusion
Date: Mon, 11 Jul 2011 12:17:13 -0500
Message-ID: <20110711171713.GA5963@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 19:17:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgK6s-00039s-Vd
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 19:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758056Ab1GKRRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 13:17:25 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54411 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758011Ab1GKRRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 13:17:25 -0400
Received: by iyb12 with SMTP id 12so3857772iyb.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 10:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VxN6YJoEx4CzrsrG6eIjTRtYr5my0cPn9PKwPQJ2AXo=;
        b=wFr3AsAbxNumq2uquD46UrC00QYSJg67frcBq95kqSoN+cIQP5lPu+Wybc28usvgGi
         ZGFw5Um9ChCgjAzPAihuSM/Ke+5+xaDjBmUYWpLMl7thBX5pjzgzGkXXyUKeR6C3r1vW
         h5Fmyk16EX5OY33jZUQ389wsrbVeEFy5X427Q=
Received: by 10.42.153.132 with SMTP id m4mr5211619icw.32.1310404644579;
        Mon, 11 Jul 2011 10:17:24 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.ameritech.net [69.209.70.6])
        by mx.google.com with ESMTPS id v3sm858740ibh.50.2011.07.11.10.17.21
        (version=SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 10:17:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176874>

Hi Ram!

Ramkumar Ramachandra wrote:

> I'm excited to announce the first iteration of a fresh series

The basic questions:

 - has the result of applying each patch in the new iteration been
   tested (for example by rebasing interactively with "exec make test"
   after each "pick" line)?

 - what changed since last time, for each patch?  (For the future, the
   space under the "---" is generally a good place to put that
   information.)

 - what proposed changes did not make it in, for each patch?  If any,
   did they not fit well with the design, or was it more a matter of
   "sure, that would be nice, but let's get this in first"?

[...]
> I would have liked to reuse the gitconfig parser as-is for the opts
> parsing, but it's too tangled up in config.c.  I think it's safe to
> say that the opts file format deviates only slightly from the
> gitconfig format, and I'm quite happy with the end result.

To be precise, the format used includes

	strategy-option = patience | renormalize

to represent the effect of "-Xpatience -Xrenormalize".  My only worry
about that is that the "|" can sound like "or", which would seem
strange to a user that does not necessarily develop software (so is
not thinking about bitfields).  The format used in config files puts

	strategy-option = patience
	strategy-option = renormalize

as separate lines.  

> 4. New tests and documentation.  There's really no end to this

Once each new feature has been documented and each new feature or
fixed bug has an associated test, you've reached the end of this.

Meanwhile, it's true that it's possible to improve tests and
documentation beyond that, but that would not fit well in the context
of this series anyway.

[...]
> The series is becoming large and unmanagable --
> we can fix minor issues after the merge.
[...]
>   advice: Introduce error_resolve_conflict
>   revert: Inline add_message_to_msg function
>   revert: Don't check lone argument in get_encoding
>   revert: Rename no_replay to record_origin
>   revert: Propogate errors upwards from do_pick_commit
>   revert: Eliminate global "commit" variable
>   revert: Introduce struct to keep command-line options
>   revert: Separate cmdline parsing from functional code
>   revert: Don't create invalid replay_opts in parse_args
>   sequencer: Announce sequencer state location
>   revert: Save data for continuing after conflict resolution
>   revert: Save command-line options for continuing operation
>   revert: Introduce a layer of indirection over pick_commits
>   reset: Make hard reset remove the sequencer state
>   revert: Remove sequencer state when no commits are pending
>   revert: Introduce --reset to remove sequencer state
>   revert: Introduce --continue to continue the operation

My main worry is still the commit messages.  They don't need to be
elaborate but they should explain the purpose and effect of each
patch.  Part of the reason I care is that it makes the life of future
readers using "git log -S" or "git bisect" before changing that code
much easier.  Think of them like a special kind of comments that don't
interfere with reading the code straight through.

The main reason I care is that that information makes the code itself
easier to review.

I don't know how to move forward on that.  I can explain what's
missing in each message, but I get the impression that you already
understand that and there's something else (e.g., time) preventing
them from getting fixed.  I could rewrite each commit message, but I
am likely to miss things and come up with something that sounds
vaguely plausible but doesn't accurately explain the intent.  What do
you suggest?

Jonathan
