Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD3B51F462
	for <e@80x24.org>; Mon, 27 May 2019 15:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfE0PkD (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 11:40:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61109 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfE0PkD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 11:40:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F28713F397;
        Mon, 27 May 2019 11:39:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9sDE2dodoZFO
        Eve5TaqRjuw4g+k=; b=pbqSdnuBuHyQCi85vnKPCBzqkOAiQ7uwE93N1Q46Dg+Y
        MCug1BeI8/W8MPtViYbXewniDF76NIlAdU6pg4yJojF5JwFy3niuN/gpi9aIqk5b
        VJwRR+IlRAVKWVYz0CqKJoI/mqcO7QcRyCTB7U820LsVVWvW1zINAEyg53tdSPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Js0ffw
        H9tb/MoQLH0rwl0z53DDCI370/R/3wKj8PcepkJTMJBDrPZMWpKaEWEanoBmt4LL
        u7DzQ9Nb/UBid3FVkkMUfCp2WHFnTCKzB/L70nATSlGil+mWSUwvPYEgrOCg8AKd
        qX2jSyfoHxFHK9gI2YMRBrUzIiE5fQbdDIG/k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2532413F396;
        Mon, 27 May 2019 11:39:59 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8C46F13F393;
        Mon, 27 May 2019 11:39:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH] refs: tone down the dwimmery in refname_match() for {heads,tags,remotes}/*
References: <CAHk-=wgzKzAwS=_ySikL1f=Gr62YXL_WXGh82wZKMOvzJ9+2VA@mail.gmail.com>
        <20190526225445.21618-1-avarab@gmail.com>
        <5c9ce55c-2c3a-fce0-d6e3-dfe5f8fc9b01@redhat.com>
        <874l5gezsn.fsf@evledraar.gmail.com>
Date:   Mon, 27 May 2019 08:39:57 -0700
In-Reply-To: <874l5gezsn.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 27 May 2019 16:29:28 +0200")
Message-ID: <xmqqef4jewj6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AEFE72FC-8095-11E9-A21E-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> It mostly (and I believe always should) works by looking at whether
> "someref" is a named ref, and e.g. looking at whether it's "master". We
> then see that it lives in "refs/heads/master" locally, and thus
> correspondingly add a "refs/heads/" to your <dst> "tags/foo", making it
> "refs/heads/tags/foo".

Yes.

(I am still not up to speed, so pardon me if I sound nonsense)

> *Or* we take e.g. <some random SHA-1>:master, the <some random...> is
> ambiguous, but we see that "master" unambiguously refers to
> "refs/heads/master" on the remote (so e.g. a refs/tags/master doesn't
> exist). If you had both refs/{heads,tags}/master refs on the remote we'=
d
> emit:
>
>     error: dst refspec master matches more than one

OK, so you are saying "if the source is unique, try to qualify the
destination to the same hierarchy (i.e. the previous paragraph). If
the source is not a ref (this paragraph), try to find a unique match
with the destination to determine where it should go".  I think that
makes sense.

> (We should improve that error to note what conflicted, #leftoverbits)

OK.

> So your HEAD:tags/for-linus resulted in pushing a HEAD that
> referred to some refs/heads/* to refs/tags/for-linus.  I believe
> that's an unintendedem ergent effect in how we try to apply these
> two rules. We should apply one, not both in combination.

Are you saying that HEAD is locally dereferenced to a branch name
(if you are not detached when pushing), and "if the source is unique
ref" rule is applied first?  That is not how I recall we designed
this dwimmery.  As we know there is no refs/heads/HEAD, it should be
like pushing HEAD^0:tags/for-linus (i.e. it should behave the same
way as pushing "<some random SHA-1>:tags/for-linus"), without "where
is the source?  let's qualify the destination the same way" rule
kicking in.  And because the repeated "Linus, please pull from that
usual tag for this cycle" request is a norm, "does the destination
uniquely exist at the receiving end" should kick in.  IOW, I think
that is quite a deliberate behaviour that is desirable, or atleast
was considered to be desirable when the feature was designed.

>> In my opinion, the bug is that "git request-pull" should warn if the t=
ag
>> is lightweight remotely but not locally, and possibly even vice versa.

Hmm (yes, I realize I am not commenting on what =C3=86var wrote)...

>>   # create remote lightweight tag and prepare a pull request
>>   git push ../b HEAD:refs/tags/tag1
>>   git request-pull HEAD^ ../b tags/tag1

I do not think lightweight vs annotated should be the issue.  The
tag that the requestor asks to be pulled (from repository ../b)
should be what the requestor has locally when writing the request
(in repository .).  Even if both tags at remote and local are
annotated, we should still warn if they are different objects, no?

Do we run ls-remote or something (or consult remote-trakcing branch)
to see if that is the case in request-pull?
?
