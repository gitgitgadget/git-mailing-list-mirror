Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3326120372
	for <e@80x24.org>; Sat,  7 Oct 2017 00:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753037AbdJGAvG (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 20:51:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56957 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753008AbdJGAvE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 20:51:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B121FAFAED;
        Fri,  6 Oct 2017 20:51:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+vmqp8iyyAtWPEYfCLToPL+hn1A=; b=uNG/nq
        musWt9hOjuV278ZqJsIrKky6dyju5hF0UNV7iam2XxND+mTcHAtQXu6EGoy+XWW7
        4V6REErYxTuTX83MsqER2h7kC+Bc3hrDe8/ekJHpaRb43SdEdYwhEzj9OamGyMRx
        daRZ4nep4vpRlNIfe1Zj1p/+eDZP+zUpOQ55A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DqfIS/foUL7HBCNQLvNMc2TTwfg0ix0A
        DvMlBS3M2cAnECpPE5KiceJe+35prMZE7WQqklXpysjtQh7gagsmPqZoa9RsTe4p
        uVQzpdBRbWX0fFPTBJ5iiOEsxL7Uw0kv4hpRIAA6hbE8KjwtfmEETFuaVP/+bRZL
        FWl8lAMZKFQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A942CAFAEC;
        Fri,  6 Oct 2017 20:51:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 28931AFAEA;
        Fri,  6 Oct 2017 20:51:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] interpret-trailers: introduce "move" action
References: <20171005132243.27058-1-pbonzini@redhat.com>
        <CAP8UFD1X-aRN5sAB5PQt04jL_92APK279bjNf=Zt_x8KOxyL+A@mail.gmail.com>
        <748131b7-bddd-08c2-ff72-9fd1a63ef6a0@redhat.com>
        <CAP8UFD28vVx51xhDgQVesm356XAjfwb286baER-U6VOC+4NL4w@mail.gmail.com>
        <fe023f38-01cc-2257-bbfe-3f4310193b41@redhat.com>
Date:   Sat, 07 Oct 2017 09:51:01 +0900
In-Reply-To: <fe023f38-01cc-2257-bbfe-3f4310193b41@redhat.com> (Paolo
        Bonzini's message of "Fri, 6 Oct 2017 14:39:46 +0200")
Message-ID: <xmqqinfrvkzu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 980040A8-AAF9-11E7-9C28-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 06/10/2017 14:33, Christian Couder wrote:
>> Ok. I think you might want something called for example
>> "replaceIfIdenticalClose" where "IdenticalClose" means: "there is a
>> trailer with the same (<token>, <value>) pair above or below the line
>> where the replaced trailer will be put when ignoring trailers with a
>> different <token>".
>
> So basically "moveIfClosest" (move if last for where=end, move if first
> for where=begin; for where=after and where=before it would just end up
> doing nothing)?  It's not hard to implement, but I'm wondering if it's
> too ad hoc.

Yeah, it makes me wonder exactly that, too.


