Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF00E1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 18:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbeDKSak (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 14:30:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54589 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbeDKSak (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 14:30:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91D35E2189;
        Wed, 11 Apr 2018 14:30:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=CtX6fHtO1wgcgizGyd6AIMc+fS0=; b=r4ngwVR
        NHf5DMJCI/6kDH3Y7yoWqtq9RW9hm7yYku8Tph2S2GHvqvqlBHw7JdTknToXJrti
        x9IBqUEKUsX0ctSCzKqz3uyhigHnxj1cc4e3uzx5O0o7UDUTF5yq4fN8X9EJp1jB
        K8e+7voyvDcjy7A3dFd2rExA4wCISw8YEPN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=oQ2AWSf11DkUXes6yJMmBj7nmXxPaxq4R
        4I0Q5BMZ9m6SZ79Eap9qC7rqViI1VDNyNWd5+Nj4Q8FWxpnczfRDOIB9J3vRG9Zp
        6FDyFVcESbRXWmX5Tp1sPS4BOnDxhsjst40eHAr0DTNk4BdliqWMO6lmF3wAKsQD
        SngKeryO90=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88B8DE2188;
        Wed, 11 Apr 2018 14:30:35 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DF9B2E2187;
        Wed, 11 Apr 2018 14:30:34 -0400 (EDT)
Date:   Wed, 11 Apr 2018 14:30:33 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Harald Nordgren <haraldnordgren@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v14 2/4] ref-filter: make ref_array_item allocation more
 consistent
Message-ID: <20180411183033.GQ29680@zaya.teonanacatl.net>
References: <20180402005248.52418-1-haraldnordgren@gmail.com>
 <20180409014226.2647-1-haraldnordgren@gmail.com>
 <20180409014226.2647-2-haraldnordgren@gmail.com>
 <CAHwyqnURebvfW4rGz9RAbe7B9p6ZDy0jUueDFrYE30dmjCtMVA@mail.gmail.com>
 <CAGZ79kYeM=CqKSWTL2tdDXWueMGoki4zAUmFy4wbhtagN7gEAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYeM=CqKSWTL2tdDXWueMGoki4zAUmFy4wbhtagN7gEAA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Pobox-Relay-ID: 6C99DFD2-3DB6-11E8-BC5C-44CE1968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

Stefan Beller wrote:
> Please see the "What's cooking?" email on the mailing list that is
> sent out periodically by Junio.
> the last one is
> https://public-inbox.org/git/xmqqd0z865pk.fsf@gitster-ct.c.googlers.com/
> which says:
> 
>> * jk/ref-array-push (2018-04-09) 3 commits
>> - ref-filter: factor ref_array pushing into its own function
>> - ref-filter: make ref_array_item allocation more consistent
>> - ref-filter: use "struct object_id" consistently
>> (this branch is used by hn/sort-ls-remote.)
>>
>> API clean-up aournd ref-filter code.
>>
>> Will merge to 'next'.
> 
> It will be merged to next and if no people speak up (due to bugs
> observed or such)
> then it will be merged to master eventually, later.
> 
> I am not able to find the documentation for the workflow right now,
> though it is partially covered in Documentation/SubmittingPatches.

Perhaps Documentation/howto/maintain-git.txt is the
documentation you're thinking of?

https://kernel.org/pub/software/scm/git/docs/howto/maintain-git.html

There's also MaintNotes in the todo branch:

https://raw.githubusercontent.com/git/git/todo/MaintNotes

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Be who you are and say what you feel because those who mind don't
matter and those who matter don't mind.
    -- Dr Seuss, "Oh the Places You'll Go"

