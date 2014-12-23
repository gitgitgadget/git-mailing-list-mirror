From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: mangled file names in git checkout-index --temp output when run
 in repo subdirectory
Date: Tue, 23 Dec 2014 18:27:18 -0500
Message-ID: <CAPig+cQ4Bb=bUKeKuBp-ykorBV+mSuztvzh=AA5CDNPFLVQw5Q@mail.gmail.com>
References: <CAA8EjDRsw6o8T1sS=rpSt_+KaKt9QnONCmF23yHDdKhgKHcdww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Russ Cox <rsc@golang.org>
X-From: git-owner@vger.kernel.org Wed Dec 24 00:27:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3YrN-0002vL-A6
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 00:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946AbaLWX1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 18:27:19 -0500
Received: from mail-yk0-f176.google.com ([209.85.160.176]:42186 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbaLWX1T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 18:27:19 -0500
Received: by mail-yk0-f176.google.com with SMTP id q200so3502471ykb.35
        for <git@vger.kernel.org>; Tue, 23 Dec 2014 15:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=APogtjgvZ4w3wBnKz1wt8YFVp5WrdF3r7fzgmT96A6Q=;
        b=iI9+1W9HUrPkF4q9reBVhQZzDVTJuG81MH0BC0FdXv1fTVR2iP5q1xN2fo2NqUTanf
         GH7IsY4/EFxT1WFg0g3MMlboXHkmq4FQCIDtYxZfgShtqoahAo/EQoLEtUIaRwMTlKIF
         D+asJfnMyi2kc25pa8njSEE+2mILQAV2OaMQDlhZJCJutaI+1decG+dzorXp5wlpn3wR
         cXB6kjvI8KZKJKZlsFloz1WQwqejbu+KYS08WW80+tmoGPshjB1ctoyH2+025E4gyUWI
         yd3XNW5z+9f57M0Gdc23Bhu2Yz19eR9IQyH7nxIkHJM8oMeemHExsE5UY3M4cxHvZpHS
         7KMA==
X-Received: by 10.170.128.207 with SMTP id u198mr26898087ykb.51.1419377238518;
 Tue, 23 Dec 2014 15:27:18 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Tue, 23 Dec 2014 15:27:18 -0800 (PST)
In-Reply-To: <CAA8EjDRsw6o8T1sS=rpSt_+KaKt9QnONCmF23yHDdKhgKHcdww@mail.gmail.com>
X-Google-Sender-Auth: HWoN6hSoK3eo3z5an6Icg1MjFJ8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261780>

On Tue, Dec 23, 2014 at 11:36 AM, Russ Cox <rsc@golang.org> wrote:
> I am using git checkout-index --temp to obtain copies of files from
> the index, but it does not always print valid file names unless run
> from the repository root.
>
> git checkout-index --temp prints names of files in the index
> interpreted relative to the current directory below the repository
> root.
>
> If you have a git repo in /tmp/gitbug, you are in /tmp/gitbug/dir1,
> and you run git checkout-index --temp /tmp/gitbug/dir1/file1, the file
> listing prints just "file1". So far so good.
>
> However, this file name shortening appears to assume that all file
> names being printed will be within the subtree rooted at the current
> directory, and it just skips over the first N characters in the name,
> where N is the length of the current directory name relative to the
> repo root (in the above example, N = len("dir1/") = 5).

Indeed, although the "checkout" functionality of checkout-index
properly handles relative paths above the current directory, the code
which prints them doesn't. I'm working up a patch.
