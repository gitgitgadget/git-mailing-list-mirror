From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] archive: allow --exec and --remote without equal sign
Date: Fri, 25 Jul 2008 17:28:31 -0700
Message-ID: <7vr69hpjyo.fsf@gitster.siamese.dyndns.org>
References: <1216982486-5887-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <1216982486-5887-2-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <1216982486-5887-3-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <1216982486-5887-4-git-send-email-rene.scharfe@lsrfire.ath.cx>
 <1216982486-5887-5-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jul 26 02:29:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMXfG-0008VN-62
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 02:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbYGZA2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 20:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbYGZA2h
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 20:28:37 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37821 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbYGZA2h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 20:28:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 270B93BBA0;
	Fri, 25 Jul 2008 20:28:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 235693BB9F; Fri, 25 Jul 2008 20:28:32 -0400 (EDT)
In-Reply-To: <1216982486-5887-5-git-send-email-rene.scharfe@lsrfire.ath.cx>
 (Rene Scharfe's message of "Fri, 25 Jul 2008 12:41:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C92171C0-5AA9-11DD-8CAD-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90136>

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Allow "--remote repo" and "--exec cmd" in addition to "--remote=repo" and
> "--exec=cmd" to make their usage consistent with parameters handled by
> parse_options().
>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
>  builtin-archive.c |   20 +++++++++++++++++---
>  1 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/builtin-archive.c b/builtin-archive.c
> index 4dd2716..22445ac 100644
> --- a/builtin-archive.c
> +++ b/builtin-archive.c
> @@ -15,7 +15,7 @@ static int run_remote_archiver(const char *remote, int argc,
>  	int fd[2], i, len, rv;
>  	struct child_process *conn;
>  	const char *exec = "git-upload-archive";
> -	int exec_at = 0;
> +	int exec_at = 0, exec_value_at = 0;
>  
>  	for (i = 1; i < argc; i++) {
>  		const char *arg = argv[i];
> @@ -24,7 +24,14 @@ static int run_remote_archiver(const char *remote, int argc,
>  				die("multiple --exec specified");
>  			exec = arg + 7;
>  			exec_at = i;
> -			break;

Interesting...  With this "break", we would have never triggered the
multiple --exec error, wouldn't we?

The patch itself looked fine.  Thanks.
