Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC6691F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 16:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbcHOQ55 (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 12:57:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54251 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752812AbcHOQ55 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 12:57:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CCDC330FC;
	Mon, 15 Aug 2016 12:57:55 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SlssW20cYrp5KKS131SuzbKiH/o=; b=vVzsDk
	pawmAWuEPmp/9nAs42qCbU+6WvWcdbVy6Pm0oWgH4a806I8I+ujpyjG9ydhrnVC7
	06d+suvFhm70DsJS7HqXaMkDadnOtg62jF7Vja6L2R1kSnawxFwkCHqv7X21RRWO
	bP0FL6BFxmAle9UEVKC5pP5V62ihp0k+GpG88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H7rNhSkWyhrIQyhRaHlbYRPV29oFCsk4
	CK8XS6iCGhvOEU1A8hWUfzN3mzplFoB9S7SZo9A/buy33+lW5fZKCElYaM3Q+B7F
	ehRlsHPJLP2lQAfIdZCOYGjU5wFtQRRtkNmvVhZzpPBU6MGu0rToKLpdqq5v47Iv
	ndvAq8kMSJk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 80FC3330FB;
	Mon, 15 Aug 2016 12:57:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E1064330FA;
	Mon, 15 Aug 2016 12:57:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	git@vger.kernel.org
Cc:	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t/Makefile: make sure that file names are truly platform-independent
References: <814aefbcf0f9380098e3f7a183399e11e24180dd.1471270061.git.johannes.schindelin@gmx.de>
	<xmqqk2fihv90.fsf@gitster.mtv.corp.google.com>
Date:	Mon, 15 Aug 2016 09:57:52 -0700
In-Reply-To: <xmqqk2fihv90.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 15 Aug 2016 09:06:35 -0700")
Message-ID: <xmqq4m6mhsvj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6907591E-6309-11E6-97E5-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> Some file names that are okay on ext4 and on HFS+ are illegal in
>> Windows. In order to stay truly platform-independent, Git's source code
>> must not contain such illegal file names, even if things just happen to
>> work on Linux.
>
> Good thinking.
>
> Some tests may have to be skipped on platforms that cannot express
> certain paths, but even then they shouldn't ship a file with
> pathname that cannot even be checked out (they should instead create
> and use such a path, protected behind filesystem specific test
> prerequisite).

This is a tangent.

Adding a check target in t/Makefile is a good first step, but any
tree of a project that gets participation from those on different
platforms must allow any supported platforms to check it out.  The
issue is not limited to the t/ hierarchy, but the whole thing.  I
do not mean to say this patch needs to do more than checking t/ at
all, by the way.  After all, people send patches without running
test-lint so this only means that we as the project must be careful.

I wonder if we already have a good mechanism to allow a project and
its participants (say, "me") to declare "in this project, pathnames
must conform to this rule" and help them avoid creating a tree that
violates the rule customized to their project.

I guess "write_index_as_tree()" would be one of the central places
to hook into and that covers an individual contributor or a patch
applier who ends up adding offending paths to the project, as well
as a merge made in response to a pull request (unless it is a
fast-forward) [*1*].  The pre-receive hook can also be used to
inspect and reject an attempt to push an offending tree into the
history.

Such a mechanism would allow a project that wants participation by
folks with case insensitive filesystems to ensure that they do not
create a directory that has both xt_TCPMSS.h and xt_tcpmss.h at the
same time, for example, but the mechanism needs to allow visibility
into more than just a single path when the custom check is made
(e.g. a hook run in "write_index_as_tree()" can see all entries in
the index to make the decision; if we were to also hook into
"add_to_index()", the hook must be able to see other entries in the
index to which the new entry is being added).


[Footnote]

*1* "add_to_index()" could be another place to hook into, and doing
so has the merit of catching a breakage sooner, but I suspect that
alone may not be sufficient if there are other ways for new entries
to appear in the index.
