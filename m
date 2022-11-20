Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A2BC433FE
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 09:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKTJUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 04:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKTJUg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 04:20:36 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9520591510
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 01:20:35 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso7128511wmo.1
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 01:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMgyAwKlPkfslPg4pgCl0xGFAcHm8Xk4nFWiWJBribU=;
        b=dtpc0HII0MnQOK9UFkEGta1N/I3onxGnCJHXHxSckRDblnIpQIDf7oxqrnSkl5CsDV
         buep3XAPLq8poMXadxRHsrP1WE1eBd+NmdXEa7/iVnSKOi1+uftuHjHM21NKA3AEIriK
         dhq30tnTAjJBVnR9Jb4KXSeUkz31uzD1UZJwm5y5iv9ejmqWENF6Y99ykd2O2PGThs1f
         /gz0Lijm6J0g807VH3jcfsfpRYJX86cHzpe5Y2P/HyqrKM5Xn71/hU2CiO8fy9Fqiqhb
         az1R9gyKgXKw9i98BeOTABj2dIh1SHJFJp8IjUMZTBmntjU3qZKzwi/wpi+I7sEfztJf
         V/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eMgyAwKlPkfslPg4pgCl0xGFAcHm8Xk4nFWiWJBribU=;
        b=YX4pqIB6ReJ77N8J0t2os0R4Lx+nHfa0K7eD8Xog7TU6muHDVBb1EPRhJpONoxV2AD
         J73eUPupA0BSbHRLrE21qp3Jrnc6GNW6rQca1cMyphE4FgYlMMlAzR8+VPcfIPd1Cj3d
         6mtaV/nfllLJ576ErgOK/mzF0F4/i6PgrYCCByxrWirX3UMv0mHkHkCRxJIp97uBpZbk
         Re2gXlPOkvczJTSNrWuULSH3MQoIizxf+2QxJ+WA8kpOs1CFg/MXG/kAD8WYeVdueZ6Z
         FzrRr5U4pDgNPrmLCR9zW2HtpQC8ioQt22Yma4A9MFTmtipC26/oYHb/SCNiV7++vvj3
         3Vmw==
X-Gm-Message-State: ANoB5pmQ2t5392v15Xm9FhajULOI0aFwTwDNEB6L0No1eyh03txWljIf
        8XY2L2sMiuQNNS9Oo6j9KHA=
X-Google-Smtp-Source: AA0mqf5Nt97BLNyLH6TY7Tw0jnMvRRKNnJ3fnu1RCV0OBqAZ92F2MpD8m2kdU3AnX+FZyRRSjP2W3w==
X-Received: by 2002:a7b:c048:0:b0:3a8:3e58:bb9b with SMTP id u8-20020a7bc048000000b003a83e58bb9bmr2773900wmc.168.1668936033990;
        Sun, 20 Nov 2022 01:20:33 -0800 (PST)
Received: from [192.168.2.52] (104.red-88-14-50.dynamicip.rima-tde.net. [88.14.50.104])
        by smtp.gmail.com with ESMTPSA id l24-20020a05600c1d1800b003cf878c4468sm16280899wms.5.2022.11.20.01.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 01:20:33 -0800 (PST)
Subject: Re: [PATCH 2/2] branch: clear target branch configuration before
 copying or renaming
To:     Victoria Dye <vdye@github.com>, Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>
 <762c1e8f-fd0c-3b4b-94a0-709d8c9431e4@gmail.com>
 <8457ad4c-51c7-4c2d-8dbf-02a60045d288@github.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <042c18df-deb6-6214-2d49-c214a872e1c1@gmail.com>
Date:   Sun, 20 Nov 2022 10:20:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8457ad4c-51c7-4c2d-8dbf-02a60045d288@github.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17-nov-2022 18:10:52, Victoria Dye wrote:
> Rubén Justo wrote:
> > There are two problems with -m (rename) and -c (copy) branch operations.
> > 
> >  1. If we force-rename or force-copy a branch to overwrite another
> >  branch that already has configuration, the resultant branch ends up
> >  with the source configuration (if any) mixed with the configuration for
> >  the overwritten branch.
> > 
> > 	$ git branch upstream
> > 	$ git branch -t foo upstream  # foo has tracking configuration
> > 	$ git branch bar              # bar has not
> > 	$ git branch -M bar foo       # force-rename bar to foo
> > 	$ git config branch.foo.merge # must return clear
> > 	refs/heads/upstream
> 
> What happens if 'bar' has tracking info? You mentioned that the
> configuration is "mixed" - does that mean 'foo' would have both the original
> 'foo's tracking info *and* 'bar's? 

