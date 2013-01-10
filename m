From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH 04/19] reset: don't allow "git reset -- $pathspec" in bare repo
Date: Thu, 10 Jan 2013 00:24:10 -0800
Message-ID: <CANiSa6gK+RqovV+NKWgV57hz-p_O085HN7WCg9qvQAD-Ynpfjw@mail.gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
	<1357719376-16406-5-git-send-email-martinvonz@gmail.com>
	<7vtxqq5f0g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 09:24:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtDRA-0003Qj-94
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 09:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215Ab3AJIYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 03:24:12 -0500
Received: from mail-ia0-f177.google.com ([209.85.210.177]:34918 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab3AJIYL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 03:24:11 -0500
Received: by mail-ia0-f177.google.com with SMTP id h8so264485iaa.8
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 00:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BTyplpYLvYGYXx5cbLU3bWAzEPB6DeoD+HP1JiEd6wE=;
        b=i1kmaEpqOdBOzFe1V43mFehMhmabYSvc8NTfNH+6HfQeO9e1pJyYB56LAl0VYnsvGO
         u+Gf3OHRPVrAbroMz5tnFjyZpotTOXmk6rRAcM8r8A+ZUdun5qawMI+EVFqQBtaBtP3y
         gXca53vKf+pRRC0P3EakE5JXfZSsLO0hrq1YTVjqR0Xu3W6riWGx0/z66aShqTAIDEHC
         5ykZaNTmI54TnP32LIqCYDkQ0/Wlp9Ox+yRdVmRiEwY65+Jih5kHyZC2vO/iwz1qYnyj
         66iY2XCv83n5flmFyk05dsWX0dYeG4Gsd5l0wo0bm93t9vYlae4F4j+FZCm+h2wPpBE5
         5Yyg==
Received: by 10.50.42.169 with SMTP id p9mr4749891igl.17.1357806250331; Thu,
 10 Jan 2013 00:24:10 -0800 (PST)
Received: by 10.64.86.68 with HTTP; Thu, 10 Jan 2013 00:24:10 -0800 (PST)
In-Reply-To: <7vtxqq5f0g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213128>

On Wed, Jan 9, 2013 at 11:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
>> ---
>>  builtin/reset.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> With the patch that does not have any explicit check for bareness
> nor new error message to scold user with, it is rather hard to tell
> what is going on, without any description on what (if anything) is
> broken at the end user level and what remedy is done about that
> breakage...

Will include the following in a re-roll.

    reset: don't allow "git reset -- $pathspec" in bare repo

    Running e.g. "git reset ." in a bare repo results in an index file
    being created from the HEAD commit. The differences compared to the
    index are then printed as usual, but since there is no worktree, it
    will appear as if all files are deleted. For example, in a bare clone
    of git.git:

      Unstaged changes after reset:
      D       .gitattributes
      D       .gitignore
      D       .mailmap
      ...

    This happens because the check for is_bare_repository() happens after
    we branch off into read_from_tree() to reset with paths. Fix by moving
    the branching point after the check.
