Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09ECA1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 14:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbfHOOhC (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 10:37:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54852 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730084AbfHOOhB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 10:37:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 949DB16C69E;
        Thu, 15 Aug 2019 10:36:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FQguyVCh3wqjiaE0kzaYwM/V4/E=; b=gc0pOB
        NVtXt19ZXiHuuF2Quz9v+0Dj/YZq8tJYeU5HlihESiUF2PKc0KpgV3c63PLLtXr0
        cXQV+7Ump2mzflroUSo+xzlcQvmBw9Nuq+f7rYcaD9wg7kkoRwrDndXe28+UdOmK
        2lK1nl3szddsfyp2EImD+2uAxxHBjgeAM0ZtA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bzosXdv6hTuCxYd1oDsUCSduhHnOaWqw
        IlkIkAT8TfH1xoeaTVFigMiveCl1LOUBIUXkIWvgLWqkgJz+nQZDi300Nr/GAuSB
        4KkZmXpmAl6ju4BH2RowsVOyyC7yuRhs8831LYrF0Gr/A+6M3YD6l3Cv5pQg0zAO
        /7mfAsZdioQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CC1516C69D;
        Thu, 15 Aug 2019 10:36:59 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBA6716C69C;
        Thu, 15 Aug 2019 10:36:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add tool to generate debugging info
References: <20190815023418.33407-1-emilyshaffer@google.com>
        <e6d56d97-99c9-064a-71b5-2b7eb9b71e01@gmail.com>
Date:   Thu, 15 Aug 2019 07:36:57 -0700
In-Reply-To: <e6d56d97-99c9-064a-71b5-2b7eb9b71e01@gmail.com> (Derrick
        Stolee's message of "Thu, 15 Aug 2019 10:15:24 -0400")
Message-ID: <xmqqy2zu4hrq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 232E01D4-BF6A-11E9-8044-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Config options to consider stripping out:
>
> 	*url*
> 	*pass* (anything "password" but also "sendmail.smtppass")

Blacklisting?  I wonder if users feel safer if these are limited to
known-benign ones.

>> +	echo "[Configured Hooks]"
>> +	find "$GIT_DIR/hooks/" -type f | grep -v "\.sample$" | print_filenames_and_content
>> +	echo
>
> Remove the sample hooks, but focus on the others. Will this look like garbage if a hook
> is a binary file?

This makes me feel very nervous.  $GIT_DIR/hooks/ are private and
people can hardcode credentials in them; $GIT_DIR/hooks/pre-foo may
be written toread from $GIT_DIR/hooks/mypassword with the knowledge
that there won't be any "mypassword" hook.
