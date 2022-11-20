Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36AEC433FE
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 14:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKTOz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 09:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiKTOz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 09:55:57 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCDB209
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 06:55:56 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e11so3480787wru.8
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 06:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rkh99EcBF29/9wwQML/GM9yzVEYlDhiL503GRz7YoO4=;
        b=XzXn6ob+PutfCrJ35PlyHX9dstMi8TBUL9Y9apwRly0wxrOdJvGuTFayRd6NXdvzT1
         L8bMxDywRO06HxPAGgxq/WnjCeXVpNcMoWWS7ACQKb2C3Ktb5sxo+zlPL2n07LA02+yf
         baR7JHUtFBi3+9g0ByTY8lm+/rjmDEoR0VdWqo0uyPrt+tRA0hQ1lXcpnP7pb2Y8thT1
         27dHmCWRlVzVlZnJ5uXoAknyg5tmWZDqutikxY3oKtrIQopwbQ/GGLvEbpYsH2ZIlbl3
         iARrlWozOFFWMIkWQm5IsBCXHX5LRvQJoV8RIobquyMPtINLCz7zk+s+xg9bbMF9vZF9
         vz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rkh99EcBF29/9wwQML/GM9yzVEYlDhiL503GRz7YoO4=;
        b=Cz92ds6cfwYpKxqDGHoqw5wy95FS+wIT5v1vztZ4/MpCXOUWpV8cDsV2TT+nrNGJLb
         WCkvym7jP5uMbtCQklGpraQaq4rmUr544eBpxRIt9VXH54xgp+CN7D4C/NulgAeoNmxk
         xFOzrl/v39rfT/qfFP81jonaHleooE/r+Dq34h9eMAAp8UD7jh9xc6vypNPRTLJ2YFzB
         w4dN6ZxhKYs+AxoqSczMsBh0dfb1kn2ri4x5INUDKo97OQdPu2QHf2dix/GDm1+aTG7s
         Jl1gickysXcp7qCyLFXKBEj/qG/mET42+FHzVU50agKMDO/E7r9cEAsqORd8Ui68igo8
         cAoQ==
X-Gm-Message-State: ANoB5ploA20ix7P7k8D+HpRf8EzhCwh3VChGM5LhlR6gxcZZAuMk6cod
        oC1zl1N7Q9p0VGFWFE9U2to=
X-Google-Smtp-Source: AA0mqf4hr4Aj68FiuxplwPzE11Uy9VmxmMZcz03ax941P3MoPNFzqYi2Q7kyiZRComir1dHp/IdaBA==
X-Received: by 2002:a5d:6b08:0:b0:236:4b06:bbb1 with SMTP id v8-20020a5d6b08000000b002364b06bbb1mr8730390wrw.303.1668956154396;
        Sun, 20 Nov 2022 06:55:54 -0800 (PST)
Received: from [192.168.2.52] (104.red-88-14-50.dynamicip.rima-tde.net. [88.14.50.104])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b003cf4eac8e80sm14277484wmq.23.2022.11.20.06.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 06:55:53 -0800 (PST)
Subject: Re: [PATCH 2/2] branch: clear target branch configuration before
 copying or renaming
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
References: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>
 <762c1e8f-fd0c-3b4b-94a0-709d8c9431e4@gmail.com>
 <221118.864juwhkcc.gmgdl@evledraar.gmail.com>
 <ddc1b100-98f3-7ddf-aa2b-af080cb40443@github.com>
 <221118.86r0y0f5ff.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <660dc134-121c-11b1-f722-2b4946495c40@gmail.com>
Date:   Sun, 20 Nov 2022 15:55:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <221118.86r0y0f5ff.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18-nov-2022 19:12:10, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Nov 18 2022, Victoria Dye wrote:
> 
> > Ævar Arnfjörð Bjarmason wrote:
> >> 
> >> On Thu, Nov 17 2022, Rubén Justo wrote:
> >>> Whenever we copy or move (forced or not) we must make sure that there is
> >>> no residual configuration that will be, probably erroneously, inherited
> >>> by the new branch.  To avoid confusions, clear any branch configuration
> >>> before setting the configuration from the copied or moved branch.
> >> 
> >> So, whatever tea leaves we read into the history, or whether this was a
> >> good or bad design in the first place, I think we should probably lean
> >> towards not having this be a bug fix, but a new feature. Both modes are
> >> clearly easy to support.
> >> 
> >> And then document it in terms of some new switch being the equivalent to
> >> --remove-section followed by a rename, the existing thing a rename etc.

Mmm... the way I see this is as an unexpected _and unintentional_
result, not sure if I am happy describing this is as a bug.

Maybe we can see this as "completing the functionality of moving and
copying a branch", a missing "NEEDSWORK".  Though I think the message
describing this patch as a problem is sensible because of the
motivations and for future reference.

I might agree with a new option like "--mix-configuration" to add this
"feature" (and document it).  But I don't find sensible to consolidate
this unexpected and unintentional result, imho, and making the
expectable an option.

