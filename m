Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 449041F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 02:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752624AbdAZCzg (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 21:55:36 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:53054 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752453AbdAZCzf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 21:55:35 -0500
Received: from glandium by mitsuha.glandium.org with local (Exim 4.88)
        (envelope-from <mh@glandium.org>)
        id 1cWaDi-0004ov-9l; Thu, 26 Jan 2017 11:55:30 +0900
Date:   Thu, 26 Jan 2017 11:55:30 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: Add some output from gpg when it errors
 out.
Message-ID: <20170126025530.r4fesye447do5wdx@glandium.org>
References: <20170125030434.26448-1-mh@glandium.org>
 <xmqqtw8m7ncp.fsf@gitster.mtv.corp.google.com>
 <20170125235410.byxwmo7o7zdszzot@glandium.org>
 <xmqq8tpy7dh8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8tpy7dh8.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 06:37:55PM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > On Wed, Jan 25, 2017 at 03:04:38PM -0800, Junio C Hamano wrote:
> > ...
> >> Overall I think this is a good thing to do.  Instead of eating the
> >> status output, showing what we got, especially when we know the
> >> command failed, would make the bug-hunting of user's environment
> >> easier, like you showed above.
> >> 
> >> The only thing in the design that makes me wonder is the filtering
> >> out based on "[GNUPG:]" prefix.  Why do we need to filter them out?
> >
> > The [GNUPG:] lines are part of the status-fd protocol. They show details
> > that don't really seem interesting to the user. In fact, they even
> > contain the signed message (yes, in my case, it turns out gpg was
> > actually still signing, but returned an error code...).
> 
> OK, that detail was what was missing in the proposed log message.
> Without that "why do we filter?", readers cannot correctly assess
> why it is a good idea.  I wasn't arguing against filtering it; I
> just wanted to make sure "git log" readers (and "git show" user
> after "git blame" identifies this change in the history) will know
> how we decided to filter lines with the prefix.  
> 
> With that information recorded in the log (or in-code comment, or
> both), if it turns out that some lines with the prefix are useful
> (or some other lines without the prefix are not very useful), they
> can tweak the filtering criteria as appropriate, with confidence
> that they _know_ for what purpose the initial "filter lines with the
> prefix" was trying to serve, and their update is still in the same
> spirit as the original, only executed better.

Come to think of it, and considering that mutt happily signs emails in
the same conditions, maybe it would make sense to just ignore gpg return
code as long as there is a SIG_CREATED message...

Mike
