Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68B8420A21
	for <e@80x24.org>; Fri, 15 Sep 2017 02:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbdIOC5h (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 22:57:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61285 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751733AbdIOC5g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 22:57:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2568AA09BD;
        Thu, 14 Sep 2017 22:57:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ULlFU64SSUUAzPyczf9rmLkzTB8=; b=MSDV9O
        ZPjKL2bc0lPLbR95TZnuQnLPceujLjFVnW103vLo4i7HPIZf+BogLFPh3vlMpcfm
        piDCoMeGseXbZX3pRId4oYT/YP3kP/eKKIPxvJSi6rRJy5f5Ijzclok+LnCMY4E5
        6IAuQgwCzwwzqA8WvRTufeT574lkfhXS0fYZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Oh0MjRnLKPY3ura0FTVjnkMbeLGLLQzY
        Zdogdurcvg8Uwrn1w+fSs0ZN7mScN/vQoWdVL9CLzRRwdjPIwm/tEuKMk8mzEw15
        ldecFyl2wtDqLJ1NW1gWyKWe41C9W0o0GVwKvPTnqpAe3MP8VDkGV4FSTADzkkgp
        AKhjT7RGi18=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E728A09BC;
        Thu, 14 Sep 2017 22:57:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 848EDA09BA;
        Thu, 14 Sep 2017 22:57:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Gene Thomas <gene@nlc.co.nz>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git diff --name-status for deleted files
References: <PS1PR0601MB1883177814CA771567A7193B8A6F0@PS1PR0601MB1883.apcprd06.prod.outlook.com>
Date:   Fri, 15 Sep 2017 11:57:34 +0900
In-Reply-To: <PS1PR0601MB1883177814CA771567A7193B8A6F0@PS1PR0601MB1883.apcprd06.prod.outlook.com>
        (Gene Thomas's message of "Thu, 14 Sep 2017 22:11:01 +0000")
Message-ID: <xmqq1sn8zn1d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A052618A-99C1-11E7-9B47-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gene Thomas <gene@nlc.co.nz> writes:

> Hello,
>           "git diff -name-status" is useful to list the files one
>           has changed but it does not list file that one has
>           deleted with "git rm". It would be really handy if it
>           did. I am using git 2.9.3 on Ubuntu Linux 16.10.

With or without --name-status option, "git diff" compares between
the contents you have in the index and in your working tree.  After
you modify contents of a file, i.e.

	edit file
	git add file

you would not see that file edited exactly because the file on the
filesystem is identical to what you added to the index with "git
add".

Your example works exactly the same way.  Instead of modifying the
contents of a file, removing the presense of the file and recording
that fact to the index (i.e. removing the path from the index, too)
is done with "git rm", so after running

	git rm file

your working tree would lack "file" and so would your index.  Hence
you wouldn't see "git diff" report any difference on "file".

Perhaps you wanted "git diff HEAD", which is a way to compare
between the contents you have in the tip commit and the paths in
your working tree thru the index?
