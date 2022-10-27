Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B210FECAAA1
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 18:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbiJ0Suo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 14:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbiJ0SuX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 14:50:23 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DC839BBC
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 11:50:21 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h2so2428071pgp.4
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1nJqo4pVaSjBPJ9HNhFOmx3InzZHRyHFz+ETG87mmL8=;
        b=bhkVA5+fAvdPuS1PEC827tSvM9G+pIKFPsVrdGgfQmzQ4xdESZfmUeIP/qPBkSAlXy
         OPUSngwQIn40VCOHtazT+2gIyHX20F6L3u1xXxwcZDtqFLA9nJtFtVn71AbtYYx6zPmS
         GrMzmQ866vL4lcUJY2JxjWLAIZ5V0D2SeEVhqPwtGMhXgLlzlOJqYg79IF0odvNe1JSF
         TKu6OXkNBad1dPVlGXCjbup5Q5Ku6SrAw+l/FkRShpHc3cQPtHnMyFAgLta5Cs5Vvkfu
         LBjjxvk4ila9NazT/NsqoJk0UgWNtdaGj51X4wRI/Nqo9Z3qeOPba3y2S4+79x5E82Pj
         JDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1nJqo4pVaSjBPJ9HNhFOmx3InzZHRyHFz+ETG87mmL8=;
        b=SZZJCpsyJoLO/+yekfqD2BFWu2r0EXp6soZkNgg49ojevC7DFRtev3GXbw1mzx1DaB
         Yskec+AdY5Aa/vWCGGUOboYIGbFWje9cXGX9gQZLfR1/Exd9r80BovgS71p/0y73ZMlM
         1Azz1GvRAtETw1DUezHLZ4KMHgAfztDVeZTmCePAivptLlYgVFI8PhlCfPQZPz2GRVQu
         ae4rybdYPsU1C0c0JpV9gEb8vAgMUE4Zkv5GysF8n37PD5zYPFEULlisOlf0NPFM2gAK
         O/R0QKDEEtablyechAj1+LMiQtoClIrt8q86uAd5Y9XgV7lc+H/gP+muK9/MQCHtAYg/
         2wUA==
X-Gm-Message-State: ACrzQf148FbahOVfbiA+q5zCcFAtnLElpzDudQrAYcg6kN78Qnj7rPMf
        /GKv5/pp0UEEHEe3x7Yd0oE=
X-Google-Smtp-Source: AMsMyM5fwKvzhGtC5BM5OV7s0mUdFMzSDfmBU+GIp/o+dqjgi1mjO/XoV0j/XVMZtMgXuJ5rRwsbyQ==
X-Received: by 2002:a65:628f:0:b0:43c:dac:646a with SMTP id f15-20020a65628f000000b0043c0dac646amr43447607pgv.397.1666896620602;
        Thu, 27 Oct 2022 11:50:20 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902db0400b00186a2274382sm1542667plx.76.2022.10.27.11.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:50:20 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Alphadelta14 via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Subject: Re: [PATCH v3 1/9] tree: do not use the_repository for tree
 traversal methods.
References: <20221027180949.1837457-1-jonathantanmy@google.com>
Date:   Thu, 27 Oct 2022 11:50:19 -0700
In-Reply-To: <20221027180949.1837457-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 27 Oct 2022 11:09:49 -0700")
Message-ID: <xmqqwn8lksno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> First of all, let me echo what Glen said [1], that this series is  
> overall well laid out and makes sense. 
>
> Other reviewers have commented on style issues, but I'll hold off on 
> making my comments on those and also possible improvements on commit 
> messages until I can say "besides style and commit messages, I think 
> that this series is good to merge in". 
>
> [1] https://lore.kernel.org/git/kl6lr0yuqlk0.fsf@chooglen-macbookpro.roam.corp.google.com/
>
> "Alphadelta14 via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> +			// This current codepath isn't executed by any existing callbacks
>> +			// so it wouldn't show up as an issue at this time.
>
> I was a bit confused by this comment, so I looked at the surrounding  
> code. I think it could be better rephrased as: 
>
>   All existing callbacks at the time of writing cause this part of the  
>   code to be skipped when S_ISGITLINK(entry.mode) is true, so this 
>   wrong behavior does not call any issues. 
>  

As I already said, I do not think this is "wrong behaviour" to begin
with.  The current code requires that you'd use add_submodule_odb()
to make the objects in them accessible and if your program fails to
do so, as a very natural consequence, you'd not see objects pointed
by the gitlink.

Changing that assumption is OK as long as existing callers that
depend on the current semantics are not broken by such a change, but
I do not think "wrong behaviour does not call any issues" is a
correct analysis of the problem.
