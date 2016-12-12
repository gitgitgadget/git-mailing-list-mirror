Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 844A31FF76
	for <e@80x24.org>; Mon, 12 Dec 2016 09:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932115AbcLLJ7L (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 04:59:11 -0500
Received: from mout.gmx.net ([212.227.17.22]:61047 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753944AbcLLJ7K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 04:59:10 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsxuQ-1ce4Ka3FaE-012cRo; Mon, 12
 Dec 2016 10:59:02 +0100
Date:   Mon, 12 Dec 2016 10:59:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 0/1] Fix a long-standing isatty() problem on Windows
In-Reply-To: <xmqqmvg2nyo6.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1612121052310.23160@virtualbox>
References: <cover.1481454992.git.johannes.schindelin@gmx.de> <xmqqmvg2nyo6.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:K6dw8mqG9FOogxSzSZEqBNDCvnWCHlk2OIDW/0/m1hTMHZKj3wi
 S+sPmcYWifn/zhBwf5NjfuU5997oDH+1/IY5U9nTmjkyr7J4aRhLEVcRTMUe78VJHeI0sdk
 gPbIC3+/c/LSfu2QBrrsyc2ERVMSeKX2iBaEadLJVxjwQ1eOIalwTuzZoADbWWSniLhPVIf
 9/P3qK+bAuQei9mPbHqMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VCvxHpD29C4=:i6+pkl9poWUh+5c1o/dKNX
 L/he3FOu45v37NACdOjiN5Cv1B1kedyI+YySyeDkEz3cyHu32ZsLiXMTrS/9ZuLOROnr37kWq
 rbbiYJr+el5y7BxsCHRO0iTaY///hwTsJMjuuB+NMQ945lwk5LrPAnjtc3TD7IgSEanMOwSDY
 jennigji/uX2x0+WjQ/k43vyIQDgcBgHviXUm4SetTdbPal7XB1N+R+61OPMpfQX7Rk5152v/
 R8zD8nNp+u+SLvAjHY+i8v0KEXhRBabEUSADA/Ul+86qP8pW/N/e8Ulywie1jhUX9/CFP7e/R
 lZmVgLUEvE4bPGCAOHqrcCrz2rgn+PZXG3OvNqnPdKRK75DIhoF6xYXlU7tat9Ig1upnTv2cg
 Zd5q30Sc9bfeHTDm2r0qe2tFd9uAM2r8aNt6fteltfgSX7gdrSrLLk7CF2HMq4SsXGLl0AmOb
 Dsiomva2qgjgNoMwrEg4xuCxFrk55zeC9qzWT8t/dtOJx1MpaPY8jZy+gMQEF2Im6zQDSDxz9
 wBC9CL4bZn5/AGdiKEvMxqagSd8mFULxxWubQQ1eHIvH0jSiINBvnyn10gz8TpFAma3LeU3oG
 oC20UrQh8yJPbbGbA3oE4GnKeCbH5qvn8IlvYHourpL3d/oQr2tJu+joQnoWxQJV1gvWloZ4w
 eltX+sVr0s3rTb67scxUnu4qMINVy3vtoL1t7tHMLnlSUd7MXRUpTjt4EtZatsaRCMCJkfS0F
 fqZhEmcHNkFq5TKfNs33xbVQmfF2x/guokilI1wF1zkHyb2fkU3rQsvraTxn6YqUdgTUteTOk
 16OdoHm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 11 Dec 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > I finally got a chance to debug the problems with the ever-timing-out
> > test runs of `pu` on Windows. Turns out that pb/bisect uncovered a
> > really old, really bad bug: on Windows, isatty() does not do what Git
> > expects, at least not completely: it detects interactive terminals *and
> > character devices*.
> 
> Sounds as if somebody who did Windows at Microsoft had a good sense
> of humor to mimick the misnamed ENOTTY gotcha ;-) 

Hehe...

> This is a great find, and a very impactful fix, as redirecting from
> /dev/null is how we try to force a "go interactive if talking to
> tty" program to realize that it is not talking to a tty.

Can we fast-track this to maint?

I will definitely ship this fix in the next Git for Windows version, but
still, it would be nice to have this in git.git as soon as possible.

Thanks,
Dscho
