Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 720561F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 02:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfJHCPz (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 22:15:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59246 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfJHCPz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 22:15:55 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE81D2F0ED;
        Mon,  7 Oct 2019 22:15:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EPtUn8F9mRhwdCL0h0A2xeHYeLQ=; b=HKnCZ+
        VVE61pJOKSLgJ/ZbNjTSrjDVmSibLwRV0KOSc6+qldCK/kNq6nxj0W8qdkciq2Vy
        p4ogwLuGd2aks71250D5wu+ZCaXAVWjuMEA9MFeF8bFjuuWE+QU9qduP0DrCGCa8
        7I6xpFOKPSMXWr1yugczi8fgWrqMEuDjEPQ5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MXGRdYb7ZKo7jqHgx1a2RCrtCQsMJmpF
        5ac3MHVrhzE7t+QaapYGDe1G9Z5QZhi2wUKdQsgrfxgeHMC8X3eilViZLwHcB43g
        WP8yd2Aehb/Bq9/T06DS98CC0ZH/aW2Fs6Zja/yr/nK5PRq/WdXBbg5REyTPP/pp
        sjgHj5pl0Mk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5B0A2F0EC;
        Mon,  7 Oct 2019 22:15:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15C372F0EB;
        Mon,  7 Oct 2019 22:15:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 21/20] convert: drop invalid comment for subprocess_entry
References: <20191006233043.3516-1-e@80x24.org>
        <20191006233043.3516-21-e@80x24.org>
        <xmqqeezp490w.fsf@gitster-ct.c.googlers.com>
        <20191007084339.GA7808@dcvr>
Date:   Tue, 08 Oct 2019 11:15:52 +0900
In-Reply-To: <20191007084339.GA7808@dcvr> (Eric Wong's message of "Mon, 7 Oct
        2019 08:43:39 +0000")
Message-ID: <xmqq4l0koucn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E64A6B6-E971-11E9-AAFD-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> "struct hashmap_entry" inside "struct subprocess_entry"
> no longer needs to be the first member of any struct,
> so the old comment is no longer true.

Hmm, is that true?

struct cmd2process {
	struct subprocess_entry subprocess;
	unsigned int supported_capabilities;
};

static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
{
	static int versions[] = {2, 0};
	static struct subprocess_capability capabilities[] = {
		{ "clean",  CAP_CLEAN  },
		{ "smudge", CAP_SMUDGE },
		{ "delay",  CAP_DELAY  },
		{ NULL, 0 }
	};
	struct cmd2process *entry = (struct cmd2process *)subprocess;
	return subprocess_handshake(subprocess, "git-filter", versions, NULL,
				    capabilities,
				    &entry->supported_capabilities);
}

The cast "struct subprocess_entry *" to "struct cmd2process *" we
see here does require that the address of the subprocess field must
be the same as the address of the structure itself.  So I'd have to
say that the comment still is true, but not for the reasons of what
is in "struct subprocess_entry".
