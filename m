From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH RFC] gitk: Allow commit editing
Date: Fri, 19 Aug 2011 23:44:04 +1200
Message-ID: <4E4E4C84.4030804@gmail.com>
References: <1313610971-1741-1-git-send-email-sojka@os.inf.tu-dresden.de> <20110818223346.GA8481@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michal Sojka <sojka@os.inf.tu-dresden.de>, git@vger.kernel.org,
	paulus@samba.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 19 13:44:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuNUb-0003ic-NG
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 13:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659Ab1HSLn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 07:43:59 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:50313 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab1HSLn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 07:43:58 -0400
Received: by pzk37 with SMTP id 37so4718109pzk.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 04:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=oFjCQR0HXWXhX+r2eUva0SxbY+9u0ivdxazL1LTVsII=;
        b=og4fVFL5xxmWiNiw5IzPp+mRXf7QN6quzt4bVxLLIzwV6OnbQUFcS+pQ6jPi71FQxs
         CUCCT/zbZ17twHBla3YTi39oNKuGPx+aK9pFvbLQtQKAAce62j7xNnh7XJswOcRSwGo6
         QBNwU82OXu5/O1NpO2RAfolNLE4FknLKrTlCk=
Received: by 10.142.231.20 with SMTP id d20mr1014152wfh.125.1313754238167;
        Fri, 19 Aug 2011 04:43:58 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz [115.188.15.163])
        by mx.google.com with ESMTPS id l10sm2279868pbl.14.2011.08.19.04.43.54
        (version=SSLv3 cipher=OTHER);
        Fri, 19 Aug 2011 04:43:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.2.18) Gecko/20110616 SUSE/3.1.11 Thunderbird/3.1.11
In-Reply-To: <20110818223346.GA8481@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179691>

Hi,

On 19/08/11 10:33, Jeff King wrote:
> On Wed, Aug 17, 2011 at 09:56:11PM +0200, Michal Sojka wrote:
> 
>> Hi, this is a proof of concept patch that allows editing of commits
>> from gitk. I often review patches before pushing in gitk and if I
>> would like to have an easy way of fixing typos in commit messages etc.

I've often _thought_ that I wanted something like this. As you say
firing up gitk to review the patch you're about to send (or commit
you're about to push) is probably a fairly common workflow.

>>
>> So the patch adds "Edit this commit" item to gitk's context menu and
>> the actual editing is done by non-interactively invoking interactive
>> rebase :-) and git gui.
> 
> Invoking rebase behind the scenes makes me very nervous. In particular:
> 
>   1. There is nothing to indicate to the user that they are rewriting a
>      string of commits, which is going to wreak havoc if any of the
>      commits have been published elsewhere (either pushed somewhere, or
>      even present in another local branch). I.e., rebasing generally
>      needs to be a conscious decision of the user.
> 
>      Yes, a veteran user who thinks about it will realize there is no
>      way to edit an old commit without rebasing, but I suspect relying
>      on that is not enough. There should probably be a prominent
>      warning at least the first time somebody uses this feature.
> 
>   2. Even if you accept the hazard of rewriting commits, you don't pass
>      "-p" to rebase. So it will linearize your history. I don't know how
>      robust "-p" is these days, and if it's up to the challenge of
>      people using it to rebase potentially large segments of complex
>      history.
> 
> So I think your idea is sane, and if you use it appropriately (by
> editing commits in recent-ish linear stretches of history) your patch
> works fine. But I really worry that it is going to be a problem for less
> clueful users to stumble across in the menu.
> 
> -Peff

And as Peff points out there are some major caveats about how far back
you would want to let people edit. I suspect you could come up with some
sane rules (e.g. only allow editing the last commit, the last N commits,
only commits that are not present in remote X). Whatever rules you come
up with to protect people I think you'll end up frustrating them as well
(why can I edit this commit but not that one).

One thing I've thought about (but don't know enough TCL to begin to
implement) is a graphical rebase front end. I often use git gui to make
tweaks to the last commit (message and content) so why not extend that
to a rebase operation. I think that might address some of Peffs concerns
because the user would be invoking something specifically intended for
rebasing and accepts all the caveats that go along with that.

Anyway that's my 2c
--
Chris
