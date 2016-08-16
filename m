Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69BBA1FD99
	for <e@80x24.org>; Tue, 16 Aug 2016 08:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbcHPIX7 convert rfc822-to-8bit (ORCPT
	<rfc822;e@80x24.org>); Tue, 16 Aug 2016 04:23:59 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:35714 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751736AbcHPIX5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2016 04:23:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id E3A3F26A0;
	Tue, 16 Aug 2016 10:23:19 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bvSBm_qeZNKK; Tue, 16 Aug 2016 10:23:19 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id CC4C6269C;
	Tue, 16 Aug 2016 10:23:19 +0200 (CEST)
Date:	Tue, 16 Aug 2016 10:44:20 +0200 (CEST)
From:	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
To:	Stephen Morton <stephen.morton@nokia.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	git@vger.kernel.org
Message-ID: <968827697.1226723.1471337060482.JavaMail.zimbra@ensimag.grenoble-inp.fr>
In-Reply-To: <09d485df-7d14-97f8-9db9-e3db7512bd68@nokia.com>
References: <09d485df-7d14-97f8-9db9-e3db7512bd68@nokia.com>
Subject: Re: git cherry-pick conflict error message is deceptive when
 cherry-picking multiple commits
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: git cherry-pick conflict error message is deceptive when cherry-picking multiple commits
Thread-Index: +TZ6msUVubo4qLi5YLp3vA03eEHEyA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Stephen,

Stephen Morton <stephen.morton@nokia.com> writes:
> +                        if  (multiple_commits)
> +                               advise(_("after resolving the conflicts,
> mark the corrected paths with 'git add <paths>' or 'git rm <paths>'\n"
> +                                        "then continue with 'git %s
> --continue'\n"
> +                                        "or cancel with 'git %s
> --abort'" ), action_name(opts), action_name(opts));
> +                        else
> +                                advise(_("after resolving the
> conflicts, mark the corrected paths\n"
> +                                        "with 'git add <paths>' or 'git
> rm <paths>'\n"
> +                                        "and commit the result with
> 'git commit'"));

In both cases (multiple_commits or not), the beginning of the advise
is nearly the same, with only a '\n' in the middle being the
difference:

multiple_commits:
 "after resolving the conflicts, mark the corrected paths with 'git
 add <paths>' or 'git rm <paths>'\n"

!multiple_commits:
 "after resolving the conflicts, mark the corrected paths\n with 'git
 add <paths>' or 'git rm <paths>'\n"
                                                  ~~~~~~~^

In 'multiple_commits' case the advise is more than 80 characters long,
did you forget the '\n' in that case?

If you end up using the same beginning of advice, maybe it's possible
to give it before the 'if(multiple_commits)' and avoid duplication of
the lines.

Thanks,
Rémi
