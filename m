Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E9DC47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 03:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2447B2082E
	for <git@archiver.kernel.org>; Mon, 11 May 2020 03:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHto9mg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgEKDpM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 23:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727824AbgEKDpL (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 May 2020 23:45:11 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB85C061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 20:45:11 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j21so3949366pgb.7
        for <git@vger.kernel.org>; Sun, 10 May 2020 20:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4sy983hk1YBI5OqS6QR4LIp1QEc6dEmJf7m4kQZ0DXg=;
        b=GHto9mg9/XNyjSwjMqh4DiszTRl0zo5qRSktL37Kmow6ZPgnumQs2qRKA1j/HG65r8
         L8HnXSjDREG3bWiO+gUOFs/0VESk+QssKTLQ332hOEgzmEWNYOKd38Xy8eOsstQZpgQy
         CAaguG+CCl2+4yCrTLKc2apvdaVuwRyBu08WzK/AAXptmSAPGK0HY8Pqam2b4ywHHa/m
         gz6ko3pivArpWMCOIs0HQjdXrZpVXFUmcHOS4ckAMsBeGoBGFeWbifx/Jb+BweGh8cL/
         VGkGzrip+3jIzlNTvrTiiyGCyA8kfPwY2UDO0Uyus/E/nsmmWaWZR1CNmuor5pKejeL5
         u9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4sy983hk1YBI5OqS6QR4LIp1QEc6dEmJf7m4kQZ0DXg=;
        b=aOLK/bheGUSshB6iCFGevpjik2mttFehvjOyVKRwidKrBErI9YDssFKRbesBeqGN7w
         nrq8LptuX+6KYtIheVTviNI1DtrocB8EqhFdcdMdh4RhG+lS3l5Eewu9zJVMo1igBMyh
         j6hf4OaCR6Bbjx9PChkLv2L0T7kH7TaOqt7AeC4JRrzitZ+nVePzVoVYaiDaPLEyyTzf
         4arTpLBr89zIQ0T8PWDyrOuwDyG5FmnXtUsUYby8Zkn+wpZq0vasLIGeyFK6IfIm0+RD
         5LEI5m7Z2NU2W/YGGNo5OufSBSx05iEZ/HrkpG54cn7/PBUX9gUbXCCjGQYaPGIqXtHu
         8LnA==
X-Gm-Message-State: AGi0PuahrtWp4nEuvQQTVULTVEZxJQPrkY2RxTtq83ZKwPr8/hp+N5Sa
        dDqAPhM8XER1EwI5STCaAh1EI0G7OW0F8w==
X-Google-Smtp-Source: APiQypKUSWkzntjggeJEi5wqB2C1M56mAnItDLv3MRi+cZgxZSVghVnoSg6SqzWHPfIgjvwvzsHMBQ==
X-Received: by 2002:a63:3206:: with SMTP id y6mr12766923pgy.68.1589168710667;
        Sun, 10 May 2020 20:45:10 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:80c:7df4:5080:2891:3f12:a884])
        by smtp.gmail.com with ESMTPSA id a136sm7998724pfa.99.2020.05.10.20.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 20:45:09 -0700 (PDT)
Date:   Mon, 11 May 2020 09:13:44 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org, jnareb@gmail.com, stolee@gmail.com
Subject: Re: [ANNOUNCE] GSoC 2020 Students and Projects
Message-ID: <20200511032932.GA1268@Abhishek-Arch>
References: <AM0PR04MB47710F0BED399BA85C5DEC89A5A00@AM0PR04MB4771.eurprd04.prod.outlook.com>
 <AM0PR04MB477183F214CD69F0A510BED9A5A00@AM0PR04MB4771.eurprd04.prod.outlook.com>
 <999d4480-7d72-3ca1-f3ba-e3b08c5089a6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <999d4480-7d72-3ca1-f3ba-e3b08c5089a6@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings everyone!

On Mon, May 11, 2020 at 12:21:08AM +0530, Kaartic Sivaraam wrote:
> Hi Philip,
> 
> You can find more details about the proposals in the the final draft which
> were sent to the mailing list. You can find the links to corresponding
> mailing list e-mails, inline.
> 
> On 10-05-2020 15:39, Matthias Aßhauer wrote:
> > Since my mail client mangled the previous mail badly I'm sending
> > it again with slight changes to hopefully prevent the mangling.
> > 
> > These modified links should be accessible without any login.
> > 
> > "Implement Generation Number v2" from Abhishek Kumar will be
> > co-mentored by Jakub Narebski and Derrick Stolee.
> > 
> > https://summerofcode.withgoogle.com/projects/#6140278689234944
> > 
> 
> https://lore.kernel.org/git/20200326101520.GA19326@Abhishek-Arch/

To add more to this:

Initially the project aimed to explore alternative methods to make
Git faster, such as using min-post labelling and more involved variants
like GRAIL [1], FERRARI [2].

After much discussion [3], implementing corrected commit date and
exploring alternatives were broken down to two different projects - with
the understanding that the exploration is closer to 'Research Experience
for Undergraduates' than a GSoC project.

However, I had been working on a proposal [4] on the exploration. I
describe the methods, talk about their characteristics such as memory
usage, preprocessing time, performance on positive and negative queries.

You should also refer to Dr. Jakub's resources at the end of SoC 2020
Ideas page [5]. I would recommend starting with the Dr. Jakub's slides
and 'Pruning Based on DFS Numbering'.

[1]: https://www.researchgate.net/publication/225756202_GRAIL_A_scalable_index_for_reachability_queries_in_very_large_graphs
[2]: https://arxiv.org/abs/1211.3375
[1]: https://lore.kernel.org/git/7d6a84c7-6b16-c2a9-11a1-3397422064d1@gmail.com/
[2]: https://github.com/abhishekkumar2718/GSoC20/blob/master/graph_labelling.md
[3]: https://git.github.io/SoC-2020-Ideas/

> 
> > "Unify ref-filter formats with other --pretty formats"
> > from Hariom Verma will be co-mentored by Heba Waly and
> > Christian Couder.
> > 
> > https://summerofcode.withgoogle.com/projects/#4593212745842688
> > 
> https://lore.kernel.org/git/CA+CkUQ966swTrR7D2vxgQ2ZA3E=Le=u8yvEAopOsphoCWGgDeg@mail.gmail.com/
> 
> > "Convert submodule to builtin" from Shourya Shukla will be
> > co-mentored by Kaartic Sivaraam and Christian Couder.
> > 
> > https://summerofcode.withgoogle.com/projects/#6451304047575040
> > 
> 
> https://lore.kernel.org/git/20200325185053.10274-1-shouryashukla.oo@gmail.com/
> 
> -- 
> Sivaraam

Regards
Abhishek
