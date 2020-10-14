Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF13C433E7
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 13:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C7B2076D
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 13:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uB80EpEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgJNNwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 09:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgJNNwm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 09:52:42 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E23C061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 06:52:41 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k25so5102480ioh.7
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 06:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2XM0s6obKeaOR/d007pGcAvgl3IkG6UMhClR5rBS54Y=;
        b=uB80EpEYsaU1jf9AQV1SUX85SZEpot6NVk78BcOqU8TH3Woj+GiWcBRpzNmT7i4SOV
         UBY8b7uEYIqrTV7WpnVe1euU3PlplehSzzmVDqRZbtUJs1POElkeFA4j6XTXw0o5rdqD
         4A6a9ns32YAVpJYS3Ir4Ik9ZXS6IooxNCpK8j6DZVereaeT72qC44ucuitDI7ODUM+MV
         MTBEKbs9BPKJBXq6egJXcN5hMiNAWjxZtKmwGG7tjyHmNha+s5ulOb5h8Jufujf3Xm4G
         igL+JPSCZloRgvyVrj/mzrHQxTMNR7je4QK77aXPVtb7tklngdGDf1L1+CeYUStERjOn
         GJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2XM0s6obKeaOR/d007pGcAvgl3IkG6UMhClR5rBS54Y=;
        b=ACI1aLsieDoRhnPega8xD1S2LmEoQqNlVg1b/HV4XnEqIwxQ/Vn0P2Dm0hCp78LGci
         a4jeSbGDu2NvcnwzLgGjyuTHps5bLO5VwRJSHxXlTwGuvnzf9laqm5G/5907tgXuh+/5
         5OKBvPcCT0kD8SK+4s1NEhFduJ6WKANUKDi5bJMf/j8BKAlndrJ+cQn4mY3AOBsuL9it
         BL/tL9PMHyoshciQlaYPXovzI3tFI9w5125ZW3hTQIzRx3SoeNBVB1fql+6AzjrIoU0n
         rGYNdTeDMXtwfilehJtEKpYCqSSuxvbrjdgoL2j3itLNIaV0Z1A/Sh+yqPR/3jrUYL04
         VhJw==
X-Gm-Message-State: AOAM531aY4J2e7MkvhD4N0ODrNblOP5W30z5VBFPWN8Scm/39HRa22rM
        /59hWtLueDqYlaa4oQhgAlqnSYBkYN9iJg==
X-Google-Smtp-Source: ABdhPJxga2YmO0V2pxWZVcc9lRZj61iu+TK2TAC7vr6igXevod0rYuYChaj9wFhN/pG3CIcL7Q0GrA==
X-Received: by 2002:a5d:904d:: with SMTP id v13mr2891903ioq.116.1602683561263;
        Wed, 14 Oct 2020 06:52:41 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id d26sm3651470ill.83.2020.10.14.06.52.39
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 14 Oct 2020 06:52:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 1/3] t: add lib-crlf-messages.sh for messages containing CRLF
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <CAPig+cR3gsqmyM9k1F4waBc8R5Tqj0thw2_7E8Sun-FGV8b1SQ@mail.gmail.com>
Date:   Wed, 14 Oct 2020 09:52:37 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>, Alex Henrie <alexhenrie24@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FA717D92-3798-44C0-8671-83596429C388@gmail.com>
References: <pull.576.v2.git.1583807093.gitgitgadget@gmail.com> <pull.576.v3.git.1602526169.gitgitgadget@gmail.com> <f17d182c3bf5e758490441801423cdb0da17060d.1602526169.git.gitgitgadget@gmail.com> <20201012224706.GA4318@flurp.local> <CC87B74C-5EC2-4129-82A5-2CD0C81188B9@gmail.com> <CAPig+cR3gsqmyM9k1F4waBc8R5Tqj0thw2_7E8Sun-FGV8b1SQ@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 14 oct. 2020 =C3=A0 09:45, Eric Sunshine <sunshine@sunshineco.com> =
a =C3=A9crit :
>=20
> On Wed, Oct 14, 2020 at 9:20 AM Philippe Blain
> <levraiphilippeblain@gmail.com> wrote:
>>> Le 12 oct. 2020 =C3=A0 18:47, Eric Sunshine =
<sunshine@sunshineco.com> a =C3=A9crit :
>>> This is somewhat onerous to digest and compose. Have you considered
>>> making it more automated and easier to read? Perhaps something like
>>> this:
>>>=20
>>>   create_crlf_ref () {
>>>       branch=3D$1
>>>       cat >.crlf-message-$branch.txt &&
>>>       sed -n "1,/^$/p" <.crlf-message-$branch.txt | sed "/^$/d" | =
append_cr >.crlf-subject-$branch.txt &&
>>>       sed -n "/^$/,\$p" <.crlf-message-$branch.txt | sed "1d" | =
append_cr >.crlf-body-$branch.txt &&
>>>       ...
>>>   }
>>>=20
>>>   create_crlf_refs () {
>>>       create_crlf_ref crlf <<-\EOF
>>>       Subject first line
>>>=20
>>>       Body first line
>>>       Body second line
>>>       EOF
>>>       ...
>>>   }
>>=20
>> I did not try to do that because I did not think of it.
>> However, I think it's clearer using printf, this way '\n' and '\r'
>> appear clearly on all platforms, whatever editor is in use
>> and whatever settings this editor is using to hide or not hide
>> control characters.
>=20
> Sorry, I'm not sure I understand what you are saying about editors and
> hiding or not hiding control characters. There are no hidden control
> characters in the example code I posted.
>=20
> The code I proposed is very explicit about using CRLF terminators. The
> here-doc fed to create_crlf_ref() contains only the normal LF, but
> then create_crlf_ref() explicitly converts those to CRLF by calling
> append_cr().

Sorry, I missed that. I'll try to see if I can make it simpler using
this approach then.=20

