Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456CFC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 19:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B5C060EE4
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 19:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhHTTwd convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 20 Aug 2021 15:52:33 -0400
Received: from elephants.elehost.com ([216.66.27.132]:55251 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhHTTwc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 15:52:32 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 17KJpcnO077333
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 20 Aug 2021 15:51:38 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Jonathon Anderson'" <janderson@acesquality.com>
Cc:     "'Jeff King'" <peff@peff.net>, <git@vger.kernel.org>
References: <CAG83euoGmVUUBh00wAEX1muZogNPOQUV6+ppL8x8qCaDnzTbDw@mail.gmail.com> <010f01d79525$f10a1f60$d31e5e20$@nexbridge.com> <CAG83euo2B4QFU_S6Yqd3UACWq63p=L+T30CwzT52D8H=S5pRVg@mail.gmail.com> <YR/tyHWQ6+2sP2iA@coredump.intra.peff.net> <CAG83euofNXHx8-=7Obj-Ju5U_fjwNBuLVJjmccVhe9bqRFyBiw@mail.gmail.com> <YR//IDB9ml5RO2H6@camp.crustytoothpaste.net>
In-Reply-To: <YR//IDB9ml5RO2H6@camp.crustytoothpaste.net>
Subject: RE: Git Modifying DLL
Date:   Fri, 20 Aug 2021 15:51:33 -0400
Message-ID: <01a101d795fc$ca46e520$5ed4af60$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFiQNuw5Jq9CnWXA2eVMek+endVOwFWDeafAjcgDiUBGAsJTAF+crAiAhkmgEysJZAxAA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 20, 2021 3:15 PM, brian m. carlson wrote:
>On 2021-08-20 at 18:47:02, Jonathon Anderson wrote:
>> On Fri, Aug 20, 2021 at 1:00 PM Jeff King <peff@peff.net> wrote:
>> >
>> > On Thu, Aug 19, 2021 at 01:21:03PM -0500, Jonathon Anderson wrote:
>> >
>> > > I had not. I tested that and it worked. I assumed that git would
>> > > automatically treat dll files as binary. Thanks for the help!
>> >
>> > Git doesn't know about any file extensions by default. Its default
>> > "is it binary" test looks for NUL bytes in the first 8k or so of the file.
>> > I'd expect your DLL would probably have such a NUL byte.
>> >
>> > Is it possible you have other .gitattributes set which are confusing
>> > things?
>> >
>> > You might try:
>> >
>> >   git check-attr --all <path>
>> >
>> > or:
>> >
>> >   git ls-files --stdin | git check-attr --stdin --all
>> >
>> > -Peff
>>
>> When I remove '*.dll binary" from .gitattributes, I get this:
>>
>> $ git check-attr --all ./PSWindowsUpdate.dll
>> ./PSWindowsUpdate.dll: text: set
>> ./PSWindowsUpdate.dll: eol: lf
>
>Yes, this is definitely not correct.  The flag "text" being set tells Git to do line-ending conversion and "eol=lf" says to convert line endings
>into LF.
>
>You should look for things in your .gitattributes file that say something like "* text", which you probably don't want.  You could use
>"* text=auto", which should be fine for most cases, though.  It's also possible those aren't in a .gitattributes file in your repository but one
>elsewhere on your system.  You can check gitattributes(5) for the locations of other files that can affect it.
>
>As a note, it is best practice not to check binary dependencies or build artifacts into the repo.  Those are best stored elsewhere, such as an
>artifact server.

OT: Unless you are using git as an artifact repository to retain the dependency relationship between objects and the source commits that built them for PCI and SWIFT compliance. git is exceptional when it comes to evidence-of-origin forensics of specific installation artifacts when release structures are more complex than "deploy everything" use cases. But that may be a discussion we can have elsewhere.

Just my $20.00.
-Randall

