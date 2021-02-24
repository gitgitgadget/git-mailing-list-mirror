Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EF2C433E6
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 20:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BC5464E20
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 20:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhBXU1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 15:27:32 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52621 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhBXU13 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 15:27:29 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 43B63112B8B;
        Wed, 24 Feb 2021 15:26:46 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=7JcdydktcPpf5yVipr1t9HMU0
        uQ=; b=vyW5A8gA5x3/8XuHz2xTJWV7ZuxDsEY5bO1t4q39udQrjNruXHMhoyIk3
        Zr/dN3ovMaXuSXc6oNRtOgfdKUE3dvq2qm0RS7voTAPB40BQlIYjejF0oX2GznsF
        24EmzLV9+I3AM4enQJiaukyERrd9J/ILu5cZXTxKuzbNL8PPJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=dCkpMosCr4O9ndoOlQ9
        tTt83YdiZCFEjjptUED8Z9PibAuMZ48bkozOM+NZOLNtbUnbrJm9+dyFshatp1eq
        U04YdSalIK13AwpZ81T0cn44UiSgwh18cc5k61uZ7GTnTKopAhb4GgCPW/TkklLB
        z53FtVZZ4A4vZj4bWyhFfDFk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C89E112B89;
        Wed, 24 Feb 2021 15:26:46 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7CE57112B86;
        Wed, 24 Feb 2021 15:26:43 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 0/3] doc: spell configuration variable names in camelCase
Date:   Wed, 24 Feb 2021 12:26:38 -0800
Message-Id: <20210224202641.913770-1-gitster@pobox.com>
X-Mailer: git-send-email 2.30.1-826-g07a034c5ea
In-Reply-To: <xmqqlfbe1sim.fsf@gitster.g>
References: <xmqqlfbe1sim.fsf@gitster.g>
MIME-Version: 1.0
X-Pobox-Relay-ID: 9BE59722-76DE-11EB-8658-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I said in the first review on Denton's patch

    This obviously does not have to be part of this miniseries, but I
    wonder if we should have a list of all the configuration variables
    in one place that we can use to record the canonical spelling of
    these variables.  As

    $ git grep -h -E -i \
	    -e '^[a-z][-a-z0-9]*\.[a-z][-a-z0-9]*::' \
	    -e '^[a-z][-a-z0-9]*\.(\*|<?[a-z][-a-z0-9]*>?)\.(\*|<?[a-z][-a-z0-9]=
*>?)::' \
	    Documentation/config

    gives many hits with camelCased names, it might be a good place to
    start.

    Pretending that the above gives a good "canonical list" (it does not
    yet, if you look at the hits), I got curious how far we can go.

    Massaging the output from the above into config-variables.lst

    $ ... above command ... |
      sed -e 's/::$//' |
      sort -u >config-variables.lst

    and then to extract use of these tokens in the main part of the
    documentation like this:

    $ git grep -h -o -i -F -f config-variables.lst -- \
      Documentation/ ':!Documentation/RelNotes/' |
      sort -u >config-usage.lst

    gives us something we can compare with the "canonical" usage list.

    $ comm -3 config-usage.lst config-variables.lst
    blame.blankboundary
    core.excludesfile
    core.filemode
    core.gitproxy
    core.ignorestat
    core.logallrefupdates
    core.repositoryformatversion
    core.trustCtime
    http.sslverify
    http.sslversion
    i18n.commitencoding
    push.pushoption
    remote.<name>.partialCloneFilter
    remote.pushdefault
    repack.UseDeltaBaseOffset
    sendemail.aliasesfile
    showbranch.default
    transfer.hiderefs
    uploadArchive.allowUnreachable

    Some of them may be false hits, some may be showing that the copy in
    Documentation/config/ are spelled in all lowercase, but the majority
    of the hits above seem to be genuine errors similar to what you fixed
    in your patch.

    Thanks.

and as I identified a handful of low hanging fruits that way, here
are a few patches on top of his patch that started the whole thing.

I think we should make sure Documentation/config/*.txt=20

 - spells all the configuration variables in the way we want to see
   them, and

 - covers all the configuration variables.

before we can proceed with more low hanging fruits with confidence,
as I do think the coverage is very good, but I know it is not 100%,
and the eventual goal should be to make sure we can teach lint-docs
to catch these before the reviewers even see them.


Denton Liu (1):
  i18n.txt: camel case and monospace "i18n.commitEncoding"

Junio C Hamano (2):
  blame-options.txt: camelcase blame.blankBoundary
  index-format doc: camelCase core.excludesFile

 Documentation/blame-options.txt          | 2 +-
 Documentation/git-am.txt                 | 2 +-
 Documentation/git-mailinfo.txt           | 4 ++--
 Documentation/i18n.txt                   | 2 +-
 Documentation/technical/index-format.txt | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

--=20
2.30.1-826-g07a034c5ea

