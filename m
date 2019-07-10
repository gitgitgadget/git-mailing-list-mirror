Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6FFD1F461
	for <e@80x24.org>; Wed, 10 Jul 2019 18:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfGJS0J (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 14:26:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56826 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfGJS0I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 14:26:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AFE3D169341;
        Wed, 10 Jul 2019 14:26:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SMIamMlQarBatEihI/RK3AAJgnc=; b=q6JPow
        YNcHc87h7JD2uHj5CzEWpIj+94INDpuPLOel4RAQydymwbX95O7i9o3BbMoS6BWA
        Oi31CzvRJD1+1t95obJ0dDoMqnW/iuyjlbt5Z9U9q+T8jZoKzxf2Db8lgSMEruS8
        forbY4wI9LgDTwDPVtm37Uk5fFhk6Kioy2AIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GluaE5SVZDxeLcNW98Daltsb3fJXANQ/
        4rz42gSdSZ93VYs3kPJrS8dIR2R+oIzOnatwtNVP9eBhTWh7T0QJghusF8f3FuoR
        lPWtBJepgHz2O2fbNadbhMwGipDS4eDxt+dSgrMyUoZXHywqn50FndKuzbFGll/h
        5j8+K4Sp2y8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A88A9169340;
        Wed, 10 Jul 2019 14:26:06 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 19F5716933F;
        Wed, 10 Jul 2019 14:26:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Avoid illegal filenames when building Documentation on NTFS
References: <pull.216.git.gitgitgadget@gmail.com>
        <1f0f4fe6fbf0e7a7eea1f3d49db183c70693a895.1562231679.git.gitgitgadget@gmail.com>
        <xmqqv9wcxre3.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907091524460.5700@tvgsbejvaqbjf.bet>
        <xmqqef2zw9op.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 10 Jul 2019 11:26:04 -0700
In-Reply-To: <xmqqef2zw9op.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 09 Jul 2019 07:43:02 -0700")
Message-ID: <xmqqef2xu4oz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E47D770-A340-11E9-8F4B-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> In addition, your `+` scheme will break on Windows once it uses `git.exe`
>> or any other non-MSYS2 helper...
>
> I am not sure what you mean here.  Is your git.exe disabled not to
> be able to do this: "git.exe add hello+kitty.txt"?  I think that is
> a more grave problem, and not limited to the Makefile in the
> Documentation/ directory.

The reason why I thought it was a more grave problem is because (1)
gets 7648757 out of (2), which gets 2297783817 (that is, among the
2.2 billion paths that appear in various GitHub public repositories,
a tad short of 8 million paths have '+' somewhere):

    (1) SELECT count(*) FROM `bigquery-public-data.github_repos.files`
        where path like '%+%';

    (2) SELECT count(*) FROM `bigquery-public-data.github_repos.files`;

If you drop the technique MSYS2 borrowed from Cygwin to support
these characters NTFS does not like by mapping them to a private
page, wouldn't it mean that these projects cannot be used with Git
for Windows?  Are we going to bug each of these projects to change
their pathnames?

If that is not the case, then that's fine.

FWIW, I am OK with moving away from '+' in *our* project; that is
easy enough to do, and such a change does not have to make the end
result visually less pleasing, as long as we pick a good substitute
suffix.  Is '~' (or ',') allowed on NTFS, for example?  The point of
'+' being short, sweet, and easy to spot, I'd rather not to use
'.<anyword>' if we can avoid it.

Whatever suffix we choose, we need to be aware that the pattern is
not limited to Documentation/ directory, so at least the top level
.gitignore and Makefile in various subdirectories need vetting.

