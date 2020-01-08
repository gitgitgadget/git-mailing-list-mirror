Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A803C00523
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 10:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4264320692
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 10:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KKY4wufV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgAHK7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:59:51 -0500
Received: from mout.gmx.net ([212.227.15.19]:41487 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgAHK7u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 05:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578481184;
        bh=WvrUWehSigUYcE3SplALISJt/U8r21gxvfVyqf5TAOI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KKY4wufVnVxdVrNrKR/JKgE13XRb22t5htgin+MBYzYWHyhYO5U7nnJquhPPDwINJ
         QY5DpMj+2Nwr3AHEdKMrpSUaKKINapNdBHua2b+xvhs+LMLZOeoRsgsONP77SdutCZ
         zkF7tJD5NtHorlNZ2Cy1kVmVi45SuXBeKfEymkac=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPGW7-1j3E6v2avF-00Pc1E; Wed, 08
 Jan 2020 11:59:44 +0100
Date:   Wed, 8 Jan 2020 11:59:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Liam Huang via GitGitGadget <gitgitgadget@gmail.com>,
        Liam Huang <liamhuang0205@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/1] Update imap-send.c, fix incompatibilities with
 OpenSSL 1.1.x
In-Reply-To: <xmqqtv573twq.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2001081148300.46@tvgsbejvaqbjf.bet>
References: <pull.516.git.1578391376.gitgitgadget@gmail.com>        <nycvar.QRO.7.76.6.2001071313580.46@tvgsbejvaqbjf.bet>        <xmqqv9pn5hgl.fsf@gitster-ct.c.googlers.com>        <nycvar.QRO.7.76.6.2001071944250.46@tvgsbejvaqbjf.bet>       
 <xmqq7e2359an.fsf@gitster-ct.c.googlers.com> <xmqqtv573twq.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6NSjVZZAMEQL/9yaAbxw8nO1NkP6tVQ9gOsgyw0mrWQuiv/0nC3
 LZbJK7Ax9ZBYIoxueprilqAekVjdVMYtbtOc0+sMGCA4+MUJ1tVMFFNTpmFM5MoSWFollrn
 b6LObmI3IALb2w/kjvDWHD86A4gN+2HRIFeT4vKN/noTE018d3ujsHqU697rh8/9khVDoH5
 i+xYDV+ZCN1F6iqdpV4bg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R8boveG16Ec=:sip8cyguJ9GBdDGTMxeucJ
 oQfXhLQb78WHFo4TzsohppHA6UE0+lEN24y6X6Cr7TdQvprYwoB//Y3dsnF0fjw6nLyXemgOo
 ID6OHJHoIZJp1ZT8WNd6GH335zy3wahYXjsI6VYNvIp9EK1FdHxkWKzwF2JU1ZjcJP9ixaFFc
 xOCtKu5FrvZuT573DADYrPhw3mVxvhnoH4XBdWNXw6lWeIDfqe5YJFGkRuOYr/aj7qXxQS8oZ
 dSkwrWiqC3b2bn6FQ9wj5DebhcYPdXPzoAqfoDBLgZ5lnUpm33aA0NTtZedUv0Edfazujii+r
 o36q4Qbf5zddOXGAKjhtAklFhQCODIVlW8u3CfXCFA18OyvBhh43zd1+Q0Grc7dOMqeYWoBSV
 UIuOO5waGLxtuUaLeQzOUZpzMncb+X7H9BpkmQLp6FFJm51WtACT569kqH7QXf9vLuUKHE86G
 icoDKurGMD5t+P0l/ZidTL1/f4gwWJl9T1NWRphI7Veds1raudoUXXSuWmKKUAUaCZ4yOf7jQ
 WGWDM5bncL4wkuvqyoRNtUauNI2MYnINFJt/LCjW1NbHxYUq+eG5dzL/UoDHXp8hRH/0hEWxr
 QIi+Y5MmPkQgtNCg/l+NZSwoMEGR4KOZ/O8dm9rTZcveGFAPBxn4/NH1ebfeDsDpPaZsNmrgJ
 fl0rT8acEjGfWG0+KwGQsqmGA5xtnWRSGjWGlmw/Ixx3lpHrfJkS1Sb4UGmp4PTLatEgqEWqq
 9QrkG6kBmniXMAf6Y5LIGMDY36pPND3pya3YpADa8d4ICBB1YrdT4FhqQBARoAkDuCijQzHmd
 e6LpIjSud4CH/ivzEY2a8DlmQSW0vG4ZQDBrjE2yygudtWJw5/TcHUKMCUWJvUD6HAaBo8muE
 0i+1D6i8hxf84kRlJ9vsocoGfgUkbHcBkfrbbW+SnP/YvBeVuFkUZGx8MYtKmeGx4oqqX9+e/
 bed1KDKnRRXQCCu3iN6oDxMZul1TKMzG23aZG3iIG/K/1NqAHaNcBmQ/lpzjGX9/eyM7IKCBo
 SWscZrtGY5Nuer7vOHrBy+eQourVfuHFQiB9lNpe+5b5A7eDjJdX0NDtTyO94hfCft1w7M5+u
 6Hstjsh7JPEGGzWq4q58PzexxRyCamem+D/0Gc/qLSVzsNwwJRsVmkpenZcxrwS91uZPYkC7O
 6CnTgLWH8YQs7PTGkO0AwgUs41BFEhnsrEHnyUbZZjVxp7GQz8hblBZ0jdh/4RE9vaZ7ZySmM
 pUk3hVzTE42OFytB6PURp+1tuBz6q45bUJCZ5kmQ35C5Ft1H5F1BPUckEadc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I will change GitGitGadget to no longer Cc: you automatically.

Please register my suspicion that this will make GitGitGadget a lot less
useful: the stated mission of GitGitGadget is to make contributing patches
to the Git project _easier_ so that the contributor can focus on the
changes they want to make, rather than on the rather involved process.

I know, you do not find any fault with the current process; it works for
you. It just does not work all that well for many other people, myself
included. The sheer amount of mostly unwritten, and not exactly static
rules contributors are expected to follow are starting to remind me of
Kafka's "The Trial".

On Tue, 7 Jan 2020, Junio C Hamano wrote:

> Besides, when they send out patches they would also add area experts and
> those who participated in the review of the earlier round to Cc: so GGG
> needs to have a mechanism to allow the end user to do so.

So GitGitGadget should now also learn to determine who the current area
experts are???

I must have misread your request.

> And by treating the maintainer merely just one of the reviewer, that
> mechanism can naturally be reused.

Well, I certainly do not treat you as just one of the reviewers, as your
complaints definitely keep me on my tip toes with regards to GitGitGadget.

I do have to remind myself frequently that only two people ever complained
about GitGitGadget, literally everybody else who is using GitGitGadget is
quite happy. So maybe I should listen more to those positive voices.
Actually, now that I wrote it, I think that is the only sane course of
action here: listen more to positive voices.

Ciao,
Dscho

