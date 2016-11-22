Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C14781FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 16:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755212AbcKVQLH (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 11:11:07 -0500
Received: from mout.gmx.net ([212.227.15.15]:59649 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752746AbcKVQLG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 11:11:06 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MHHZT-1bwpKY1TeN-00E3eU; Tue, 22
 Nov 2016 17:11:01 +0100
Date:   Tue, 22 Nov 2016 17:11:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] stripspace: respect repository config
In-Reply-To: <20161121190514.18574-2-gitster@pobox.com>
Message-ID: <alpine.DEB.2.20.1611221710470.3746@virtualbox>
References: <xmqq7f7wk7x9.fsf@gitster.mtv.corp.google.com> <20161121190514.18574-1-gitster@pobox.com> <20161121190514.18574-2-gitster@pobox.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QeQIkFJnHx364YLHs5sGpme+fceumSY2yQqYkmQ11awsPgCdNoP
 TTLszt3n6LShdyuPHY3Mjfa3IMQ47aW3Acoo3pE8hM4vVi4nuzc/6NBcDqoIdExzxFntL1r
 EsBuUU/EaSzAxqXZXH7bKFl4hGBzx8mmcT9c8V3bBqSvV+dsTERoFd2D9rBJyzNwi5fO4Z6
 GzGE3S0FUwGr+hHzDD3Gw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4AyIczxcazc=:VROzg4TpWGuqMAOwiu3WS+
 FJ4gBrSoVyQngkW2JjxXYw7UGrjZZm4d7WTO9rTbRoQRnkh18B2/eZ7YT9cQBssONuv+Breq/
 /BRQBP957RYD4cUvkX6FBJS4dgYumMi2yszOW++FmGDufoSsQvxnaPfBCNVgnj5IYZyEqHubh
 CWqSEKMVMaKh6Z0VeuHMyvCzpwDws08qfbwuct1K2H6wUDQ8p0MiSZkTuWEs5UEYWEh8GQT/6
 dfJH+neWVxsPe8Kx2wlOgKC2c0fJCg8TtvaBTtapliZ3CEyvj6Lys5MFJVC8MSPYLt2upxLlt
 eiC7EWddK3it3hEIsiQGqUL7DkzqyvYpYovSHx62yxQhQbRiGB6gFv/C41KYUtmvginXaXDhk
 sjBt+ZWzv5HyPsflVPuIKvnSkOMppxnsDiSP8bYO9pdUtJz+MMdCwBSUboUhLx6m2ERbNN8Ev
 KKnqreTNy0VPxInP7Zzc4hmfg70ZUx9DDEFKsIkt2QznW7ugBKlKR10OYfgCWmvtU0JxfFV9Q
 xWBzFx9XJpVwcVq89psG+94pxCoV+2OlGhbRRBygyMC41FoPomDrJnz69EqyCBewlka3UOgk1
 oz4QPxO4U5UVUwAShFIMKEK/oUP3XKFZ/3bg3ZdxN8y0chaRTo2uj8FtvTy1SqYkgyDntZxZ7
 da1kvEyquMf2xzURYkTXFegH6Jx7tpv7+b01cCeOj6aKbfnzgdAKWYh3G5rMhgrvHUe8SHQG/
 lSkFU6MQRVfvJfcMLoOlkhTGXMZn9nNerB1vY1oS8OM1NqcruRG35GTlQJdGzHot5Rdbx9Qwl
 ljhOBSFMmpBJ5XiOhpfkIH4dzpk+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 21 Nov 2016, Junio C Hamano wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The way "git stripspace" reads the configuration was not quite
> correct, in that it forgot to probe for a possibly existing
> repository (note: stripspace is designed to be usable outside the
> repository as well) before doing so.  Due to this, .git/config was
> read only when the command was run from the top-level of the working
> tree.  
> 
> A recent change b9605bc4f2 ("config: only read .git/config from
> configured repos", 2016-09-12) stopped reading the repository-local
> configuration file ".git/config" unless the repository discovery
> process is done, and ".git/config" is no longer read even when run
> from the top-level, which exposed the bug even more.
> 
> When rebasing interactively with a commentChar defined in the
> current repository's config, the help text at the bottom of the edit
> script potentially used an incorrect comment character. This was not
> only funny-looking, but also resulted in tons of warnings like this
> one:
> 
> 	Warning: the command isn't recognized in the following line
> 	 - #
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks for the corrected commit message!
Dscho
