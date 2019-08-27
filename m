Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83C881F461
	for <e@80x24.org>; Tue, 27 Aug 2019 23:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfH0XVP (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 19:21:15 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:59888 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfH0XVP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 19:21:15 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1i2kly-0008CV-BU; Wed, 28 Aug 2019 08:21:10 +0900
Date:   Wed, 28 Aug 2019 08:21:10 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: revision.c alters commit object state ; also no cleanup
Message-ID: <20190827232110.f3xdnr3i4e2aqenn@glandium.org>
References: <20190826085844.ue77hen2z6rggpe5@glandium.org>
 <xmqq7e6zhk0a.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7e6zhk0a.fsf@gitster-ct.c.googlers.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 11:14:13AM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > First, revision.c doesn't come with a function to clear a struct
> > rev_info....
> > Then, revision.c kind of does nasty things to commit objects...
> 
> Yeah, these two stem from the "run once and let exit() clean things
> up" design the oldest part of the system shares.  Regarding the
> latter, i.e. parent rewriting, I recall that there is a codepath
> that saves the original true parents away in a second field when we
> know we would want to show it (and avoid the overhead of copying
> when we do not have to), so you should be able to extend it to keep
> the original parent list.

I guess you're refering to save_parents/get_saved_parents? Would it make
sense for things to be reversed, as in, make revision.c keep the
simplified parents separately, and traverse through that?

Mike
