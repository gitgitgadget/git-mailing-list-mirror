Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B518E20248
	for <e@80x24.org>; Sun, 17 Mar 2019 18:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfCQSQe (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 14:16:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59183 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfCQSQd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 14:16:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D537A6116F;
        Sun, 17 Mar 2019 14:16:26 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vArizIBQAz2E
        i24KQPr22JPiKTM=; b=Fp5LofkWfrqf85bQT7M7KAkcgovBPuc5x1KeLfgWazFp
        AASOenpwikgIUHDvErvK4gDmzypMSoufvrOCoAkQwfBacrJ+4T9er9ubyWsyBo2t
        NNFiNyQ9J4YLUzWeq9+wONyazslrfwBYyiQH3uenYOJSv3RIMvheTWgEH941Mck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dnZ4ax
        rL+ftwujmRE/lihrl/14ZJSDj32yedz9e+xo2KxBpb53VooLHelpAULsk3ephl3o
        VibL/YPRNnr6GANVwKaWmi8m2NChhxkjMEOvpsC6bOtmi9yKVYpL8MTQEKDq77/J
        /E/GdEICjqmGz72AFutBgd4362ZYjMiYKt59k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE03C6116E;
        Sun, 17 Mar 2019 14:16:26 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 45D576116B;
        Sun, 17 Mar 2019 14:16:23 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/4] completion.commands: fix multiple command removals
Date:   Sun, 17 Mar 2019 14:16:16 -0400
Message-Id: <20190317181620.26727-1-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CACsJy8BuR=syjT1gjTxXXKKaevzpbdRGp+je+rsX6jV96F3sbA@mail.gmail.com>
References: <CACsJy8BuR=syjT1gjTxXXKKaevzpbdRGp+je+rsX6jV96F3sbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: C5B75B7C-48E0-11E9-9629-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Duy Nguyen wrote:
> Poking this thread before it goes completely dead...

I've been meaning to send out a re-rolled version.  I didn't
realize 2 weeks had slipped by already. :/

> On Sat, Mar 2, 2019 at 12:34 AM Todd Zullinger <tmz@pobox.com> wrote:
>>
>> The completion.commands config var must be set in either the system-wi=
de
>> or global config file.  The completion script does not read a local
>> repository config.
>=20
> After the last discussion, I think the consensus was it's ok to allow
> per-repo config so we can just drop this and update the code to read
> from any config file, right?

Yeah.  Here's an updated series which I hope sums up the changes
from the discussion.

Changes since v1:

    - Change --list-commands to respect local config and use
      test_config rather than test_config_global
    - Avoid git upstream of pipes
    - Check that both cherry and mergetool are removed
    - Use __git in completion calls which use --list-cmds, to
      ensure the proper git repo config is checked with git -C
      /some/other/repo

Jeff King (2):
  git: read local config in --list-cmds
  completion: fix multiple command removals

Todd Zullinger (2):
  t9902: test multiple removals via completion.commands
  completion: use __git when calling --list-cmds

 contrib/completion/git-completion.bash | 8 ++++----
 git.c                                  | 7 +++++++
 help.c                                 | 4 ++--
 t/t9902-completion.sh                  | 6 ++++++
 4 files changed, 19 insertions(+), 6 deletions(-)

Range-diff against v1:
1:  385c596510 < -:  ---------- doc: note config file restrictions for co=
mpletion.commands
-:  ---------- > 1:  e51bdea6d3 git: read local config in --list-cmds
2:  ffa5ed9780 ! 2:  2f5e9da9de t9902: test multiple removals via complet=
ion.commands
    @@ -18,11 +18,9 @@
      '
     =20
     +test_expect_failure 'completion.commands removes multiple commands'=
 '
    -+	echo cherry-pick >expected &&
    -+	test_config_global completion.commands "-cherry -mergetool" &&
    -+	git --list-cmds=3Dlist-mainporcelain,list-complete,config |
    -+		grep ^cherry >actual &&
    -+	test_cmp expected actual
    ++	test_config completion.commands "-cherry -mergetool" &&
    ++	git --list-cmds=3Dlist-mainporcelain,list-complete,config >out &&
    ++	! grep -E "^(cherry|mergetool)$" out
     +'
     +
      test_expect_success 'setup for integration tests' '
3:  af029e908d ! 3:  7548dcc23f completion: fix multiple command removals
    @@ -2,16 +2,16 @@
    =20
         completion: fix multiple command removals
    =20
    -    6532f3740b ("completion: allow to customize the completable
    -    command list", 2018-05-20) added the completion.commands config
    -    variable.
    +    Commit 6532f3740b ("completion: allow to customize the completab=
le
    +    command list", 2018-05-20) tried to allow multiple space-separat=
ed
    +    entries in completion.commands. To do this, it copies each parse=
d token
    +    into a strbuf so that the result is NUL-terminated.
    =20
    -    The documentation states multiple commands may be added,
    -    separated by spaces.  Adding multiple commands to remove fails,
    -    only removing the last command in the config.
    -
    -    Fix multiple command removals.
    +    However, for tokens starting with "-", it accidentally passes th=
e
    +    original non-terminated string, meaning that only the final one =
worked.
    +    Switch to using the strbuf.
    =20
    +    Reported-by: Todd Zullinger <tmz@pobox.com>
         Signed-off-by: Jeff King <peff@peff.net>
    =20
      diff --git a/help.c b/help.c
    @@ -38,6 +38,6 @@
     =20
     -test_expect_failure 'completion.commands removes multiple commands'=
 '
     +test_expect_success 'completion.commands removes multiple commands'=
 '
    - 	echo cherry-pick >expected &&
    - 	test_config_global completion.commands "-cherry -mergetool" &&
    - 	git --list-cmds=3Dlist-mainporcelain,list-complete,config |
    + 	test_config completion.commands "-cherry -mergetool" &&
    + 	git --list-cmds=3Dlist-mainporcelain,list-complete,config >out &&
    + 	! grep -E "^(cherry|mergetool)$" out
-:  ---------- > 4:  26bef0b2af completion: use __git when calling --list=
-cmds
