Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 971EE1FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 19:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933168AbcFTTO2 (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 15:14:28 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35304 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374AbcFTTNu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 15:13:50 -0400
Received: by mail-qk0-f174.google.com with SMTP id c73so175477793qkg.2
        for <git@vger.kernel.org>; Mon, 20 Jun 2016 12:13:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dT3pRhgbkVEFcd/Z77Dem+vYOFla21nJfyqD9YeLj9M=;
        b=YJ4A5GqzWdkl0mj+NzgnvwyO88yTd/VCxlQxITPfM/DQqf0PnxjSMfoqzvABQ3Hlbr
         r7zT2QedvSo5QOjbIkoPHETCKUYhIxZ+otgkfs1Sv9cxNbdeGFA4TkW2LPe1s+2nWktz
         CnlOhuCLtvCPo3c27muGUWrEj1B5gTd0R3MljXiwk16mG6wAoVaotzs6WxqgOxTYe/3a
         Q1fwsvEZdIjk67jNY57y40JUo66seqNfNKIbNO3PD408tnTNAlH1nWr7lajiLhc+dsj3
         8KMkGfrGSfpzGrh6Rae/ag09iMbdtwLiPMjhFa3pj6nYvG+fKwzWT+h6dc95rzpL4kwv
         jl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dT3pRhgbkVEFcd/Z77Dem+vYOFla21nJfyqD9YeLj9M=;
        b=EeG3HNsJtNyIcJ+ouM5tUR275UI/v7+I5FkzWCdWTSV1A2KZPboZ6m2gbVWbpgpTqT
         o2wsfVHQWyvc/LnOIy1/eeQlOUbkp7E86QIym3+rQEVwL+2Q/oIY0wpR9S7BzIyDbZEI
         D1e/UZtJcLxZCgNSvcu86aRuF5FlG52Y6g5C+AuoHCcpWsDuKYmY0zEO7nNZaDyELNOM
         CjPR1Eemzi2mAQ5gLTNTvAdyJ2b9RmFr3dViP63Neb342FClG0CMBQYRqa+DnmZtgK5h
         O55bVz2FN/9K/eKD5phL47NKrtFSJkzZod9v1GwZ4Lkmnjs4LJsb3cacFn27+oDtEYIr
         s9uw==
X-Gm-Message-State: ALyK8tICyEE2ScJ8Pq+6FabsC96GnTqnxfFAjojMt2G+L8AEsyx5lwd0itITwaQW3hzol5uunQJRJIsJAP4YTPZ2
X-Received: by 10.55.10.147 with SMTP id 141mr24244856qkk.91.1466448367883;
 Mon, 20 Jun 2016 11:46:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.42.226 with HTTP; Mon, 20 Jun 2016 11:46:07 -0700 (PDT)
In-Reply-To: <CAM+g_NswH8fd8aFPEHfSLYnZWptNU2GX=xTWpehzjTJfJM_GfQ@mail.gmail.com>
References: <CAM+g_NswH8fd8aFPEHfSLYnZWptNU2GX=xTWpehzjTJfJM_GfQ@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 20 Jun 2016 11:46:07 -0700
Message-ID: <CAGZ79kZL-ZY_0hZx9uA-ObPvMiD+EWvJYQa+OfCeQe2RLOPECA@mail.gmail.com>
Subject: Re: unable to pull from remote if commit date is in the future
To:	Norbert Kiesel <nkiesel@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 20, 2016 at 11:41 AM, Norbert Kiesel <nkiesel@gmail.com> wrote:
> Hi,
>
> I'm following an upstream repo on github.  Today morning I saw a new
> commit there, but a `git pull` in my clone did not fetch it and
> instead said "Already up-to-date.".  On closer inspection, github
> reports commit time as 2152-06-19. The same project has some other
> commits with commit time in the future that were fetched.  My guess is
> that happened when those commits got a child with commit date in the
> past.

git-pull doesn't care about the commit/author date/time at all.

All it takes into consideration
is the graph structure of the commits on the local and the remote branch,
i.e. Are there any commits on the remote branch that are not part of the local
branch history?


>
> Is there any way to force git pulling that request?  (Perhaps I should
> try to tell git that it's really 2152?)

You need to see if that commit is part of the history of the
remote branch you pulled.

>
> For the record: the faulty commit is
> https://github.com/seandepagnier/weather_routing_pi/commit/23c07cc5d2be7ce68349f4b3719b6fa6fe90e0bf
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
