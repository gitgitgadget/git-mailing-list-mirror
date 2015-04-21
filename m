From: Stefan Beller <sbeller@google.com>
Subject: Re: Regular Rebase Failure
Date: Tue, 21 Apr 2015 10:51:42 -0700
Message-ID: <CAGZ79kadXgsdCLH-YFQ5RhyKbRv9-qmUOQo-9QkKM2=8p17j+g@mail.gmail.com>
References: <553685E0.8010304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Adam <adamgsteel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 19:51:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkcKq-0001vj-DI
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 19:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213AbbDURvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 13:51:43 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38796 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758AbbDURvm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 13:51:42 -0400
Received: by igbhj9 with SMTP id hj9so22024518igb.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 10:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qW1ZynJ3BST+so2vS0alquBhB3ldymnSMCjMbvlH1r4=;
        b=ei3tmFx3huSIGhB6lKCGv4MfBZcwYmuc8BifdUThz2xyNLbzN7T5YxFPOQID9+/mws
         e97Q9UAWm0imgvqyoIKskXUzb1ssBjPGfpTcLoheDVJptQLkFFXjaN3g9T8XPb4VwWks
         97vaYd8GWMuzXKUwQkzGcLLeC9mHxe3hxrJby4uxp2WXEIMQXXoa89BPJ8wqm+5M61Iy
         uk/VJdu82CjgfB9bjLtKByPZeI8DJda1pdfZaYWDURLZ8tH82wVpXWPhuBh6WHyeyq+f
         qdHweAhMUTOwPH85Zk9oYcpmYtWdHG1HBR3f6wB/2Lw5g9tuXURKCY9si/CDUOJkxB7S
         0QYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=qW1ZynJ3BST+so2vS0alquBhB3ldymnSMCjMbvlH1r4=;
        b=AnD/Y6RiOIzoEN/TQX6D4IC5cK54/VPTG0ZNOR/e4pM4bVmmKlBtqOiG/hTr8ZTDL0
         tzSc0OqRGAaEeTu+FUXaXEWZY90I6r5j8iAOeRgvTkOpJ9fofsEWMkHyyAkn0wJd3Xz5
         5xj2fNg+WwmTbSOMQeYhjuCoc848rVlYep6kGdyI6QNbYnk2PlaKk16T6R7KHWUA6e9b
         sNoHwSaPYyeICQeRnKn0aKHeQuID5TWSR4xtM4AnaigEdLFIUZWj42q2Lv35psd+X+ZR
         0cT9vZ2IA82RN5zdexhaf8HWBZAhzrqOaR7LQ7+CHGO4/nue3S8CoCL8MijInfk52QyK
         OAGA==
X-Gm-Message-State: ALoCoQnEjCeIlo9SwoQhMIUiS2kqdZByRalQOs20Iwt6CRyAISrxHxguWhlm6VZPd1jgsIOOzC8f
X-Received: by 10.50.254.4 with SMTP id ae4mr5784243igd.10.1429638702189; Tue,
 21 Apr 2015 10:51:42 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Tue, 21 Apr 2015 10:51:42 -0700 (PDT)
In-Reply-To: <553685E0.8010304@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267542>

On Tue, Apr 21, 2015 at 10:16 AM, Adam <adamgsteel@gmail.com> wrote:
> About two weeks ago I started getting a regular rebase failure. I get this
> error several times a day and at least once a day I lose work to it.

Which git version are you using?

> ---
> fatal: Unable to create '/Users/asteel/path/to/repo/.git/index.lock': File
> exists.

Searching through the code base there are only 3 occurrences of
"Unable to create" matching the capitalization of the letters. (we
have many more error messages where the U is lower case)

The first occurrence is in refs.c create_symref
    if (rename(lockpath, git_HEAD) < 0) {
        error("Unable to create %s", git_HEAD);
        goto error_unlink_return;
    }

The other 2 occurrences are in the lockfile.c so any place using
lock files may trigger that error.

>
> If no other git process is currently running, this probably means a
>
> git process crashed in this repository earlier. Make sure no other git
>
> process is running and remove the file manually to continue.
>
> Could not apply 71a...
> ---
> The weird part is that the file does not exist

Not anymore when you're looking I guess, as git creates and deletes a lock file
for the index quite frequently. Also when a git command shuts down roughly
as expected (such as when calling a die(error message) as opposed to being
terminated by the operating system), then the exit handler makes sure to remove
all the lock files it held.

>
> Any ideas? Thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
