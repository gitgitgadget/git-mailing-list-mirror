From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use line buffering for standard output
Date: Sun, 03 Aug 2008 17:24:01 -0700
Message-ID: <7vej557hlq.fsf@gitster.siamese.dyndns.org>
References: <1217798768-18021-1-git-send-email-mail@cup.kalibalik.dk>
 <alpine.LFD.1.10.0808031444270.3668@nehalem.linux-foundation.org>
 <87hca1ogto.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Mon Aug 04 02:25:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPnsx-0003Dz-UU
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 02:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbYHDAYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 20:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753349AbYHDAYL
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 20:24:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbYHDAYK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 20:24:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D885149FC9;
	Sun,  3 Aug 2008 20:24:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6F5C249FC8; Sun,  3 Aug 2008 20:24:03 -0400 (EDT)
In-Reply-To: <87hca1ogto.fsf@cup.kalibalik.dk> (Anders Melchiorsen's message
 of "Mon, 04 Aug 2008 00:48:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A78CA00C-61BB-11DD-94BC-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91298>

Anders Melchiorsen <mail@cup.kalibalik.dk> writes:

> From: Anders Melchiorsen <mail@cup.kalibalik.dk>
> Date: Mon, 4 Aug 2008 00:35:40 +0200
> Subject: [PATCH] Flush standard output in start_async
>
> This prevents double output in case stdout is redirected.
>
> Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
> ---
>  run-command.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index a3b28a6..67be079 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -304,6 +304,9 @@ int start_async(struct async *async)
>  	async->out = pipe_out[0];
>  
>  #ifndef __MINGW32__
> +	/* Flush output before fork() to avoid cloning the buffer */
> +	fflush(stdout);
> +
>  	async->pid = fork();
>  	if (async->pid < 0) {
>  		error("fork (async) failed: %s", strerror(errno));

I think this with s/stdout/NULL/ would be a reasonable thing to do.
