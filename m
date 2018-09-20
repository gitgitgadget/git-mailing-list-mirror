Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 836011F453
	for <e@80x24.org>; Thu, 20 Sep 2018 23:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeIUFOl (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 01:14:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36169 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeIUFOk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 01:14:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id e1-v6so11047487wrt.3
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 16:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=C26VbB1jzAKl1IK3yGSlgyZNvOfzCkery4g8e/auhr4=;
        b=hwWk369VMmIRPCi3mWYDauLQJ7TXdx4TaFhZjH8YfddHDaJ6CFjxqnMCNbquGALMth
         9S1mCu8BnpqteN1+m7joYDNFMjixV+HUsH0wTBBhrBqseDy3hI12z+t5dMq2v7AhsM3G
         Rp637LdvoBQSPBwg4zMc/FNHrRFSE48kw2JDCVf0BpIOxfDB8WMWxWK+MHsOqPLg9LUq
         LABEovFpqLL+XQyZ8Eg1YyWhOvkwt+ujvPFLr4zwmC2HavPFcV9sYPKRSvqppvmNZgl8
         kiaBsJ8WSq/XjkU3rosYZ4BdCmY7S3VGGCxl2bTsoFNEiifZ5/wNzwJlbe6X2NVPfjCn
         PpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=C26VbB1jzAKl1IK3yGSlgyZNvOfzCkery4g8e/auhr4=;
        b=gpQSblNuYnB3J3lHMUbFtEzexALQTbBdHoio6N4TAb9vRIINd4VRiBj1oP+efRBluG
         J2Clt8iJNsu/0I/q0hX84/EGv+cz+cKsDn0PtQ1GXKrwZ5Ntk1QIbENB3+vqshCCSh5C
         3m2PA6bBApiCU6D/ItiNFrbAbU3ifIzQ8mQzABwF0zrVB64shqz3RR17mK/iFkdXPIqa
         ngUkmzIMSCGawgfneWO63l6BxhWvgN6QJ4J2AnOMezuRg+yEeH5NI1c9ef/ZZU+Qm0eu
         g8PVfiftII/0+A846w/7ZY3XY2AI6SRf29hzYBi3byWotqeOn41WHqhYsugX+Ss7giZc
         tm6Q==
X-Gm-Message-State: ABuFfojhkLDtRgYAQ5Z2tuhO3VYq2rjHNKSgUejqV2/P1pJYWJN8rSPE
        fIX7R3M5bcrRNrnOhDeRMHs=
X-Google-Smtp-Source: ACcGV61u8UpvP4VFJVfEK5DUMj8HRpttHcEBHXk75MVzBNQXQy1jjPW6wZ+FdYd85LQy9yAyhJayEQ==
X-Received: by 2002:adf:c454:: with SMTP id a20-v6mr3593535wrg.20.1537486122768;
        Thu, 20 Sep 2018 16:28:42 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 14-v6sm7631605wmp.32.2018.09.20.16.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 16:28:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, matvore@google.com
Subject: Re: [PATCH] fetch: in partial clone, check presence of targets
References: <xmqqh8ijzyep.fsf@gitster-ct.c.googlers.com>
        <20180920221038.74193-1-jonathantanmy@google.com>
Date:   Thu, 20 Sep 2018 16:28:41 -0700
In-Reply-To: <20180920221038.74193-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 20 Sep 2018 15:10:38 -0700")
Message-ID: <xmqqy3bvycie.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> The hard part for me lies in how to communicate to future readers of the
> code that they cannot remove this section to simplify the code. We would
> need a more complicated comment, something like this:

That suggests two things.

 - Perhaps quickfetch() is misnamed.  It is to ensure "these exist,
   and are 'connected'"; renaming the helper to convey that would be
   sufficient to prevent future readers from removing the "these
   exist" check from it.

 - Perhaps check_connected() is also misnamed, if the above "these
   exist, and are 'connected'" is not a sufficient warning against
   removal of the "these exist" test, perhaps "check_connected()" is
   not telling the readers that things that are 'connected' do not
   have to exist.  What does being 'connected' mean in the world
   with "promised" objects anyway?  The designer of the feature
   should probably have a concise and clear answer.

>  /*
>   * Check if all wanted objects are present.

Here 'wanted' means... the tip that was directly requested must
exist, and in addition, anything that is reachable from it must
either exist locally or available from the lazy-clone source?  But
that is not quite it. Your definition of 'present' is fuzzy and mean
two different things---for the wanted tips, they must exist.  For
the objects that are required for these wanted tips to be well
formed, they do not have to exist but it is OK for them to be merely
promised.

Perhaps the comment for the quickfetch() function itself should say

/*
 * Ensure that the requested tips exist locally, and anything that is
 * reachable from them either exist locally or promised to be available.
 */

Adding a similar comment to check_connected() function is left as an
exercise, but I suspect it would be the latter half of the above
sentence.

It may be worth renaming both functions for clarity, as I mentioned
already.
