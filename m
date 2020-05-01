Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E19C4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 00:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFFC0206C0
	for <git@archiver.kernel.org>; Fri,  1 May 2020 00:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgEAAyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 20:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726384AbgEAAyn (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Apr 2020 20:54:43 -0400
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F50C035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 17:54:43 -0700 (PDT)
Received: from p576124-ipngn200707tokaisakaetozai.aichi.ocn.ne.jp ([122.31.139.124] helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1jUJws-00021C-Ux
        for git@vger.kernel.org; Fri, 01 May 2020 00:54:40 +0000
Received: from glandium by goemon.lan with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1jUJwm-000QIQ-9F
        for git@vger.kernel.org; Fri, 01 May 2020 09:54:32 +0900
Date:   Fri, 1 May 2020 09:54:32 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: git checkout --recurse-submodules doesn't like checking out an older
 commit after a submodule was removed
Message-ID: <20200501005432.h62dnpkx7feb7rto@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Doing the following fails:

$ git clone --recurse-submodules https://github.com/trailofbits/winchecksec/
$ cd winchecksec
$ git checkout --recurse-submodules 93ffe67dbfc757bf6f440d80b8acf88e652ed60a
fatal: not a git repository: ../.git/modules/pe-parse
fatal: could not reset submodule index

The main reason is that the pe-parse directory/submodule was removed in
the commit that follows 93ffe67dbfc757bf6f440d80b8acf88e652ed60a (which
is current master).

This also leaves the tree in a bad state, and it's hard to fix anything
from that state.

Mike
