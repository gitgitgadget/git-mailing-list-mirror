From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 0/3] nd/clear-gitenv-upon-use-of-alias
Date: Wed, 23 Dec 2015 21:37:04 +0100
Message-ID: <567B05F0.5020604@kdbg.org>
References: <1449166676-30845-1-git-send-email-pclouds@gmail.com>
 <1450597819-26278-1-git-send-email-pclouds@gmail.com>
 <xmqq4mfbfqla.fsf@gitster.mtv.corp.google.com>
 <CACsJy8DFmZSa2x4y2fDwVsvwa5uAuMJn8v=utvYtAPTGFbdWPg@mail.gmail.com>
 <CACsJy8A5AcRj2HiLe3PQijhYcHMzJ6eEuMyeVTMvPtXvMg_Sug@mail.gmail.com>
 <xmqqd1tye4i8.fsf@gitster.mtv.corp.google.com>
 <20151223093700.GA13386@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Anthony Sottile <asottile@umich.edu>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 23 21:37:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBq9q-0007rg-VJ
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 21:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965377AbbLWUhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 15:37:11 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:22466 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965368AbbLWUhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 15:37:09 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pQmYF69L8z5tlD;
	Wed, 23 Dec 2015 21:37:05 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id E0B4A53B0;
	Wed, 23 Dec 2015 21:37:04 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <20151223093700.GA13386@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282954>

Am 23.12.2015 um 10:37 schrieb Jeff King:
> The second line comes from handle_alias itself. It calls
> die_errno whenever run_command returns a negative value.
> However, only -1 indicates a syscall error where errno has
> something useful (note that it says the useless "success"
> above). Instead, we treat negative returns from run_command
> (except for -1) as a normal code to be passed to exit.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   git.c         | 2 +-
>   run-command.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git.c b/git.c
> index 6ed824c..34a18a3 100644
> --- a/git.c
> +++ b/git.c
> @@ -252,7 +252,7 @@ static int handle_alias(int *argcp, const char ***argv)
>   			alias_argv[argc] = NULL;
>
>   			ret = run_command_v_opt(alias_argv, RUN_USING_SHELL);
> -			if (ret >= 0)   /* normal exit */
> +			if (ret != -1)  /* normal exit */

Why does this make a difference? We only ever return -1, zero, or a 
positive value from run_command/finish_command/wait_or_whine, as far as 
I can see.

>   				exit(ret);
>
>   			die_errno("While expanding alias '%s': '%s'",

-- Hannes
