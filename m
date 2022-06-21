Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEA9CCA473
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 18:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345270AbiFUS6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 14:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352868AbiFUS6i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 14:58:38 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA0FEBA
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 11:58:36 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id cw10so5712757ejb.3
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 11:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=eTz9woGWJqqqYrIiriqMc4De5ecuIBkMqQPNIeld8LA=;
        b=MrtdRX11c41Kbag/KXq1R6qQvUUXScoQi2Mcz2w7qrBE3rOahSSAahjveXnztNCHzx
         drqikTzWOixTGI/Cy8/QqeI1M8mnBlHOJ5qq/39ul1K306yX+tEgqor/KxIi/s7tvAhR
         iWlMwEo4Ooc798xdKiJR7ZClvGdUzTbmpBraBu6L7/Ak/VqlzUAUvjfLwbZxHMtmXtmS
         SipG1e1OPCZpvQxhTo5XZnhYt0aFKF2mdGBZuHQS/rcxiJ9/PMJpjjOC09pIsxZG5And
         HSBm9WrPM3WthGz8ymfNwqd3Lhb1H78fa4gWJ0yC7aEYHBXwl0JBg3KLuaq+6/mJVA9U
         jc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=eTz9woGWJqqqYrIiriqMc4De5ecuIBkMqQPNIeld8LA=;
        b=t+YL6luir9S2vQ0f+vSJjJhFQ4cTcoszIYgO8HuqnxAfOjUErbC0neV4Iv1PLUBntT
         Pho2xyDHmaRIy5xaYW7g1ba7EqilAj7oHanAJRpKkrpzlc2c7cNmBOKfiKXvrI8FHHSR
         K2QihVYgFkNyqC+eLEXb14mk/qBC6tnDyyoG13SV/NBoChNqudh0VSYsUtPg+QFv9/zx
         issB5jmu5GG9QlRLTpzPlu57pa2WkHq1PAJuU1SgI5Ka00r/nwBUuKlEDpG5X1Bgd4gF
         n5t5bdH4MjNSlMqdAsWVoMR9UvnSwoXdNqkC23BLxwP7mUWJJz+wsL43N9kNOAij6x6x
         8rMg==
X-Gm-Message-State: AJIora81yCs0sKQirp+dDF5Yotn56Wie89uZw5uQ/bFDNFE2kTh/42gZ
        KehPK48TxID1cDeo6H2WIt4=
X-Google-Smtp-Source: AGRyM1sW3U2YL6KW2kp/jv5atJ5g/YMMZ9ufLy71IiH1NCXCTHwUaWR5BojqAeyJcUxQF6/3tzTSxA==
X-Received: by 2002:a17:906:b53:b0:715:7d4a:dd74 with SMTP id v19-20020a1709060b5300b007157d4add74mr27292720ejg.90.1655837914854;
        Tue, 21 Jun 2022 11:58:34 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id n23-20020a170906089700b006f3ef214e13sm7770443eje.121.2022.06.21.11.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 11:58:34 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o3j57-000Vp1-Dh;
        Tue, 21 Jun 2022 20:58:33 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     rsbecker@nexbridge.com
Cc:     'Stephen Smith' <ischis2@cox.net>, 'git' <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: SHA-256 transition
Date:   Tue, 21 Jun 2022 20:14:47 +0200
References: <12011256.O9o76ZdvQC@thunderbird>
 <220621.86sfnyuvt0.gmgdl@evledraar.gmail.com>
 <011f01d88571$755df480$6019dd80$@nexbridge.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <011f01d88571$755df480$6019dd80$@nexbridge.com>
Message-ID: <220621.86o7ylvo6e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 21 2022, rsbecker@nexbridge.com wrote:

