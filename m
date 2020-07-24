Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E75C433E4
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 20:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741C82065F
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 20:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="casQw2Ch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgGXUgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:36:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54632 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgGXUgM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 16:36:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6CF18DD818;
        Fri, 24 Jul 2020 16:36:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OBAwWc7ACJJJPMS6taKpmZWUOMo=; b=casQw2
        ChwZdezc0gvY0sxp6BouiA44hM/YfbtrB7MVedr2NzEhwhIKZtp8cHl9VVq4wN8v
        Oj0l9gM7KREh4YXT44Dk/F8WSsVMP5QKoSwA+BMxecY2eFa73xfC53uHeV9AlVSQ
        Y718jpkYDeLvf5zURgVcH0DxJ8DY4Q1NPHTAs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YzpUXnl4Y84ETfxl3EP69KKKD+ZlbV1w
        IBfYkMWL5l0Fk9LVxVOdbreIJoF5FPHJH3qlfhrRyqBSCOJDc8+ChfPs0nMtEFWA
        8NT1R6qmxAjF/ShFgHs4BRz009W1ujvyTloGnTkiUYWNRvb19hO+50fTwS0/33Oi
        KWjOJD/xvMc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 65905DD817;
        Fri, 24 Jul 2020 16:36:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A2F5DDD816;
        Fri, 24 Jul 2020 16:36:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tommaso Ercole <Tommaso.Ercole@qlik.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Creation of a branch named that has a directory prefix equal to the name of another branch fail.
References: <DM5PR1801MB2076F807C0B9F29A152DBEB7F0760@DM5PR1801MB2076.namprd18.prod.outlook.com>
        <DM5PR1801MB20762477763E6298C7FE6315F0770@DM5PR1801MB2076.namprd18.prod.outlook.com>
Date:   Fri, 24 Jul 2020 13:36:05 -0700
In-Reply-To: <DM5PR1801MB20762477763E6298C7FE6315F0770@DM5PR1801MB2076.namprd18.prod.outlook.com>
        (Tommaso Ercole's message of "Fri, 24 Jul 2020 10:26:14 +0000")
Message-ID: <xmqqzh7ok5vu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D58A3FA-CDED-11EA-B31D-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tommaso Ercole <Tommaso.Ercole@qlik.com> writes:

> As per compiled bug report, creation of a branch that has a prefix that map to a folder, when that prefix is just an existing branch in the repo fails.
>
> I.E. 'a/b/c' when 'a/b' just exists.

Yup, that is one of the natural consequences of the design to
organize refs in a directory like hierarchies.  There are various
ref backends (e.g. packed-refs that already exists, and reftable)
that could potentially store both D and D/F at the same time, but
it is very likely that the higher layer that calls into these ref
backends will keep the behaviour as a policy, to ensure that those
on older versions of Git can smoothly interoperate with newer
versions of Git.

Thanks.
