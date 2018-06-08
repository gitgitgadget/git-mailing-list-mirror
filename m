Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89C6E1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 15:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeFHPQD (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 11:16:03 -0400
Received: from forward23p.cmail.yandex.net ([77.88.31.52]:53341 "EHLO
        forward23p.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751140AbeFHPQC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Jun 2018 11:16:02 -0400
X-Greylist: delayed 659 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Jun 2018 11:16:02 EDT
Received: from mxback10g.mail.yandex.net (mxback10g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:171])
        by forward23p.cmail.yandex.net (Yandex) with ESMTP id A8A5721124
        for <git@vger.kernel.org>; Fri,  8 Jun 2018 18:05:00 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback10g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id y7CX0N4qNh-4v78G0Co;
        Fri, 08 Jun 2018 18:04:57 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1528470297;
        bh=aPMZHHBgNpA7tsWLSQlXsZGCywXbkB61QXAPr6mbFes=;
        h=From:To:Subject:Date:Message-Id;
        b=GlkLiGfEy8r/QBKNB3+EtTB8YLDd3hK69NiaRFVOsBTe9ns/KpyNc2mZy+80vwzrd
         JiwsT8jcRWqstJlobpwWbA4xlScte4xyKHP4wOKgXTfZhTRtAcTylZYlEE2QCJUsN+
         w8k8SQ4EGgC5VOIIBt1Bd5gdeEDhdrd4QVpBdVzE=
Authentication-Results: mxback10g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web41o.yandex.ru with HTTP;
        Fri, 08 Jun 2018 18:04:57 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.com
To:     git <git@vger.kernel.org>
Subject: BUG: Merge commits are displayed by `--cherry-pick` despite on they introduce same change
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 08 Jun 2018 18:04:57 +0300
Message-Id: <41901528470297@web41o.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `--cherry-pick` option states:

>Omit any commit that introduces the same change as another commit on the “other side”


For next git command I see next tree:

    $ git log --graph --decorate --pretty=oneline --abbrev-commit --cherry-mark --boundary --left-right
    
    <   bc2820d (openapi3) Merge branch 'openapi3_exception_handling' into openapi3
    |\
    | = 4e1e0aa Testcase for not_found/exception requests to api
    | = b39673d 'not_found' templates should not be probed automatically. Only when fallback
    | = a8677df Dump empty schemas and non empty data
    | = 27db48f Implemente before_render hook
    |/
    <   aa60f0a Merge branch 'hide_temporal_interface' into openapi3
    |\
    | = 5dd02f2 Mutate current object after update
    | = d58c0ab Install missed modules
    |/
    | >   b8d09ce (xtucha/openapi3) Merge branch 'openapi3_exception_handling' into openapi3
    | |\
    | | = b6362ad Testcase for not_found/exception requests to api
    | | = dc926cc 'not_found' templates should not be probed automatically. Only when fallback
    | | = 55dc88d Dump empty schemas and non empty data
    | | = 8369185 Implemente before_render hook
    | |/
    | >   c03438d Merge branch 'hide_temporal_interface' into openapi3
    | |\
    | | = d534cc4 Mutate current object after update
    | | = 1b6af27 Install modules required by MonkeyMan
    | |/
    | > a3b7230 Clarify schema
    |/
    o f5b06ed Assign some defaults

If I want to see only new commit I add `--left-only` option and get merge commits in output.


    <   bc2820d (openapi3) Merge branch 'openapi3_exception_handling' into 
    <   aa60f0a Merge branch 'hide_temporal_interface' into openapi3

This commits introduce same change as another merge commit on the "other side"
Thus they should not be displayed


