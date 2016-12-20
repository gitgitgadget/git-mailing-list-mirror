Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 959161FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 20:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753680AbcLTUsu (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 15:48:50 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:46200 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752783AbcLTUss (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 15:48:48 -0500
Received: from glandium by mitsuha.glandium.org with local (Exim 4.88)
        (envelope-from <mh@glandium.org>)
        id 1cJRKz-0006d0-9Y; Wed, 21 Dec 2016 05:48:41 +0900
Date:   Wed, 21 Dec 2016 05:48:41 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, johan@herland.net
Subject: Re: [PATCH] fast-import: properly fanout notes when tree is imported
Message-ID: <20161220204841.awvabgwsxudxfzca@glandium.org>
References: <20161219021212.15978-1-mh@glandium.org>
 <xmqqk2aujsyb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk2aujsyb.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 20, 2016 at 11:34:04AM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > In typical uses of fast-import, trees are inherited from a parent
> > commit. In that case, the tree_entry for the branch looks like:
> > ...
> > +# Create another notes tree from the one above
> > +cat >>input <<INPUT_END
> > +...
> > +M 040000 $(git log --no-walk --format=%T refs/notes/many_notes) 
> 
> There is a trailing SP that cannot be seen by anybody.
> 
> Don't do this.  It makes it very easy to miss what is going on and
> wastes reviewers' time.
> 
> Protect it by doing something like:
> 
> 	sed -e 's/Z$//' >>input <<INPUT_END
> 	...
> 	M 040000 $(git log --no-walk --format=%T refs/notes/many_notes) Z

How about
EMPTY=
...
M 040000 $(git log --no-walk --format=%T refs/notes/many_notes) $EMPTY

?

Mike
