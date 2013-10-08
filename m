From: Chris J Arges <christopherarges@gmail.com>
Subject: Re: [PATCH] blame: add color
Date: Tue, 08 Oct 2013 11:03:01 -0500
Message-ID: <52542CB5.3050005@gmail.com>
References: <1381241929-23378-1-git-send-email-christopherarges@gmail.com> <xmqqob6zn67d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 08 18:03:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTZkW-0005yK-IN
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 18:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961Ab3JHQDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 12:03:01 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:61898 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832Ab3JHQC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 12:02:59 -0400
Received: by mail-ob0-f178.google.com with SMTP id uz6so635270obc.37
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 09:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=0pCPMqiqXPGmzk4VrEJTRosumbkpcXOQjvl0hrtUckM=;
        b=Z1xpsYzQtiEK5jDITzN+UjJhXuu0dloXT74JlFvHDtHmBqHaxN6kQPoVxeb6hDuddo
         CdB4DgIqONaDYbJiwRFnl1h7edXdh2w6slFiwV+ATMksZzg7CvbteKu9oLQkS30tkywR
         KpGGvSXmEqTlrXB0/um9oQqFGe5ahjVS1V6PfCLsE76xGeCAVTAB2w+ltgeGtKv1HIbe
         aoFbcG8v+Ol3YZyu2sI12KXaymkaINnOqvLc6msxcVvfeQ9zatFTBab8jav7vyhhbs6f
         aqx38dxlJfDvFCmoMkq69YI6eKi0L72PvOx1n/PZ1ZX4wMB0NL+LltHAi06VQ8laHZNe
         CqrQ==
X-Received: by 10.60.44.240 with SMTP id h16mr1793904oem.2.1381248177976;
        Tue, 08 Oct 2013 09:02:57 -0700 (PDT)
Received: from [192.168.1.117] (cpe-66-68-155-223.austin.res.rr.com. [66.68.155.223])
        by mx.google.com with ESMTPSA id u3sm71324757oeq.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 08 Oct 2013 09:02:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <xmqqob6zn67d.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235781>

On 10/08/2013 10:16 AM, Junio C Hamano wrote:
> Chris J Arges <christopherarges@gmail.com> writes:
> 
>> Add colorized text for git blame when color.interactive is enabled.
> 
> It does not make any sense to tie this to color.interactive at all,
> at least to me.  The "check color.blame and if absent fall back to
> color.ui", which is the usual pattern, would be more appropriate.
> 
Ok, I wasn't entirely sure of convention, but I could modify it to do this.

>> +static char blame_colors[][COLOR_MAXLEN] = {
>> +	GIT_COLOR_RESET,
>> +	GIT_COLOR_NORMAL,	/* PLAIN */
>> +	GIT_COLOR_YELLOW,	/* COMMIT */
>> +	GIT_COLOR_BOLD,		/* NAME */
>> +	GIT_COLOR_CYAN,		/* LINE */
>> +	GIT_COLOR_GREEN,	/* TIME */
>> +};
> 
> Unlike "git grep", where some pieces of a single line are more
> interesting (i.e. the exact text matching the pattern given) than
> others (i.e. other text on the same line), and "git diff", where
> some lines have different meanings from others (i.e. hunk header,
> deleted lines, added lines, context lines), the output from "git
> blame" is already columnar and it is obvious to the reader of the
> output that everything on the leftmost part of all lines is commit
> object name, without distraction of extra colours; I do not see much
> point in painting the output into vertical stripes of colours.
> 
I mainly did this because it makes it easier for me to see where the
different columns start and stop.

> It may make more sense to assign one colour to each blame origin
> (i.e. <commit, path> pair), to make it clear that first five lines
> came from the same origin that is different from the two lines that
> follow, etc., showing horizontal stripes of colours. If we were to
> go that route, I suspect that it would be too distracting to paint
> the whole line (like "git diff" does for added or deleted
> lines). Perhaps paint only the commit object name part in different
> colors to show which lines form a group that came from the same
> origin?  The way "git show-branch" paints its output might give an
> inspiration.
> 
This could provide a more useful colorization; in addition if something
as simple as the line number was colorized it would provide a easy way
for me to see where the code column starts.

--chris j arges
