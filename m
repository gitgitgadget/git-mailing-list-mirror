From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: gitignore excludes not working?
Date: Sat, 7 Dec 2013 10:20:46 +0700
Message-ID: <CACsJy8CyvSP9y7ui=2h7oFyeYCJK7WTdpqoSk00SM=LdpEokyQ@mail.gmail.com>
References: <CACPiFCJ0Jj1M8KCrwus=DeRSBE2O3HKhvEo-UJhHoZDhHTzsSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 07 04:21:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp8SI-0004Zu-OS
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 04:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857Ab3LGDVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 22:21:18 -0500
Received: from mail-qa0-f50.google.com ([209.85.216.50]:58727 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab3LGDVS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 22:21:18 -0500
Received: by mail-qa0-f50.google.com with SMTP id i13so1157410qae.9
        for <git@vger.kernel.org>; Fri, 06 Dec 2013 19:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Zb1OJOTgMWmo648f41BG7xabu8lDs9o7pr5PArbw87Y=;
        b=y5hHgYucEG4uMzmO6Ki2qgyZNSOOTOvurSHv9ohSKWqRIMGcFDfaoTRPhkMcaCxAwa
         zsm49ZV+9Skdj0CSxBZ5a1Fx2ZbZAdlFadhzlncERP4qpXF8fyYOMa5TLVfQir4m0MxW
         oHnw38hF9r1ETHYXNqRIckFT1RB+oLpvxmJU7RidSo+bw/WzuiADBFX6gEV5gSb2uQMK
         8Puawyt/A95Lb3Zffml0jT9o/oFmZNcFbMDwF0tInziePu73uo7jwjrAY1FceduA8rwL
         qAVgno4K7hXpf5dnCyI1nsxnQR8WY7pRFT2xhyqKWClyHtjVEWMhAuDxXZQcTu7fbbBr
         46rA==
X-Received: by 10.224.136.136 with SMTP id r8mr12760617qat.0.1386386477434;
 Fri, 06 Dec 2013 19:21:17 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Fri, 6 Dec 2013 19:20:46 -0800 (PST)
In-Reply-To: <CACPiFCJ0Jj1M8KCrwus=DeRSBE2O3HKhvEo-UJhHoZDhHTzsSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238970>

On Sat, Dec 7, 2013 at 12:26 AM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> # modules/boring/
> # modules/interesting/other.c
>
> $ echo '/modules/' > .gitignore
> $ echo '!/modules/interesting/' >> .gitignore

Once you ignore the directory "modules", it won't bother with anything
inside. As a result, !/modules/interesting/ is ignored. Turning the
first rule to /modules/* like Jiang Xin showed does the trick because
git is told to ignore entries inside 'modules', not 'modules' itself.

I think the best we could do is turning /modules/ into /modules/*
internally. But it only works for simple cases like yours. If you
write /mo*ules/, I don't think we can make git smart enough to
correlate /mo*ules/ to !/modules/interesting/. So the second best
thing is improve documents about this case, which is what
kb/doc-exclude-directory-semantics does (currently on 'next').
-- 
Duy
