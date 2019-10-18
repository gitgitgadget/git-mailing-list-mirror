Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C96A1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 06:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407672AbfJRGnu (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 02:43:50 -0400
Received: from mail12.gandi.net ([217.70.182.73]:41477 "EHLO gandi.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393594AbfJRGnt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 02:43:49 -0400
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Oct 2019 02:43:48 EDT
Received: from diconico07.dev (unknown [IPv6:2001:4b98:beef:a:e921:9c91:35ed:759a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by gandi.net (Postfix) with ESMTPSA id A11781602FD;
        Fri, 18 Oct 2019 06:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gandi.net; s=20190808;
        t=1571380457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jpi61/2s16j3fMtRfMj2xF4NuVyqdh4656NY34j9qBw=;
        b=SPPiFN+nP1KBYsIYmk+vIOht95Cx/oNJm0rrk9zrtSCBbrDaeHT9N6rOdh/dcMYOFYIC9e
        GMqfRhIz+DG2+i/FP0IUHyBNeWxWHeH2GAt7iSIiIsY10NtgT6ZbbW1NT4VWG1V71ix3x5
        fFGMVgRdw9v50NGTsTNv6pXL+AddYF2oxvRz5ZX6g3wdFSbZNI/+sudoqkIXG4myGeeVY+
        ZxXIvpAAHW4hMdiB+fqIU8DkUMGwbd7km1DW81Ke9JidW9LieCaIPAgy3hxTm+IbPQY8tk
        HwqjI93URS2jntDPKiBZukWPnJs68Aaxb6tw2Tpsshg4Z/+Tc16flbeB9m0zMQ==
Subject: Re: email as a bona fide git transport
To:     Willy Tarreau <w@1wt.eu>, Greg KH <greg@kroah.com>,
        Santiago Torres Arias <santiago@nyu.edu>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Eric Wong <e@80x24.org>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
 <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
 <20191017204343.GA1132188@kroah.com> <20191017204532.GA6446@chatter.i7.local>
 <20191018013029.GA1167832@kroah.com> <20191018015447.GB6446@chatter.i7.local>
 <20191018025215.GA15777@1wt.eu>
From:   Nicolas Belouin <nicolas.belouin@gandi.net>
Message-ID: <4ea21178-0cac-e958-7c69-ad5b4a74e6b5@gandi.net>
Date:   Fri, 18 Oct 2019 08:34:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018025215.GA15777@1wt.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/18/19 4:52 AM, Willy Tarreau wrote:
> On Thu, Oct 17, 2019 at 09:54:47PM -0400, Konstantin Ryabitsev wrote:
>> On Thu, Oct 17, 2019 at 06:30:29PM -0700, Greg KH wrote:
>>>> It could only possibly work if nobody ever adds their own
>>>> "Signed-Off-By" or
>>>> any other bylines. I expect this is a deal-breaker for most maintainers.
>>> Yeah it is :(
>>>
>>> But, if we could just have the signature on the code change, not the
>>> changelog text, that would help with that issue.
>> We totally should, and I even mused on how we would do that here:
>> https://public-inbox.org/git/20190910121324.GA6867@pure.paranoia.local/
>>
>> However, since git's PGP signatures are made for the content in the actual
>> commit record (tree hash, parent, author, commit message, etc), the only way
>> we could preserve them between the email and the git tree is if we never
>> modify any of that data. The SOB and other trailers would have to only be
>> applied to the merge commit, or migrate into commit notes.
> There's also the possibility to handle this a bit like we do when adding
> comments before the SOB: a PGP signature would apply to the text *before*
> it only. We could then have long chains of SOB, PGP, SOB, PGP etc.
>
> Willy

I don't think it can work that easily as the signed content is not just
the message.
It would need git to support nesting signatures and to allow amending a
commit without
touching the signature and to allow adding one to cover the new content
and to have a
way to verify every step.
Moreover you won't be able to reparent the commit as a maintainer (wich
I think is
also a deal-breaker)

Nicolas

