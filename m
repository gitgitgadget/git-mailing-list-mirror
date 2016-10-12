Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD2CE207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 13:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755360AbcJLNKm (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 09:10:42 -0400
Received: from smtprelay03.ispgateway.de ([80.67.29.7]:58016 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755706AbcJLNKi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 09:10:38 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1buJIm-0001Bx-2X; Wed, 12 Oct 2016 15:10:33 +0200
Date:   Wed, 12 Oct 2016 15:10:27 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH v2 2/3] serialize collection of refs that contain
 submodule changes
Message-ID: <20161012131027.GB84247@book.hvoigt.net>
References: <cover.1475851621.git.hvoigt@hvoigt.net>
 <81bdbf6a1295c17c1b9233c91da6e5eb4583785e.1475851621.git.hvoigt@hvoigt.net>
 <CAGZ79kZ5CPTuW2fARDs3BUt89b8H_=P3otZv+Vm5nTV70NLWtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ5CPTuW2fARDs3BUt89b8H_=P3otZv+Vm5nTV70NLWtg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 07, 2016 at 11:16:31AM -0700, Stefan Beller wrote:
> > diff --git a/submodule.c b/submodule.c
> > index 59c9d15905..5044afc2f8 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -522,6 +522,13 @@ static int has_remote(const char *refname, const struct object_id *oid,
> >         return 1;
> >  }
> >
> > +static int append_hash_to_argv(const unsigned char sha1[20], void *data)
> > +{
> > +       struct argv_array *argv = (struct argv_array *) data;
> > +       argv_array_push(argv, sha1_to_hex(sha1));
> 
> Nit of the day:
> When using the struct child-process, we have the oldstyle argv NULL
> terminated array as
> well as the new style args argv_array. So in that context we'd prefer
> `args` as a name for
> argv_array as that helps to distinguish from the old array type.
> Here however `argv` seems to be a reasonable name, in fact whenever we
> do not deal with
> child processes, we seem to not like the `args` name:
> 
>     $ git grep argv_array |wc -l
>     577
>     $ git grep argv_array |grep args |wc -l
>     293
> 
> The rest looks good to me. :)

Thanks. So I do not completely get what you are suggesting: args or kept
it the way it is? Since in the end you are saying it is ok here ;) I
mainly chose this name because I am substituting the argv variable which
is already called 'argv' with this array. That might also be the reason
why in so many locations with struct child_processe's we have the 'argv'
name: Because they initially started with the old-style NULL terminated
array.

I am fine with it either way. Just tell me what you like :)

Cheers Heiko
