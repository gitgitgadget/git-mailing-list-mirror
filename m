Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9097F1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 12:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbcJKMNG (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 08:13:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:56041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751953AbcJKMNF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 08:13:05 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MSHax-1bS8CV1c3X-00TWMF; Tue, 11 Oct 2016 14:12:12
 +0200
Date:   Tue, 11 Oct 2016 14:12:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v10 04/14] run-command: add clean_on_exit_handler
In-Reply-To: <20161008112530.15506-5-larsxschneider@gmail.com>
Message-ID: <alpine.DEB.2.20.1610111407080.3492@virtualbox>
References: <20161008112530.15506-1-larsxschneider@gmail.com> <20161008112530.15506-5-larsxschneider@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lkv9BK+gKjZw8pva17FNMURysGnomePkShM6pxsWAuWAbHBBHPM
 DdmhQpZKeslJTaXELtcQUZb+43uwkxPWMeqFqzYEKJoIclmOMBCHUhaiYPVfU4LicmMkVo6
 3xIpWo3h/gnus3w/IraFAq0Je46p8u8kk+mQYaJSxTpzmsGbh3q9AINi63LEmipDhAG/nPw
 u6fNkgMXe0lVrc30vlLAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bCG9o00l5RA=:KsIr1P2KTUdHcYodIbe3/A
 OmA9nwwv2ttbH/18w1VD4bxA7RR4eO6jC0feicJu6MTfstqjCFIdrzKbjxGrW1EjbQGQom+5y
 GocY7C4xsoXwZyMANwJQbkv7bBbke6/lv1PvlEL4XG0Hx8i8+XgozLhpsKxEnxwF+BxtU7slp
 pDIMuab7bPkPxCb9K9wKQVhZXYOLgs8VQ8sTBTCY2br9QEq2btzKNs4RDJpyosomyl2PdG9Le
 iE8yMJRSwhz7ewmC3WHyjiGKSYFm2mJGtcvzlg4QEkAUY6TsWOBw8R3SNmCgMiRR2MLX6dTQ8
 YmGEYDSK9rv/MXR37IAKWlThsmvCYZSR3QOelIEGzZgDAqdb5/bsvbxcGl8E0G6k/Q0p0nubj
 9bnvkgpeZicm1MW7jMN6LdXUj+lSEppgQH1JCmm2/WmosAwZl7I6N1X5VjViNahcscmJAUeA8
 QCMEZxZ9U5aGtqEoRa8fyfeyBNgk4HmU4Tw6N8jfgTSaa1NIJu/AGV/AKP4R1cJYzMrigDlKX
 NHvLC/Hy5akntKK9z2NkcPX7aFx+juMQ3kguEXlF6nJSftEdRN9W7jGsD7vysOU009pk+I4es
 bY37kad4S71rzOv/M+9veNFZoN3pGEEed/zWrnc0dTlK/xNXSu1+J4zJCd5aAuTsKstfoUZTG
 TP7bxV3Fx1n3p0+SPAOZjfAJdnMGKT0iQsX4wRroq+IW/7Z05Ga911CbD0vNAXX4lDtf41XmW
 gpPCzeEFMvjge6PPNcLekfwEMDcSyFsw8Zh26u62MOnJPTNWnvMILshLFtKt5q+fFkz+uWy4z
 Zif7kN6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

On Sat, 8 Oct 2016, larsxschneider@gmail.com wrote:

> @@ -31,6 +32,15 @@ static void cleanup_children(int sig, int in_signal)
>  	while (children_to_clean) {
>  		struct child_to_clean *p = children_to_clean;
>  		children_to_clean = p->next;
> +
> +		if (p->process && !in_signal) {
> +			struct child_process *process = p->process;
> +			if (process->clean_on_exit_handler) {
> +				trace_printf("trace: run_command: running exit handler for pid %d", p->pid);

On Windows, pid_t translates to long long int, resulting in this build
error:

-- snip --
 In file included from cache.h:10:0,
                  from run-command.c:1:
 run-command.c: In function 'cleanup_children':
 run-command.c:39:18: error: format '%d' expects argument of type 'int', but argument 5 has type 'pid_t {aka long long int}' [-Werror=format=]
      trace_printf("trace: run_command: running exit handler for pid %d", p->pid);
                   ^
 trace.h:81:53: note: in definition of macro 'trace_printf'
   trace_printf_key_fl(TRACE_CONTEXT, __LINE__, NULL, __VA_ARGS__)
                                                      ^~~~~~~~~~~
 cc1.exe: all warnings being treated as errors
 make: *** [Makefile:1987: run-command.o] Error 1
-- snap --

Maybe use PRIuMAX as we do elsewhere (see output of `git grep
printf.*pid`):

	trace_printf("trace: run_command: running exit handler for pid %"
		     PRIuMAX, (uintmax_t)p->pid);

Ciao,
Dscho
