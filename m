Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82C4C433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 21:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D49212CC
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 21:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgFZVdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:33:18 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:12141 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgFZVdS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 17:33:18 -0400
Received: from host-92-20-155-32.as13285.net ([92.20.155.32] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jovyF-0004PT-Fn; Fri, 26 Jun 2020 22:33:16 +0100
Subject: Re: Regarding Git and Branch Naming
To:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>
Cc:     Craig H Maynard <chmaynard@me.com>, git@vger.kernel.org
References: <B4814F42-7AF8-4D80-93D4-FAF752C72F21@me.com>
 <CAPx1GvcZk2o7f8-27xokwxUayWwO+t5qdsMjLrjBymc+WHznmw@mail.gmail.com>
 <20200626203539.GA1173768@coredump.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <6b9d76e4-68dd-8e57-f96a-318579dea6f3@iee.email>
Date:   Fri, 26 Jun 2020 22:33:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200626203539.GA1173768@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/06/2020 21:35, Jeff King wrote:
> On Fri, Jun 26, 2020 at 11:33:53AM -0700, Chris Torek wrote:
>
>> On Fri, Jun 26, 2020 at 10:19 AM Craig H Maynard <chmaynard@me.com> wrote:
>>> Does the git init command really need to create a default branch? Perhaps that step could be left to the user.
>> The HEAD pseudo-ref must exist and must contain a valid OID or
>> branch name.  (If it does not exist, Git says that the directory
>> is not a repository.  Perhaps this test could be weakened, but
>> that's definitely a fairly big change.)
>>
>> In a new, empty repository there are no valid OIDs, so HEAD must
>> contain a branch name.  The branch itself need not exist, but
>> whatever name is in HEAD is the branch that will be created
>> when the user makes the first commit.
> We definitely _could_ extend HEAD to allow a "not pointing at anything"
> state. Presumably for reading that would behave like the "pointing at a
> branch that doesn't exist yet" case. But I think the experience it
> creates for writing is not very good. I.e., I think the best we could do
> is something like:
>
>   $ git init
>   $ git add some-files
>   $ git commit -m whatever
>   fatal: HEAD does not point to any branch
>   hint: use "git checkout -b <branch>" to make commits on <branch>
>
> Perhaps that's not _too_ bad, but it feels a bit unfriendly (and
> definitely more likely to cause backwards compatibility issues than
> picking _some_ default name). There would also be a lot of corner cases
> to cover and debug (e.g., "git checkout foo" moving away from the "no
> branch" state should make the usual complaints if we'd have to overwrite
> or modify index and untracked files).
>
>
A wild bikeshed question: Is HEAD itself protected as a branch name e.g.
that HEAD could contain `ref: HEAD` or `ref: refs/heads/HEAD`? (or maybe
the null  oid

It sort of feels that we may already have some sort of protection for
the first self reference - i.e. exists, but not defined (self-reference).

Philip
