Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5390C282DD
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 23:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786F82072A
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 23:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a1F+NYKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgAJXBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 18:01:34 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54747 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgAJXBd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 18:01:33 -0500
Received: by mail-pj1-f67.google.com with SMTP id kx11so1557072pjb.4
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 15:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VfFCmQJNB+p11g2lb9HJhHX2vHAmPF1n3B+fPpmufqw=;
        b=a1F+NYKnGzzchD11HG44S6Gdw7v96TRp3IpQ3RUmd37dLjyPwa/GoyqccX2dVpdHRz
         5E9hUNzRslRqt5/re903VqFHbj8vYSbh1GFl2XZMA5r3HgrErDZDx9bKo534HO9PvaKA
         tI58utyeFG6YfsygfuAcQAmv0eTMwHfyRNWxRn2+z3IgZoXe8PcdSUx1JIPjlMXK5WVj
         ciNMduBlAguMlN+xyj6AkEe/1J9BYgaDwoSoaCgiW5nrXFsS5WQsavTP30MY+ePA9FtI
         nk/6vpPzRFiG2wAWoQ30VGoLQ+57whp+zPX3NesPUDnYXi9MOCNuXq34T8isl7UlcBDP
         sQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VfFCmQJNB+p11g2lb9HJhHX2vHAmPF1n3B+fPpmufqw=;
        b=mpVAIcF5vPuM0aG4t6ZF3Rp5xNbutGOkHUF8qKEDoM6XNK+qxhWOslKtFLDToqDPd3
         7Rk6pAwV1RyUfh4P5SvGrIdW/pcSauqGA2pBvwkJDsun41/+0evUA11qdcVn+GCDrxja
         Fx3ausol1+uGJc+zplA4JYUPWE8FZSfYbingUHB/p2aIPrMtgyqlixtIFOlL2/K+iTyt
         Z7X9uJXCAsCpZlgltN5bTpO3zwwWlX098SHRchgJaJDMoVHA35/tsdYnrHMV4kImKbKS
         5boNPaYWjBNg/IFTE/IGUSOP0Jm9YNhtKcOnO7LEqaW8JLLgJOHApi1P7tUEzxJR8L6J
         mnxA==
X-Gm-Message-State: APjAAAXwkp6oAonbpDl4OPz8GVS70QoqTQylJhXLrs9VzDoZECcDz7sN
        Ao4HvR2aE4cqOH26VusExO4PX5oAB9M=
X-Google-Smtp-Source: APXvYqy8NWm5av/A0+BGGql6aCpCbybYFKWLyyYe+pbmos2TTA0QC/R9IbaAa0FFIKgO40/CuXZ51w==
X-Received: by 2002:a17:90a:ba07:: with SMTP id s7mr7908941pjr.75.1578697292870;
        Fri, 10 Jan 2020 15:01:32 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id 7sm4256006pfx.52.2020.01.10.15.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 15:01:32 -0800 (PST)
Date:   Fri, 10 Jan 2020 15:01:28 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: emphasize failure during submodule fetch
Message-ID: <20200110230128.GG181522@google.com>
References: <20200110195533.6416-1-emilyshaffer@google.com>
 <xmqqtv53kquh.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtv53kquh.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 10, 2020 at 12:18:30PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > In cases when a submodule fetch fails when there are many submodules, the error
