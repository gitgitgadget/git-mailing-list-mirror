Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 495DB2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 18:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbcIOSCd (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 14:02:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60164 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752020AbcIOSCa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 14:02:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E14103B4F5;
        Thu, 15 Sep 2016 14:02:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PTTD5bkMvfqxtU5mmhnN4q7Etkc=; b=PamBG5
        gFWGWRFb38/0UTAJ2zr1nyjz1XMG6LhS9II1xo/XY6wafVifG/lTANBGsg2Q8NVC
        4q45rlbOy4R7hINZHQKcZEjgEb7xG4HF80ViXVZZhOVhtDfFvCTI3AJmd6NbXy6Z
        TSlNXXdBeY5p517YSCYDTG8qWB7ZyGFRTMNCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wuL40Gfr7CPMaQ32o/l9AITdBwe1bazs
        xw1/2MNN1Kyl08e/WLnOfs9zLzKPOXoQYt+4Ds2Ah4lNij+rDOm70YqhOeu/pShc
        U+k3n6+P2Xbh9ZDRpRtktTSyT0+UOtES+hZC4gInk7kKRMXnpMDavGbDTO+Q8go1
        F0cH6LGTkto=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D7E783B4F4;
        Thu, 15 Sep 2016 14:02:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 461BA3B4F1;
        Thu, 15 Sep 2016 14:02:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Yaroslav Halchenko <yoh@onerussian.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [wishlist?] make submodule commands robust to having non-submodule Subprojects
References: <20160915130233.GC9833@onerussian.com>
        <CAGZ79kZLdsKcf0t=dDB24VVe+V=uqQCW_VNQwSJ638m5Keu2nQ@mail.gmail.com>
Date:   Thu, 15 Sep 2016 11:02:25 -0700
In-Reply-To: <CAGZ79kZLdsKcf0t=dDB24VVe+V=uqQCW_VNQwSJ638m5Keu2nQ@mail.gmail.com>
        (Stefan Beller's message of "Thu, 15 Sep 2016 09:05:10 -0700")
Message-ID: <xmqqwpidniry.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 908AF978-7B6E-11E6-B37E-90D812518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Thu, Sep 15, 2016 at 6:02 AM, Yaroslav Halchenko <yoh@onerussian.com> wrote:
>>
>> If e.g. you just 'git add' a subdirectory which is a git repository, git
>> adds it as a subproject but doesn't initiate any entry in .gitmodules
>> since it is the job done by submodule and git core itself is
>> agnostic of those beasts.
>> ...
>> $> git submodule
>>  cc6a09ac06c13cf06b4f4c8b54cda9a535e4e385 ds000001 (2.0.0+4)
>>  0a9f3b66e06a2137311a537b7377c336f1fb30ad ds000002 (1.0.0-3-g0a9f3b6)
>>  9da7e4f4221699915645ac2003298c6aba2db109 ds000003 (1.1.0+4)
>>  fe16cacb5cb9b4d53c50e498298fab182500e147 ds000005 (2.0.0+3)
>>  6898d99ff3ba26880183ed3672a458a7fcde1737 ds000006 (2.0.0+2)
>>  bbd10f634fe87e9d5853df3a891edbdb18cda7f9 ds000007 (2.0.0+3)
>>  138e6730193c0585a69b8baf5b9d7a4439e83ecc ds000008 (2.0.0+2)
>>  ddf3a4cf7ce51a01a664e6faff4b8334b8414b1f ds000009 (2.0.1+1)
>>  7fa73b4df8166dba950c7dc07c3f8cdd50fca313 ds000011 (1.0.0-5-g7fa73b4)
>> fatal: no submodule mapping found in .gitmodules for path 'ds000017
>>
>> which then stops without even looking at other submodules.
>>
>> I think it would be more logical to make it a 'warning:' not a 'fatal:' and
>> proceed.

Making "git submodule" listing to continue from that point may be
one thing, but do we have a sensible way in "git submodule add" to
allow the user to recover from this condition?  That is, "git add"
is a right way to tell the core level that there is a gitlink, but
as Yaroslav correctly observed in the early part of his message,
having that gitlink alone is not good enough for the world view of 
"git submodule" that sits at higher-layer.  And the usual way to
tell the submodule layer that there is a submodule is with "git
submodule add", but

	$ git init top
        $ cd top
        $ git commit --allow-empty -m 'initial in top'
        $ git init sub
        $ git -C sub commit --allow-empty -m 'initial in sub'

        $ git add sub
	$ git submodule
        fatal: no submodule mapping found in .gitmodules for path 'sub'

	$ git submodule add ./sub sub
        'sub' already exists in the index
	$ git submodule add -f ./sub sub
        'sub' already exists in the index

I highly suspect that the user will then get stuck at this point,
after trying to "submodule add" and then even attempting to force
it.

I think that is a more pressing thing to address.  Once we make it
easier for the user to bring a half-initialized submodule properly
into the world view of the submodule subsystem, we would have to
worry about the reported failure case even less and you do not need 
to pile on workaround options to let things continue in a state that
is half-broken (that is, in a state that is perfectly sane to the
core layer, but is not liked by the submodule layer).

