Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 471471F600
	for <e@80x24.org>; Sun, 23 Jul 2017 19:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751466AbdGWTXh (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 15:23:37 -0400
Received: from smtp33.i.mail.ru ([94.100.177.93]:58672 "EHLO smtp33.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751456AbdGWTXg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 15:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=list.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=1scPm6TREeDd739aJHQJLJu04Re4RhywCoBCr/3C2OU=;
        b=SCcnebJCpONQCZoPy84nGqge4XmbtW4mWxwKDccN5zzRCMDw0+Jq51O2Grg8GrLqnvF2Nx/Wth1Qn616beYICfbUdXblnaG8oh77kFApnHEJIpEw7lDvnkMam2uKq8FF9kc9XEC16NSGfz9WY3RlKKivs5wyH64ZN7Jk21oleXE=;
Received: by smtp33.i.mail.ru with esmtpa (envelope-from <stsp@list.ru>)
        id 1dZMTW-00042V-3p; Sun, 23 Jul 2017 22:23:34 +0300
Subject: Re: git gc seems to break --symbolic-full-name
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
References: <234492d7-7fd6-f847-8b85-010732ff43b6@list.ru>
 <xmqqbmodhb5h.fsf@gitster.mtv.corp.google.com>
 <223fa7c7-196d-e4fe-85b5-7d7cc576aa52@list.ru>
 <CA+P7+xrhLf9eS_KkxTmWZgQ+Ho8VN83GS-OvxmboZ=_iY4dY0g@mail.gmail.com>
From:   Stas Sergeev <stsp@list.ru>
Message-ID: <ed1ddfec-5782-d14b-6717-a1532efc0138@list.ru>
Date:   Sun, 23 Jul 2017 22:23:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CA+P7+xrhLf9eS_KkxTmWZgQ+Ho8VN83GS-OvxmboZ=_iY4dY0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
Authentication-Results: smtp33.i.mail.ru; auth=pass smtp.auth=stsp@list.ru smtp.mailfrom=stsp@list.ru
X-7FA49CB5: 0D63561A33F958A5D59ACFFF9D340267DB405DAF63ECEA6F9359964C814EBB62725E5C173C3A84C311BA4339981C382AB4AB110E430470DC6436AE5DD6441DC7C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0FD29CFF114C3378C93B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: F1845AB6CCC9920DF7838D61D4D05C421389D1DE49E1C1F665909428E46D896EF29DA5AF09CA8C991653177920737CA72999BEE114A20FF4278B2D54D4112F244F0A872F021F905956A8FB0C6EBA5FCCEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

23.07.2017 11:40, Jacob Keller пишет:
> On Fri, Jul 21, 2017 at 12:03 PM, Stas Sergeev <stsp@list.ru> wrote:
>> I wanted some kind of file to use it as a
>> build dependency for the files that needs
>> to be re-built when the head changes.
>> This works very well besides git gc.
>> What other method can be used as simply
>> as that? git show-ref does not seem to be
>> giving this.
> There's no real way to do this, and even prior to 2007 when the file
> always existed, there's no guarantee it's modification time is valid.
>
> I'd suggest you have a phony rule which you always run, that checks
> the ref, and sees if it's different from "last time" and then updates
> a different file if that's the case. Then the build can depend on the
> generated file, and you'd be able to figure it out.
OK, thanks, that looks quite simple too.
I will have to create the file by hands that
I expected git to already have, but it appears
not.

> What's the real goal for depending on when the ref changes?
So that when users fill in the bug report, I can
see at what revision have the bug happened. :)
While seemingly "just a debugging sugar", the
hard experience shows this to be exceptionally
useful.
I think even linux kernel does something like
this, and solves that task the hard way. For
example I can see a script at scripts/setlocalversion
whose output seems to go to
include/config/kernel.release and a lot of
logic in the toplevel makefile about this.
So not liking the fact that every project solves
this differently, I was trying to get the solution
directly from git. But I'll try otherwise.
