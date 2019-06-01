Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A7D31F462
	for <e@80x24.org>; Sat,  1 Jun 2019 00:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfFAAMf (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 20:12:35 -0400
Received: from resqmta-po-04v.sys.comcast.net ([96.114.154.163]:34106 "EHLO
        resqmta-po-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726483AbfFAAMf (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 May 2019 20:12:35 -0400
Received: from resomta-po-05v.sys.comcast.net ([96.114.154.229])
        by resqmta-po-04v.sys.comcast.net with ESMTP
        id WrX3hmrK8d4wBWrdShhEWC; Sat, 01 Jun 2019 00:12:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559347954;
        bh=We1YiSJPP7VWIsYZTHDveQAFvMG1CMp3C6k7/xajmFA=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=J7XIREl8I6un1rTzumq4GT9ZPCBMAXLvf/KMJsYXtG7c6VIkgvrdpxSpY1CmOX/QA
         uwU0p73Qj7rlcdWGP7A+StssWG40nGci/Wi4xHgTDnvXYap6R8coCojyMuU+jUPqYv
         TuqdLKpZj6zXaz6DF5eBehsglz17bLUc7Iqbn8ebVmtSoQq1XbMGeNZoTJqs+/HocS
         bdRaL92UnDXmz1WTwwFj71ixYwNWQywuJEmIEawwdrAQnS++hW4GyHeD02IqD6q4pG
         Ww6rOr3FRqDVN5AOycYbSu83H04Ok77qTjJg3W6l9rCjxafkmhiDQMzCmzYYLEB2rL
         H7F9PYoNOVfrA==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:a4f1:9a8c:7e29:36eb])
        by resomta-po-05v.sys.comcast.net with ESMTPSA
        id WrdPhzE2EDlddWrdRhN5CJ; Sat, 01 Jun 2019 00:12:33 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Date:   Fri, 31 May 2019 17:12:31 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Jeff King <peff@peff.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v1 3/5] list-objects-filter: implement composite filters
Message-ID: <20190601001231.GF4641@comcast.net>
References: <cover.1558484115.git.matvore@google.com>
 <1f95597eedc4c651868601c0ff7c4a4d97ca4457.1558484115.git.matvore@google.com>
 <20190528215359.GB133078@google.com>
 <20190531204821.GC4641@comcast.net>
 <20190531211041.GA19792@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531211041.GA19792@sigill.intra.peff.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 31, 2019 at 05:10:42PM -0400, Jeff King wrote:
> On Fri, May 31, 2019 at 01:48:21PM -0700, Matthew DeVore wrote:
> 
> > > > +static int digit_value(int c, struct strbuf *errbuf) {
> > > > +	if (c >= '0' && c <= '9')
> > > > +		return c - '0';
> > > > +	if (c >= 'a' && c <= 'f')
> > > > +		return c - 'a' + 10;
> > > > +	if (c >= 'A' && c <= 'F')
> > > > +		return c - 'A' + 10;
> > > 
> > > I'm sure there's something I'm missing here. But why are you manually
> > > decoding hex instead of using strtol or sscanf or something?
> > > 
> > 
> > I'll have to give this a try. Thank you for the suggestion.
> 
> Try our hex_to_bytes() helper (or if you really want to go low-level,
> your conditionals can be replaced by lookups in the hexval table).
> 
> -Peff

Using hex_to_bytes worked out quite nicely, thanks!
