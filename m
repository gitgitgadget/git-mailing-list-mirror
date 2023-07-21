Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088C0EB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 04:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGUESG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 00:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjGUESC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 00:18:02 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C812106
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 21:18:00 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7654e1d83e8so144811985a.1
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 21:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689913080; x=1690517880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GhbPJIlLCZl9XutZOhle3Zs4P52tNa/5QZG7GwXZmV4=;
        b=eEOoEyS55EMJ0rd/y80nxbSS5O8GTjLsI+d7wJSH5v9JaRnUpt5/+IiAY2LLW8QVbq
         N45TJXc0pDfM4yxbYKQ3z9bxSIuQJmNbPDejwM/rE7I81rkpLWzlI0anoj5MIhMkodhT
         I8QFpGeUY38ogY4DSCi2gNHVEfSFWU+rTFJ2/kx3U1/m/j6r8AfcwhekeLmHAZ/I6WO8
         KPdCiiwfw9Mte/Jckak5x7fGCyetPwLySeMnHxkEmrJc8uDlRl4NqK/Y0tiU/Zt2YyNV
         0ykn1xBpeC4U40QqdLWj+4wkbSG7Nbz00g65kD7VBG6ihxlIt9SYXB99liyMRsT3G/0j
         b8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689913080; x=1690517880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhbPJIlLCZl9XutZOhle3Zs4P52tNa/5QZG7GwXZmV4=;
        b=W0K9rHo4DlRkq2LhBYo42jTjTPh2F0meeMC8f3MOHuTNkGlcDO8nxPnfWPTX3LokRH
         riM4fKRP2jKx93zqhDfTE/E7JfpZvfmXn2BBYPyuPJVQw5l0hpl83hkSImxrBVWRyhe4
         +Hxd0gITQUGywmKdsuvg/e5JnFMfFeaKdxrjuYeP/qkRQdR9E/8z0PRlP2A2xtTVdh6Z
         QJFKdGF6Cx3sPayrwVu3ojtKHnxc9tA2bZU6DdQzgq5BrLhkx+cj9V9BrMv2bfx4q+6q
         VFhk1iHhHYa2YiN3J+ZYFYcTHoxbqUPvKhKMHx8j99S01skeapMzQPywL5RY1ph6Lspm
         BNZw==
X-Gm-Message-State: ABy/qLaq2bwSX6ujQhDFiYNi68/EJqEFq5yTJZGmhbmo6WnZDc4ExJ8h
        8tvCy7AExYkIdsNynEPsUaMzlOy3uSHoew==
X-Google-Smtp-Source: APBJJlFtJMma0fGY+Fmc5SyLFjim4DvtVPt+64sRx9aOBvfsUkRGlAc1HULYegf28BfqU2OEdFYpMg==
X-Received: by 2002:a05:620a:394b:b0:765:7a1e:a456 with SMTP id qs11-20020a05620a394b00b007657a1ea456mr881997qkn.54.1689913079665;
        Thu, 20 Jul 2023 21:17:59 -0700 (PDT)
Received: from five231003 ([49.37.158.8])
        by smtp.gmail.com with ESMTPSA id bo10-20020a17090b090a00b002677029c726sm1666845pjb.22.2023.07.20.21.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 21:17:59 -0700 (PDT)
Date:   Fri, 21 Jul 2023 09:47:45 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v3 0/2] Add new "describe" atom
Message-ID: <ZLoG6a7tG-HisBhq@five231003>
References: <20230714194249.66862-1-five231003@gmail.com>
 <20230719162424.70781-1-five231003@gmail.com>
 <xmqqr0p219ib.fsf@gitster.g>
 <xmqqjzuu18oe.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzuu18oe.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 20, 2023 at 04:10:09PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > The linux-gcc job is where we force the initial branch name to be
> > 'main' and not 'master', so if your tests assume that the initial &
> > primary branch name is 'master', that may be something you need to
> > fix.
> 
> Perhaps something along the line of the attached patch?
> 
> The primary test repository t6300 uses is aware of the "problem"
> where the tester may set GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> to 'main' and hacks it around by using
> 
> 	git branch -M main
> 
> as one of the first things it does, to _force_ the primary branch
> name always to 'main', whether the tester's environment forces "git"
> to start with 'main' or 'master', and existing tests in the script
> relies on 'main' being the primary branch.
> 
> But your tests are done in a repository newly created with your own
> "git init", so depending on the tester's environment, the primary
> branch may be 'master' or 'main'.  The way your new tests are
> written, however, things will fail if "refs/heads/master" is not the
> primary branch.
> 

I see. I looked at the trash directory by doing -v -i -d when running
these describe tests and was under the impression that it is always
master.I guess I should have had a bigger view of things.

>  t/t6300-for-each-ref.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git c/t/t6300-for-each-ref.sh w/t/t6300-for-each-ref.sh
> index 4bbba76874..489f4d9186 100755
> --- c/t/t6300-for-each-ref.sh
> +++ w/t/t6300-for-each-ref.sh
> @@ -563,7 +563,7 @@ test_expect_success 'color.ui=always does not override tty check' '
>  '
>  
>  test_expect_success 'setup for describe atom tests' '
> -	git init describe-repo &&
> +	git init -b master describe-repo &&
>  	(
>  		cd describe-repo &&

I'll add this to the re-rolled version.

Thanks
