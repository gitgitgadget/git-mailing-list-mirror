From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: About global --progress option
Date: Thu, 5 Nov 2015 00:47:22 -0600
Message-ID: <CAOc6etbuK7=-8kH60taO8uH+6XNGTFRNGmmkswgP-19bCRNB3Q@mail.gmail.com>
References: <CAOc6etYiGV0v4gkkpudi3ACa6kA3H8CnqYYeSksfO4mGGfEyXg@mail.gmail.com>
	<xmqqk2px7z7h.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 07:48:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuELx-0003OY-9S
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 07:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1034463AbbKEGrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 01:47:31 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33269 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1034430AbbKEGrW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 01:47:22 -0500
Received: by pabfh17 with SMTP id fh17so78254882pab.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 22:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=w2rzR6pHlolRv0EDYuOMfG0pRwYh64zPS/zqJPbw+Go=;
        b=q9uEBIMi5zJocVW77Blesy6H0CQkZXcccjI9cotWi6TuRXXDOKEQ1xF3/v60TTAjBB
         9Z9uSjeMOK94PrlBCB7BO3J4XwFszlRxTNtVdD897stP8S75n7iDVCiPpsFBq1AwYQEe
         ztcphj+yn4MW7QTb3Nfv1YdE65u6hlj57G1JVwNTfI2AHFDczE9fg7dzIcKGby6t0I9y
         u2Uns/p8s7pn8COmVraM5946KEMp7oTrhr2Wl3/w0S4xK5ZIv4liuMhjzJyPSj8gt0Ul
         Zoh7oNkIOdqMECL9qrNbWBJ3Qb/l02Pwoc0lGVLQ5EryAohU9e5PbhoztI9vdVSNDKr8
         ureA==
X-Received: by 10.68.201.97 with SMTP id jz1mr7469037pbc.28.1446706042130;
 Wed, 04 Nov 2015 22:47:22 -0800 (PST)
Received: by 10.66.97.70 with HTTP; Wed, 4 Nov 2015 22:47:22 -0800 (PST)
In-Reply-To: <xmqqk2px7z7h.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280907>

On Thu, Nov 5, 2015 at 12:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Besides, I am not convinced that you are bringing in a net positive
> value by allowing "git --no-progress clone".  You would need to
> think what to do when you get two conflicting options (e.g. should
> "git --no-progress clone --progress" give progress?  Why?), you
> would need to explain to the users why the resulting code works the
> way you made it work (most likely, "do nothing special") when the
> global one is given to a command that does not give any progress
> output, and you would need to make sure whatever answers you would
> give to these questions are implemented consistently.  And you would
> need more code to do so.  It is unclear to me what value the end
> users get out of all that effort, if any, and if the value offered
> to the end users outweigh the added complexity, additional code that
> has to be maintained, and additional risk to introduce unnecessary
> bugs.

The contradictory case of git --progress whatever --no-progress (or
viceversa) was going to be my follow-up question. Dude, don't get too
far ahead in the conversation :-)

On the technical side, I think the global --progress option (and
removing the option from the builtins) would not add complexity but
the opposite because setting the flag would be done at the "main git"
level and then all the builtins would just forget about it and would
use progress regardless (cause deciding _if_ progress should be shown
or not won't be up to them anymore) so the code from the builtins to
support the option would be gone. It would certainly be more complex
while keeping global and builtin options alive. Anyway, I do
understand your concerns and will stand down on the topic (as in....
global --progress who???).

> A lot more useful thing to do in the same area with a lot smaller
> amount of effort would be to find an operation that sometimes take a
> long time to perform that does not show the progress report and
> teach the codepath involved in the operation to show progress, I
> would think.

Sounds interesting and in-topic (different direction). You got a list
of those paths that I could work on? At least a couple you can think
off the top of your head? Cause I can't complain about the progress I
get on the workflows I follow (although I could keep a closer look to
try to catch some operation I know is taking place and is not showing
any progress and I'm used to it and so I don't complain at the lack of
progress). Right now I'm thinking about cherry-picking... sometimes it
can take a few seconds (or more seconds.... you have to see the
performance of some of the boxes that I work on) and getting some
progress there would be nice. Will take a look at it. Nice way to get
familiarized with the code, by the way.

Thank you very much, Junio!
