Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15D891FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 12:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932862AbcH2MKa (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 08:10:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:62867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932839AbcH2MK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 08:10:29 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LgqEs-1bHueG0VHS-00oBkR; Mon, 29 Aug 2016 14:09:34
 +0200
Date:   Mon, 29 Aug 2016 14:09:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 12/15] sequencer: lib'ify save_opts()
In-Reply-To: <xmqqwpj3h1bg.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608291409210.129229@virtualbox>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <7768b55e65c771a5615a6f1209b40395dc705425.1471968378.git.johannes.schindelin@gmx.de> <xmqqwpj3h1bg.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:LHrskEAJLjqAI4504roo8IPVYxoRTryHPcHMEJYNLtmhjzeBMWL
 5KK8G0faZuvEanOyF6ZEJ6ayQ8OEhYTna4d1hlQ30hriV5xSaeZqgNPXD6gciYfSr838gHP
 9swSxHTw04pLkfXKr2PiBLRIqdJyA7elUamtkIUiySwMZAAVBJcWb2SG9Qn6Bro9hgTBZYd
 yMWIOPMUkBUecM+n3b5Bg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KMxOXB4yC3M=:KbygPdAAlp4GxN8/y32OPQ
 +3HiPpVIfMwBRZ6oMqPJsVQIj4OLqOCdDIbb3XAXQGiOyVIu8tMOZRp2+lyns272qkSQ8+7rp
 YHePqRZBZEDMYUAm4TWfUFpAP8uWYi28BhhlJq3k+VFb7qGqV42qhdIj+DTTZ3y/OJeas7ddO
 PiuRxWEA+2Uzop6xP3njFBL5fEjSC93fvHLa7LU5FUGFupoA6uucwoi0dMoaAt1zaZYtZqHYX
 yAXzfM3ju3TYHYnZ3ojBkEp78LA9NbcOigQEBTF+8aLrORwarvTnlCQ+DipkGmcKQ/OdMiCCX
 n1k1g8/80GGnnK2FGynKUMNbFbpDmrxgMq1n4RTlq+DIgFNE1iHL1qdcORgoA8bhrFae+hGaM
 72f8506uHYkJyRkelDbAtSfFhdLHAZ6yA+OOQaW8tUZBx/+8/EulwXCtBMovAnupTiE9Nocvo
 oCzpbj4UUUIu0A2Zb49JL9RA+eN5nbJYv/hSe0+megvGyKYnqFkRsG+kurFBhevsYTRKFqDBS
 ByBE+F9TkjVsD5idOs+FyD5gWbdYNYMlA6PJbmx6Yk7pizqKhJUMiU1y5JWRh2oRstl+ZOx0t
 40e4QhTJ9Pga24qva+RjUnpBN3l6LsZMeJUfr+blqmN9HjOpicERR+aqRftp30nCthiGYu42u
 XuKj7GLgXJrOPp7lf7ge9vmCEPzicbn2zDVVukIHcV4ZquO95btQE6kd75u0/+VUEmtgYrU02
 gR1g2R+y+wEaImyOPYf0idhgM40mg0ZOUdJ/Gn07Vu33a+EFAhgssXePjomUyuLlh8Rf6gCr/
 SgOAEnz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 26 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> >  static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
> > @@ -1128,9 +1130,9 @@ int sequencer_pick_revisions(struct replay_opts *opts)
> >  		return -1;
> >  	if (get_sha1("HEAD", sha1) && (opts->action == REPLAY_REVERT))
> >  		return error(_("Can't revert as initial commit"));
> > -	if (save_head(sha1_to_hex(sha1)))
> > +	if (save_head(sha1_to_hex(sha1)) ||
> > +			save_opts(opts))
> >  		return -1;
> > -	save_opts(opts);
> 
> I think it is much easier to read to keep this on a single line.  It
> would be more verbose but an even easier would be to keep these two
> operations two separate steps, i.e.
> 
>         if (save_head())
>                 return -1;
>         if (save_opts())
>                 return -1;

Done,
Dscho
