From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Mostly Evil
Date: Sun, 04 May 2014 16:13:10 -0500
Message-ID: <5366ad66b9a6c_18f9e4b308b8@nysa.notmuch>
References: <5363BB9F.40102@xiplink.com>
 <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
 <5364A143.1060404@bbn.com>
 <5364b62d5fb7b_ac68dd30816@nysa.notmuch>
 <5365691C.1010208@bbn.com>
 <5365af33825c3_520db2b308bf@nysa.notmuch>
 <5365F10C.6020604@bbn.com>
 <536613bd14e24_1c89b0930cac@nysa.notmuch>
 <53669051.6090204@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Sun May 04 23:23:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wh3t6-0007FU-2s
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 23:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbaEDVXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 17:23:52 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:33469 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbaEDVXv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 17:23:51 -0400
Received: by mail-ob0-f170.google.com with SMTP id uy5so1831568obc.15
        for <git@vger.kernel.org>; Sun, 04 May 2014 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=10kIH8GFLD2+vFeRNYWGyfclMxGY7d5bhiiIaS115SM=;
        b=IrPdfvMSV/0m4fQlWwau1+P+n1Ddai8EzqtnQt/SYpxq6M8NP69uEiEUM7KJy8rpld
         8RxiMkBGPGSVZAurlXZNPpk4uTVMHP4tdySMc4RyCWzRUwc657hbYSFxdpDjccCBdQXQ
         xK7Iav9EXNEOCLjo3SrTHLAp8W3ZL7PtDcDZLwNbfQ+Ekome2xJDPa7xvdayJ8VgHeNq
         auRfcZwt+xN3UyoxGWY7wzr0NGA+AQm81RMCJTuQ/+hlzNnxm3Ljr2dzlVjXyb+XGxgq
         WadshuVMh7SBx0+dFztEpNhVC+797Ec4VztN1sNZM7W5zm8iwVYZ71y7ShV3ClBT6HaA
         h/SQ==
X-Received: by 10.60.135.106 with SMTP id pr10mr29406978oeb.15.1399238631425;
        Sun, 04 May 2014 14:23:51 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id sm4sm14383511obc.3.2014.05.04.14.23.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 May 2014 14:23:49 -0700 (PDT)
In-Reply-To: <53669051.6090204@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248114>

Richard Hansen wrote:
> On 2014-05-04 06:17, Felipe Contreras wrote:
> > Richard Hansen wrote:
> >> On 2014-05-03 23:08, Felipe Contreras wrote:
> >>> It is the only solution that has been proposed.
> >>
> >> It's not the only proposal -- I proposed a few alternatives in my
> >> earlier email (though not in the form of code), and others have too.  In
> >> particular:
> >>
> >>   * create a new 'git integrate' command/alias that behaves like 'git
> >>     pull --no-ff'
> > 
> > Yeah but that's for a different issue altogheter. I doesn't solve the
> > problems in 1. nor 2. nor 3.
> 
> 'git integrate' would handle usage cases #2 (update a published branch
> to its "parent" branch) and #3 (integrate a completed task into the main
> line of development),

But these cases are completely different. One should reverse the
parents, the other one not.

I feel if a new command is to be added, it should be the one that is
introducing the brand new behavior: switching the parents. So it would
be appropriate for 1. and 2.

> >>   * change 'git pull' and 'git pull $remote [$refspec]' to do --ff-only
> >>     by default
> >>
> >> Another option that I just thought of:  Instead of your proposed
> >> pull.mode and branch.<name>.pullmode, add the following two sets of configs:
> >>
> >>   * pull.updateMode, branch.<name>.pullUpdateMode:
> >>
> >>     The default mode to use when running 'git pull' without naming a
> >>     remote repository or when the named remote branch is @{u}.  Valid
> >>     options: ff-only (default), merge-ff, merge-ff-there, merge-no-ff,
> >>     merge-no-ff-there, rebase, rebase-here, rebase-here-then-merge-no-ff
> > 
> > Those are way too many options to be able to sensibly explain them.
> 
> Certainly this is too many options for a first patch series, but I don't
> think they're unexplainable.  (I listed a bunch of options because I was
> trying to envision where this might take us in the long run.)

Actually I think they are too many for any point in time.

Maybe pull.updateArgs would make more sense.

> For the first patch series, I'd expect:  merge (which uses the merge.ff
> option to determine whether to ff, ff-only, or no-ff), rebase, and ff-only.

Seems sensible.

> > then it might make sense to have these two options.
> > 
> > However, that doesn't change the proposal you described above (1. 2.
> > 3.).
> 
> Not sure what you mean.  I oulined three usage cases:
>   #1 update local branch to @{u}
>   #2 update a published branch to its "parent" branch
>   #3 integrate a completed task into the main line of development
> 
> Having these two sets of options (updateMode and integrateMode) would
> make it possible to configure plain 'git pull' to handle usage case #1
> and 'git pull $remote [$refspec]' to handle usage cases #2 and #3.

Not if by default they are already handled.

> > There's something we can do, and let me clarify my proposal. What you
> > described above is what I think should happen eventually, however, we
> > can start by doing something like what my patch series is doing; issue a
> > warning that the merge is not fast-forward and things might change in
> > the future.
> 
> OK, let me rephrase to make sure I understand:
> 
>   1. leave the default behavior as-is for now (merge with local
>      branch the first parent)
>   2. add --merge argument
>   3. add ff-only setting
>   4. plan to eventually change the plain 'git pull' default to ff-only,
>      but don't change the default yet
>   5. add a warning if the plain 'git pull' is a non-ff
>   6. wait and see how users react.  If they're OK with it, switch the
>      default of the plain 'git pull' to ff-only.
> 
> Is that accurate?  If so, sounds OK to me.

That is what my patch series is doing already, basically.

The new warning I'm proposing would be for the split behavior of 'git
merge' and 'git merge $there'. Which is what is worrysome.

> mode = rebase-here-then-merge-no-ff would do what I described

I think that mode is way too specific to be useful for most people.

-- 
Felipe Contreras
