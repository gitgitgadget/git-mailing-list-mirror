From: Stefan Beller <sbeller@google.com>
Subject: Re: [BUG] `git submodule update --init --recursive` stores gitdir in
 full path into `.git` of nested submodules
Date: Wed, 30 Mar 2016 09:05:05 -0700
Message-ID: <CAGZ79kaa2uBmRZ_OPG9hVkrc29uj8Lx9b-6fgbcDNE0OGvJ+cg@mail.gmail.com>
References: <F89ED33B-E33D-4693-8559-4255727B78B8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Norio Nomura <norio.nomura@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 18:05:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alIcM-0008Qh-VC
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 18:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005AbcC3QFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 12:05:08 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:34986 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929AbcC3QFH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 12:05:07 -0400
Received: by mail-io0-f176.google.com with SMTP id g185so79035572ioa.2
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Aqqo13R1r3Moa+dk6Ag52wKruPe+kYqk5fbhXe+rHQc=;
        b=WD3LkJGesZnmN8D50Pg0v2Cqgx47pQ9Ylm35cDEN5KKSzIqCF+fI+SGgIBPthcHp4g
         ytjYCKqk6dcpMimp8jq3S9khvqXbLgqePYlG2vPFPmI92kykWu6cyt4+gZyCcJKLpubY
         Ku7RLBCwABISbEdLMqt9w9XSzak5/Vd5KgTjKAftcJ7JpHD/VQB0wxfhl3UraQkBT3Xv
         r5xf2yvBIzJKo2pzRRZKB96UFYNWHlT8XTKez6hRWFIEUEwxUnaV18ZIccq1GA+YaynX
         yhGPMY58OQSbGLx3YeTcudsuJ1Acv4FWYra3bSncz2p7vSu6bF0JgECFKST1eAqn6TSl
         TC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Aqqo13R1r3Moa+dk6Ag52wKruPe+kYqk5fbhXe+rHQc=;
        b=gImnUJHE010RVWccfxEPtnENkpIAw4pJcSZ6XrR2XznNO09fiSC2I5VGLBxycsxZlu
         QX9mlvUTDy4qmGzwPHxSno1vM6Z/lH79SjC/Mw5s8leaFWEptWH+o7+nlDT8FbTkPshl
         45Zh6HR8ZwHSjKTbZM4XBlI8De79vaUBZUY9lg+0Nif1lQc652coSuKRG0HRB7p0Xg/L
         V62FeUz+oX4IWmmkUnKwN8Q8ZWHtouV5bZv2ON2aabxvZh+ssyPSiYcyqmKKNvYcUXjd
         JbZScw6CtIg9NCFu6jUibzh6ixVHijABFuX21bCW5TioT+HPf8VQJKD7mVxM+FAj9u/V
         J5iQ==
X-Gm-Message-State: AD7BkJIAuZ19z07jQ/TX05qkAYa/7TvsTm6hH8dmLsPE6VRXX+8J8U938sWn/Y53rz/XjVO2AfYedKpAn+KMOkgf
X-Received: by 10.107.158.138 with SMTP id h132mr10088217ioe.174.1459353905113;
 Wed, 30 Mar 2016 09:05:05 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Wed, 30 Mar 2016 09:05:05 -0700 (PDT)
In-Reply-To: <F89ED33B-E33D-4693-8559-4255727B78B8@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290310>

On Wed, Mar 30, 2016 at 2:03 AM, Norio Nomura <norio.nomura@gmail.com> wrote:
> Hi,
>
> `git submodule update --init --recursive` stores `gitdir` in full path into `.git` of nested submodules.
> So, working directory is not portable to another directory.

Are you reporting a regression bug? (Is that a new thing or has it
always been that way and you just discover that it is unfortunate?)
Which versions did you test with?

>
> On following example, `Carthage/Checkouts/Quick/Externals/Nimble/` is nested submodule and `Carthage/Checkouts/Quick/Externals/Nimble/.git` contains full path.
> https://gist.github.com/norio-nomura/17ce4bdf0151185e77d9b1fcfb5a469d
>
> Thanks,
> --
> Norio Nomura @norio_nomura
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
