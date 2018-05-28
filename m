Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE6AA1F42D
	for <e@80x24.org>; Mon, 28 May 2018 13:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163282AbeE1N3Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 09:29:16 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:43264 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939138AbeE1N3O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 09:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VeUjSzID002Ix8paGGSLfUAy1WmmkpDfhxFupnP7rX4=; b=KbBldEAkDk370Z+RpP/HljNLiS
        7qTfBPtGaM18X8L2eD6tV2SgaEroyqkkwhwLbLcY+GkQOXHYMGgBWWjLWIijfukuXZNaC9HDTdpvg
        e/jyZ1X+tQfUA3oeVblVzeTww8bMZCbkegoU9q5OC+/crJp0PDRRMnHncQsY9Soz+6XsEbIHKTX51
        l2ERoZbNYzFKmtUnbx6gNN/oBH9XFy0hw9alXFiPKx5nsWPRukDLYwrXD2pQ6pg4R3FguB/5AKL2G
        EWB8YGRuCtF5JeSx/IXwzntn7OPBYICG3f06/Z8CkV57ejy56Qc64iWg1zWW1Ks+A9vI5PWetd7Uc
        9evSf34Q==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:46132 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fNICz-002Gqd-Cq
        for git@vger.kernel.org; Mon, 28 May 2018 09:29:11 -0400
Date:   Mon, 28 May 2018 09:27:18 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: why does builtin/init-db.c mention
 "/etc/core-git/templates/hooks/update"?
Message-ID: <alpine.LFD.2.21.1805280920100.12022@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  just noticed this in builtin/init-db.c:

... snip ...
#ifndef DEFAULT_GIT_TEMPLATE_DIR
#define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
#endif
... snip ...
static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
                             DIR *dir)
{
        size_t path_baselen = path->len;
        size_t template_baselen = template_path->len;
        struct dirent *de;

        /* Note: if ".git/hooks" file exists in the repository being
         * re-initialized, /etc/core-git/templates/hooks/update would
         * cause "git init" to fail here.  I think this is sane but
         * it means that the set of templates we ship by default, along
         * with the way the namespace under .git/ is organized, should
         * be really carefully chosen.
         */
... snip ...

  should the reference to /etc/core-git/templates/hooks/update instead
refer to the directory /usr/share/git-core/templates/..., given the
default directory defined just a few lines above it? (there is no such
directory, /etc/core-git/, on my system.)

  more to the point, is that actually what the "update" hook does? i
just looked at the shipped sample, "update.sample", and it seems to be
related to tags:

  #!/bin/sh
  #
  # An example hook script to block unannotated tags from entering.
  # Called by "git receive-pack" with arguments: refname sha1-old sha1-new
  #
  # To enable this hook, rename this file to "update".

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