> On June 21, 2022 6:25 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>On Mon, Jun 20 2022, Stephen Smith wrote:
>>
>>> What is the current status of the SHA-1 to SHA-256 transition?   Is the
>>> transition far enough along that users should start changing over to
>>> the new format?
>>
>>Just my 0.02, not the official project line or anything:
>>
>>I wouldn't recommend that anyone use it for anything serious at the momen=
t, as
>>far as I can tell the only users (if any) are currently
>>(some) people work on git itself.
>>
>>The status of it is, I think it's fair to say, that it /should/ work 100%=
 (or at least
>>99.99%?) as far as git itself is concerned.
>>
>>I.e. you can "init" a SHA-256 repository, all our in-repo tooling etc. wi=
ll work with it.
>>We run full CI tests with a SHA-256 test suite, and it's passing.
>>
>>But the reason I'd still say "no" on the technical/UX side is:
>>
>> * The inter-op between SHA-256 and SHA-1 repositories is still
>>   nonexistent, except for a one-off import. I.e. we don't have any
>>   graceful way to migrate an existing repository.
>>
>> * For new repositories I think you'll probably want to eventually push
>>   it to one of the online git hosting providers, none of which (as far
>>   as I'm aware) support SHA-256 repos.
>>
>> * Even if not, any local git tooling that's not part of git.git is
>>   likely to break, often for trivial reasons like expecting SHA-1 sized
>>   hashes in the output, but if you start using it for your repositories
>>   and use such tools you're very likely to be the first person to run
>>   into bugs in those areas.
>>
>>But more importantly (and note that these views are definitely *not* shar=
ed by
>>some other project members, so take it with a grain of salt):
>>There just isn't any compelling selling point to migrate to SHA-256 in th=
e near or
>>foreseeable future for a given individual user of git.
>>
>>The reason we started the SHA-1 -> $newhash (it wasn't known that it woul=
d be
>>SHA-256 at the time) was in response to https://shattered.io; Although it=
 had
>>been discussed before, e.g. the thread starting at [1] in 2012.
>>
>>We've since migrated our default hash function from SHA-1 to SHA-1DC (exc=
ept
>>on vanilla OSX, see [2]). It's a variant SHA-1 that detects the SHAttered=
 attack
>>implemented by the same researchers. I'm not aware of a current viable SH=
A-1
>>collision against the variant of SHA-1 that we actually use these days.
>>
>>But even assuming for the sake of argument that we were using a much weak=
er
>>and easier to break hash (say MD4 or MD5) most users still wouldn't have =
much or
>>anything to worry about in practice.
>>
>>Discovering a hash collision is only the first step in attacking a Git re=
pository. This
>>aspect has been discussed many times on-list, but e.g. [3] is one such th=
read.
>>
>>The above is really *not* meant to poo-poo the whole notion of switching =
to a
>>new hash. We're making good progress on it, although I think the really h=
ard part
>>UX-wise is left (online migration).
>>
>>Likewise I'd be really surprised if given the progress of that work the a=
verage Git
>>user isn't going to be using not-SHA-1 with Git in 15-20 years, of it's e=
ven still
>>around at that time as a relevant VCS.
>>
>>But should even advanced git users be spending time on migrating their da=
ta at
>>this point?
>>
>>No, I don't think so given all of the above, and I really think we should=
 carefully
>>consider all of the trade-offs involved before recommending that the aver=
age
>>user of git migrate over.
>>
>>1.
>>https://lore.kernel.org/git/CA+EOSBncr=3D4a4d8n9xS4FNehyebpmX8JiUwCsXD47E
>>QDE+DiUQ@mail.gmail.com/
>>2. https://lore.kernel.org/git/cover-0.5-00000000000-20220422T094624Z-
>>avarab@gmail.com/
>>3. https://lore.kernel.org/git/CACBZZX65Kbp8N9X9UtBfJca7U1T0m-
>>VtKZeKM5q9mhyCR7dwGg@mail.gmail.com/
>>
>
> Adding my own 0.02, what some of us are facing is resistance to
> adopting git in our or client organizations because of the presence of
> SHA-1. There are organizations where SHA-1 is blanket banned across
> the board - regardless of its use. While it is sometimes possible to
> educate of out the situation, as above, and show that SHA-1 is not
> really vulnerable except as above, which arguably applies to any hash
> given enough computing power, and in in-flight communication scenarios
> and cryptographic use.  Getting around this blanket ban is a serious
> amount of work and I have very recently seen customers move to older
> much less functional (or useful) VCS platforms just because of SHA-1.

