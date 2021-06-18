Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E81AC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 19:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 211996100B
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 19:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhFRTMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 15:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhFRTML (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 15:12:11 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A484DC061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 12:10:00 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id m137so11643078oig.6
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 12:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=kJeDDBtbbETkgMla3qLdc1jv5tLSQrcq7xlDNW6vi3U=;
        b=RcN5d/3penHmng/j/akVb0mnJ/vDDhP00SD5qS7nLBExPBLjhrfVL7r3IC/hdP/ADc
         k2mlitNeXTfl0SlloaDTJdAQQCl4x113OiPN3xrpH1s0pUTC0dQuK+55EcdbG0BZO5gI
         oRCvDFWB2Rm2J8lDaSi7lBXWEMgYpcE0iPP1F4mFz+06Vq6ytH1rS3Dk/OiJOgtDWu9M
         vpfhnFa0B3p0qPOpXGeEm0AZ8ZTfupuOrSf5/xe1btOlMnUiS+jTwNs+SQ/oClNSANyV
         tPpx0zLHmiXB6Oy8phYY5n7yIfrBkMNHMAykqZL/bS0RsOCVG5DAhgOrNUOXTN3W//5A
         S8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=kJeDDBtbbETkgMla3qLdc1jv5tLSQrcq7xlDNW6vi3U=;
        b=Do8R10woA9wsco4Qi22zKqorKoC4XkEuacySXyMIlR5gxL3MFiS8qDWCLStOG+lCyq
         CWOHSu20wJo9QzDWAQjOlFF2AfxH20kwxfqpBSqFkBvuNPBw6iW7bAOWqn0jJ9KPdXo9
         el5HlQcbBAElYlSJ2l69YakTwzYVJgsR6eKFqWzPvpSCmdVOFJ2hsWrig2V37JR2hAH4
         smphEIV1YsEFqLiRbI01M4Ve/zqfRVKwp1P1OFNFMXIJ+cIIx0a4H6gnyOHtzKTwduq+
         KFhp5hRGhiLASyQ/5OGuvzwERoZ7cAPIlVZXGXkCZ8kKsWpw+g3oGJaeHmkpIV/i+age
         NM+A==
X-Gm-Message-State: AOAM531no6RR6WnhUVh1QtdYeiVC3QYi8Mfa7+gdYBNPpPvQ+Zt4kRmS
        nUdV99aLDXLi8UE1bfvR0t6cGU8/RAznJw==
X-Google-Smtp-Source: ABdhPJxSWk5sVQ8dkRa0aq3FJOdpD+DzWuBejIkYEeHFkg96ZkzD/Rh+LBwE7dtjYzIzuAm+oYPifw==
X-Received: by 2002:a54:4692:: with SMTP id k18mr15651246oic.118.1624043399929;
        Fri, 18 Jun 2021 12:09:59 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id c34sm2142698otu.42.2021.06.18.12.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 12:09:59 -0700 (PDT)
Date:   Fri, 18 Jun 2021 14:09:58 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Fabian Wermelinger <fabianw@mavt.ethz.ch>, git@vger.kernel.org
Cc:     Fabian Wermelinger <fabianw@mavt.ethz.ch>
Message-ID: <60ccef865312e_a69392081a@natae.notmuch>
In-Reply-To: <20210618140256.256481-1-fabianw@mavt.ethz.ch>
References: <20210618140256.256481-1-fabianw@mavt.ethz.ch>
Subject: RE: [PATCH] completion: bash: fix late declaration of __git_cmd_idx
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Wermelinger wrote:
> A recent update to contrib/completion/git-completion.bash causes bash to fail
> auto complete custom commands that are wrapped with __git_func_wrap. Declaring
> __git_cmd_idx=0 inside __git_func_wrap resolves the issue.

I was about to say the idx should be 1, and that fixes the issue, but
actually 0 is more correct, since when we do __git_complete there's
actually no real command.

In the future we might want to improve __git_complete to manufacture a
real command since some completions do check the command at
__git_cmd_idx (e.g. __git_complete_remote_or_refspec), and then set
__git_cmd_idx to 1.

But for now your patch fixes the issue better than my previous patch
[1], however, it's still missing the zsh part. I've sent an update patch
with the best of both [2].

Cheers.

[1] https://lore.kernel.org/git/20210618182518.697912-2-felipe.contreras@gmail.com/
[2] https://lore.kernel.org/git/20210618185832.700477-1-felipe.contreras@gmail.com/

Cheers.

-- 
Felipe Contreras
