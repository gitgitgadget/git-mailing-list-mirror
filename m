Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38CDB20189
	for <e@80x24.org>; Wed, 22 Jun 2016 20:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbcFVUVE (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 16:21:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:63319 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751868AbcFVUVD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 16:21:03 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MZCxA-1ax3s31NnQ-00KvjY; Wed, 22 Jun 2016 22:20:55
 +0200
Date:	Wed, 22 Jun 2016 22:20:54 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Make find_commit_subject() consistent with
 --format=%s
In-Reply-To: <xmqq1t3pnnpq.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606222220240.10382@virtualbox>
References: <901b24554eb4d0381d74ceb31f7bd08709d5eb25.1466512959.git.johannes.schindelin@gmx.de> <cover.1466587806.git.johannes.schindelin@gmx.de> <xmqq1t3pnnpq.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uWfka7RKxWtVQMEJRrXFzn5MgwwJyyPmGuWk0gPX0KfdkQFoX31
 jrLhHPuAmKzQ1jF+7BK3eN2Rawpd+qXE+Wq2LtgqArER+ArYaYb9dWDbtTZ0a3fIClkfWoN
 8BxLoc+LZ5maTIhyxtZOpEUosv1tq5PJvpu60BDJ0h6kuYoi7mpU+XRORvUdz2+EaKEOwVS
 lgEaAgWj3a9S5qrZ9qTVg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:1/CIjY11zeo=:4szfnpuiLkwR9HOC+gC+V6
 WGeZmjMUY8oWXgZRdjM/yNlLG7TrI71GTTrk5jLDTadKRwVR+7m4vpZZTAQf6A+ZUdG+UimXB
 zG6IAUztE6Yz9+f7y7B89xCz6XRaPpV2mZMvVCndnfzawy422l6iOzwgQwqq93l6zFAGERyhZ
 uIgEZdRplnDTBdbUJEDzpV/D4zFmDy31J2GY6T6GfCMEPj4iLQzVcEKB4lnwdznvEjQsI94pF
 TA1dm+UFiTm5gXOt+0IOQcN8faOAl0WKKaGRXx1ZvMS3vZm/4ZvI8U862BBPFa6vCXneNooOe
 bA1CbMDD7uPazZZ+01aVW7QxFGdWYENsilphmJTlAIG5eoVCu78GVFfREUOmWe9cO1Ranidg9
 v+b8d5ckCF+ZtbagQLgFn0XY7FhJ3ZRVC+rQ6O0jqNvAV7mmY19To/RxsJW78iKoVs1c4eVhf
 7/gzgn00IAdJDzpbK3HyTjTKLFiHPosbWEkgvzjTZcdZqk5UUWutIw0RG5If8ft/V3SSPyvJo
 R4a07zKzurL6pwLZHXmFTcxfmT4U9aEkvzi3/b5m8iaO4COOHKv3Gna6tZGYCBzbtSaNmEoM/
 gwDAWi6PBzonoCP1Yn7fReiCLxsSWUxgyoqpxYhFthIjzcZasdrzG4NJEYi5hmtl4Wy5wIyNr
 DBy5eb37X/2epAWp/31A8JzbNvSMJdWph9u2ITA+0YkcEZoFRV5aNWGvr6+2IvHlqOpaSm/WU
 hIDi4sztIAXMqXomTDeUdOZ3wX4fk3gRXX5w6aa3DPi2vJyFs2+51N8JjoDi+sOCEqRKfVel6
 Kz8TL6c
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 22 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > In an intermediate iteration of my rebase--helper patches, I
> > accidentally generated commits with more than one empty line
> > between the header and the commit message. When using
> > find_commit_subject() to show the oneline, it turned up empty, even
> > if the output of `git show --format=%s` looked fine.
> 
> Much easier to read with s/this developer/I/g ;-)

:-P

> > Turned out that the pretty-printing machinery helpfully skipped any
> > blank lines before the commit message.
> >
> > In the first iteration of this patch, I failed to notice that
> > the skip_empty_lines() function used by the pretty printing (which is
> > declared static, and therefore I originally did not use it in order to
> > keep the patch as minimal as possible) skips also blank lines.
> 
> By the way, I think skip_empty_lines() is misnamed, and I think your
> use of "blank lines" in the previous paragraph indicates that you
> agree ;-) It probably was OK back when it was a file-local static
> helper in pretty.c, but it becomes a part of the global API with
> 1/2, renaming it to skip_blank_lines() may be a good thing to do
> there at the same time.
> 
> I could do the tweaking while queuing if you too think it should
> happen; that way we'd save one roundtrip ;-).

I just sent another iteration.

Ciao,
Dscho
