Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF5CE202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 13:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbdJCNYZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 09:24:25 -0400
Received: from pmta2.delivery5.ore.mailhop.org ([54.186.218.12]:60154 "EHLO
        pmta2.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751868AbdJCNYY (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 3 Oct 2017 09:24:24 -0400
X-Greylist: delayed 963 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Oct 2017 09:24:24 EDT
X-MHO-User: db8eaced-a83b-11e7-b50b-53dc5ecda239
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 74.98.178.3
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [74.98.178.3])
        by outbound2.ore.mailhop.org (Halon) with ESMTPSA
        id db8eaced-a83b-11e7-b50b-53dc5ecda239;
        Tue, 03 Oct 2017 13:07:51 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id DA72D8010C;
        Tue,  3 Oct 2017 13:08:14 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io DA72D8010C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1507036095;
        bh=nJy4OsF7atex3Y/3vSA08YRa4wNF5HXjrSXOtbxS3DM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Gw5yMc3IGmMO01RoyJ4e5qa0RxDU8L9/+sb/t+Z58aZKYZMycSlClHFPlJEnaVOPG
         Vdfz7mJs3w6ljIHouEUiTXuhrlsREP50h+s9Hr0fO2eIXhXtpxSVDg0uKDHm+7Zm30
         B6t5/suxU8jDkaOLf8yxhsGrCHndxm+4QauRoWdZhxowET3nckOyF4gj3oDBljpHaN
         goc6MTXHO4i0YEOuECrcvwovS3IFOmYkUxYFWmWtog634M6Jq6xDSzwEoJjRk0fpt4
         iYGwzqvkvshEJBjpGO7y6Tiv7hQOd9cs8z1f+ROhiRclp8+EvQJdonBSyD8rASCvNz
         yG/7YHqressAw==
Date:   Tue, 3 Oct 2017 13:08:14 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Shawn Pearce <spearce@spearce.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Masaya Suzuki <masayasuzuki@google.com>, demerphq@gmail.com,
        The Keccak Team <keccak@noekeon.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] technical doc: add a design doc for hash function
 transition
Message-ID: <20171003130814.GJ31762@io.lakedaemon.net>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com>
 <20170928044320.GA84719@aiede.mtv.corp.google.com>
 <xmqqbmlokcvp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbmlokcvp.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2017 at 02:40:26PM +0900, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
...
> > +Meaning of signatures
> > +~~~~~~~~~~~~~~~~~~~~~
> > +The signed payload for signed commits and tags does not explicitly
> > +name the hash used to identify objects. If some day Git adopts a new
> > +hash function with the same length as the current SHA-1 (40
> > +hexadecimal digit) or NewHash (64 hexadecimal digit) objects then the
> > +intent behind the PGP signed payload in an object signature is
> > +unclear:
> > +
> > +	object e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7
> > +	type commit
> > +	tag v2.12.0
> > +	tagger Junio C Hamano <gitster@pobox.com> 1487962205 -0800
> > +
> > +	Git 2.12
> > +
> > +Does this mean Git v2.12.0 is the commit with sha1-name
> > +e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7 or the commit with
> > +new-40-digit-hash-name e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7?
> > +
> > +Fortunately NewHash and SHA-1 have different lengths. If Git starts
> > +using another hash with the same length to name objects, then it will
> > +need to change the format of signed payloads using that hash to
> > +address this issue.
> 
> This is not just signatures, is it?  The reference to parent commits
> and its tree in a commit object would also have ambiguity between
> SHA-1 and new-40-digit-hash.  And the "no mixed repository" rule
> resolved that for us---isn't that sufficient for the signed tag (or
> commit), too?  If such a signed-tag appears in a SHA-1 content of a
> tag, then the "object" reference is made with SHA-1.  If the tag is
> in NewHash40 content, "object" reference is made with NewHash40, no?

I do hope we adhere to "no mixed repository" rule.  Or, at least, "no
mixing of hash types".  Ambiguity opens cracks for uncertainty to creep
in.

For our case, where we counter-hash the sha1 commits, and counter-sign
the sha1-based signatures, we intend to include the relevant
sha1<->newhash lookups in the newhash signature body.  afaict, the git
sha1<->newhash table is not cryptographically secured underneath
signatures, and thus can't be used in the verification of objects.

The advantage to this approach is that we can be as explicit as
necessary with "SHA-1 -> SHA-512/256" or "SHA-1 -> SHA3-256" in the body
of the message.

thx,

Jason.
