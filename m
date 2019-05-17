Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTTP_EXCESSIVE_ESCAPES,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 155761F461
	for <e@80x24.org>; Fri, 17 May 2019 13:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfEQNRr (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 09:17:47 -0400
Received: from resqmta-po-12v.sys.comcast.net ([96.114.154.171]:60352 "EHLO
        resqmta-po-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726628AbfEQNRr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 May 2019 09:17:47 -0400
Received: from resomta-po-16v.sys.comcast.net ([96.114.154.240])
        by resqmta-po-12v.sys.comcast.net with ESMTP
        id RcQlhnHDX83t0Rck5hxxSj; Fri, 17 May 2019 13:17:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1558099066;
        bh=LE7JdxU9aW0bYkL0jDTrqO0F+L+c1d8jMzPcVc6mQ7Y=;
        h=Received:Received:Content-Type:Mime-Version:Subject:From:Date:
         Message-Id:To;
        b=s09sR0OnrU9Q6D663VL/ZDCTkeO6jPmqqqpoZTwBhzB2j2Cx2tpKVSiktQ4XXfDd8
         CbmTG5sRqSFmuUTAjAZGWSPxoj3vJQ+L/6pJtIeNiKhEvGgewkm+7s5Pg8cYG0pEcN
         fsAnLj7/0vl9mD0Ws1gcehfMdDf5o+VhGCSPBoDCYz1DIcEYPHLigKgzRR2BiJldVL
         mQfAfy+SFdJzGO9IJA/Q0pbmoEVCCeuy7ILVEgUII3QdklngyCAi8SJd7C1manJ8Td
         ClB+31AAMRUdN2FHiT63Cy8Ubv/dWusialugE0dSnYL6dL8vO/gZmpMYM/tX4XAKTw
         nv7GifyHlWwyg==
Received: from [IPv6:2601:647:4b02:2491:e51e:524f:db07:1065] ([IPv6:2601:647:4b02:2491:e51e:524f:db07:1065])
        by resomta-po-16v.sys.comcast.net with ESMTPA
        id Rck4hZ1NGlqqqRck5hiLKJ; Fri, 17 May 2019 13:17:45 +0000
X-Xfinity-VMeta: sc=0;st=legit
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [RFC PATCH 3/3] list-objects-filter: implement composite filters
From:   Matthew DeVore <matvore@comcast.net>
In-Reply-To: <xmqqwoip3gp0.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 17 May 2019 06:17:43 -0700
Cc:     Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1E174CAA-BD57-400B-A83B-4AABFAFBC04B@comcast.net>
References: <20190514001610.GA136746@google.com>
 <cover.1558030802.git.matvore@google.com>
 <02a8c9b017d8df056d7e90aff907d6e0b5506467.1558030802.git.matvore@google.com>
 <xmqqwoip3gp0.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On May 16, 2019, at 8:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>=20
>> 	$ git rev-list --filter=3Dtree:2 --filter:blob:limit=3D32k
>=20
> Shouldn't the second one say "--filter=3Dblob:limit=3D32k" (i.e. the
> first colon should be an equal sign)?

That's right. Fixed locally.

>=20
>> Such usage is currently an error, so giving it a meaning is =
backwards-
>> compatible.
>=20
> Two minor comments. =20
>=20
> If combine means "must satisfy all of these", '+' is probably a poor
> choice (perhaps we want '&' instead).  Also, it seems to me that

I think I agree. & is more intuitive.

> having to worry about url encoding and parsing encoded data
> correctly and securely would be far more work than simply taking
> multiple command line parameters, accumulating them in a string
> list, and then at the end of command line parsing, building a
> combined filter out of all of them at once (a degenerate case may
> end up attempting to build a combined filter that combines a single
> filter), iow just biting the bullet and do the "potentially be
> improved" step from the beginning.

My intention actually is to support the repeated flag pretty soon, but I =
only want to write the code if there's agreement on my current approach.

My justification for the URL-encoding scheme is:

1. The combined filters will eventually have to travel over the wire.

2. The Git protocol will either have repeated "filter" lines or it will =
continue to use a single filter line with an encoding scheme.

3. Continuing to use a single filter line seemed the least disruptive =
considering both this codebase and Git clones like JGit. Other clones =
will likely fail saying "unknown filter combine:" or something like that =
until it gets implemented. A paranoid consideration is that clones and =
proprietary server implementations may currently allow the "filter" line =
to be silently overridden if it is repeated.

4. Assuming we *do* use a single filter line over the wire, it makes =
sense to allow the user to specify the raw filter line as well as have =
the more friendly UI of repeating --filter flags.

5. If we use repeated "filter" lines over the wire, and later start =
implementing a more complete DSL for specifying filters (see Mercurial's =
"revsets") the repeated-filter-line feature in the protocol may end up =
becoming deprecated and we will end up back-pedaling to allow =
integration of the "&" operator with whatever new operators we need.

(I very much doubt I will be the one implementing such a DSL for filters =
or resets, but I think it's a possibility)

> So why are we allowing %3A there that does not even have to be
> encoded?  Shouldn't it be an error?

We do have to require the combine operator (& or +) and % be encoded. =
For other operators, there are three options:

1. Allow anything to be encoded. I chose this because it's how I usually =
think of URL encoding working. For instance, if I go to =
https://public-inbox.org/git/?q=3Dcod%65+coverage in Chrome, the browser =
automatically decodes the %65 to an e in the address bar. Safari does =
not automatically decode, but the server apparently interprets the %65 =
as an e. I am not really attached to this choice.

2. Do not allow or require anything else to be encoded.

3. Require encoding of a couple of "reserved" characters that don't =
appear in filters now, and don't typically appear in UNIX path names. =
This would allow for expansion later. For instance, "~&%*+|(){}!\" plus =
the ASCII range [0, 0x20] and single and double quotes - do not allow =
encoding of anything else.

4. Same requirements as 3, but permit encoding of other arbitrary =
characters.

I kind of like 3 now that I've thought it out more.

>=20
> In any case, I am not quite convinced that we need to complicate the
> parameters with URLencoding, so I'd skip reviewing large part this
> patch that is about "decoding".

It's fine if we drop the encoding scheme. I intentionally tried to limit =
the amount of work I stacked on top of it until I got agreement. Please =
let me know if anything I've said changes your perspective.

>=20
> Once the combined filter definition is built in-core, the code that
> evaluates the intersection of all conditions seems to be written
> sanely to me.

Great! I actually did simplify it a bit since I sent the first roll-up.

Thanks.

