Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27960C2BB85
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 11:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F40B20656
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 11:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506106AbgDPLeT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633404AbgDPLeO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 07:34:14 -0400
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90D8C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 04:34:14 -0700 (PDT)
Received: from p576124-ipngn200707tokaisakaetozai.aichi.ocn.ne.jp ([122.31.139.124] helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1jP2mY-0000Ua-FF
        for git@vger.kernel.org; Thu, 16 Apr 2020 11:34:10 +0000
Received: from glandium by goemon.lan with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1jP2mS-000Kkf-6G
        for git@vger.kernel.org; Thu, 16 Apr 2020 20:34:04 +0900
Date:   Thu, 16 Apr 2020 20:34:04 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: Re: Order of operations at the end of fast-import?
Message-ID: <20200416113404.pr2hzihavdvtfjh3@glandium.org>
References: <20200416042449.ztgyrdunsrzt7avp@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416042449.ztgyrdunsrzt7avp@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 16, 2020 at 01:24:49PM +0900, Mike Hommey wrote:
> Hi,
> 
> I just noticed that the order of operations at the end of fast-import
> are:
> - end_packfile
> - dump_branches
> - dump_tags
> 
> The first may create loose objects if the pack is small (per
> fastimport.unpackLimit, defaulting to 100). The latter two create refs.
> 
> There seems to be a theoretical race condition here, if something else
> triggers a gc at the "wrong" time, the loose objects might be cleaned up
> and the branches/tags refs become dangling.

Come to think of it, this is only a problem with --prune=now, and the
same applies to loose objects created with git add, git write-tree,
git-commit-tree.

Mike
