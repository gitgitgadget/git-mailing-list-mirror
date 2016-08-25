Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B55211F859
	for <e@80x24.org>; Thu, 25 Aug 2016 17:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754417AbcHYRtv (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 13:49:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57405 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753423AbcHYRtv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 13:49:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E20FE374C3;
        Thu, 25 Aug 2016 13:46:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tiKFjvCjaNjPH+1zyNejR9AuWlo=; b=syP4Yr
        rXjQcNdNUvlr9OTqMqhopQdwNeLwaSwS+kPmHZm1GkuizV4TNhF28Xu19Tn3tKFW
        Kz1fd/48qEXgGhmtHcsrBE9q8z88O2kfVGtnzMwQCbTqwCCjg8DN0QAk4pGaAE8K
        uwwS6nGrQJFOYL+hEY5zjdqpUoeYupVyuogaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fU87Lh/wueOOveLFMYrQ5pgqLzuw4TU9
        LMBnWA15jmF1QObzBdPhvuT7ie8RE8r94WiUINTl1dLmDJwFjJ0ngnpzmIVqsG3y
        cpSw1sHaWdleSct5CQ/lCrbizIcBfDk9IV/kcxYTDf+BNtjBfQ5shOHRtDfAgV8x
        NVuYDCBT+og=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D96A8374C2;
        Thu, 25 Aug 2016 13:46:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70024374C1;
        Thu, 25 Aug 2016 13:46:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hedges Alexander" <ahedges@student.ethz.ch>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Feature Request: Branch-Aware Submodules
References: <7B5AD16B-9729-453E-839C-2A2FDB07F8E9@student.ethz.ch>
Date:   Thu, 25 Aug 2016 10:46:18 -0700
In-Reply-To: <7B5AD16B-9729-453E-839C-2A2FDB07F8E9@student.ethz.ch> (Hedges
        Alexander's message of "Thu, 25 Aug 2016 09:00:47 +0000")
Message-ID: <xmqqvayon3md.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4FEBF88-6AEB-11E6-97D1-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hedges  Alexander" <ahedges@student.ethz.ch> writes:

> Right now updating a submodule in a topic branch and merging it into master
> will not change the submodule index in master leading to at least two commit
> for the same change (one in any active branch).

I stopped reading here because I am not getting this.

I guess I am confused because I do not understand what you mean by
"the submodule index in master".  The concept of "index" does not
belong to each branch (or even a commit), so by "index" you are
trying to point at something else, but I cannot guess what it is.

You have a top-level superproject that has another project as its
submodule.  The superproject has topic and master branches (or it
may only have master).  The project that is used as its submodule
also has topic and master branches (it may have more).  You do your
development in the submodule, e.g.

    cd submoduledir
    git checkout topic
    hack hack hack
    git commit
    git checkout master
    git merge topic

and merge the topic branch into its master when the topic is
polished enough.

And then?  The 'master' in the submodule is good enough, so you'd
go back to the top-level superproject and bind that merged result 
in its place?  e.g.

    cd ..
    git add submoduledir
    git commit -m "Updated submoduledir with the topic"

That is only one commit each in the superproject and the submodule
project.

