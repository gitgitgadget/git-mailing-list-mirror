From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/3] interactive git clean
Date: Mon, 6 May 2013 05:40:06 -0400
Message-ID: <CAPig+cTSER2ngpGoM-3pwPO3dAnqq+9qCHdVb1YbLg9UgkPF0g@mail.gmail.com>
References: <cover.1367551846.git.worldhello.net@gmail.com>
	<CAPig+cQALgr_VXwG5jBiFVTM627se8zQz7vsmF=A9OLcp_GT9A@mail.gmail.com>
	<CANYiYbG5q7g-Gn-EGtsgS4XYLbQJuY6Pr_6FgKknADTD5_KoTg@mail.gmail.com>
	<CAPig+cR--LQSkxc27_tMRrEnFJFApymqK9268BQA0bab38W3OQ@mail.gmail.com>
	<vpqli7s8rqp.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 06 11:40:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZHu4-0002n1-EU
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 11:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248Ab3EFJkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 05:40:10 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:60041 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700Ab3EFJkI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 05:40:08 -0400
Received: by mail-la0-f54.google.com with SMTP id fd20so3148722lab.13
        for <git@vger.kernel.org>; Mon, 06 May 2013 02:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=ROG4Ixd/OMcDohvN6GWktZNKslsHhYZ69chI2UPHDvQ=;
        b=AGpCpGmItLFpZdNn5Yl07+iU/Y8bDlm32WG7LxfkSiKndlG2t+vBtYpGRDzlzunk1R
         xpCFA+lv+4ZXHF/qqPed62tDdVxyC2HsmDsZ91wKeJXYmt0FrAVcgm+V/9pvzZWiRdnw
         4cAsMrPuxgm56PTB+SbtlewCNPZKcYtch8Us3SUjhMQb7yGjCjfAGATk5GJCRIxpzGFH
         IwxOKxTwCs/6Idu8j0IyDv24agoH+1F6KU0Pbw76fsztLzUJt/moMzP7klKd93XKiV9A
         LKZnGIx+8SYzm4GggiqFu9wmrxDEwKz/1E91grUXGVNRwaZ+epY7qtFhMb/Ifjkn9o0+
         5AUQ==
X-Received: by 10.112.159.1 with SMTP id wy1mr7628234lbb.80.1367833207011;
 Mon, 06 May 2013 02:40:07 -0700 (PDT)
Received: by 10.114.182.172 with HTTP; Mon, 6 May 2013 02:40:06 -0700 (PDT)
In-Reply-To: <vpqli7s8rqp.fsf@grenoble-inp.fr>
X-Google-Sender-Auth: h6sJkjbaE8oa8rKbcjqIArv8pEA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223431>

Hi Matthieu,

On Mon, May 6, 2013 at 3:58 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> The pattern [y] will match file named 'y'. It probably is unusual for
>> files named 'y', 'n', etc. to exist in the top-level directory, but
>> the gitignore patterns already provide an escape hatch for these
>> unusual cases.
>
> But how does the user know that?

Documentation. Junio also mentioned having a '?' in each prompt
explaining the options at that point.

> I'd rather stay away from dwim that works in 99% of cases but do
> something dangerous in the 1% remaining, and complex un-guessable escape
> scheme to solve these few cases. The two stages (yes/no/edit, and then
> escape patterns) is clear, and does not require so many additional
> keystrokes.

The scheme doesn't have to be unsafe. git-clean *knows* which files
are up for deletion. If one of those filenames conflicts with one of
the prompt options, --interactive mode can warn about the ambiguity at
the point the user types that particular ambiguous response, and ask
for clarification ("did you mean 'yes, delete everything' or 'exclude
filename y'?"). You get DWIM for 99.9% of the cases, and an extra
prompt for the other 0.1%. Nothing unsafe. Is such an implementation
more complicated or ugly than the separate 'edit' mode? Is the user
experience better or worse (more or less convenient)? Is it easier or
harder to document and explain?

Another observation which came to mind after my original email:

Would it make sense for --interactive mode to launch an editor with
the list of files scheduled for deletion and allow the user to remove
lines he does not want deleted (similar to "git-rebase
--interactive"). Depending upon case, this could be more or less
convenient than the proposed gitignore-patterned 'edit' mode. It could
be yet another option in the yes/no/prompt/edit menu or it could be
the default and only behavior of "git-clean --interactive" (again
similar to "git-rebase --interactive).

I'm not advocating any particular user interface. The observations and
questions about convenience and user experience both here and in my
original email were made with the hope of promoting discussion before
the interface gets locked in. How clunky or fluid should it be? How
verbose or terse?

-- ES
