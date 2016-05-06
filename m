From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v2 1/4] rev-parse: fix some options when executed from
 subpath of main tree
Date: Fri, 6 May 2016 09:02:40 -0400
Message-ID: <CANoM8SWBzFiHGc3zAwndyx+GUkWQGDoaewVVQtH-06jazAn8uQ@mail.gmail.com>
References: <1461361992-91918-2-git-send-email-rappazzo@gmail.com> <20160429135051.15492-1-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri May 06 15:03:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayfPQ-00004s-A4
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 15:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbcEFNDD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2016 09:03:03 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35277 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932276AbcEFNDC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 09:03:02 -0400
Received: by mail-io0-f195.google.com with SMTP id u185so14014396iod.2
        for <git@vger.kernel.org>; Fri, 06 May 2016 06:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9dcF0B36X6Du/Bekzom/gKQvUsaYptIZysUqlpCLJN4=;
        b=w+JFKKdLirI9fnlzAr50PEoNMM7uK5KUVsxdU6lyAVqzZvWgBi73lu8J6fUBWVV+H6
         nIsmFZE7iU6pN8VtT3+8NFK3qj59QnYOropQ+57xHjNCDxLFyvm+fCJJCk+dPvaw9dis
         e5j59KOY/0X7+TqbFUQ/cj12md1jt8RjNpBaww866/qi9yzyMFvJ7HScR2/mpxLfoxr6
         z7KfxEMrDqAuNSf6LQbLlYgMh7yar3Rh+pC0xBsIzVLCZIuCCDsw/G7WVFg/Iv7pERkP
         FhqJHYOJeg43pH1rEw2A/6puNKXWOg8+ngOSPSuPrZ5jyj3jJYv8eYs74Pi3FxZ6yhFT
         NQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9dcF0B36X6Du/Bekzom/gKQvUsaYptIZysUqlpCLJN4=;
        b=O/YIOS4IoZz/A2jUKUpzLKsOkcgvwBqbmKRWLy0+d+gcbzAmtf/g3F9jF3hoM4dGnX
         QUJ22GPgM04Pn2vtB9qXlm+7iSWNQDqJrlqJGYOxxzYfdEHWx2u3G257rCJgj0D5X8yh
         aDpa/D5k2qNmAaJGUp1YMzdtWpszBFq0udN0qoXHqQizo3GEvxXmDANFFQIouE5CHhRz
         TdIYmAtwyJISeJCE/PE96iw48n952FZNGV5EzLTOic2tiltQH+hIkyRt+PMs12kBKQMK
         RQm7L9rEAqmp+jP+QIixOVizpQSY1JxQhyS649+1lBa11ejqFtQxryHRd4e122r20Zmc
         WZdQ==
X-Gm-Message-State: AOPr4FX7AEP0OwnwiaPZ2Y760gwkHpO6Da5qgVWvfoemRZFudGd+FUmF6Wj636FZayAwtph2yyxDLJDR2yr77w==
X-Received: by 10.107.168.160 with SMTP id e32mr26217607ioj.55.1462539780481;
 Fri, 06 May 2016 06:03:00 -0700 (PDT)
Received: by 10.107.7.220 with HTTP; Fri, 6 May 2016 06:02:40 -0700 (PDT)
In-Reply-To: <20160429135051.15492-1-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293774>

On Fri, Apr 29, 2016 at 9:50 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
>> Executing `git-rev-parse` with `--git-common-dir`, `--git-path <path=
>`,
>> or `--shared-index-path` from the root of the main worktree results =
in
>> a relative path to the git dir.
>>
>> When executed from a subdirectory of the main tree, however, it inco=
rrectly
>> returns a path which starts 'sub/path/.git'.
>
> This is not completely true, because '--git-path ...' returns a
> relative path starting with '.git':
>
>   $ git -C t/ rev-parse --git-dir --git-path objects --git-common-dir
>   /home/szeder/src/git/.git
>   .git/objects
>   t/.git
>
> It's still wrong, of course.

I'll try to reword this to make it indicate that the value isn't
always incorrect.

>
>> Change this to return the
>> proper relative path to the git directory.
>
> I think returning absolute paths would be better.  It is consistent
> with the already properly working '--git-dir' option, which returns a=
n
> absolute path in this case.  Furthermore, both '--git-path ...' and
> '--git-common-dir' already return absolute paths when run from a
> subdirectory of the .git directory:
>
>   $ git -C .git/refs rev-parse --git-dir --git-path objects --git-com=
mon-dir
>   /home/szeder/src/git/.git
>   /home/szeder/src/git/.git/objects
>   /home/szeder/src/git/.git
>

I agree with this, but at one point Junio suggested that it should
return the relative path[1],
so I went with that.  Maybe I could RFC a separate patch that changes
all of these to
absolute.

>> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
>> ---
>>  builtin/rev-parse.c | 19 ++++++++++++++-----
>>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> This patch doesn't add any new tests, while subsequent patches of the
> series do nothing but add more tests.  Splitting up your changes this
> way doesn't add any value, it only increases the number of commits.  =
I
> think either:
>
>   - all those new tests could be added with this patch, or
>
>   - if you want to add the test separately, then add them before
>     this patch and mark them with 'test_expect_failure' to clearly
>     demonstrate what the series is about to fix, and flip them to
>     'test_expect_success' in this patch.
>
>   - An alternative way to split this series, following the "Make
>     separate commits for logically separate changes" guideline, would
>     be to fix and test these options in separate patches, i.e. fix an=
d
>     test '--git-path ...' in one patch, then fix and test
>     '--git-common-dir' in the next, ...
>
>

Thanks, have a re-roll ready to go based on you input.  I went with
option 2 - add
tests with expect failure and fix them with the next.

[1] http://article.gmane.org/gmane.comp.version-control.git/290061
