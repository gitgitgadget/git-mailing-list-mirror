Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E95C31FD09
	for <e@80x24.org>; Sat, 27 May 2017 09:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754636AbdE0JND (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 May 2017 05:13:03 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:34196
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751648AbdE0JNC (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 27 May 2017 05:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1495876380;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=FcvAFkT8NqQ+PCpZzNHEvufzbt9TBA0CafMavTk9wUg=;
        b=VYi7yMZC4KL6A75mpiD2G7c+37N2lxjOI0HHIxqdkNyJkVy3jLMtCTfQ57U9Toro
        6C5Zgs9xp1GfI2urWm1OXoAxmxQyqtAGnXNLaCnBGtKUekhEdwu0fHwGLllfQqHv/6h
        w+fJr3cuCA0sboDo2cNcP2DTady7KWGllc2GipTY=
From:   =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015c492e27c6-669f7ca8-e7c6-484f-9c5b-7cb9358ee966-000000@eu-west-1.amazonses.com>
Subject: [PATCH] wildmatch test: cover a blind spot in "/" matching
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date:   Sat, 27 May 2017 09:13:00 +0000
X-SES-Outgoing: 2017.05.27-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test which covers a blindspot in how these tests should assert
that negated character classes are allowed or not allowed to match "/"
in certain circumstances.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 t/t3070-wildmatch.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
index ef509df35160..65ea07b68356 100755
--- a/t/t3070-wildmatch.sh
+++ b/t/t3070-wildmatch.sh
@@ -82,6 +82,7 @@ match 1 0 'foo/bar' 'foo/**/bar'
 match 1 0 'foo/bar' 'foo/**/**/bar'
 match 0 0 'foo/bar' 'foo?bar'
 match 0 0 'foo/bar' 'foo[/]bar'
+match 0 0 'foo/bar' 'foo[^a-z]bar'
 match 0 0 'foo/bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
 match 1 1 'foo-bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
 match 1 0 'foo' '**/foo'
@@ -226,6 +227,7 @@ pathmatch 0 foo/bba/arr 'foo/*z'
 pathmatch 0 foo/bba/arr 'foo/**z'
 pathmatch 1 foo/bar 'foo?bar'
 pathmatch 1 foo/bar 'foo[/]bar'
+pathmatch 1 foo/bar 'foo[^a-z]bar'
 pathmatch 0 foo '*/*/*'
 pathmatch 0 foo/bar '*/*/*'
 pathmatch 1 foo/bba/arr '*/*/*'

--
https://github.com/git/git/pull/362
