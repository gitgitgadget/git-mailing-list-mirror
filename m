Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73A801F407
	for <e@80x24.org>; Wed, 13 Dec 2017 16:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753097AbdLMQCw (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 11:02:52 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:23853 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752860AbdLMQCv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 11:02:51 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id P9UfeIMIsCbAZP9UfeDOep; Wed, 13 Dec 2017 16:02:50 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=JvuBlIwC c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=NEAV23lmAAAA:8 a=MNp9dsCeAAAA:8 a=5rxgeBVgAAAA:8 a=dIu3SnmMAAAA:8
 a=yCj-8V4UDTZBzwZoHnAA:9 a=wPNLvfGTeEIA:10 a=L9qljj1yQPij81MuFaMk:22
 a=PwKx63F5tFurRwaNxrlG:22 a=Ua9G7VpiFza3u12uuhVB:22
Message-ID: <53BD7DB89F12403F974A7D2201CC7307@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Christian Couder" <christian.couder@gmail.com>,
        <git@vger.kernel.org>
Cc:     "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
        "Thomas Rast" <tr@thomasrast.ch>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        "Christian Couder" <chriscool@tuxfamily.org>
References: <20171213151344.2138-1-chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/8] Codespeed perf results
Date:   Wed, 13 Dec 2017 16:02:48 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 171212-0, 12/12/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfDeLj1Jg9s3ejtmJTuGD+QMIqJF0s9TWJ2xngd6BionzwJQ5Q8p5PY4zNA3WCBLbGY3c+pq0ZoDDTbCfB6Ov5IY9VVdzu+h+QWqSCPVx2XFVvlq8rICg
 IkUfd/umjl9T2cCMxZ3MxcT0dD/+kFjlLaQNsUQh0jeYPe209y6P23sb6Q2pyLF2oeY0vqVStbueXyi1oeIOL8exWxPXJzMioico8+9iGAiXYF7zQXMeBbIC
 ClU4+KPXyXdFzplJIP2FTGEUU5vMS2VKfMl2s/apnxX9cqoiam1BX7NuXbsXhrH3jxw0dyIsZGXpJNQ43/TSelNzhLAIz+2SQ0BMLryzhicL2G08DeURTpiF
 67TTQLh3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Christian Couder" <christian.couder@gmail.com>
> This patch series is built on top of cc/perf-run-config which recently
> graduated to master.
>
> It makes it possible to send perf results to a Codespeed server. See
> https://github.com/tobami/codespeed/ and web sites like
> http://speed.pypy.org/ which are using Codespeed.
>
> The end goal would be to have such a server always available to track
> how the different git commands perform over time on different kind of
> repos (small, medium, large, ...) with different optimizations on and
> off (split-index, libpcre2, BLK_SHA1, ...)

Dumb question: is this expected to also be able to do a retrospective on the 
performance of appropriate past releases? That would allow immediate 
performance comparisons, rather than needing to wait for a few releases to 
see the trends.

Philip

>
> With this series and a config file like:
>
> $ cat perf.conf
> [perf]
>        dirsOrRevs = v2.12.0 v2.13.0
>        repeatCount = 10
> sendToCodespeed = http://localhost:8000
> repoName = Git repo
> [perf "with libpcre"]
>        makeOpts = "DEVELOPER=1 USE_LIBPCRE=YesPlease"
> [perf "without libpcre"]
>        makeOpts = "DEVELOPER=1"
>
> One should be able to just launch:
>
> $ ./run --config perf.conf p7810-grep.sh
>
> and then get nice graphs in a Codespeed instance running on
> http://localhost:8000.
>
> Caveat
> ~~~~~~
>
> For now one has to create the "Git repo" environment in the Codespeed
> admin interface. (We send the perf.repoName config variable in the
> "environment" Codespeed field.) This is because Codespeed requires the
> environment fields to be created and does not provide a simple way to
> create these fields programmatically.
>
> I might try to work around this problem in the future.
>
> Links
> ~~~~~
>
> This patch series is available here:
>
> https://github.com/chriscool/git/commits/codespeed
>
> The cc/perf-run-config patch series was discussed here:
>
> v1: 
> https://public-inbox.org/git/20170713065050.19215-1-chriscool@tuxfamily.org/
> v2: 
> https://public-inbox.org/git/CAP8UFD2j-UFh+9awz91gtZ-jusq7EUOExMgURO59vpf29jXS4A@mail.gmail.com/
>
> Christian Couder (8):
>  perf/aggregate: fix checking ENV{GIT_PERF_SUBSECTION}
>  perf/aggregate: refactor printing results
>  perf/aggregate: implement codespeed JSON output
>  perf/run: use $default_value instead of $4
>  perf/run: add conf_opts argument to get_var_from_env_or_config()
>  perf/run: learn about perf.codespeedOutput
>  perf/run: learn to send output to codespeed server
>  perf/run: read GIT_TEST_REPO_NAME from perf.repoName
>
> t/perf/aggregate.perl | 164 
> +++++++++++++++++++++++++++++++++++---------------
> t/perf/run            |  29 +++++++--
> 2 files changed, 140 insertions(+), 53 deletions(-)
>
> -- 
> 2.15.1.361.g8b07d831d0
> 

