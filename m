Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F74C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 00:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A622071E
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 00:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzB64Yy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKZAqv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 19:46:51 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37501 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfKZAqu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 19:46:50 -0500
Received: by mail-pj1-f68.google.com with SMTP id bb19so3876509pjb.4
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 16:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=alI7Hqs/pz/88Def1TlGqUtS/QRzGaANaV3+ow924Ow=;
        b=mzB64Yy1UeYVBZsfW5XwsvLe5tx4oZQArGvGFH8YpO/rGevIQ7zb30/4014sMUTUYm
         FLNU3jqtVqUqT/Z9Cj1bFFJ+2DQHM9GWKEcPtAalwDNCv5HdcZLTxIY5fQUOBhisHUU5
         nNXmHbzq+4yFKs6xjkyw1NdQMM+NRWtf4d9iTcMkxzuLPeNLWTTGm6SA7M9DaYSUFC9u
         kqhcNJk68lKkRandIpWOxxH7kr7ZDldOvKbaVEW4j+EA5fCgFfM+FspRvJHg0oPckVnv
         GUudxSZ62IKp/PZE1XDxLamlfuq+yfS11WLdQu0YvCjN9hR62ZaF23falILvDZuIjvCO
         3U1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=alI7Hqs/pz/88Def1TlGqUtS/QRzGaANaV3+ow924Ow=;
        b=dmWdO2NvVq7IlkVJpn6+47AUPY+k/jxQ2U3/iRoM01XmjqxfoHny2bMWxFMlk7DaDs
         HiO9bE8cJ2H4gWL//GTr8UUKNYqgrXsrbpUq3ZW2SdjSeonymZ4ZrQ3SFNUCzZF1MJmW
         hE8dB+5XyLLwRnP/l5+zOWSe4NFpP3e/UbYW2lzj0H+7pLv/tGXFv+lqtqtHQIcfzFF/
         xFoS0rzJ78rTklcvOV+vvVfuM7OyloKYlDhwg7brzGH6H+IkoMlzgfE0mceHx1Q2vwQw
         D8C4j/GdsumroVsEE0+pHvN5GHp0ToWadZ7bMBk2/PVXVXg9WHb6qRmU0b73gE+aslau
         ev4A==
X-Gm-Message-State: APjAAAXJsruAweiWeid3befp6nKSrvP6DreEcSU8qHfhcj+rZGTROPT8
        jOykXZTlBj2cMOdsDRtD39M=
X-Google-Smtp-Source: APXvYqyW8ULszlTEI4MRHHL3Qo9zhtsaxG+OyqFbcKEtGyHhu3clL3nFbgh0wNzkVUiZpzE052eKtg==
X-Received: by 2002:a17:90b:30d7:: with SMTP id hi23mr2637637pjb.10.1574729209879;
        Mon, 25 Nov 2019 16:46:49 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id v189sm10138216pfv.133.2019.11.25.16.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 16:46:49 -0800 (PST)
Date:   Mon, 25 Nov 2019 16:46:47 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ruud van Asseldonk <dev@veniogames.com>
Cc:     git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] t5150: skip request-pull test if Perl is disabled
Message-ID: <20191126004647.GD14157@google.com>
References: <4f11b5b3-a68e-642a-c5fb-7b5dae698669@veniogames.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f11b5b3-a68e-642a-c5fb-7b5dae698669@veniogames.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ruud van Asseldonk wrote:

> The git-request-pull.sh script invokes Perl,

Okay, on second glance I found it:

  set fnord $(git ls-remote "$url" | @@PERL@@ -e "$find_matching_ref" "${remote:-HEAD}" "$headrev")

This does seem pretty inherently to require perl, so makes sense.

I wonder if we can generalize this.  For example, would it make sense to
have a helper that looks for @@PERL@@ in a file,  so we could say

	if uses_perl git-request-pull.sh && ! test_have_prereq PERL
	then
		...
	fi

That way, this would be more futureproof in case someone eliminates
the perl dependency (either by improving that particular parsing step
or by rewriting the whole program in C).

In any event,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Do the request-pull tests in t7006-pager.sh need the same treatment?

Thanks,
Jonathan
