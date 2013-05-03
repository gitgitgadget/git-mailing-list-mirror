From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/3] interactive git clean
Date: Fri, 3 May 2013 06:37:34 -0400
Message-ID: <CAPig+cQALgr_VXwG5jBiFVTM627se8zQz7vsmF=A9OLcp_GT9A@mail.gmail.com>
References: <cover.1367551846.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 03 12:37:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYDNA-0000O2-1O
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 12:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762986Ab3ECKhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 06:37:38 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:65508 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762544Ab3ECKhg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 06:37:36 -0400
Received: by mail-lb0-f179.google.com with SMTP id d10so1409180lbj.38
        for <git@vger.kernel.org>; Fri, 03 May 2013 03:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=zHuc9VkC1MD+9pRWgan19rE208siuM4eMqSRUlOSdsU=;
        b=HBx3QX8MrKEVUqTgNnXt0StsFNMxZC13h6ClqjAQwUhivRdoMJZefGeS00AgZyhm2u
         4xLWJihNKJp9GyM2ea3Yr2sqdZEmY8yMD6TLBJT3tJfEWulaWzXp/FMPSBtwxBy9Cv0w
         CNNZ685CMSYN+IP2kLfNJOo5QkVZKZXrgGa4dnuKKV+mkcG+m3elDBzS9LJAMbkqOnnB
         Jvjy1/c05Q7fqTZ766vLH+cnY2DyxS34B/Nizp9x7pDPcbb1riX0+Cvuc6Pw0phOf1kb
         X/BZRMWSmZRq9qsqdtQuw3Do1bQfB0s/0xcyslNOFwMuODawuCIG03losZapgL+3JW6N
         MvhA==
X-Received: by 10.152.5.37 with SMTP id p5mr4005970lap.13.1367577454231; Fri,
 03 May 2013 03:37:34 -0700 (PDT)
Received: by 10.114.186.233 with HTTP; Fri, 3 May 2013 03:37:34 -0700 (PDT)
In-Reply-To: <cover.1367551846.git.worldhello.net@gmail.com>
X-Google-Sender-Auth: AWtAGryqdhW0EK-CCS1KUi9cT9Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223303>

Usability observations below...

On Thu, May 2, 2013 at 11:49 PM, Jiang Xin <worldhello.net@gmail.com> wrote:
> The interactive git clean combines `git clean -n` and `git clean -f`
> together to do safe cleaning, and has more features.
>
> First it displays what would be removed in columns (so that you can
> see them all in one screen). The user must confirm before actually
> cleaning.
>
>     WARNING: The following items will be removed permanently. Press "y"
>     WARNING: to start cleaning, and press "n" to abort the cleaning.
>     WARNING: You can also enter the "edit" mode, and select items
>     WARNING: to be excluded from the cleaning.

The user intended for files to be removed when invoking git-clean,
therefore WARNING that git-clean will do what was requested explicitly
seems overkill. Along the same lines, the user asked explicitly for an
interactive session (via --interactive), hence the above paragraph is
effectively redundant since it does little more than tell the user (in
a lengthy fashion) what he already knows (that the session is
interactive). The short prompt printed after the listed files says the
same thing (more succinctly), thus this warning paragraph is
essentially superfluous.

>       What would be removed...    What would be removed...
>       What would be removed...    What would be removed...
>
>     Remove (yes/no/Edit) ?

For convenience, implementations traditionally allow single letter
responses (y/n/e), but this one does not. Should it?

> In this confirmation dialog, the user has three choices:
>
>  * Yes: Start to do cleaning.
>  * No:  Nothing will be deleted.
>  * Edit (default for the first time): Enter the edit mode.

What about the user who desires more traditional "rm -i" behavior in
which he is prompted for each file? Should that be supported with a
"Prompt [each]" option in the above menu?

> When the user chooses the edit mode, it would look like this:
>
>     NOTE: Will remove the following items. You can input space-seperated
>     NOTE: patterns (just like .gitignore) to exclude items from deletion,
>     NOTE: or press ENTER to continue.

As earlier, this (lengthy) paragraph says little more than what could
be said in a more succinct prompt printed after the file list, thus is
probably superfluous.

>       What would be removed...    What would be removed...
>       What would be removed...    What would be removed...
>
>     Input ignore patterns>

The list of files to be removed was already shown directly above.
Dumping the entire list to the user's screen a second time upon
entering edit mode seems unnecessary. If you drop the WARNING and NOTE
paragraphs as suggested, then the session becomes much less verbose,
thus there is little reason to re-display the file list upon entering
edit mode. For instance:

  % git clean -i
  file1 file2 file3
  file4 file5 file6
  Remove (yes/no/edit)? e
  Exclude (space-separated gitignore patterns): file[4-6]
  file1 file2 file3
  Exclude (space-separated gitignore patterns): [enter]
  Remove (yes/no/edit)?

> The user can input space-separated patterns (the same syntax as gitignore),
> and each clean candidate that matches with one of the patterns will be
> excluded from cleaning.
>
> When the user feels it's OK, presses ENTER and back to the confirmation dialog.
>
>     WARNING: The following items will be removed permanently. Press "y"
>     WARNING: to start cleaning, and press "n" to abort the cleaning.
>     WARNING: You can also enter the "edit" mode, and select items
>     WARNING: to be excluded from the cleaning.
>
>       What would be removed...
>
>     Remove (Yes/no/edit) ?
>
> This time the default choice of the confirmation dialog is "YES".
> So when user press ENTER, start cleaning.

Is there precedent for this sort of self-mutating default action in
other utilities? Wouldn't this lead to high "surprise factor" for
users and potential for lost files? For instance:

  % git clean -i
  file1 file2 file3
  file4 file5 file6
  Remove (yes/no/Edit)? [enter]
    {user presses ENTER for edit mode}
  Exclude (space-separated gitignore patterns): file[3-6]
    {user mistakenly types "3" rather than "4"}
  file1 file2
  Exclude (space-separated gitignore patterns): [enter]
  Remove (Yes/no/edit)? [enter]
    {user notices mistake and presses ENTER expecting edit mode}
  Removing file3
  Removing file4
  Removing file5
  Removing file6

Oh no! The user didn't notice the subtle change of default from
"yes/no/Edit" to "Yes/no/edit",  thus he pressed ENTER thinking it
would take him to edit mode as it did initially, but instead git-clean
proceeded with the removals and file3 is lost.

Other considerations:

Is it necessary to force the user to escape from edit mode by pressing
ENTER (i.e. empty input)? Wouldn't you achieve the same level of
functionality by exiting back to the (yes/no/edit) prompt
automatically after the user enters his gitignore pattern(s)? For
instance:

  % git clean -i
  file1 file2 file3
  file4 file5 file6
  Remove (yes/no/edit)? e
  Exclude (space-separated gitignore patterns): file[4-6]
  file1 file2 file3
  Remove (yes/no/edit)?

More generally, is this sort of modal edit mode desirable and
convenient? Can the edit operation be combined with the top-level
prompt? For example:

  % git clean -i
  file1 file2 file3
  file4 file5 file6
  Remove ([y]es, [n]o, [p]rompt, exclusion-list)? file[4-6]
  file1 file2 file3
  Remove ([y]es, [n]o, [p]rompt, exclusion-list)? p
  file1 (y/n/q/!)? y
  file2 (y/n/q/!)? n
  file3 (y/n/q/!)? y

-- ES
