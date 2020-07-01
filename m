Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A43C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 21:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FDCA2082F
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 21:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="noGdyfV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgGAVC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:02:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62652 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgGAVC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 17:02:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CCA63C6C79;
        Wed,  1 Jul 2020 17:02:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jXKV2QjRdK6PiAHMohvtxfDED94=; b=noGdyf
        V6Vu6y2EO5lvrsmoB+z4nlsT+ekN9NkDn6IGpL0Me8Yv/Q09RWmXO4G81zKwePQo
        8R2qS7IEWJtwtlhsRj6OPSd7Ot7xd9gqdIdFK6yBNmgcEhUpuFq1Iqy3Fkpaj/eq
        9/eXMYQPmmyNipwB74oXlIm0Vw9ARsnjwleA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UsuWAsfp6H4MIhJEhMePsodAJiJlcQy0
        jQhk3iwZ7cS74OyH4VMIbtPzLnA5vsaUsBWC7dutIrh4KPHCtIi6K/P6YCWnAnMh
        Rti7T7sqLSsMAQ1Iy74QIld6WYWDRHD8g1uNKsNGJ8dTQRLYmhTR0u+u9vYQUUx9
        Kmsn3D/tNjQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C429BC6C77;
        Wed,  1 Jul 2020 17:02:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0CBE7C6C75;
        Wed,  1 Jul 2020 17:02:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: Re: [PATCH v4 1/2] diff-files --raw: show correct post-image of intent-to-add files
References: <pull.654.v3.git.1593010066.gitgitgadget@gmail.com>
        <pull.654.v4.git.1593107621.gitgitgadget@gmail.com>
        <69256ab9107c3dba0dc007b69cc0ce98a9b91f9a.1593107621.git.gitgitgadget@gmail.com>
        <xmqqmu4r3to1.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2007011144410.56@tvgsbejvaqbjf.bet>
Date:   Wed, 01 Jul 2020 14:02:18 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2007011144410.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 1 Jul 2020 11:46:42 +0200 (CEST)")
Message-ID: <xmqqeepvc5k5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 270FB646-BBDE-11EA-A8E8-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 25 Jun 2020, Junio C Hamano wrote:
>
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>>
>> > diff --git a/diff-lib.c b/diff-lib.c
>> > index 61812f48c2..25fd2dee19 100644
>> > --- a/diff-lib.c
>> > +++ b/diff-lib.c
>> > @@ -220,8 +220,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>> >  			} else if (revs->diffopt.ita_invisible_in_index &&
>> >  				   ce_intent_to_add(ce)) {
>> >  				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
>> > -					       the_hash_algo->empty_tree, 0,
>> > -					       ce->name, 0);
>> > +					       &null_oid, 0, ce->name, 0);
>>
>> This (even if the preimage were correctly using empty_blob) is *so*
>> simple a change that it is very surprising that the new test in
>> [2/2] passes without any other code change.
>>
>> It means that difftool was written correctly in the first place,
>> right?
>
> Well, it means that difftool does not even consume the OID. Sure, it
> parses it, but then it ignores it. All it _really_ is interested in is
> that status flag (`A`),

Ah, that's an ultimately defensive code.  No matter what is on the
right hand side of the raw output, as long as it knows that the
right hand side is a file on the working tree, it can safely ignore
the object name and directly go to the working tree file.

Nice ;-)

> so technically, my fix in 1/2 is not even needed
> after `sk/diff-files-show-i-t-a-as-new` to let 2/2 pass.

Sure, but I think it is the right thing to do nevertheless.  Giving
the object name for an empty blob would be wrong unless the working
tree file is known to be empty (and empty tree?  what were we even
thinking, gee...).
