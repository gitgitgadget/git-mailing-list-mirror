From: Atousa Duprat <atousa.p@gmail.com>
Subject: Re: Suspected bug on `git -C <rp> rev-list --all` where <rp> has 0 commits
Date: Tue, 24 Nov 2015 22:56:50 -0800
Message-ID: <CA+izobv6OuAAjnKH5A=vcmJh3yDhWi41WAD-OmVSN2d7P_5SGA@mail.gmail.com>
References: <20151111192634.629102e6@linux-apw9.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: yac <yac@blesmrt.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 07:57:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1U0c-00042G-0i
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 07:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbbKYG4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 01:56:53 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:33379 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057AbbKYG4v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 01:56:51 -0500
Received: by ykdv3 with SMTP id v3so46672676ykd.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 22:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OTDHqcGGpuEXbFbwSfvinTZJNXll9ofAfeN0/LGnMvg=;
        b=tkjwiYQCSfHdszfmfIjXIbfvWzvQYl8ke49TZGDdurgo70J4zASD6MHjuK755Hv2iN
         hvUNSlUUX0VuxQoOseJ1DX09WrsY3AoDyyx0NXfRUQcwjhJbbvyMnSIzQUrQmFqljZxt
         XZ0N1pAhdNoq17KLGd7I7g7HGppnU+WWmXhuQKpKupFigSK59ofCmq4gc2iBnNTZOADz
         rvR5UAYICDmh+2EYp6uFajgYcZUD44ddFLt2aWOaT1G7794gCRvnRn8T7oMtzX8c+44l
         CIyDmvIOdcAQhF2U9suLhCfb9NPRYYqUztKmtUD5k84Ab7q1Nt2+QkW2IPQnu+iZsG3o
         9/rA==
X-Received: by 10.129.105.198 with SMTP id e189mr10195064ywc.244.1448434610458;
 Tue, 24 Nov 2015 22:56:50 -0800 (PST)
Received: by 10.37.83.195 with HTTP; Tue, 24 Nov 2015 22:56:50 -0800 (PST)
In-Reply-To: <20151111192634.629102e6@linux-apw9.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281682>

I agree with Yac that this error is unwarranted, though it's been like
that since forever.
If a repo is empty, git rev-list should probably just return without
erroring out.
The fix is trivial, if the list agrees that this is in fact legit.

Atousa

On Wed, Nov 11, 2015 at 10:26 AM, yac <yac@blesmrt.net> wrote:
> Hello
>
> basics:
>
> % rpm -q git git-core
> git-2.6.2-2.1.x86_64
> git-core-2.6.2-2.1.x86_64
>
> ~ % grep PRETTY_NAME /etc/os-release
> PRETTY_NAME="openSUSE Tumbleweed (20151030) (x86_64)"
>
> current behavior:
>
> ~ % git init no-commits
> Initialized empty Git repository in /home/tester/no-commits/.git/
> ~ % git -C no-commits rev-list --all
> usage: git rev-list [OPTION] <commit-id>... [ -- paths... ]
>   limiting output:
>     --max-count=<n>
>     --max-age=<epoch>
>     --min-age=<epoch>
>     --sparse
>     --no-merges
>     --min-parents=<n>
>     --no-min-parents
>     --max-parents=<n>
>     --no-max-parents
>     --remove-empty
>     --all
>     --branches
>     --tags
>     --remotes
>     --stdin
>     --quiet
>   ordering output:
>     --topo-order
>     --date-order
>     --reverse
>   formatting output:
>     --parents
>     --children
>     --objects | --objects-edge
>     --unpacked
>     --header | --pretty
>     --abbrev=<n> | --no-abbrev
>     --abbrev-commit
>     --left-right
>     --count
>   special purpose:
>     --bisect
>     --bisect-vars
>     --bisect-all
> ~ % echo $?
> 129
>
> expected behavior:
>
> ~ % git -C no-commits rev-list --all
> ~ % echo $?
> 0
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
