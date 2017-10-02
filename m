Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8DC020281
	for <e@80x24.org>; Mon,  2 Oct 2017 20:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbdJBUCR (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 16:02:17 -0400
Received: from siwi.pair.com ([209.68.5.199]:61209 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751055AbdJBUCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 16:02:16 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0343884632;
        Mon,  2 Oct 2017 16:02:11 -0400 (EDT)
Received: from [10.160.98.77] (unknown [167.220.148.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A9CD184631;
        Mon,  2 Oct 2017 16:02:10 -0400 (EDT)
Subject: Re: [idea] File history tracking hints
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.org>,
        Pavel Kretov <firegurafiku@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CAOZF3=Ouvk8ccME+fXr_T=GL1j4Gx3Hgj3ao_-GQng-noeOubg@mail.gmail.com>
 <E8C827ED458648F78F263F2F2712493B@PhilipOakley>
 <alpine.DEB.2.21.1.1709131322470.4132@virtualbox>
 <04DDB36236444FFD8C3668AA7B62B154@PhilipOakley>
 <alpine.DEB.2.21.1.1709300110350.40514@virtualbox>
 <5fb263a8-d83b-64a7-812f-fd8e3748feb6@jeffhostetler.com>
 <xmqqtvzjv987.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbghnWmvQweup=Z79HnVQQCMM65CKgEO3oqDoRp-Bj=2Q@mail.gmail.com>
 <ea1538e3-2b2e-f7eb-9c0e-e29c15bf2ea9@jeffhostetler.com>
 <CAGZ79kbjfXC3CxMDouUrCUVt-OJXckDtg9U_7=R=FM-eon4ikA@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <f9b722d9-cd37-40f3-7ae4-6f7f3d90de83@jeffhostetler.com>
Date:   Mon, 2 Oct 2017 16:02:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbjfXC3CxMDouUrCUVt-OJXckDtg9U_7=R=FM-eon4ikA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/2/2017 3:18 PM, Stefan Beller wrote:
> On Mon, Oct 2, 2017 at 11:51 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
> 
>> Sorry to re-re-...-re-stir up such an old topic.
>>
>> I wasn't really thinking about commit-to-commit hints.
>> I think these have lots of problems.  (If commit A->B does
>> "t/* -> tests/*" and commit B->C does "test/*.c -> xyx/*",
>> then you need a way to compute a transitive closure to see
>> the net-net hints for A->C.  I think that quickly spirals
>> out of control.)
> 
> I agree. Though as a human I can still look at
> A..C giving the hint that t/*.c and xyz/*.c ought to
> be taken into account for rename detection.
> (which is currently done with -M -C --find-copies-harder
> as a generic "there are renamed things", and not the very
> specific rule, that may be cheaper to examine compared to
> these generic rules)
> 
>> No, I was going in another direction.  For example, if a
>> tree-entry contains { file-guid, file-name, file-sha, ... }
>> then when diffing any 2 commits, you can match up files
>> (and folders) by their guids.  Renames pop out trivially when
>> their file-names don't match.  File moves pop out when the
>> file-guids appear in different trees.  Adds and deletes pop
>> out when file-guids don't have a peer. (I'm glossing over some
>> of the details, but you get the idea.)
> 
> How do you know when a guid needs adaption?

I'm not sure I know what you mean by "adaption".

> 
> (c.f. origin/jt/packmigrate)
> If a commit moves a function out of a file into a new file,
> the ideal version control could notice that the function
> was moved into a new file and still attribute the original
> authors by ignoring the move commit.

I think that's an orthogonal problem.  I could move a function
from one file to an existing file or to a new file it doesn't
matter.  Attributing those lines back to the original author
(rather than the mover) is a bit of a pipe dream IMHO.  And I
have to wonder if it is always the correct thing to do?  I can
see scenarios where you'd want the mover.

I guess there's nothing from stopping the "ideal VC system"
doing all this line-based analysis, but that shouldn't make
file renames expensive to detect (since that is the granularity
that people and most tools expect the system to work with).

> 
> Another series in flight could have modified that
> function slightly (fixed a bug), such that it's hard to
> reason about these things.
> 
> For guids I imagine the new file gets a new guid, such that
> tracking the function becomes harder?
> 

Yeah, I'm not thinking about tracking individual functions.

> 
>> To address Junio's
>> question, independently added files with the same name will
>> have 2 different file-guids.  We amend the merge rules to
>> handle this case and pick one of them (say, the one that
>> is sorts less than the other) as the winner and go on.
>> All-in-all the solution is not trivial (as there are a few
>> edge cases to deal with), but it better matches the (casual)
>> user's perception of what happened to their tree over time.
> 
> The GUID would be made up at creation time, I assume?
> Is there any input other than the file itself? (I assumed so
> initially, such that:
>    By having a GUID in the tree, we would divorce from the notion
>    of a "content addressable file system" quickly, as we both could
>    create the same tree locally (containing the same blobs) and
>    yet the trees would have different names due to having different
>    GUIDs in them
> ), which I'd find undesirable.

Right.  A real solution would store the guid data slightly
differently so we could preserve the existing SHA properties.
My example was more conceptual.

> 
>> It also doesn't require expensive code to sniff for renames
>> on every command (which doesn't scale on really large repos).
> 
> I wonder if the rename detection could be offloaded to a server
> (which scales) that provides a "hint file" to clients, such that the
> clients can then cheaply make use of these specific hints.
> 

I don't know.  Might be easier to add that computation to the
occasional client-side housekeeping (somewhat like the commit
generation number computation we keep talking about).

Thanks
Jeff
