Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DE351F462
	for <e@80x24.org>; Thu, 13 Jun 2019 17:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393304AbfFMRRG (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 13:17:06 -0400
Received: from resqmta-po-08v.sys.comcast.net ([96.114.154.167]:52318 "EHLO
        resqmta-po-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728555AbfFLVVs (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 12 Jun 2019 17:21:48 -0400
Received: from resomta-po-13v.sys.comcast.net ([96.114.154.237])
        by resqmta-po-08v.sys.comcast.net with ESMTP
        id b8mqhYfgz1iPKbAglh8JdP; Wed, 12 Jun 2019 21:21:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1560374507;
        bh=zcAMMQZsJ8cZVXT7CdTb+QTtwK3ryTG0jeTehdcUMsw=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=5J/dHii/4lOd/nY4Smwf+EMnK1SXDMUaEA+tRYFtSEibhK/8o0y5e3My9UonQIT77
         BFFfnbs+Oglez/x5ORrYLU/8k4JKF60naGjFDi9ZxpVIpzKBraz1vtId4FyF7Jm0+/
         30nxmhLdPKh1h4pBEHqFF20krVB+8XM1x43+oM1laMyWtMLcETJg8lzjNIFsSZH+Q6
         aMbqnUvqTNsU4azpOEBU2fYPNMny9EpXvlhePNE+pa4WjznQo/oqARHdQLv8NR2RLV
         3ssrET7rSyP+trZegE6GEPO7Jaroli2tjKWJuUyCvhEjypgD4BlCb4j/nrOCrEyDRw
         cEyEzt9qL8G5A==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:8063:176b:924:d4ca])
        by resomta-po-13v.sys.comcast.net with ESMTPSA
        id bAgBhSdzyBnAXbAgFhk0dd; Wed, 12 Jun 2019 21:21:44 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Wed, 12 Jun 2019 14:21:11 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        avarab@gmail.com, git@matthieu-moy.fr, olyatelezhnaya@gmail.com,
        samuel.maftoul@gmail.com, Johannes.Schindelin@gmx.de,
        karthik.188@gmail.com, pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 1/1] ref-filter: sort detached HEAD lines firstly
Message-ID: <20190612212111.GF58112@comcast.net>
References: <faaa9a3d6ba66d77cc2a8eab438d1bfc8f762fa1.1559857032.git.matvore@google.com>
 <cover.1560277373.git.matvore@google.com>
 <cf0246a5cce6cbd9b4a1fd1eefa0f5cbc2cfcaf0.1560277373.git.matvore@google.com>
 <xmqq7e9rlw72.fsf@gitster-ct.c.googlers.com>
 <xmqqo932ik7y.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo932ik7y.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 12, 2019 at 02:09:53PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> +		/*
> >> +		 * When sorting by name, we should put "detached" head lines,
> >> +		 * which are all the lines in parenthesis, before all others.
> >> +		 * This usually is automatic, since "(" is before "refs/" and
> >> +		 * "remotes/", but this does not hold for zh_CN, which uses
> >> +		 * full-width parenthesis, so make the ordering explicit.
> >> +		 */
> >> +		if (a_detached != (b->kind & FILTER_REFS_DETACHED_HEAD))
> >> +			cmp = a_detached ? -1 : 1;
> >
> > So, comparing a detached and an undetached ones, the detached side
> > always sorts lower.  Good.  And ...
> >
> >> +		else
> >> +			cmp = cmp_fn(va->s, vb->s);
> >
> > ... otherwise we compare the string using the given function.
> >
> > Sounds sensible.  Will queue.
> 
> Stepping back a bit, why are we even allowing the surrounding ()
> pair to be futzed by the translators?

I was thinking about removing () from the translated strings, but decided
against it since there are a lot of full-width parenthesis in the translated
strings already:

$ cd po; git grep -B 1 'msgstr.*（'
... 246 matches in zh_CN ...

and it seems strange to force only a few pairs of parens to be half-width to
make the code simpler. I don't know if that's a great argument, since it is
somewhat aesthetic. I would have liked half-width parens more if it were
closing off purely ASCII text. But it is in fact surrounding Chinese text:

$ git branch
* （头指针分离于 cf0246a5cc）

> 
> IOW, shouldn't our code more like this from the beginning, with or
> without Chinese translation?
> 
> With a bit more work, we may even be able to lose "make sure this
> matches the one in wt-status.c" comment as losing the leading '('
> would take us one step closer to have an identical string here as we
> have in wt-status.c
> 
>  ref-filter.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/ref-filter.c b/ref-filter.c
> index 8500671bc6..7e4705fcb2 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1459,20 +1459,22 @@ char *get_head_description(void)
>  		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
>  			    state.branch);
>  	else if (state.detached_from) {
> +		strbuf_addch(&desc, '(');
>  		if (state.detached_at)
>  			/*
>  			 * TRANSLATORS: make sure this matches "HEAD
>  			 * detached at " in wt-status.c
>  			 */
> -			strbuf_addf(&desc, _("(HEAD detached at %s)"),
> -				state.detached_from);
> +			strbuf_addf(&desc, _("HEAD detached at %s"),
> +				    state.detached_from);
>  		else
>  			/*
>  			 * TRANSLATORS: make sure this matches "HEAD
>  			 * detached from " in wt-status.c
>  			 */
> -			strbuf_addf(&desc, _("(HEAD detached from %s)"),
> +			strbuf_addf(&desc, _("HEAD detached from %s"),
>  				state.detached_from);
> +		strbuf_addch(&desc, ')');
>  	}
>  	else
>  		strbuf_addstr(&desc, _("(no branch)"));
> 
> 
