From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v2 00/10] reroll of ap/log-mailmap
Date: Tue, 8 Jan 2013 08:27:24 +0100
Message-ID: <CALWbr2w8z2iVx2PxM2sn3yDQzB5rTXc4EuZD9GCKSCofHzEzLQ@mail.gmail.com>
References: <1357603821-8647-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 08:27:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsTbD-0006PL-N0
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 08:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251Ab3AHH11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 02:27:27 -0500
Received: from mail-ee0-f53.google.com ([74.125.83.53]:41455 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab3AHH10 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 02:27:26 -0500
Received: by mail-ee0-f53.google.com with SMTP id e52so42772eek.12
        for <git@vger.kernel.org>; Mon, 07 Jan 2013 23:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=m0EKsS+w/VkNF0VxfgjYGzypcvrsY5ztVRn8bLxcuME=;
        b=lAB0WE9t3ZxTYDcNX8Tgix4hq7kQM8PhLa6rZiSvbYfMJMHI3L0g8NE5eF4kjpXXvz
         ol0rmjD9eSFydJAlF1yKrHtvK1Rzpam3aHYZF6bx5wlFiDiXNnMoWe/+RDjJ4R1x2wVj
         5YEbTdMpDqhD0RifmETUTFY5Gx9iITrxn6Bd2G6FllUlZVHXdPGW3EDjWqdtIzKoB34i
         BOEvTGSOyT5awgrkUHPGmI520DBATqcW1Rz0bnuX4S6c2Q/+tSRF3myYCZ1LJ3hWvzNU
         9wdk+T+qxSsKpycuYCKE7zyfsrESIowrCm9A71NOgF0b81euUqvE2lDUniV3TfefVe6b
         MPdw==
Received: by 10.14.208.137 with SMTP id q9mr171130740eeo.28.1357630045024;
 Mon, 07 Jan 2013 23:27:25 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Mon, 7 Jan 2013 23:27:24 -0800 (PST)
In-Reply-To: <1357603821-8647-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212938>

On Tue, Jan 8, 2013 at 1:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> This is a reroll of the previous series Antoine posted on Saturday.

Thanks a lot for the reroll Junio

> A new patch "string-list: allow case-insensitive string list"
> teaches the string-list API that some string lists can be sorted
> case insensitively (actually, you can feed any custom two string
> comparison functions).
>
> The string_list_lookup_extended() function introduced by the
> previous series has been discarded.  Instead, the third patch
> "mailmap: remove email copy and length limitation" introduces a
> helper function that takes a <char *, size_t> key that is not NUL
> terminated to look for a matching item in a string list, and uses
> that to update map_user() function, together with the fourth
> patch "mailmap: simplify map_user() interface".
>
> All other patches are unmodified from Antoine's series (modulo
> wording tweaks here and there).
>
> Antoine Pelisse (9):
>   Use split_ident_line to parse author and committer
>   mailmap: remove email copy and length limitation
>   mailmap: simplify map_user() interface
>   mailmap: add mailmap structure to rev_info and pp
>   pretty: use mailmap to display username and email
>   log: add --use-mailmap option
>   test: add test for --use-mailmap option
>   log: grep author/committer using mailmap
>   log: add log.mailmap configuration option
>
> Junio C Hamano (1):
>   string-list: allow case-insensitive string list

I think this one is missing (and I forgot to reroll it before):
log --use-mailmap: optimize for cases without --author/--committer search

>
>  Documentation/config.txt  |   4 +
>  Documentation/git-log.txt |   5 ++
>  builtin/blame.c           | 183 ++++++++++++++++++++++------------------------
>  builtin/log.c             |  16 +++-
>  builtin/shortlog.c        |  54 ++++----------
>  commit.h                  |   1 +
>  log-tree.c                |   1 +
>  mailmap.c                 |  94 +++++++++++++++---------
>  mailmap.h                 |   4 +-
>  pretty.c                  | 114 ++++++++++++++++-------------
>  revision.c                |  54 ++++++++++++++
>  revision.h                |   1 +
>  string-list.c             |  17 ++++-
>  string-list.h             |   4 +
>  t/t4203-mailmap.sh        |  56 ++++++++++++++
>  15 files changed, 379 insertions(+), 229 deletions(-)

Have you been able to measure a speed increase due to less copies ?

Thanks,
Antoine