I'm not sure if we're talking past one another, or if you're just using
this thread to raise a tangental topic.

I understood the question to be closer to "is it ready for normal users,
and should we generally recommend it?". Not whether a fully functioning
and integrated into the wider ecosystem git SHA-256 would be useful to
anyone.

Clearly it would be useful to you, but for that question I'd think that
your experience here is one more datapoint in the "it's not really
ready" column.

I.e. if SHA-1 is a pain for you why not just use SHA-256? That's of
course rhetorical, you and I know why you and I are not using it, which
was I was trying to get across here.

> I also think the comment about git in 15-20 years is a bit concerning
> if we are making decisions on that basis. Having written code in the
> mid 1980s that is still alive and relevant today, once processes are
> put in place, customers are very reluctant to move. I expect git to
> continue to be relevant for a long time, particularly if it is
> actively maintained by a motivated team.

I meant that I hope to be using git with SHA-256 in my daily workflow
around that time, at least. I'd probably have been more optimistic in
2017, but it's now been around 5 years since SHAttered and well, here we
are. So big migrations of infrastructure-level software take time.

But even if you read that (which I didn't mean) that we couldn't expect
git to be around by then that probably also wouldn't be such a big
deal.

Plenty of people were fully invested in Subversion around 2003 or so,
and what system were those people using 15 years later in 2018 ? :)

I hope git has more staying power than that, but if it doesn't then it's
probably for the best, as whatever new system will replace it will be
worthwhile enough to justify the migration pain.

> IMO, the SHA-1 to SHA-256 (or other hash) migration should receive
> more attention, which I am willing to give, but I think it requires a
> deeper discussion.

I think the overall state at this point is more "requires work/patches"
than "requires [deeper] discussion". I.e. I think having some
bidirectional mapping of SHA-1<->SHA-256 (as discussed in the hash
transition doc) was up next, and hashing out all the UX issues around
that.

I'm not sure what the state of patches (if any) is that area.

> Arguably, if GitHub were to offer SHA-256 repos, I am 99% certain you
> will see much wider adoption.

I hope you're right, but I'm really not so certain myself.

Even if we and the wider ecosystem magically get 100% of the
technological aspect right I think there'll still be emergent pain from
any such transition that'll outweigh any gains for many existing repos.

E.g. if you'll need to store objects twice for existing clients and
maintain a mapping how is any hosting provider that charges you for
storage space for your repositories going to handle that?

And there'll inevitably be some time of confusion etc. as repositories
are migrated.

Anyone who's gone though e.g. a CVS->SVN->Git migration with a large
organization will know what I mean. A Git->Git migration will be less
painful, but probably never pain-free.

I think it says a lot that the people most concerned about this (and
this may just be my confirmation bias) seem the least familiar with how
any potential issues with SHA-1 might affect Git in particular.

Or, as in your case, people who are at the receiving end of "checklist
compliance" droids :)

Which (and I am partially serious) I wonder if it would help if we
officialy stated that we're simply not using SHA-1 anymore.

Which is the case both in the the mathematical sense
(sha1collisiondetection won't return the same outputs for the same
inputs as "real" SHA-1), and in the sense that actually matters.

I.e. at least part of the urgency with SHA-1 migrations is because of
SHAttered specifically, but not entirely, as it's thought that SHA-1
variants might have other future vulnerabilities.

But that last bit is an area where I'm way less comfortable giving
anybody advice on, so take that with an even bigger grain of salt.
