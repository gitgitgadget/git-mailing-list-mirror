Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CBEC43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB92921941
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgIPU4c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:56:32 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:53120 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbgIPQwk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 12:52:40 -0400
Received: from host-89-241-187-35.as13285.net ([89.241.187.35] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1kIZAj-0005UC-7e; Wed, 16 Sep 2020 16:16:37 +0100
Subject: Re: Git in Outreachy?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <CAP8UFD2rpNhDhyHdQNxS-KJZgcumsCpK_JQ5koCqXJd70s-+_w@mail.gmail.com>
 <20200903060041.GH4035286@google.com>
 <a3613b9d-730a-7a4b-c84b-c833490fcea6@iee.email>
 <nycvar.QRO.7.76.6.2009060933480.56@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <5be2fca8-2dbd-115e-b3bb-5783daeba4a3@iee.email>
Date:   Wed, 16 Sep 2020 16:16:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2009060933480.56@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Sorry I've not been able to attend to the list discussions recently.

On 07/09/2020 19:49, Johannes Schindelin wrote:
> Hi Philip,
>
> On Fri, 4 Sep 2020, Philip Oakley wrote:
>
>> On 03/09/2020 07:00, Jonathan Nieder wrote:
>>> Christian Couder wrote:
>>>
>>>> I would appreciate help to find project ideas though. Are there still
>>>> scripts that are worth converting to C (excluding git-bisect.sh and
>>>> git-submodule.sh that are still worked on)? Are there worthy
>>>> refactorings or improvements that we could propose as projects?
>>> I think setting up something like snowpatch[*] to run CI on patches
>>> that have hit the mailing list but not yet hit "seen" might be a good
>>> project for an interested applicant (and I'd be interested in
>>> co-mentoring if we find a taker).
>>>
>>> Some other topics that could be interesting:
>>> - better support for handling people's name changing
>>> - making signing features such as signed push easier to use (for
>>>   example by allowing signing with SSH keys to simplify PKI) and more
>>>   useful (for example by standardizing a way to publish signed push
>>>   logs in Git)
>>> - protocol: sharing notes and branch descriptions
>>> - formats: on-disk reverse idx
>>> - obliterate
>>> - cache server to take advantage of multiple promisors+packfile URIs
>>>
>>> Jonathan
>>>
>>> [*] https://github.com/ruscur/snowpatch
>> A suggestion with high value for the Windows community
>> - mechanism to map file names between the index and the local FS, should
>> a repos file/path name already be taken, or invalid. [1]
> This suggestion keeps coming up, but I cannot help but highly doubt that
> it will prove useful in practice: if your source code contains a file
> called `aux.c`, chances are that your build system lists this file
> specifically, and it won't do at all to "magically" rename it to, say,
> `aux_.c` during checkout.

I'd disagree with that line of reasoning in the sense that if someone is
on Windows wanting to 'view' a repo that was developed on Linux, with
colons in pathnames, and filenames like aux.c we shouldn't be
deliberately de-include them just because of those file/pathname
'accidents. I accept that the build system probably won't be working for
their Windows environment (how could it be?), but, if possible, we
should be able to support them, in some positive way. In our distributed
collaborative environment we can trip over the user's  'your file / your
build' tag.

> In contrast, I think a much more useful project would be to relax the
> `core.protectNTFS` protections to cover only the files that will be
> written to disk, and not bother even checking the files excluded from a
> sparse-checkout for invalid file names on NTFS.

That's a valid base method for all the NTFS valid file and path names.

The next level could be a mechanism for path and file name adjustment,
at least for a _copy-out_ step (without ability to 'git add' / check
back in).
>
> This is trickier, of course, than meets the eye: we would still want to be
> _very_ careful to ensure that the unchecked file names will _never_ make
> it to the disk. And, slightly related, the question whether checking for
> `.git` (or `GIT~1`) would be likewise weakened, or whether that is too
> dangerous to allow even in `skip-worktree` entries.

Agree that the security aspects of `.Git` etc must still be retained.
>
> Not necessarily decisions you would want to burden a first-time
> contributor with.

True, but still worth recording as a useful Git project (and that there
are a number of nuances within it!)

--
Philip

> Ciao,
> Dscho
>
>> Philip
>>
>> [1]
>> https://github.com/git-for-windows/git/issues/2803#issuecomment-687161483
>>

