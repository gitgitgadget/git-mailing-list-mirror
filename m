Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467FCC433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 19:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6400207BC
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 19:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VTItIhc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgHZTqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 15:46:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53597 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgHZTqx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 15:46:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A63EC7EC48;
        Wed, 26 Aug 2020 15:46:51 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=EtZ0TSHTfbsKdiKbo2c2+IUx9
        xM=; b=VTItIhc+E5XAKlkN0cy15jDv8T027/YtXDSXFKcFvlHhbht4AG+1xIjlO
        R6fF78mCwm8B0oAbRwn3OzRFGRuwMipyy3Jad7vfyH9cr/1CoTqjox+qBjTJAWFL
        b+Ug4bn2J2twa2YCKUHU+yo9s1tlQtTdzJ5NVlwnVEJ6p8b2d4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=ZwZsWcI8nUsyFrhYgPL
        g+J4mlA5hvqdFBQ5b4Q+2KxgIp27eM6O5fjVIaPcN/Y7i/6EtoMH1sVK5y6j0u9Q
        waMQMIQHTVPAhazsP9sq9hojpD+pehlvLL5JbYeWV53W5EiJx9o5E9OtckU06GtA
        k8lj2vZW3iL/bPU04dTyNJFQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E6C47EC47;
        Wed, 26 Aug 2020 15:46:51 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 299247EC44;
        Wed, 26 Aug 2020 15:46:51 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 0/2] avoid running "git-subcmd" in the dashed form
Date:   Wed, 26 Aug 2020 12:46:48 -0700
Message-Id: <20200826194650.4031087-1-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-454-g5f859b1948
In-Reply-To: <xmqqd03dwe2x.fsf@gitster.c.googlers.com>
References: <xmqqd03dwe2x.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: E2C48CDC-E7D4-11EA-8A53-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I think the cvsexportcommit and transport-helper changes are worth
> salvaging even if we don't remove builtin binaries, so I'll split
> them and whip them a bit more into a reasonable shape to be merged
> to 'next'.  The "break those who say 'git-cat-file'" can be left for
> future.

And here it is.

These two patches are clean-ups that are worth doing whether we
decide to remove on-disk binaries for the builtin commands. =20

I droped the third one, that actually stops users from running
built-in commands using the dashed form, at least for now.  It can
be resurrected later if we really wants to propose removal to the
users, but I am not inclined to make such a proposal right now.

Junio C Hamano (2):
  transport-helper: do not run git-remote-ext etc. in dashed form
  cvsexportcommit: do not run git programs in dashed form

 git-cvsexportcommit.perl | 16 ++++++++--------
 transport-helper.c       |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

--=20
2.28.0-454-g5f859b1948

