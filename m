From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1 2/2] Ignore dirty submodule states during stash
Date: Mon, 16 May 2016 23:49:29 -0400
Message-ID: <CAPig+cTShM4Qc7sVN5NXSmwP8Cxz22q+ZAbSrW3bHVm66aaCQg@mail.gmail.com>
References: <20160517033632.GA2782@gmail.com>
	<20160517034050.GC2782@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Vasily Titskiy <qehgt0@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 17 05:49:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2W0m-0003lG-1E
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 05:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbcEQDtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 23:49:33 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33545 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081AbcEQDta (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 23:49:30 -0400
Received: by mail-io0-f196.google.com with SMTP id x35so1205922ioi.0
        for <git@vger.kernel.org>; Mon, 16 May 2016 20:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=BxEV94WQh+/QdNs5fANY1J6/c4hNK2PtgUvdzyTVEbk=;
        b=vkX8+NzExyhIUMGD5kV/peCBAKi0lgcEhJdiTh8HZIS7wSQeBXfB5dIloVys+8aRVg
         G8i7cIPYycHaKX80OpLPpcEO0HHeo/pSOfurpsjvBtUl/dt2sByJqEy9St5fMFSgPYx0
         0tPAuDWWvfKNEJ28Mri6dYg9r2AUvjrLnYJzRPpTI/0G0MVRZ/kVCNL/8BagRu1J8lRS
         kZMc2ky/Mzyks9RMZc9kPyqJb+Kf61Y2AlXYxKzGu75YnSjD4/+kjK7OpGd3qRqtGKUF
         392u5kPOwUouvY7bJMbG/hy4Awf9grQwMsX/TScjUxuYICQY5i2tIp3cZ8lKEHPcvfWc
         71Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=BxEV94WQh+/QdNs5fANY1J6/c4hNK2PtgUvdzyTVEbk=;
        b=cnuwKe77bcR2ImUZxXLEFPaVXb+Z1hIwr1I147oodMK9v/p3hobz2CzxNxqLQoE5qh
         bTbyIy28h171bsaxmIhjPxf+cEku9iQvDSvxAhJw2uaAsWY88NlFoLO2zvTDyHg9xfDz
         txsqeYYUGghG56M4cufoG3HX398TnDluvIW1Bh6047r4crsFvjLq94w1+5HzXYTvf7vn
         4kZ+iU2KimKY5q/TB5zETMKvnjbH9y5Lv730yR+pQt4Lexl+2whfoMsb4p1hSRR8CCTm
         KuIK2Eg6wMPliz9L2VH15ZRyKH06n5j43qbzI8tSrrLfvFvy3MGikMfxFqVty811zcH7
         sVpQ==
X-Gm-Message-State: AOPr4FWcA8MkyX9nL1ijKriS8OkQQfeHowh2+ryDO5fOFL0DokWnwDqfuXvbssV0yH0im3AGeDgBYUQmySqyvg==
X-Received: by 10.36.55.81 with SMTP id r78mr13065433itr.73.1463456969275;
 Mon, 16 May 2016 20:49:29 -0700 (PDT)
Received: by 10.79.139.135 with HTTP; Mon, 16 May 2016 20:49:29 -0700 (PDT)
In-Reply-To: <20160517034050.GC2782@gmail.com>
X-Google-Sender-Auth: MixAZOUBNMH5ehlzv89uHPKcVbY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294849>

On Mon, May 16, 2016 at 11:40 PM, Vasily Titskiy <qehgt0@gmail.com> wrote:
> It checks if 'stash pop' does not trigger merge conflics
> in submodules.

Missing sign-off.

Also, it would be best to combine these two patches so that the fix
and patch reside in a single patch.

More below...

> ---
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> @@ -731,4 +731,39 @@ test_expect_success 'stash list --cc shows combined diff' '
> +test_expect_success 'stash ignores changes in submodules' '
> +       git submodule init &&
> +       git init sub1 &&
> +       (
> +               cd sub1 &&
> +               echo "x" > file1 &&

Style: Drop space after redirection operator: >file1

Ditto below for both '>' and '>>'.

> +               git add file1 &&
> +               git commit -a -m "initial sub1"
> +       ) &&
> +       git submodule add ./. sub1 &&
> +       echo "main" > file1 &&
> +       git add file1 &&
> +       git commit -a -m "initial main" &&
> +       # make changes in submodule
> +       (
> +               cd sub1 &&
> +               echo "y" >> file1 &&
> +               git commit -a -m "change y"
> +       ) &&
> +       git commit sub1 -m "update reference" &&
> +       # switch submodule to another revision
> +       (
> +               cd sub1 &&
> +               echo "z" >> file1 &&
> +               git commit -a -m "change z"
> +       ) &&
> +       # everything is prepared, check if changes in submodules are ignored
> +       echo "local change" >> file1 &&
> +       git stash save &&
> +       git checkout HEAD~1 &&
> +       git submodule update &&
> +       git stash pop
> +'
> +
> +

Style: drop extra blank line

>  test_done
> --
> 2.1.4
