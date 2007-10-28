From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] use only the $PATH for exec'ing git commands
Date: Sat, 27 Oct 2007 23:18:12 -0700
Message-ID: <7vlk9nzrrv.fsf@gitster.siamese.dyndns.org>
References: <1193474215-6728-1-git-send-email-srp@srparish.net>
	<1193474215-6728-2-git-send-email-srp@srparish.net>
	<1193474215-6728-3-git-send-email-srp@srparish.net>
	<1193474215-6728-4-git-send-email-srp@srparish.net>
	<1193474215-6728-5-git-send-email-srp@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott R Parish <srp@srparish.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 07:18:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im1Tv-0003uU-GY
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 07:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbXJ1GSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 02:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbXJ1GSS
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 02:18:18 -0400
Received: from rune.pobox.com ([208.210.124.79]:45690 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762AbXJ1GSR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 02:18:17 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 0B86215149A;
	Sun, 28 Oct 2007 02:18:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 77607150FE6;
	Sun, 28 Oct 2007 02:18:36 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62523>

Scott R Parish <srp@srparish.net> writes:

> diff --git a/exec_cmd.c b/exec_cmd.c
> index 8b681d0..c228dbf 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -29,85 +29,68 @@ const char *git_exec_path(void)
>  	return builtin_exec_path;
>  }
>  
> +static void add_path(struct strbuf *out, const char *path)
> +{
> +	if (path && strlen(path)) {

I wonder if s/strlen(path)/*path/ micro-optimization is worth
doing.  Ideally, if built-in strlen() is used, the compiler
should be clever enough to notice it, though...
