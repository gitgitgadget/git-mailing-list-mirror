Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFF441F461
	for <e@80x24.org>; Wed,  3 Jul 2019 18:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfGCSRp (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 14:17:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62254 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfGCSRp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 14:17:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C042153904;
        Wed,  3 Jul 2019 14:17:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mSSaqc1V9R6XW2BwTWY+5+2iX1A=; b=nq6axn
        CAYZmXjBAZnwKPDw5Hqj7mlHCbr+1ScTbRiBZrEwUa+ovhu9CXAErWHiEncUoVjQ
        vBS0Wft3wld51rRxG0MDc3c/W+BJvwiOIFzjf68CIF9qi6V7gahZe1Kw84vd9uWX
        1npfVGKV6GCjlNGCZ5EEXjwVMVYolFX2Svfcw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KPscZ5j4lsLh1PuU334qPSbtF+/iQD9J
        6FLCPnnhSkBbzNeVddcsWxKxMy64KFUcGughsB1UBQigff6Cdk8zy7WDM/0lTngk
        3K6zyK7CX4/hnjRVRo43mD9kdqKA8S08Mh0lvYx2JwPdHjjVGZY5HU9MXQ3gObWc
        pBGn6FDod3I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8491E153901;
        Wed,  3 Jul 2019 14:17:43 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DDE8E153900;
        Wed,  3 Jul 2019 14:17:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Julius Smith <jos@ccrma.stanford.edu>
Cc:     git@vger.kernel.org
Subject: Re: Submodule "git branch" says (HEAD detached at <incorrect-commit>)
References: <CAMPRpjUWBXCEagDB5RwsBTYSJWeypOeY47CGWOO95oZiSCTOjw@mail.gmail.com>
Date:   Wed, 03 Jul 2019 11:17:41 -0700
In-Reply-To: <CAMPRpjUWBXCEagDB5RwsBTYSJWeypOeY47CGWOO95oZiSCTOjw@mail.gmail.com>
        (Julius Smith's message of "Wed, 3 Jul 2019 01:28:59 -0700")
Message-ID: <xmqq7e8z0ypm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9771EB2-9DBE-11E9-9661-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Julius Smith <jos@ccrma.stanford.edu> writes:

> "git branch" in the the submodule directory says "(detached from
> <commit-for-D>)" but this seems to be wrong.  I did "git diff
> <commit>" in the submodule directory to show that it was the C-commit
> and not the D-commit as it appeared.  Could "git branch" in the
> submodule directory be referring to the commit at the time it was
> first detached and not updating after a "git submodule update --init"
> in the parent?

There are "detached from" and "detached at" messages.  Their use was
somewhat inconsistent in the older version of Git, but at least
since 2.4.0 (quoting from Documentation/RelNotes/2.4.0.txt):

 * The phrasing "git branch" uses to describe a detached HEAD has been
   updated to agree with the phrasing used by "git status":

    - When HEAD is at the same commit as when it was originally
      detached, they now both show "detached at <commit object name>".

    - When HEAD has moved since it was originally detached, they now
      both show "detached from <commit object name>".

   Previously, "git branch" always used "from".

"git branch" and "git status" should be using the same language to
describe the situation.
