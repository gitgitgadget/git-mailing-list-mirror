Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 187741FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 15:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752763AbcLHP2P (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 10:28:15 -0500
Received: from mout.gmx.net ([212.227.15.15]:63602 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751772AbcLHP2P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 10:28:15 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LynHb-1clCOe1M6p-016AFv; Thu, 08
 Dec 2016 16:28:07 +0100
Date:   Thu, 8 Dec 2016 16:28:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stephan Beyer <s-beyer@gmx.net>
cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 4/5] Make sequencer abort safer
In-Reply-To: <20161207215133.13433-4-s-beyer@gmx.net>
Message-ID: <alpine.DEB.2.20.1612081627290.23160@virtualbox>
References: <20161207215133.13433-1-s-beyer@gmx.net> <20161207215133.13433-4-s-beyer@gmx.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uFgjvSlYPTlcAoRFNU7rB/08tH34lyZqaSCltkudd1aZWffZBVf
 oNlWjTLYzDJkVfPC2AZu9oNsV7qCSKmG5fEZu+DC7gRyjmOuEUT2OIEqPZ225lT7G85E68i
 /Iah9uNfQ0DTysSma/m2CeD5iD4xfA/wmNC4TTrK3pjVSYHHwNspmRFGkNuPaEV917avW5G
 X9GLQK6qf3dG+jQpggAXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/Imv0IUsWQs=:zVFJd1hvPNLbzfrQAecQIS
 M3LBMMzjhC62siRqWa0RyXds2Odjx33kmDbSks4vQLlfJhDsVYRsQJ+Qq5lBkMFvcSkgVpg0M
 5mdnAylPZTDV1p5Wa+8AiSo44hptR6aF1y7wcWgqC07jCQ1MleTwy9JXqobcBOz+raSbiLyBY
 KoA6M4T11R5ihO34oOTrfFzyKOWg7GYOQjTyXmXtW8gfN4IGmgLtYj/MKAkIkaCrWLuVqKf9Q
 ePohranEqPmKZzQqW/2Rxpb0RE9y/w2jzKqkmPNpc3JEkbtyOicWEji7LEsGu9YEv7r+xYv03
 n47BE3FQYC+Opb1cjY4pjiMAj71U1sXxrOzqDxQKJvlJXfse9i70GXIiu2RSvb15ZrnK0d4pY
 aUeL94rTOchVF8EeUYHkmS71abdLTk3vO2NXe/TPq9FAGJHYF+NhgZfk2SaC3ELoAV/DfsMm2
 Yfc4n3B875aS+odeKGnK92GRQPl3rYwHXuzlQV4slVduARiPIMr8s3LQcG8iTakDQZ6C9Wwo+
 IpeibCPhIL+1YRnU8hEMSoindn3NW3GMB8JBvxnb054tTpnJcxxCHFosaOGVDqDNpWVB8d1w0
 liZ3TOHWGAyaDXHn15YVch+giqaDuycVZH9Ek4Z/9byIzXRAU/KzICQM3VVXYVDhfQT9i4ALd
 on7epFuoexQhSPvb+qwepEOfz3fV1I1oJerznBVrynWMl6MtiS+PFRSuw2UROZ1u5ZNXtjMaC
 99okZaKvsBYbWwQrVkMxF+6sEpHDyclObvcdvwhmlPpNbN50z8X+9UZIG9CZDCcwvmmoAkRbQ
 wq4PUig
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 7 Dec 2016, Stephan Beyer wrote:

> diff --git a/sequencer.c b/sequencer.c
> index 30b10ba14..c9b560ac1 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -27,6 +27,7 @@ GIT_PATH_FUNC(git_path_seq_dir, "sequencer")
>  static GIT_PATH_FUNC(git_path_todo_file, "sequencer/todo")
>  static GIT_PATH_FUNC(git_path_opts_file, "sequencer/opts")
>  static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
> +static GIT_PATH_FUNC(git_path_curr_file, "sequencer/current")

Is it required by law to have a four-letter infix, or can we have a nicer
variable name (e.g. git_path_current_file)?

Ciao,
Dscho
