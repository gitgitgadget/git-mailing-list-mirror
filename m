Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702DAC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 12:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbhKWMYS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 07:24:18 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:60028 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231623AbhKWMYR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 07:24:17 -0500
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mpUnH-0005H0-44; Tue, 23 Nov 2021 12:21:08 +0000
Message-ID: <09cbc27d-8fdf-ed84-716f-23fd8dbb11de@iee.email>
Date:   Tue, 23 Nov 2021 12:21:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: git 2.34.0: Behavior of `**` in gitignore is different from
 previous versions.
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Danial Alihosseini <danial.alihosseini@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Git List <git@vger.kernel.org>
References: <CACLOEFZz7bunO2S5-ec1K10B9AJU4-m50j3j9c=12R6d1D+-dg@mail.gmail.com>
 <YZaHpJKeyDEY8qKW@coredump.intra.peff.net>
 <2bd2269f-c7f1-7afb-7052-48fac148dffd@gmail.com>
 <CACLOEFbY3LwMa2uhc=9jmcGFf0mvWzEM=YityLyFcuGWXVmqbw@mail.gmail.com>
 <72fffbff-16f7-fa17-b212-67aae9e1b034@gmail.com>
 <190a1fea-124d-2e85-38ea-9dab87f3e377@kdbg.org>
 <429375f7-ec3e-596f-5f79-c724570c8397@gmail.com>
 <CAPx1GveHusi8n8n03hUwBu6B3=_j0ZY6FWXWKDs8mLGwHEN-Qg@mail.gmail.com>
 <xmqq5ysmnxnx.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqq5ysmnxnx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/11/2021 00:46, Junio C Hamano wrote:
> Chris Torek <chris.torek@gmail.com> writes:
>
>> ...  So the standard
>> explanation -- at least, the one I use -- is this:
>>
>>  * Git opens and reads the working tree directory.  For each file
>>    or directory that is actually present here, Git checks it
>>    against the ignore rules.  Some rules match only directories
>>    and others match both directories and files.  Some rules say
>>    "do ignore" and some say "do not ignore".
>>
>>  * The *last* applicable rule wins.
>>
>>  * If this is a file and the file is ignored, it's ignored.
>>    Unless, that is, it's in the index already, because then it's
>>    tracked and can't be ignored.
>>
>>  * If this is a directory and the directory is ignored, it's
>>    not even opened and read.  It's not in the index because
>>    directories are never in the index (at least nominally).
>>    If it is opened and read, the entire set of rules here
>>    apply recursively.
>>
>> This works, but skips over files that are in the index and are in
>> a directory that won't be read.  So I add one last rule, which is
> All of the above is sensible.  If you deal with a path that is in
> the index upfront, you can simplify the later rules somewhat, I
> would think.  I.e. add a first rule before everything else that
> says:
>
>  * A file in the index is not ignored.  Everything below is about a
>    path not in the index.
>
> Then your third rule can lose "Unless...", and you do not have to
> add one last rule outside the bulleted list, either.
>
> ;-)
>
Perhaps, the clarifications are an opportunity to improve the
documentation, should the Danial think that the explanation would have
helped. The 'ignore' matching rules does appear to show up quite often
on the list.

Any thoughts, Danial?

Philip
