Return-Path: <SRS0=73cz=AB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC2EC433E1
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 06:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 853D520739
	for <git@archiver.kernel.org>; Sat, 20 Jun 2020 06:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhNJW9pc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgFTGzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Jun 2020 02:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgFTGzV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jun 2020 02:55:21 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E60C06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 23:55:20 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s23so5531860pfh.7
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 23:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8dVqLn4nBXklbW/qmACvIzY3MzyXQC0gkT/vF9qY97U=;
        b=PhNJW9pc5Vq2undce6wfxd7VYFF9Xu1bt1Dwmj8y9kdzzhWuBzX1LX3XtP0qSaTB+n
         zCb07xn8HoN9A+TJFlk7iAT//1fGZLJ+dE4kqdtTsFMt0wP9jPnKFlGgZ9QIm0OO3ZDb
         m+aDIgxjdPTsU9wsmFy3v/RMX3UmoNfuydDWBwJ1hLnhTYAMfbVtxMscPRAqeVaRbTPr
         mpQ5qXKfTPbxZwFbPWNJKKwVwDBDupg6lYQi/PypKtrnNXW8C9AI/8cVA/+Hlc6nUHM6
         1eN4i2qiSi+7HAZdbVTGCbgvv+o/pUFcq+r8R3GE/NpKoJcMHlcQRa3gtoC56satyFg0
         Algg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8dVqLn4nBXklbW/qmACvIzY3MzyXQC0gkT/vF9qY97U=;
        b=eT91qzjOgkQQXHGc0zZSW7ac4wDJOuVTsYqDHMUfVHpsr8ANspdySVIBQcxRphKS3s
         UlqrPtCEoCu6FcFeSDGDnYHOohW/cWB/klyaFvnRME18JjhncRKn9VX1Akj95eb3kkuR
         F/05Hq7WwlDxHN6XLvh6JrhxIalLpiZ9Kjy6WnmJCOg75AFgSo3uDUrLtF9AEQCCtZNg
         NO7gA80Kd4N3FPrl5Bi/WiV6W/XDii54yEglYBPuNZqHCQSKiFAw3QY8sp56O1ZZqabp
         yf+5jnqEhodNhwjYNfwgWYAs/Skrc3/Vy5b4w9DvHnCLmZkYRbdIF4gpTs89c/ErwhCD
         oBPw==
X-Gm-Message-State: AOAM531Avh8SP5wZKZ3Bo1G/s0Gd+K2unNCRH0+mhOblkXn69EEFp38M
        iiQXtTdyeGh+aAAf4geDONU=
X-Google-Smtp-Source: ABdhPJwp5LxPjZ2pF8xrjb9eJ5v12cpe5tApkZNXeV55dn0eWSuCCpRobxLhi6iRshwxMx4+/3353w==
X-Received: by 2002:aa7:8598:: with SMTP id w24mr11243352pfn.2.1592636120212;
        Fri, 19 Jun 2020 23:55:20 -0700 (PDT)
Received: from konoha ([45.127.46.204])
        by smtp.gmail.com with ESMTPSA id r7sm6516107pgu.51.2020.06.19.23.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 23:55:19 -0700 (PDT)
Date:   Sat, 20 Jun 2020 12:25:12 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [GSoC] Shourya's Blog
Message-ID: <20200620065512.GA15019@konoha>
References: <20200616072108.GA10273@konoha>
 <c88fe426-eac7-8d77-ec9b-9cb6d8dfc9f9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c88fe426-eac7-8d77-ec9b-9cb6d8dfc9f9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/06 02:08, Kaartic Sivaraam wrote:
> Some things I noted in the blog:
> 
> > As far as I have learned, summary prints a git log --oneline
> > between the revision checked out in the submodule and the
> > revision superproject assumed the submodule to be in (i.e.,
> > the one checked out in the superproject).
> 
> The explanation is pretty close. The wording could be tweaked a little
> to be more precise. Particularly "assume" isn't a proper word to
> explain the working of summary. It works based on facts not
> assumptions. Something along the lines of:

Thanks for the feedback. I couldn't think of a word back then! Will make
amends.

>     As far as I have learned, summary prints a git log --oneline
>     between the revision checked out in the submodule and the revision
>     "known" to the superproject (i.e., the revision found in the index
>     of the superproject).
> 
> >  If no revision is specified of the submodule then we assume it to be HEAD
> 
> As discussed elsewhere, the revision passed to the summary command is
> the revision of the superproject and not the revision of the submodule.

Alright! Will amend.

> > $ git submodule summary my-subm
> >   * my-subm abc123..def456
> >     < some commit
> >     < another commit
> >     < some another commit 
> 
> While the command above would produce the result you mention when
> 'my-subm' in the repo. The command itself is incorrect if it's
> intention is to print "only" the summary of 'my-subm'. This is the
> format of the 'summary' sub-command according to the doc:
> 
>     summary [--cached|--files] [(-n|--summary-limit) <n>] [commit] [--]
> [<path>...]
> 
> So, it expects a 'commit' followed by the 'path'. As you had passed the
> path as the first argument it would be treated as the 'commit' argument.
> As 'my-subm' is likely not a valid commit-ish, the script would
> default to 'HEAD' (the final else mentioned below) and would
> print the summary of all the submodules. IOW, it just prints the
> same output as:
> 
>    $ git submodule summary
> 
> in this case.

I just took the case of only one submodule existing in the superproject.
Though even my output isn't wrog, the path taken to achieve it is a bit
ambiguous. I will change it.

> > else
> > 	head="HEAD"
> > fi
> >
> > This means that if the above 2 cases fail (which will most probably
> > lead to presence of commits yet a failure in git rev-parse --verify)
> > then make head as HEAD.
> 
> Characterising 'git rev-parse --verify ...' as not being able to print
> the hash of a commit even when there is one in the repo seems incorrect
> to me. There are other more likely cases which would lead to rev-parse
> failing and that last else part getting executed. For instance, an
> incorrect ref being passed as the first argument to the summary
> sub-command like:
> 
>     git submodule summary no-such-ref-exists
> 
> or
>      git submodule summary "invalid ref"

Oh! I did not think this one! I will change this too. Thank you so much
for pointing this out.

Regards,
Shourya Shukla
