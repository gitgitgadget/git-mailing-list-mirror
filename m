Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196BF1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 23:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfFZXwv (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 19:52:51 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:42580 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfFZXwv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 19:52:51 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1hgHiZ-0005Zt-GE
        for git@vger.kernel.org; Thu, 27 Jun 2019 08:52:47 +0900
Date:   Thu, 27 Jun 2019 08:52:47 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: Multiple urls for remotes?
Message-ID: <20190626235247.nhw45da52rz46mad@glandium.org>
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

I was surprised to figure out that urls/pushurls set up for remotes can
be set multiple times, and that those urls end up being used
sequentially.

Sadly, this has the side effect that one cannot override the config from
the command line, as the url is then added as an extra url, which is
tried after the already configured one.

e.g.
    git -c remote.origin.url=/tmp/foo push origin

will keep pushing to wherever the .git/config's remote.origin.url points
to.

With all the configuration items that work this way, it's actually kind
of sad that it's not possible to force the value from the command line to
override anything that is set in the configuration.

It's worth noting that the documentation for -c says:

    Pass a configuration parameter to the command. The value given will
    override values from configuration files.

... which implies -c remote.origin.url=/tmp/foo should, in fact, replace
any other value already set.

Coming back to the fact that remote.origin.url and remote.origin.pushurl
can actually have multiple values, it's also worth noting that none of
the git-config, git-fetch or git-push documentation seem to say anything
about the fact there can be multiple values.

The git-config documentation says:
   remote.<name>.url
       The URL of a remote repository. See git-fetch(1) or git-push(1).

   remote.<name>.pushurl
       The push URL of a remote repository. See git-push(1).

The git-fetch and git-push documentations always talk about _the_ URL.

The only thing that seems to be talking about this is the documentation
for git-remote, which has --add for set-url. There doesn't seem to be any
documentation about what conditions are required for the non-primary URL
to be used.

Mike
