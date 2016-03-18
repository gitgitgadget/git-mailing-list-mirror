From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] git-log should use the same diff-options as git-show
Date: Fri, 18 Mar 2016 14:54:27 -0700
Message-ID: <CAGZ79kb8xcNymJ3=nE2C60BGdsAXEaF_CYpwy54DZ-MDc8ktsg@mail.gmail.com>
References: <loom.20160318T222303-528@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Henning Moll <newsScott@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 18 22:54:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah2Lp-0003Gv-9A
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 22:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbcCRVya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 17:54:30 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35029 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbcCRVy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 17:54:28 -0400
Received: by mail-io0-f175.google.com with SMTP id o5so68734753iod.2
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 14:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=IR6HxqXArDIHnclco2squYpnK0miBNzJduAzctDGjf0=;
        b=efPhqrnPfkd6ah460AEmZKZRccw7AkauFDirszyFWusWOJzHa5EufsnGkn5AX45nV1
         14S4nn2Cy9Cz52XYI/m4MDdDXcqRwJB51n42fQwqlucW1a985RNSBPqBpajUlZzH64P2
         9kl7T9Ci/d4TePitZBNfQl0TVT/waWIvz3Ci9vMRr6h0/+zbew1DS0nSp7EDGavYizEI
         6wPJkMkQuKC5LglnMa/voCP7I927h3IqrUGzcBYvdV8T+r8ugfUs2XDC/ba2p+fB5DOj
         jPNhwXUsxNM94nGnrJyFUZl2gmxc2WDyxmPanFGz8VPDb13ojLsQl6RIhmARWhYJQWaZ
         Jl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=IR6HxqXArDIHnclco2squYpnK0miBNzJduAzctDGjf0=;
        b=W81NbeunwuuF3GQsbbtgiAZQqm7NLkmihHZ1X0NZz/D4MjORL0aWOB62rbreduifM3
         AKLEJwrEV42Tg/nuN7ichNU75nr9CP0/z8ssValG5u56+MZ81KpWbgd3uD9Vzop4hNiS
         GzQBzdHIMQ4garelcgG+P1Er7sL2C8+iaaHejrjdzSB/6XWV2BegpWizjt+/4xMP0Ogx
         KR5Zvn99D6ZDdFCsl+PN9ga3v6l+2Urf0U4jRrmTZpVN/SWpyfTtXNBHpcMQwkUBHrie
         JYHArve36VNJsT4GPdzb586sqClSE5knZhe/6pySioEiUkxWuPEzJ4OG60hI1qMy6Rs7
         ZFvQ==
X-Gm-Message-State: AD7BkJJMwB7QsfmHfzcxVE2nMu5rRWSDAhupYnibvZcj8AuT+ooPpYPYDo+Kz7zgOwJRUnqK+krQXLIgPDg/IS/5
X-Received: by 10.107.135.96 with SMTP id j93mr17976310iod.96.1458338067482;
 Fri, 18 Mar 2016 14:54:27 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Fri, 18 Mar 2016 14:54:27 -0700 (PDT)
In-Reply-To: <loom.20160318T222303-528@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289259>

On Fri, Mar 18, 2016 at 2:47 PM, Henning Moll <newsScott@gmx.de> wrote:
> Hi
>
> Recently i stumbled upon an old stash entry. It was clear to me that the
> stash only contained non-indexed worktree changes. So i assumed to get
> insight by doing
>
>     $ git log -1 -p stash@{0}
>
> But surprisingly the result was "no patch" (The problem which i was not
> aware at that time was the fact that a stash commit is a merge). So i asked
> a question on stackoverflow (1) an learned that there are different default
> options used depending on the git command used:
>
>     $ git show stash@{0}
>     $ git diff stash@{0}^..stash@{0}
>
> work with default, but for git-log i need to
>
>     $ git log -1 -p --cc stash@{0}
>
> to make it behave the same. This does not seem reasonable to me, though i
> read about commit 1aec791 (2) in git's own repository. What do you think?
>
> Maybe - as a compromise - just show any kind of hint instead of nothing?

Junio did some slight tweaks to --cc and -p,
see 82dee4160cc6d1b0d792c9f07b5803cd42abc610/
and its parent. That should be live in the upcoming 2.8.

>
> Best regards
> Henning
>
> (1) -
> http://stackoverflow.com/questions/36089674/git-log-1-p-stash0-shows-empty-patch
> (2) -
> https://git.kaarsemaker.net/git/commit/1aec7917dc52901c6df301ddc8fea70f5ce0db09/
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
