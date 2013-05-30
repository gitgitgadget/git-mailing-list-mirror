From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH v2 0/8] rebase: new cherry-pick mode
Date: Wed, 29 May 2013 21:37:52 -0500
Message-ID: <CAMP44s2QtqgfuhyvJ=aZKaFHJzvwdWPkpyWjXOfAHACwTagOow@mail.gmail.com>
References: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
	<7vehcpqsk4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 30 04:38:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhskZ-0004tq-1k
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 04:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967313Ab3E3Chz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 22:37:55 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:64389 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073Ab3E3Chy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 22:37:54 -0400
Received: by mail-lb0-f176.google.com with SMTP id x10so62979lbi.21
        for <git@vger.kernel.org>; Wed, 29 May 2013 19:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dVFdcWvzZMRcrLZ5bFO5naxnmmc/oLbc9kkkd56faw4=;
        b=KnIV6wXV7moRGmNG0kIciTsv0GdFy4YCYSELNDmW+N3L+ol/5DHBhIFr/QZqj6yFWb
         qQLXVePkbsF3p5RyzWjtOPXWdKCpda+EwfI4JFQ8va8rieTcqETqjRlt3poGvNMOMz1j
         420tttux7r4YC8eUnRMZkkkAhKxLTwM+hxraLPwfW2/rezvvnoTEHsbwKUqJNdrmNbwE
         rWyl8QDW+q0Brahaatv8UhCUJ4uVLRLwlPgmo59Z4weqzGTcCzDVDDtFFuAtQRflGfS5
         zmrrXYW0MFVbnmhStIGWp82rBeXgZRMV6+xJRa1zUCEc1CCdBw7d381ut6LHplbzwcmy
         mJQw==
X-Received: by 10.112.138.131 with SMTP id qq3mr2737466lbb.46.1369881472676;
 Wed, 29 May 2013 19:37:52 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Wed, 29 May 2013 19:37:52 -0700 (PDT)
In-Reply-To: <7vehcpqsk4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225912>

On Wed, May 29, 2013 at 6:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> We already rely on cherry-pick for the 'am' mode, but only when using the
>> --keep-empty option, and when in such mode the behavior of 'git rebase' changes
>> completely; more specifically; it's completely broken. Manually enabling
>> --keep-empty to be the default and running the test-suite shows a huge lot of
>> failures.
>>
>> After fixing the --keep-empty option by creating a new cherry-pick mode, this
>> patch series uses this new mode instead of the 'am' mode, and everything works.
>
> This may be a stupid question, but does --keep-empty only fail with
> the "am" mode?
>
> More specifically, how well does "rebase -i --keep-empty" work?
>
> If the answer is "very well", then it might make sense not to
> introduce yet another cherry-pick mode, but do exactly the same
> thing as what -p mode does, namely, to internally delegate the
> processing to "rebase -i" codepath.  After all, multi-pick mode of
> cherry-pick uses the same sequencer machinery as rebase -i uses,

No, that's not true. 'rebase -i' implements sequencing completely on
it's own, and cherry picks commits one by one, it never uses the
sequencer.c code.

Also, there's the issue of the 'git am' options, that of course only
the am mode respects. I personally wouldn't mind getting rid of them
for consistency purposes, but I know you would disagree.

But the real issue is that we would be detracting from the goal even
more; to replace script code with C code.

> so if we are already producing a correct "rebase todo" sequencer
> insn list for "rebase -i" anyway, it should be the matter of not
> launching the editor to edit the initial insn sheet to make it
> non-interactive, isn't it?

Sure, and make 'git rebase' extremely much more complicated (and
probably inefficient) in the process.

I don't mind going that way, but I want to rewrite
'git-rebase--interactive.sh' to use 'git cherry-pick' more, and maybe
'git-rebase--merge.sh' too, and the first step was to replace the
simplest mode.

-- 
Felipe Contreras
