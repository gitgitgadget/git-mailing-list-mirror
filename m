Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1D66202BB
	for <e@80x24.org>; Wed, 20 Mar 2019 18:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfCTSDw (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 14:03:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50297 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfCTSDw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 14:03:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F3E6855F3F;
        Wed, 20 Mar 2019 14:03:49 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sVYEvg+BXKIL
        B1Kpj0ZZj6kLoCs=; b=J4puk/adEDoJQ/fq8XyC2xYF+kL0EZ7+ChV1kHHsM/xu
        Wzbb7EgjH1uIUfq7yGhGnQs7nSVQkCtxhgIHnT5+xj13oHCwu1SCwuJWc/fiVLuu
        pN4Uk3In69ly9qJmnF06dsq6bowptTLunqkJY9UOOLN6zXG6m2FuQr76zk7Q8Og=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LupNso
        B39+ebQV6k7AQvFWkqMv2zkyYUq+JsPzAaHVPsnTogAgsKjD8wyfN90+hUEBVHkB
        EiGkj3Cxp+7LyUrkjsj6DqwHD5bGW6KVGRduT+O9+Zpd0BZMdm26nHkUiIKA5+tf
        EjxmcTZiU8BH8n2IPAc/OCvUCGgfTcZY56J08=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ED02955F3E;
        Wed, 20 Mar 2019 14:03:49 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.93.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6937955F22;
        Wed, 20 Mar 2019 14:03:45 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 4/4] completion: use __git when calling --list-cmds
Date:   Wed, 20 Mar 2019 14:03:29 -0400
Message-Id: <20190320180329.22280-5-tmz@pobox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CACsJy8DiQwmAKMruOAO4roPbiRTvt5TESBTd682hTwkZjcoj2Q@mail.gmail.com>
References: <CACsJy8DiQwmAKMruOAO4roPbiRTvt5TESBTd682hTwkZjcoj2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 81D57266-4B3A-11E9-B190-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since e51bdea6d3 ("git: read local config in --list-cmds", 2019-03-01),
the completion.commands variable respects repo-level configuration.  Use
__git which ensures that the proper repo config is consulted if the
command line contains 'git -C /some/other/repo'.

Suggested-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 contrib/completion/git-completion.bash | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
index 499e56f83d..e505f04ff7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1010,7 +1010,7 @@ __git_all_commands=3D
 __git_compute_all_commands ()
 {
 	test -n "$__git_all_commands" ||
-	__git_all_commands=3D$(git --list-cmds=3Dmain,others,alias,nohelpers)
+	__git_all_commands=3D$(__git --list-cmds=3Dmain,others,alias,nohelpers)
 }
=20
 # Lists all set config variables starting with the given section prefix,
@@ -1620,9 +1620,9 @@ _git_help ()
 	esac
 	if test -n "$GIT_TESTING_ALL_COMMAND_LIST"
 	then
-		__gitcomp "$GIT_TESTING_ALL_COMMAND_LIST $(git --list-cmds=3Dalias,lis=
t-guide) gitk"
+		__gitcomp "$GIT_TESTING_ALL_COMMAND_LIST $(__git --list-cmds=3Dalias,l=
ist-guide) gitk"
 	else
-		__gitcomp "$(git --list-cmds=3Dmain,nohelpers,alias,list-guide) gitk"
+		__gitcomp "$(__git --list-cmds=3Dmain,nohelpers,alias,list-guide) gitk=
"
 	fi
 }
=20
@@ -2888,7 +2888,7 @@ __git_main ()
 			then
 				__gitcomp "$GIT_TESTING_PORCELAIN_COMMAND_LIST"
 			else
-				__gitcomp "$(git --list-cmds=3Dlist-mainporcelain,others,nohelpers,a=
lias,list-complete,config)"
+				__gitcomp "$(__git --list-cmds=3Dlist-mainporcelain,others,nohelpers=
,alias,list-complete,config)"
 			fi
 			;;
 		esac
