From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 8/9 v13] difftool: teach difftool to handle directory diffs
Date: Sun, 15 Apr 2012 15:20:22 -0700
Message-ID: <CAJDDKr7Uw3Nwg4p7F2zaY8f82j3_tRf3WiiO+YSN+nA6a9wY6w@mail.gmail.com>
References: <1334335002-30806-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, ramsay@ramsay1.demon.co.uk
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 00:21:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJXob-0005LD-Ap
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 00:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059Ab2DOWUY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Apr 2012 18:20:24 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63530 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab2DOWUX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Apr 2012 18:20:23 -0400
Received: by gghe5 with SMTP id e5so2224567ggh.19
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 15:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=zfAJn1KXkIIQj79osqnvTBfKHMMScxcz6ZGFO8rP9rs=;
        b=pqS84RsWFdO1VzmvnntrS7tTQOzEE88hDReuumddAvln8jvhdqARS6Iy6k2DVblCGU
         hqdWFh+LvsNiGJGU42HYEcu5MdrwaZ2wnIwdeGRYtsC+WmJOqzZZ8gWLh7KuuZ8PyqGU
         8VvYRQvzZgMLXIpYCCObno9ce1IxD5QHbnmO/XslL57A/D7qjO8e7mMrp0KP/F5qBCIq
         dXHFZK2RM7oNcYVziL7Q3szrvK3NOapf8zG+mNDhVqfHqqAR0gnnFNpqmNAY57sLE2ES
         lRvlhzaU0GnEbzGnbCpQhqaZq1kmogX7Y0uKsap+6LBfwApJl2aQ2n4rzAga7DeCl47y
         wsAg==
Received: by 10.101.179.7 with SMTP id g7mr2476721anp.69.1334528422382; Sun,
 15 Apr 2012 15:20:22 -0700 (PDT)
Received: by 10.147.128.8 with HTTP; Sun, 15 Apr 2012 15:20:22 -0700 (PDT)
In-Reply-To: <1334335002-30806-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195594>

On Fri, Apr 13, 2012 at 9:36 AM, Tim Henigan <tim.henigan@gmail.com> wr=
ote:
> When 'difftool' is called to compare a range of commits that modify
> more than one file, it opens a separate instance of the diff tool for
> each file that changed.
>
> The new '--dir-diff' option copies all the modified files to a tempor=
ary
> location and runs a directory diff on them in a single instance of th=
e
> diff tool.
>
> Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
> ---
>
> This replaces v12 of the script that was sent to the list on April 12=
, 2011.
>
> Changes in v13:
>
> The 'git diff' command is now called via 'Git->repository->command_on=
eline'
> again. We need to run the command in a way that allows @ARGV to be gi=
ven
> as a list, rather than a string, to insure that IFS and shell meta-
> characters are handled properly. =C2=A0Thanks to Junio Hamano for poi=
nting
> this out [1].
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/195326/fo=
cus=3D195353

Thanks Tim.  Sorry for reading this patch out of context and missing
the obvious point that it needs the diff output to do something useful
in my last review.

I started testing this patch.  I started on the commit before what's
in pu and then applied this patch:

$ git checkout e9653615fafcbac6109da99fac4fa66b0b432048
$ git am difftool.patch

The basics work and I know folks will be really happy when this
feature lands.  Folks have personally asked me for this feature in the
past.  I dig it.  I'd also like to help pursue using symlinks sometime
in the future if that sounds like a reasonable thing to you, but the
stabilizing the existing implementation is more important right now.

I ran into some issues when trying it against a few random commits.  I
went pretty far back in git's history to see what would happen.

$ git difftool --dir-diff e5b06629de847663aaf0f7daae8de81338da3901 | ta=
il
Use of uninitialized value $rmode in string eq at
/home/david/src/git/git-difftool line 96.
Use of uninitialized value $lsha1 in concatenation (.) or string at
/home/david/src/git/git-difftool line 107.
Use of uninitialized value $rmode in string ne at
/home/david/src/git/git-difftool line 110.
Use of uninitialized value $rsha1 in string ne at
/home/david/src/git/git-difftool line 111.
Use of uninitialized value $rmode in concatenation (.) or string at
/home/david/src/git/git-difftool line 112.
Use of uninitialized value $rsha1 in concatenation (.) or string at
/home/david/src/git/git-difftool line 112.
Use of uninitialized value $rmode in string eq at
/home/david/src/git/git-difftool line 96.
Use of uninitialized value $lsha1 in concatenation (.) or string at
/home/david/src/git/git-difftool line 107.
Use of uninitialized value $rmode in string ne at
/home/david/src/git/git-difftool line 110.
Use of uninitialized value $rsha1 in string ne at
/home/david/src/git/git-difftool line 111.
Use of uninitialized value $rmode in concatenation (.) or string at
/home/david/src/git/git-difftool line 112.
Use of uninitialized value $rsha1 in concatenation (.) or string at
/home/david/src/git/git-difftool line 112.
Use of uninitialized value $rmode in string eq at
/home/david/src/git/git-difftool line 96.
Use of uninitialized value $lsha1 in concatenation (.) or string at
/home/david/src/git/git-difftool line 107.
Use of uninitialized value $rmode in string ne at
/home/david/src/git/git-difftool line 110.
Use of uninitialized value $rsha1 in string ne at
/home/david/src/git/git-difftool line 111.
Use of uninitialized value $rmode in concatenation (.) or string at
/home/david/src/git/git-difftool line 112.
Use of uninitialized value $rsha1 in concatenation (.) or string at
/home/david/src/git/git-difftool line 112.
fatal: malformed index info /t9800-git-p4-basic.sh 	:100755 100755
a25f18d36a196a4b85f6cac15a6a081744fe8fa1
d41470541650590355bf0de1a1b556b3502492b5 M
update-index -z --index-info: command returned error: 128


This one works fine but the difftool I used for testing (xxdiff)
complained about a missing file:
$ git difftool -d 86e15ff4fe9924b73af32d1bebe77eb5592b93cd

You can find more problematic commits by doing `git log -- xdiff`.  I
was originally going to test --dir-diff in a subdirectory (xdiff in
this example) and that's when I found these.  I don't think it has
anything to do with subdirs; there's probably a commit in the history
that changes something (submodules? modes? not sure...) so once we go
beyond that point in the history it confuses --dir-diff.
--=20
David
