Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D89BC433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 15:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF2260E08
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 15:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbhJZPye (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 11:54:34 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:23065 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237121AbhJZPyS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 11:54:18 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mfOjw-0003o9-4H; Tue, 26 Oct 2021 16:51:52 +0100
Message-ID: <04ef1d38-8800-e260-b852-8ca86ef44d3c@iee.email>
Date:   Tue, 26 Oct 2021 16:51:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [Summit topic] The state of getting a reftable backend working in
 git.git
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110211148400.56@tvgsbejvaqbjf.bet>
 <CAFQ2z_NBOC5sDSL6AjCe-5mPVhU1B_guJEsHwVT3=AK1aAt8UA@mail.gmail.com>
 <211026.86wnm021ih.gmgdl@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <211026.86wnm021ih.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Han-Wen,

On 25/10/2021 23:09, Ævar Arnfjörð Bjarmason wrote:
> On Mon, Oct 25 2021, Han-Wen Nienhuys wrote:
>
>> On Thu, Oct 21, 2021 at 1:56 PM Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>> This session was led by Ævar Arnfjörð Bjarmason (on behalf of Han-Wen
>>> Nienhuys, the driving force behind the reftable patches, who did not
>>> attend the Summit). Supporting cast: Jonathan "jrnieder" Nieder, Johannes
>>> "Dscho" Schindelin, Philip Oakley, Jeff "Peff" King, and Junio Hamano.
>>>
>> Thanks Ævar for doing this. I wanted to be there, but I took a much
>> needed 2 week computer-less vacation .
> No problem, as is perhaps clear from the notes I had to hand-wave some
> questions away since I didn't know about those things.
>
>>> ..
>>>      9.  Reftable has a set of files that go together. May want debugging tool
>>>          to dump the content of a binary reftable file. But we can
>>>          incrementally add those
>>
>> The patch series includes a test-tool for dumping both individual
>> tables and a stack of tables. It's not super-polished, but it gets the
>> job done.
>>
>> $ touch a ; ~/vc/git/git add a; ~/vc/git/git commit -mx
>> ...
>>
>> $  ~/vc/git/bin-wrappers/test-tool  dump-reftable -t
>> .git/reftable/0x000000000002-0x000000000002-327b23c6.ref
>> ref{refs/heads/main(2) val 1 ab21c324503544acca84eb55f5ee7dce24b23e15}
>> log{HEAD(2) Han-Wen Nienhuys <hanwen@google.com> 1635188263 0200
>> 0000000000000000000000000000000000000000 =>
>> ab21c324503544acca84eb55f5ee7dce24b23e15
>>
>> commit (initial): x
>>
>> }
>> log{refs/heads/main(2) Han-Wen Nienhuys <hanwen@google.com> 1635188263 0200
>> 0000000000000000000000000000000000000000 =>
>> ab21c324503544acca84eb55f5ee7dce24b23e15
>>
>> commit (initial): x
>>
>> }
> Neat.
>
> From memory I think the more general concern Philip Oakley was also
> expressing (but maybe he'll chime in) could also be addressed by a tool
> that just un-reftable-ifies a repository.

I was remembering my early exploits with trying to understand Git and
all the web references tended to refer to the file system implementation
of refs, in a reverse-specification sort of way.

refs can be hard to comprehend especially when DWIMmery is also
involved, and the user hasn't yet fully understood all the git commands
that can affect and read refs

>
> I think such a thing would be useful, and I think we don't have that
> already. Isn't the files backend or reftable usage now an "init"-time
> setting.
>
> It would be useful if for no other reason than to give user who are
> looking at a repository that's weird somehow the ability to quickly
> migrate 100% away from reftable, to see if it has any impact on whatever
> they're seeing.

I remember the usefulness of the data_dumper when I was looking at the
early Git Visual Studio project generators and the like.

Having a similar dumper for the refs would be useful. I can see it being
split between a dumper for repos with just a few refs and one that can
cope with the thousands of refs scaling problem (some sort of selectivity?)
>
> I wanted to implement a "git unpack-refs" a while ago for "pack-refs",
> just to simulate some performance aspects of loose-refs without writing
> an ad-hoc "ref exploder" one-liner again.
>
> A migration tool would surely be pretty much that, no? I.e. we'd just
> create a .git/refs.migrate or whatever, then hold a lock on reftable,
> and in-place move .git/refs{.migrate,} (along with top-level files like
> HEAD et al, presumably...).

I could see an option that puts the exploded refs 'somewhere else' just
for inspection by a confused user...
>
> Maybe there's more complexity I'm not considering than just the *.lock
> dance in .git/*, but if not such a tool could also convert freely
> between the two backends, so you could try refable out in an existing
> checkout.
Philip
