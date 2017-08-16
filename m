Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B69C208CD
	for <e@80x24.org>; Wed, 16 Aug 2017 00:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752243AbdHPALi (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 20:11:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64458 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751598AbdHPALi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 20:11:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 47D32A78F2;
        Tue, 15 Aug 2017 20:11:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DENoG7fk3Vr+2iWe5Qdq4BKlrKQ=; b=jeGoSK
        eP7vE/dctGV46+2nTcCEApqxmtvwzw669W+v2hnPa8iytyRO+PvcO2ESmRXxJvgh
        Hedis36Iem7ijUUffQeBTQB/rWnfvDqE7EQGIV/jwffK4AlGDxJRFS4iQfg2gb24
        0L5t0eET9QTkt+LIgKc36QrC8ttaFcxwG5Oso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g0d5jhLazTetl1KFhmY+IF2TnFNH6Wf0
        dIbDTgwZdZvn9Nc9OPSfuaJcAF9dRHVCObUNnPzCM/03ZTQoKCdzRCpSeyOrXjYy
        Ura/BLDVSE3PsJDZm0I0KqmE8V+aONT3qMuHCj1yjrgGWcv2utI34JIsZsBZ4slP
        zeOOerPjXJI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F947A78F1;
        Tue, 15 Aug 2017 20:11:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A77EBA78EE;
        Tue, 15 Aug 2017 20:11:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] push: do not add submodule odb as an alternate when recursing on demand
References: <CAGZ79kZouNBxOKr7X8j6wqebp3Wh3cDqhYR-t_PxaF7AwQ0Wzg@mail.gmail.com>
        <20170815224332.22730-1-sbeller@google.com>
        <xmqqh8x8pg8p.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kag+U94tzJ14mB4VZjSZ2MtUJ4vu4MXKLKkpkLw=2K_NA@mail.gmail.com>
Date:   Tue, 15 Aug 2017 17:11:35 -0700
In-Reply-To: <CAGZ79kag+U94tzJ14mB4VZjSZ2MtUJ4vu4MXKLKkpkLw=2K_NA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 15 Aug 2017 16:31:05 -0700")
Message-ID: <xmqqd17wpe14.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77FCF18A-8217-11E7-A891-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> Is "is it populated" a good thing to check here, though?  IIRC,
>> add-submodule-odb allows you to add the object database of an
>> inactivated submodule, so this seems to change the behaviour.  I do
>> not know if the behaviour change is a good thing (i.e. bugfix) or
>> not (i.e. regression) offhand, though.
>
> Good point, we should be able to push non-populated, even inactive(?)
> submodules. For that we strictly need add_submodule_odb here
> (or the repo object of the submodule, eventually).
>
> So let's retract this patch for now.

Not so fast.  

I am not convinced "push --recursive" should touch a submodule that
was once cloned from the upstream and then deactivated, so using
add-submodule-odb to decide if the push should go through may be a
bug that we may want to fix, in which case the diff of the patch in
question may be good as-is.  We need to sell it as a bugfix to the
users, who may complain about behaviour change (if there is one).

On the other hand, even if it were desirable for such a deactivated
submodule to be pushed, as your log message explained, there is no
reason to contaminate the in-core object hash by calling the
add-submodule-odb helper, when the only thing we care about is "do
we have the refs and object store for this submodule? we do not care
if it is activated or not".  Perhaps there is a more appropriate
helper in submodule.c that answers that question that we should be
using instead of add-submodule-odb, and if there is not yet such a
helper, perhaps this indicates that we need to add such a helper,
which essentially is the early half of what add-submodule-odb does,
i.e. ask git_path_submodule() for the object store and check if that
directory exists.

Thanks.