> > from the lone failing submodule fetch is buried under activity on the other
> > submodules if more than one fetch fell back on fetch-by-oid. Call out a failure
> > late so the user is aware that something went wrong.
> >
> > Example without this change:
> 
> >   $ git pull --rebase
> >   remote: Counting objects: 1591, done
> >   remote: Finding sources: 100% (4317/4317)
> >   remote: Total 4317 (delta 1923), reused 4252 (delta 1923)
> >   Receiving objects: 100% (4317/4317), 2.09 MiB | 8.15 MiB/s, done.
> >   Resolving deltas: 100% (1923/1923), completed with 101 local objects.
> >   From https://android.googlesource.com/platform/superproject
> >   [snip ~100 lines]
> >   From https://android.googlesource.com/platform/prebuilts/fullsdk/platforms/android-29
> >    * branch            a97149980b7d8acf48392af591b35689f7205d9e -> FETCH_HEAD
> >   From https://android.googlesource.com/platform/prebuilts/fullsdk-darwin/platform-tools
> >    * branch            98f9454af8ca210818eff4f502097c471d7327b5 -> FETCH_HEAD
> >   From https://android.googlesource.com/platform/prebuilts/checkstyle
> >    * branch            6fb3e23f05ed186908ea9f48d6692220891363b0 -> FETCH_HEAD
> >    * branch            f21d92f6339f0993a946b25fa2172c2ceb5e332b -> FETCH_HEAD
> >   From https://android.googlesource.com/platform/prebuilts/androidx/studio
> >    * branch            bed5e7b5866b8698bbcd1879134b03ac312a2ba8 -> FETCH_HEAD
> >   From https://android.googlesource.com/platform/prebuilts/androidx/internal
> >    * branch                179375220f834de5dfbee169f4c2f948d850a203 -> FETCH_HEAD
> >    * branch                1dcf3ceef9a86001c693fa34b3513f0c4af26178 -> FETCH_HEAD
> >    * branch                2ea3ccef4c98f5de1b74affd1dda33f5b2834a45 -> FETCH_HEAD
> >    * branch                a09de09c3814c3d31cc770d5351b92d29ea624ae -> FETCH_HEAD
> >    * branch                d2ae6add8b2c0e28899e4faeb2d6889ceefb0b62 -> FETCH_HEAD
> >    * branch                e244e2a5f7d98f47f75d06ef57ef1c6c5701a38d -> FETCH_HEAD
> >   Auto packing the repository in background for optimum performance.
> >   See "git help gc" for manual housekeeping.
> >   From https://android.googlesource.com/platform/prebuilts/androidx/external
> >    * branch              c3df2fa7f3e63b8714ac8d24f86a26cc50ee4af5 -> FETCH_HEAD
> >   fatal: remote error: want c5bd7796550b3742772c8fb8c73a1311013b5159 not valid
> >   From https://android.googlesource.com/platform/external/noto-fonts
> >    * branch            02969d3046f6944a5a211d2331d1c82736487f01 -> FETCH_HEAD
> >    * branch            9ee45fcd0b8bb8621c1cdbc6de5fe7502eff7393 -> FETCH_HEAD
> >   From https://android.googlesource.com/platform/external/dokka
> >    * branch            03a8ed966a7b847931a0ee20327f989837aaff13 -> FETCH_HEAD
> >    * branch            cb1684602b5b4e18385d890c972764c55d177704 -> FETCH_HEAD
> >    * branch            fd4521e89ab0e01447dda9b42be2b9bbc000f02f -> FETCH_HEAD
> >   From https://android.googlesource.com/platform/external/doclava
> >    * branch            04ddf3962f0cd40c81a2e144f27f497223782457 -> FETCH_HEAD
> >    * branch            44bf22680e939b21a21a365f6038d5883d5163c8 -> FETCH_HEAD
> >    * branch            66f673f4a3865f3b4ab645655a6484101dbd051f -> FETCH_HEAD
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> > As hinted by the snippet in the commit-message (should I remove it? I
> > think it's a poignant example, I couldn't see the fatal without grepping
> > even after being told it was there) this manifested to an end user via
> > 'git pull'.
> 
> It indeed is too noisy, especially without showing what happens with
> this patch.

Sure, it makes sense. I'll take it out in next round.

> 
> Is it clear to the users that a block of lines starting "From $URL"
> and ending before the next "From $AnotherURL" is about the same
> repository, including error messages?

Well, for me - and the bug reporter - the "fatal" line visually blends
in with the "From" next to it. I think once you see the "fatal" line
it's clear where it's coming from, sure.

I wonder if the line order still holds with -j specified, though.

> 
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index b4c6d921d0..0c19781cb9 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -1857,6 +1857,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
> >  						    verbosity < 0,
> >  						    max_children);
> >  		argv_array_clear(&options);
> > +		if (result)
> > +			fprintf(stderr, _("Failure during submodule fetch.\n"));
> 
> How does a user find out which submodule had trouble with after
> seeing this message?  Or is it something you still need to find by
> scrolling back?

The handiest way is probably the latter; maybe there is some way to
achieve the former, but my submodule fu isn't strong enough for me to
answer from the top of my head.

> 
> If the latter, I am not sure if there is much point to add a
> half-way solution like this.  It is a different story if "fetch"
> exits with success status when this happens, but I do not think the
> "result" that is non-zero is being lost before the function returns,
> so...

I agree, although I do find it irritating that there's no final
success/failure log line from 'git fetch'. I personally don't run 'echo
$?' after every step in my Git workflow.

It's less trivial (a low bar) to try and point out the submodule(s) which
had an issue by this point, but I can give it a shot if you are open to
the change.

> 
> >  	}
> >  
> >  	string_list_clear(&list, 0);
