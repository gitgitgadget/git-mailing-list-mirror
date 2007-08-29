From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Explain in --pid-file that using --inetd implies it automatically
Date: Wed, 29 Aug 2007 01:17:17 -0700
Message-ID: <7vabsasqk2.fsf@gitster.siamese.dyndns.org>
References: <ejhm3gs6.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Aug 29 10:17:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQIjy-0004sm-KF
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 10:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbXH2IRX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 04:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbXH2IRW
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 04:17:22 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48586 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbXH2IRV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 04:17:21 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id EA23912A533;
	Wed, 29 Aug 2007 04:17:40 -0400 (EDT)
In-Reply-To: <ejhm3gs6.fsf@cante.net> (Jari Aalto's message of "Wed, 29 Aug
	2007 11:07:37 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56908>

Jari Aalto <jari.aalto@cante.net> writes:

> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> index f902161..687deb2 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -124,7 +124,8 @@ OPTIONS
>  	Detach from the shell. Implies --syslog.
>  
>  --pid-file=file::
> -	Save the process id in 'file'.
> +	Save the process id in 'file'. When `--inetd` is in use, this
> +        option is not needed.

Is it "is not needed"?  I think you meant to say "is ignored",
IOW, no pid file is written.

Which unfortunately makes the title of your patch wrong as
well X-<. 

I am not seriously suggesting to apply the following patch at
this point, but I think this is what we should have done from
the beginning.

diff --git a/daemon.c b/daemon.c
index 9cf22fe..a7b7990 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1143,8 +1143,8 @@ int main(int argc, char **argv)
 		usage(daemon_usage);
 	}
 
-	if (inetd_mode && (group_name || user_name))
-		die("--user and --group are incompatible with --inetd");
+	if (inetd_mode && (group_name || user_name || pid_file))
+		die("--user, --group and --pid-file are incompatible with --inetd");
 
 	if (inetd_mode && (listen_port || listen_addr))
 		die("--listen= and --port= are incompatible with --inetd");
