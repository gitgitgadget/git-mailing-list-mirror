Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA36C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 14:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F57F2077C
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 14:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nexZ3/rA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388304AbgAXOFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:05:51 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:36831 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387412AbgAXOFu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 09:05:50 -0500
Received: by mail-qv1-f66.google.com with SMTP id m14so940263qvl.3
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 06:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GEOGZDjp4Ln5+N1rh5Y6q2MhIIXRAZhLWjo2cuS+ku4=;
        b=nexZ3/rAjL8oSdmeUzZ0gyIHZK5pDqKKUDYSuHsW6/OxdK9SXHbXPNJtz+FHyf54ho
         YBMorQqELZ2PdAUpe9qndQxcaAXDXeNKDP7iJYHH3e9YuEuFhNnJBBuLWGycMbrUaQaO
         b72C0BuycVIuC80c1IL8dmet3QrfnaYc8eJa5RqNdbzNVbvrl2lTCiP9Sz9B1jZhY2cA
         NoeQKWDQjCQQ2d3RsznRL+rsmg1am4rATdc0FBmylSXfKy4O+J7HuZ77zUrFfUsj5YD7
         sC88Xr7uD45nsqvU1rzdJnSQus2hNR0mx4Zbq2a38iELU5CVNM4IicvouJ04xxRXPjeu
         DBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GEOGZDjp4Ln5+N1rh5Y6q2MhIIXRAZhLWjo2cuS+ku4=;
        b=heOKxvwbhX4pXMIs3DKr4YMJGPQR5gPAI700SoRTuqGyGDGBBOZ1RmEJz88IsC83h9
         kQvf90FOMRbOKEMQxW5IVQk0y0790GBTg1nh/QFmY6xAFiIqftpD6pyBo4rJn/z3tgmy
         hoRVB0OpvBQXAUZoQiqHCWfzvRYKMS0Rp1Yi7vOId13rCUDrcAI0dAOP5hQvF0QH40MH
         myEtfwD2M9wF2zFea6dZ7+57YFbtduU5HeYT7FxF8mxBVQJSBWOjPgrsOz093Rhqe+T7
         apu2qX0DafwRkA2YrXIWTSVWwu4faTWvneSvUhMPlURQkW0g3DXm6CXCKIDah0vAWLFq
         8n0Q==
X-Gm-Message-State: APjAAAWbuJQHgU06WJD3lt5yYJQiSDayPmDXpiSJWDRHzRdRYTd/fU0d
        Hu8XkYjDZMno+/xEoNkBWL6IwEpeJdk=
X-Google-Smtp-Source: APXvYqzY4I4BrRsFd7MeH2wjTUeCdEzbkCMKQL0OuyJQtqazNWjSGwqhxOUpFwMQY3RvSC1CvnP/gA==
X-Received: by 2002:a0c:8204:: with SMTP id h4mr2865132qva.137.1579874749729;
        Fri, 24 Jan 2020 06:05:49 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:fdb6:49de:4189:c4f0? ([2001:4898:a800:1010:aeec:49de:4189:c4f0])
        by smtp.gmail.com with ESMTPSA id o17sm2423140qtj.80.2020.01.24.06.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 06:05:49 -0800 (PST)
Subject: Re: Misrendering of git 2.24 log --graph
To:     Jan Engelhardt <jengelh@inai.de>, git@vger.kernel.org,
        James Coglan <jcoglan@gmail.com>
References: <nycvar.YFH.7.76.2001232353220.26179@n3.vanv.qr>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b64e8fb7-1dd3-439f-6ab1-1b88c52879d1@gmail.com>
Date:   Fri, 24 Jan 2020 09:05:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.2001232353220.26179@n3.vanv.qr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/23/2020 6:12 PM, Jan Engelhardt wrote:
> Greetings.

Hello, Jan. Thanks for sending this report.

> I have observed git 2.24 outputting a garbage graph element for a 
> particular history. The issue does not appear in 2.25, but the 
> underlying bug may still be in there; it is just that _this particular 
> history_ does not expose it anymore due to the new, more compact tree 
> rendering that 2.25 seems to be shipping.

I initially thought you were right, as 2.25 did include some new
rendering, and we've already found and fixed a regression [1] and
a style issue [2].

[1] https://lore.kernel.org/git/pull.517.git.1578408947.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/pull.518.git.1578457675.gitgitgadget@gmail.com/

> Reproducer:
> 
> $ git clone git://github.com/jengelh/git-issue-20200123 gi

I needed to use "--mirror" in my clone to create local copies
of all the remote refs.

> $ cd gi; git log --oneline --graph --all --topo-order | head -n 74
> [...]
> | | * |   ba85ad93c Merge branch 'kc-8.7.x'
> | | |\ \  
> | |/ / /  

Interesting, since the compact graph output in 2.25 intentionally
wanted this merge to have the first edge go immediately to the left
(see my output below).

> | | | _   
> | | * 79106b731 doc: update 8.7.x news
> 
> See that underscore there in line 73. The connection between commit 
> 610d621dd and its parent 79106b731 is not properly connected (visually). 
> I think this should have been [diff notation follows]
> 
> -| | | _   
> +| | | /
> +| | |/
>  | | * 79106b731 doc: update 8.7.x news
> 
> or something along those lines (pun intended).

You are correct about the expected output here.

Here is something I noticed: this does not reproduce without a
commit-graph! That's likely because it changes the order of the
initial refs. Keep that in mind for anyone trying to repro this.

However, I see this output with 2.24.1:

| | | | * d95d49694 freebusy: add missing "else" in HrGetHumanReadableString
| | | |/  
| | |/|   
| | * |   ba85ad93c Merge branch 'kc-8.7.x'
| | |\ \  
| |/ / /  
| | | _   
| | * 79106b731 doc: update 8.7.x news

and this output in 2.25.0:

| | | | * d95d49694 freebusy: add missing "else" in HrGetHumanReadableString
| | | |/  
| | |/|   
| | * | ba85ad93c Merge branch 'kc-8.7.x'
| |/| | 
| | |/  
| | * 79106b731 doc: update 8.7.x news

And comparing v2.25.0 versus ds/graph-horizontal-edges has
no difference in output.

Is it possible that you are not running the version you think you are?

Thanks,
-Stolee

