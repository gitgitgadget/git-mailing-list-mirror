Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BB9C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 05:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CD2161357
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 05:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbhHYFyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 01:54:23 -0400
Received: from ikke.info ([178.21.113.177]:42084 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232420AbhHYFyV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 01:54:21 -0400
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Aug 2021 01:54:21 EDT
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 951D244010B; Wed, 25 Aug 2021 07:45:05 +0200 (CEST)
Date:   Wed, 25 Aug 2021 07:45:05 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Stef Bon <stefbon@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: Get tree of remote repository using custom ssh library.
Message-ID: <YSXY4WoB+Z1aayz4@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>, Stef Bon <stefbon@gmail.com>,
        Git Users <git@vger.kernel.org>
References: <CANXojcyX2uqAp5gLtfH8ffQFQBKkMoPqSzpDUnbFe0QBd5nJqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXojcyX2uqAp5gLtfH8ffQFQBKkMoPqSzpDUnbFe0QBd5nJqg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 22, 2021 at 08:47:18PM +0200, Stef Bon wrote:
> Hi,
> 
> I want to add git support to my fuse workspace, enable browsing of the
> users repositories.
> I've got a custom ssh library:
> 
> struct ssh_channel_s *channel=create_channel(session, _CHANNEL_TYPE_SESSION);
> if (channel==NULL) return -1;
> set_channel_exec(channel, command);
> 
> if (add_channel(channel, CHANNEL_FLAG_OPEN)==-1) goto free;
> 
> if (send_channel_start_command_message(channel, 1, &seq)>0) {
>      struct ssh_payload_s *payload=NULL;
> 
>       payload=get_ssh_payload_channel(channel, &expire, &seq, &error);
> 
>       if (payload && payload->type==SSH_MSG_CHANNEL_DATA) {
> 
> .... process the received data
>       }
>       free_payload(&payload);
> }
> 
> Now I read:
> 
> https://git-scm.com/book/en/v2/Git-Internals-Transfer-Protocols
> and
> https://www.git-scm.com/docs/protocol-v2
> 
> How can I get remote repositories of a user on a server (say
> github.com, user stefbon) and browse each HEAD repository and the
> source tree?
> 
> Stef Bon

Hello Stef,

Git has no way of knowing what repositories might exist on a
given server. They might live everywhere, and git does not keep track of
what repositories are created on a central location, so there is not
central directory to query.

Besides that, services like github do not let you remotely browse
repositories over SSH, they only allow you to run git-upload-pack /
git-receive-pack or equivalent to handle the git protocol.

The only way to programatically explore what is available remotely is to
use an API that exposes this information (most public git forges provide
one).

Hope this helps, Kevin
