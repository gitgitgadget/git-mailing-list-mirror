Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D50F1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 19:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbcHIT3H (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 15:29:07 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:45859 "EHLO
	mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932235AbcHIT3G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 15:29:06 -0400
Received: from teco.navytux.spb.ru (pppoe.178-66-1-64.dynamic.avangarddsl.ru [178.66.1.64])
	by mail2.tiolive.com (Postfix) with ESMTPSA id 3AC12BF0332;
	Tue,  9 Aug 2016 21:29:03 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
	(envelope-from <kirr@teco.navytux.spb.ru>)
	id 1bXChy-0008KM-64; Tue, 09 Aug 2016 22:29:02 +0300
Date:	Tue, 9 Aug 2016 22:29:02 +0300
From:	Kirill Smelkov <kirr@nexedi.com>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	=?iso-8859-1?Q?J=E9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-objects: Teach --use-bitmap-index codepath to
 respect --local, --honor-pack-keep and --incremental
Message-ID: <20160809192858.GA25822@teco.navytux.spb.ru>
References: <20160808135020.yggthtfekdiwq3lz@sigill.intra.peff.net>
 <20160808181942.GD3995@teco.navytux.spb.ru>
 <xmqqoa53dpue.fsf@gitster.mtv.corp.google.com>
 <20160809112123.GA14273@teco.navytux.spb.ru>
 <xmqqtwetc2bh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtwetc2bh.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 09, 2016 at 09:52:18AM -0700, Junio C Hamano wrote:
> Kirill Smelkov <kirr@nexedi.com> writes:
> 
> > Would you please explain why we should not use touch if we do not care
> > about timestamps? Simply style?
> 
> To help readers.
> 
> "touch A" forcess the readers wonder "does the timestamp of A
> matter, and if so in what way?" and "does any later test care what
> is _in_ A, and if so in what way?"  Both of them is wasting their
> time when there is no reason why "touch" should have been used. 

I see, thanks for explaining. I used to read it a bit the other way;
maybe it is just an environment difference.


> > diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> > index cce95d8..44914ac 100755
> > --- a/t/t5310-pack-bitmaps.sh
> > +++ b/t/t5310-pack-bitmaps.sh
> > @@ -8,16 +8,15 @@ objpath () {
> >  }
> >  
> >  # show objects present in pack ($1 should be associated *.idx)
> > -packobjects () {
> > -	git show-index <$1 | cut -d' ' -f2
> > +pack_list_objects () {
> > +	git show-index <"$1" | cut -d' ' -f2
> >  }
> 
> pack-list-objects still sounds as if you are packing "list objects",
> though.  If you are listing packed objects (or objects in a pack),
> list-packed-objects (or list-objects-in-pack) reads clearer and more
> to the point, at least to me.

Ok, let it be list_packed_objects().


> > -# hasany pattern-file content-file
> > +# has_any pattern-file content-file
> >  # tests whether content-file has any entry from pattern-file with entries being
> >  # whole lines.
> > -hasany () {
> > -	# NOTE `grep -f` is not portable
> > -	git grep --no-index -qFf $1 $2
> > +has_any () {
> > +	grep -qFf "$1" "$2"
> 
> Omitting "-q" would help those who have to debug breakage in this
> test or the code that this test checks.  What test_expect_success
> outputs is not shown by default, and running the test script with
> "-v" would show them as a debugging aid.

Ok, makes sense. Both patches adjusted and will be reposted.

Thanks,
Kirill
