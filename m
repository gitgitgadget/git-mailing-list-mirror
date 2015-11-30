From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Bug: git crashes on rebase reporting bogus memory corruption
Date: Mon, 30 Nov 2015 00:39:58 -0500
Message-ID: <CAPig+cQBS2DVKkoyQWTRs6-zrXkEhrDnnZU0efh63B2B7Qu5CA@mail.gmail.com>
References: <CA+mi_8Y5bx-RDCV2oFfFRVZz-Jjcii7QbB6k45B5YsLoed-b8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Daniele Varrazzo <daniele.varrazzo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 06:40:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3HBw-00060z-T0
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 06:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbbK3FkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 00:40:00 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35404 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbbK3Fj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 00:39:59 -0500
Received: by vkha189 with SMTP id a189so95518609vkh.2
        for <git@vger.kernel.org>; Sun, 29 Nov 2015 21:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0qSdNawSW49Rn+7/3B1/g5exrF+Q2JQ62lg5PKnJ+hk=;
        b=ieCxgAXkvV5wc4H584rc6FDNa+q5p6+wH+ZOAn7gj26fKePdyCSo//9wUCWVysBRuE
         Pi+jvvnIZlEplN0IRe1quR10hYEP+PBzRmooU6i2b9v3t1BsaelORH/lug8/qj6r/Fdq
         HHGdPUPe5gDZDM2gCha+Wb6SwFfR5JrpEbhCE5qNoTDgJ9U8JKMusuy7viUNJPsYhPel
         S++EMz3RSmc/88ERY4UEDg1VDB5DeHkS5xwvP2t4shyGrSZqPvRNmcyHPQT6SoRX2VDd
         p/sL7Lsxi2ceqHLOth9Tut8E6YqfJopvI85azLejRKTT2ZIuLPVCYygUCOYROgGsuk2x
         w9QA==
X-Received: by 10.31.56.18 with SMTP id f18mr47585689vka.19.1448861998634;
 Sun, 29 Nov 2015 21:39:58 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Sun, 29 Nov 2015 21:39:58 -0800 (PST)
In-Reply-To: <CA+mi_8Y5bx-RDCV2oFfFRVZz-Jjcii7QbB6k45B5YsLoed-b8g@mail.gmail.com>
X-Google-Sender-Auth: C1cqrE5NubRDQu6bFKEsNxJmux4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281801>

On Fri, Nov 27, 2015 at 9:08 AM, Daniele Varrazzo
<daniele.varrazzo@gmail.com> wrote:
> I was trying to rewrite history in a small repos and replace
> indentation tabs with spaces. Steps to reproduce:
>
> git clone https://github.com/dvarrazzo/suponoff.git
> git checkout -b gitbug
> git config core.whitespace
> trailing-space,tabwidth=4,tab-in-indent,space-before-tab
> git rebase  6af85bcde9a30c3841b754bbb60c03ba58b88a50 --whitespace=fix
>
> error reported on crash is:
>
> Applying: Read configuration from supervisor config itself, added groups tags
> *** Error in `git': malloc(): memory corruption: 0x00000000023f9420 ***
>
> Tested with:
>
> CentOS Linux release 7.1.1503 (Core)
> git: 1.8.3.1
>
> Ubuntu 14.04.3 LTS
> git: 1.9.1

Bisection indicates that this bug was fixed by 407a792 (apply: count
the size of postimage correctly, 2015-01-16), which is included in Git
2.3.1.
