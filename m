Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99B0F1F744
	for <e@80x24.org>; Fri,  1 Jul 2016 11:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbcGALOa (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 07:14:30 -0400
Received: from mout.gmx.net ([212.227.17.20]:60158 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751960AbcGALO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 07:14:29 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MMHaL-1bFuf7264T-007z93; Fri, 01 Jul 2016 13:14:24
 +0200
Date:	Fri, 1 Jul 2016 13:14:22 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 8/9] merge-recursive: switch to returning errors instead
 of dying
In-Reply-To: <xmqq7fd73d6s.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607011310050.12947@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <06c09ab4d684c239ae4ae03373c7cc7afb3be60b.1467199553.git.johannes.schindelin@gmx.de> <xmqq7fd73d6s.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sw4lswGcQqyBN/ROD0V3QVIoj1HEL7c/z8GJQ6PaDhcaYHHOpIp
 kC++DWwSUy7r8pnhY2I0FPJFIrl7xe+s2vR4tysd7vzds4829aQI27Z63q4CIi0bP4ovddr
 Pwaqq+aDILchrjLVWYGi0lLsvY4hOFwjdmJnnIz9gLBvsNo+f5RfbUZhcmitDPEFZJVjBDR
 KAA5gCQTDQfz0xF9q6+7A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:KF3t6o+kjXk=:NEXYO76dwPY4RiySAZPKs3
 /6KxI+KJvbUDVVseBmhrZmxIWbYsYy0j003GqwBaFC8c9Iv6/8dkWWvYUmA05df4sA7mVcbOx
 14kFjM48OmjqucD0CDqcLbl620ruBmoFcdu8E3l5DuD8Uq4/0qHjlSRBsVwNMumIXkToT7yy6
 7pCm6Dm8R+2RUshmR+qgBZaB7p8Uzc7PaGYV24dg/R3BwXd3EF22Slvh22S5okSDHWvW0noZp
 2l7+HXfaklRW+vFP9AbxKk5vkMASfhY8ekUM1ogiIgXloh7HizwwiQvqEffMcrK5juI6Ys6EL
 M00THpBEy5+sMlczdKGEr/gSMCj2n6GDmZsjYX+GBh2Nnsr5zvaapn8Ni2jq0hfeHYQ95oSQO
 Pnxew4yBAL3E4upOCh1lTs8QqgxLtXCOWXYgwmlgwHolbKJo0OlSrA05fvMmaJrzdTFlRrEP9
 86d27reqbcBMCSsmT75w7M+SEjEYpnd7Li6ALff6rQPIHzI+Pv7kxJmzCjACMgH2Y8KnBjpMe
 OxXKvm9GEciiflDaZuYiCM+ZS8MK2HrsCFj0cI99tNX9USLrCX4hXn5Pq4QdXqkPUPt5KC6Me
 4eXFnzoZST8x2gV9xT0k9J5IQOKFlfcOe71v9gdM6S0F0OFNMtKMVNmUd7Rsuf8roXMO+w1Z7
 LCw0xTwTV+fsvxKjcU7cOWaM2ZpJm+0LiIVa86/DvhxsqzeM4QDMs7POARTTQr/duFGzleQqj
 xZs2pl6VvNNjDzWfHPcmFkxrmQXWcYom1O9iCXH9Tfu+bU1Ln+KiCB99QkDlSaeuIqd7ZjYys
 TQ0D3d1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 29 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > @@ -743,6 +741,8 @@ static int update_file_flags(struct merge_options *o,
> >  			      int update_cache,
> >  			      int update_wd)
> > ...
> > +			ret = error_errno(_("do not know what to do with %06o %s '%s'"),
> > +				mode, sha1_to_hex(sha), path);
> >  free_buf:
> 
> OK, with a few more users of this label, it no longer looks so
> strange to me to have this label here.
> 
> At least, match the indentation level to the existing one we see
> below, though?

Okay, fixed.

Although I have to say that I do not quite understand the meaning of the
one-space indentation, in particular since the later "error_return" label
lacks it.

> >  		free(buf);
> >  	}
> >   update_index:
> > [...]
> > @@ -1861,7 +1867,7 @@ static int process_entry(struct merge_options *o,
> >  		 */
> >  		remove_file(o, 1, path, !a_mode);
> >  	} else
> > -		die(_("Fatal merge failure, shouldn't happen."));
> > +		return error(_("Fatal merge failure, shouldn't happen."));
> 
> Isn't this BUG()?

I guess it is! Fixed.

Ciao,
Dscho