> But my spidey sense is a bit tickled by the proposed change discussing
> the existing behavior as a pure bug, when it seems to me that it's
> approximately what you'd get if it was implemented in terms of "config
> --rename-section", v.s. the proposed new behavior of (as I understand
> it) a "config --remove-section" followed by "config --rename-section".

Explaining this as something you'd get modifying directly the
configuration, might not be a good idea.  A user can break the config,
but "git branch" should not.

> I think a conservative approach would be to focus narrowly on the
> tracking config, if that's the thing that's at issue. I.e. we read that
> ourselves, know that it's broken if it's transmuted in certain ways etc.
> 
> But the proposed patch suggests that we extend that fix to anything we
> might find in that config namespace.

Yes, as the expectation (again, imho) is that the resultant branch gets
its original configuration not a mix of the original and the remanent.

> >>> @@ -583,12 +583,17 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
> >>>  
> >>>  	strbuf_release(&logmsg);
> >>>  
> >>> -	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
> >>> -	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
> >>> -	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
> >>> -		die(_("Branch is renamed, but update of config-file failed"));
> >>> -	if (copy && strcmp(interpreted_oldname, interpreted_newname) && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
> >>> -		die(_("Branch is copied, but update of config-file failed"));
> >>> +	if (strcmp(interpreted_oldname, interpreted_newname)) {
> >>> +		strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
> >>> +		strbuf_addf(&newsection, "branch.%s", interpreted_newname);
> >>> +
> >>> +		delete_branch_config(interpreted_newname);
> >>> +
> >>> +		if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
> >>> +			die(_("Branch is renamed, but update of config-file failed"));
> >>> +		if (copy && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
> >>> +			die(_("Branch is copied, but update of config-file failed"));
> >> 
> >> Aside from any question of a hypothetical "should", your implementation
> >> is running head-first into a major caveat in our config API.
> >> 
> >> Which is that we don't have transactions or rollbacks, and we don't even
> >> carry a lock forward for all of these.
> >> 
> >> So, there's crappy edge cases in the old implementation as you've found,
> >> but at least it mostly failed-safe.
> >> 
> >> But here we'll delete_branch_config(), then release the lock, and then
> >> try to rename the new branch to that location, which might fail.
> >> 
> >> So, we'll be left with no config for the thing we tried to clobber, nor
> >> the new config.
> >
> > This is a good point, so to add to it: I think a fairly unobtrusive solution
> > would be to move the config deletion after the rename is 100% complete.

The update of the ref is already done when we operate on the
configuration.  I think that _even_ if the
git_config_{rename/copy}_section fails, the delete_branch_config() is
sensible.

> Also, whatever this is supposed to do, shouldn't we make it consistent
> with other "git branch" modes. E.g.:
> 
> 	git branch -D foo
> 	git -P config --show-origin --get-regexp '^branch\.foo\.'
> 	git config branch.foo.rebase true
> 	git branch foo -t origin/seen
> 	git -P config --show-origin --get-regexp '^branch\.foo\.'
> 
> Will emit:
> 	
> 	Deleted branch foo (was ...).
> 	branch 'foo' set up to track 'origin/seen'.
> 	file:.git/config        branch.foo.rebase true
> 	file:.git/config        branch.foo.remote origin
> 	file:.git/config        branch.foo.merge refs/heads/seen
 
I'm not sure.  I did notice that, and I can think of ill but legit uses
there: a user might be setting the configuration and then creating the
reference.  It is tangential here, but we can issue a warning like:

	$ git branch -t foo
	$ git branch -t bar
	$ git branch -C foo bar
	$ git branch --set-upstream-to foo bar
	warning: branch.bar.remote has multiple values
	warning: branch.bar.merge has multiple values
	branch 'bar' set up to track 'foo'.

I have different unsent patches to address this too, but I'm not sure
what we want there, and how.

> The upthread commit message doesn't discuss it, but even multiple
> "merge" values are a valid state of affairs. E.g.:
> 	
> 	$ git branch seen -t origin/seen
> 	branch 'seen' set up to track 'origin/seen'.
> 	$ git branch next -t origin/next
> 	branch 'next' set up to track 'origin/next'.
> 	$ git branch -C seen next
> 	$ git config --get-regexp 'branch\.next'
> 	branch.next.remote origin
> 	branch.next.merge refs/heads/seen
> 	branch.next.remote origin
> 	branch.next.merge refs/heads/next
> 
> Now, if you do:
> 
> 	git checkout next
> 
> and:
> 	git pull --no-rebase
> 
> You'll get e.g.:
> 
>        Merge branches 'next' and 'seen' of github.com:git/git into next

I think this is unexpected and unintentional.

> And again, don't take any of that as an a-priori argument against
> changing it, I'm still undecided. I'd just prefer that we know what it
> is we're changing.

Thank you for your analysis.
