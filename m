Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 571CA201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 18:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbdBTSiP convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 20 Feb 2017 13:38:15 -0500
Received: from elnino.lfos.de ([46.165.227.75]:9302 "EHLO elnino.lfos.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751071AbdBTSiO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 13:38:14 -0500
Received: by elnino.lfos.de (OpenSMTPD) with ESMTPSA id a6b0f800 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <git@vger.kernel.org>;
        Mon, 20 Feb 2017 19:38:05 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     git@vger.kernel.org
Message-ID: <148761588216.31363.15518967793189077139@typhoon>
From:   Lukas Fleischer <lfleischer@lfos.de>
User-Agent: alot/0.3.7
Subject: Sending informational messages from upload-pack
Date:   Mon, 20 Feb 2017 19:38:02 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

It would be handy to be able to show a message to the user when
cloning/fetching from a repository (e.g. to show a warning if a
repository is deprecated). This should technically already be possible
using the current pack protocol and sidebands. However, to my knowledge,
there is no easy way to configure this on the server side; writing a
wrapper around git-upload-pack(1) or replacing git-upload-pack(1) seem
to be the only options.

What I have in mind is something like a post-upload hook whose stdout
and stderr are redirected to sideband 2 and 3, respectively. The commit
message of 20b20a22f (upload-pack: provide a hook for running
pack-objects, 2016-05-18) suggests that such a hook should be
implemented as a "config variable hook" rather than a regular hook.

One could think of additional parameters passed to such a hook. For the
purposes I intend to use this, no parameters are needed. However, a
fixed per-repository MOTD would be too inflexible since we are using
namespaces and database accesses to determine whether a repository is
"deprecated".

Am I missing any "easy" already supported way to add such messages
without patching Git or writing a git-upload-pack(1) wrapper? If not,
does this sound general and useful enough to become an official feature?
Are there any alternative suggestions on how to display such messages?

Regards,
Lukas
