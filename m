From: Brandon McCaig <bamccaig@gmail.com>
Subject: Re: Re: Extended splitting for "git add --interactive"
Date: Thu, 27 Nov 2014 10:46:37 -0500
Message-ID: <CANUGeEYrpduzwiUY3KuWbR8MDpfFpeBRva15+LxMsL1+W82mWg@mail.gmail.com>
References: <5475F7E7020000A100018050@gwsmtp1.uni-regensburg.de>
 <xmqq3895rdr1.fsf@gitster.dls.corp.google.com> <5476F4FA020000A100018078@gwsmtp1.uni-regensburg.de>
 <CALKQrgcHvjuynbmRZWAKWu-Ld1-h7eqEZEBqorPTHW9m8onDGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Nov 27 16:47:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xu1Hc-0003rD-0r
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 16:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbaK0Pq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2014 10:46:59 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:54183 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbaK0Pq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2014 10:46:58 -0500
Received: by mail-ob0-f180.google.com with SMTP id wp4so3872307obc.39
        for <git@vger.kernel.org>; Thu, 27 Nov 2014 07:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tO2fzgZz/7qdZZXzYtjHilGBWxwhg3nou7wL7lg1ckc=;
        b=a4LjgpS0oZxe2tiSeK0g+y3WIBQNJwQeQzVMNCOP4pjeGZprMOeBwQKuwZ2ugcR1ZL
         lFHmfWpgdPRdG0yPzbb2TQ0Zocy0r9XP01A9l7sRRPx28CSIbZdyMv16cJKtrXT4YZ+2
         +gfX+MHAB9mdk3OanxxJXoXpPFPgwyF/9XtBmr6qSSu8pCMBjOWuNTH1j3WxPaHQ5WDw
         LyHVAHjHL/YGlGAOnOz67hlCluc9CHrY77OtrNYptv5hxInMXyr56m5hZA9toTkp7cvf
         mppFqnRBTgrOp5vsbZ+dB5LrFC6oAibeVC8/UPKOKw+qQt1dUrMKNa6Z5zv5QLqHnqWD
         QpBg==
X-Received: by 10.202.128.139 with SMTP id b133mr22909222oid.52.1417103217582;
 Thu, 27 Nov 2014 07:46:57 -0800 (PST)
Received: by 10.202.130.70 with HTTP; Thu, 27 Nov 2014 07:46:37 -0800 (PST)
In-Reply-To: <CALKQrgcHvjuynbmRZWAKWu-Ld1-h7eqEZEBqorPTHW9m8onDGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260345>

Hello,

On Thu, Nov 27, 2014 at 5:14 AM, Johan Herland <johan@herland.net> wrote:
> FWIW, I would very much like a "2nd-level split" where it simply splits
> into individual lines. I think it's not worth trying to be extra clever
> about it. For your example, I'd simply want the following behavior:
>
>   -AAA
>   -BBB
>   +CCC
>   +DDD
>   Stage this hunk? SPLIT
>
>   -AAA
>   Stage this hunk? YES
>
>   -BBB
>   Stage this hunk? NO
>
>   +CCC
>   Stage this hunk? YES
>
>   +DDD
>   Stage this hunk? NO
>
> This would allow me to stage the following:
>
>   -AAA
>   +CCC
>
> and leave the following unstaged:
>
>   -BBB
>   +DDD
>
> but would also allow any other combination.

Having (e)dited a lot of hunks manually I can see it being a bit
difficult to understand line-by-line (but then I rarely split as it
rarely does what I need so I'm not sure what use cases this would
apply). I just had an idea about re-joining added lines in the output
each time to show you what you're actually doing to the hunk with each
prompt. I don't know if it's a good idea. Illustration:

 AAA
 BBB
-CCC
-DDD
+EEE
+FFF
 GGG
Stage this hunk? s

  AAA
  BBB
- CCC
Stage this hunk? y

  AAA
  BBB
 -CCC
- DDD
Stage this hunk? n

  AAA
  BBB
 -CCC
  DDD
+ EEE
Stage this hunk? y

  AAA
  BBB
 -CCC
  DDD
 +EEE
+ FFF
  GGG
Stage this hunk? n

In any case, I find that editing the hunk is generally faster than
trying to figure out if split is going to do something useful (perhaps
studying the Git code would help in that regard).

That said, the key to making editing the hunk (or patches in general)
efficient is adding keybindings to your favorite editor to edit
unified diffs. In my Vim configuration I map ,, to a function that
removes the current line change (removes - line, deletes + line) and
,. to add - to context lines. Both also always move down a line
automatically and center that line on the screen, and have no effect
on lines for which the chosen function has no meaning. So editing a
hunk typically becomes ,, to remove unwanted changes from the current
hunk or skip context lines and j to skip good lines to get to the next
changes. Occasionally I use ,. to remove a context line that was in my
original source. And if I want to invent a + line it's just o or O.
The bit I'm editing remains in the middle of my screen with my whole
screen for context. My relevant vimrc:

autocmd FileType diff
            \ nnoremap ,, :call UndoPatch()<CR>|
            \ nnoremap ,. :s/^ /-/e<CR>:nohl<CR>jzz

function! UndoPatch()
    normal! 0

    if getline('.') =~ '^+'
        delete
        normal! zz
        return
    endif

    if getline('.') =~ '^-'
        s/^-/ /
        nohlsearch
    endif

    normal! j
    normal! ^
    normal! zz
endfunction

Maybe that'll be useful for somebody else. Any editor suitable for a
programmer will be able to do something similar. I suspect that
customizing your editor will be time better spent.

Regards,


-- 
Brandon McCaig <bamccaig@gmail.com> <bamccaig@castopulence.org>
Castopulence Software <https://www.castopulence.org/>
Blog <http://www.bambams.ca/>
perl -E '$_=q{V zrna gur orfg jvgu jung V fnl. }.
q{Vg qbrfa'\''g nyjnlf fbhaq gung jnl.};
tr/A-Ma-mN-Zn-z/N-Zn-zA-Ma-m/;say'
