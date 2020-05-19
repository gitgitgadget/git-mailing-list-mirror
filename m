Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2061DC433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 15:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA1C72075F
	for <git@archiver.kernel.org>; Tue, 19 May 2020 15:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cVZMBppt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgESPVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 11:21:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60105 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbgESPVq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 11:21:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61CE4D090C;
        Tue, 19 May 2020 11:21:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iy9poON2BrjWRJpjk9r1FCCYfbM=; b=cVZMBp
        ptW/g2ztfPzExD7ISu2L3oqKu0fzbM2NsQ3JY2Uk6asim5xWOk3qt9BjGMEDzQnk
        E6jgbJIasfG29g7ZHZHEYRB/U5R0BwZBBaucoiZHRNv+652VQ0DCJ6Wwqqe8iTRD
        0CFFGc9+B9Pj/cS1j1PI8ZbfAPCv2kZmHVqaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y+LUve6Jk8qWrZIygpiw9kfWOEEvi8qS
        0ZlAr2jPLbD6P400/MIZP51XVP4cS3WcCbW3bLlDDjM+yz0SWQvsrqCBaeO3+HzP
        ZjKX9E8i3qgok/I374zEZq3ot9quVMToIveFlCfM/FMIZ5wkZTdneMojKOZsxjqQ
        /tmA/v5pd9w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 594BAD090B;
        Tue, 19 May 2020 11:21:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 45CBCD090A;
        Tue, 19 May 2020 11:21:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v13 13/13] Add some reftable testing infrastructure
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
        <0e732d30b516855a7e91240a9055712b26905b2e.1589226388.git.gitgitgadget@gmail.com>
        <xmqq8shvtxpm.fsf@gitster.c.googlers.com>
        <CAFQ2z_O3hWEfdyQgH9PrkZcoQUQuaLZWRf0=LY2y93N8aOmEJg@mail.gmail.com>
Date:   Tue, 19 May 2020 08:21:38 -0700
In-Reply-To: <CAFQ2z_O3hWEfdyQgH9PrkZcoQUQuaLZWRf0=LY2y93N8aOmEJg@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 19 May 2020 15:54:14 +0200")
Message-ID: <xmqqzha4ympp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 703F45A0-99E4-11EA-8DF2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Wed, May 13, 2020 at 9:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> > --- a/refs.c
>> > +++ b/refs.c
>> > @@ -1742,7 +1742,7 @@ struct ref_store *get_main_ref_store(struct repository *r)
>> >       r->refs_private = ref_store_init(r->gitdir,
>> >                                        r->ref_storage_format ?
>> >                                                r->ref_storage_format :
>> > -                                              DEFAULT_REF_STORAGE,
>> > +                                              default_ref_storage(),
>> >                                        REF_STORE_ALL_CAPS);
>> >       return r->refs_private;
>> >  }
>>
>> Would it make sense to let NULL stand for "we use the default,
>> whatever it is" so that anybody outside the implementation of the
>> refs API does not have to care what the default is, and make
>> ref_store_init() function the only thing that knows what it is?
>
> Is this your strong recommendation in the form of a question? :)
>
> If it is just a question: maybe. I don't know enough of Git to say for sure.

I try not to ask a rhetorical question without marking it explicitly
as such.  The question "instead of having to sprinkle ?: all over
the place on the callers' side, would it make it better or worse to
give a 'not decided' default to the ref_storage_format field?" came
to mind while reading the series.

> How do submodules decide on other settings, such as the hash ID?

I am not sure the issue of "what default to use" is limited to the
submodule case (e.g. "git init" and "git clone" starts from having
no "current repository" and they need to make the decision among
available choices).  As I've seen this series and SHA-256 series
conflict in the "init" area, it probably is time for me to introduce
you to Brian (cc'ed) to pick his brain ;-).

Thanks.

