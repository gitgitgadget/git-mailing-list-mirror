Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF8D520195
	for <e@80x24.org>; Fri, 15 Jul 2016 12:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbcGOMcx (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 08:32:53 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:58350 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035AbcGOMcw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 08:32:52 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1bO2IP-0006G4-2o; Fri, 15 Jul 2016 21:32:45 +0900
Date:	Fri, 15 Jul 2016 21:32:45 +0900
From:	Mike Hommey <mh@glandium.org>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] blame: Allow to blame paths freshly added to the index
Message-ID: <20160715123245.rdpbl4tmqscyf2tx@glandium.org>
References: <20160715024254.29186-1-mh@glandium.org>
 <alpine.DEB.2.20.1607151242020.6426@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607151242020.6426@virtualbox>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.1-neo (2016-06-11)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 15, 2016 at 12:45:15PM +0200, Johannes Schindelin wrote:
> Hi Mike,
> 
> On Fri, 15 Jul 2016, Mike Hommey wrote:
> 
> > When blaming files, changes in the work tree are taken into account
> > and displayed as being "Not Committed Yet".
> > 
> > However, when blaming a file that is not known to the current HEAD,
> > git blame fails with `no such path 'foo' in HEAD`, even when the file
> > was git add'ed.
> > 
> > This would seem uninteresting with the plain `git blame` case, which
> > it is, but it becomes useful when using copy detection, and the new file
> > was created from pieces already in HEAD, moved or copied from other
> > files.
> > ---
> 
> Well explained.
> 
> Please add your sign-off.

Facepalm, forgot to sign-off again.

> >  static struct commit_list **append_parent(struct commit_list **tail, const unsigned char *sha1)
> > diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
> > index a9b266f..a0a09e2 100755
> > --- a/t/t8003-blame-corner-cases.sh
> > +++ b/t/t8003-blame-corner-cases.sh
> > @@ -137,6 +137,29 @@ test_expect_success 'blame wholesale copy and more' '
> >  
> >  '
> >  
> > +test_expect_success 'blame wholesale copy and more in the index' '
> > +
> > +	{
> > +		echo ABC
> > +		echo DEF
> > +		echo XXXX
> > +		echo YYYY
> > +		echo GHIJK
> > +	} >horse &&
> 
> A more common way to do this in our test scripts is by using here
> documents. However, in this case I would suggest
> 
> 	test_write_lines ABC DEF XXXX YYYY GHIJK >horse

I merely copied the pattern used in other places in the same test file.
Using test_write_lines or something else (what are "here documents"?)
would break consistency. I can also change the other similar blocks at
the same time, though, whichever you prefer.

> instead. The equivalent applies to the 'expected' file below:
> 
> > +	git add horse &&
> > +	git blame -f -C -C1 -- horse | sed -e "$pick_fc" >current &&
> > +	{
> > +		echo mouse-Initial
> > +		echo mouse-Second
> > +		echo cow-Fifth
> > +		echo horse-Not
> > +		echo mouse-Third
> > +	} >expected &&
> > +	test_cmp expected current &&
> > +	git rm -f horse
> 
> Should this not be a
> 
> 	test_when_finished "git rm -f horse"
> 
> at the beginning?

Indeed.

Thanks

Mike