Of course :-).  My reasoning here is considering 'no tracking' as
tracking information, hence the 'if any'.  I think that the unexpected
functioning this patch is trying to resolve is more obvious having an
unexpected tracking information if we rename a branch /with 'no
tracking'/, overwriting (-M) a branch that already has tracking
information.

> I wasn't sure whether "transfer the source's tracking information to the
> destination" was the desired behavior, but it looks like it is (per
> 52d59cc6452 (branch: add a --copy (-c) option to go with --move (-m),
> 2017-06-18)). Given that, I agree this is the right fix for the issue you've
> identified.

Yes, a reference to that commit is a good information to have in the
message.  But I prefer to not refer to it as I don't think that commit
is responsible or explains this unexpected result, though I cc'ed Ævar
;-)

The design decisions in branch.c and config.c have brought us to this
unexpected result, which just need to be addressed. IMHO

> >  
> > +test_expect_success 'git branch -M inherites clean tracking setup' '
> 
> s/inherites/inherits

Oops, thanks.

> > +	test_when_finished git branch -D moved &&
> > +	git branch -t main-tracked main &&
> > +	git branch non-tracked &&
> > +	git branch -M main-tracked moved &&
> > +	git branch --unset-upstream moved &&
> > +	git branch -M non-tracked moved &&
> > +	test_must_fail git branch --unset-upstream moved
> 
> If I'm reading this correctly, the test doesn't actually demonstrate that
> 'git branch -M' cleans up the tracking info, since 'moved' never has any
> tracking info immediately before 'git branch -M'. The test could also be
> more precise by verifying the upstream name matches. What about something
> like this?
> 
> 	test_when_finished git branch -D moved &&
> 	git branch -t main-tracked main &&
> 	git branch non-tracked &&
> 
> 	# `moved` doesn't exist, so it starts with no tracking info
> 	echo main >expect &&
> 	git branch -M main-tracked moved &&
> 	git rev-parse --abbrev-ref moved@{upstream} >actual &&
> 	test_cmp expect actual &&
> 
> 	# At this point, `moved` is tracking `main`
> 	git branch -M non-tracked moved &&
> 	test_must_fail git rev-parse --abbrev-ref moved@{upstream}

You are right, good eye.  Thanks.  That first '--unset-upstream'
eliminates the possible undesired inherited tracking info.  Removing it
is needed to make the test meaningful.  'rev-parse' is a good change,
but as the test is not testing that '-M' works as expected but doesn't
work in the unexpected way the message describes, I don't think we need
it here, imho.

> s/inherites/inherits (same typo as before, just pointing it out so it's
> easier to find)

Oops, thanks again.

> > +	test_when_finished git branch -D copiable copied &&
> > +	git branch -t copiable main &&
> > +	git branch -C copiable copied &&
> > +	git branch --unset-upstream copied &&
> > +	git branch -C copied copiable &&
> > +	test_must_fail git branch --unset-upstream copiable
> 
> This doesn't have the same issue as the other test (since 'copied' has no
> tracking but 'copiable' does before both 'git branch -C' calls), but it
> would still be nice to use the 'git rev-parse --abbrev-ref
> <branch>@{upstream}' for more precision here. 

I still prefer the test_must_fail for '--unset-upstream', for the same
reasons that in the previous hunk.  I also think it improves
t3200-branch.sh.

Something like...

--- >8 ---

Thank you!

 t/t3200-branch.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index c3b3d11c28..ba959a82de 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -218,17 +218,16 @@ test_expect_success 'git branch -M should leave orphaned HEAD alone' '
 	)
 '
 
-test_expect_success 'git branch -M inherites clean tracking setup' '
+test_expect_success 'git branch -M inherits clean tracking setup' '
 	test_when_finished git branch -D moved &&
 	git branch -t main-tracked main &&
 	git branch non-tracked &&
-	git branch -M main-tracked moved &&
 	git branch --unset-upstream moved &&
 	git branch -M non-tracked moved &&
 	test_must_fail git branch --unset-upstream moved
 '
 
-test_expect_success 'git branch -C inherites clean tracking setup' '
+test_expect_success 'git branch -C inherits clean tracking setup' '
 	test_when_finished git branch -D copiable copied &&
 	git branch -t copiable main &&
 	git branch -C copiable copied &&

