From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] hooks--update: fix test for properly set up project description
 file
Date: Tue, 06 Nov 2007 14:55:55 +0100
Message-ID: <4730726B.1000407@op5.se>
References: <20071106134749.24233.qmail@809f27f669039a.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 14:56:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpOuc-0006ky-6K
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 14:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbXKFN4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 08:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbXKFN4A
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 08:56:00 -0500
Received: from mail.op5.se ([193.201.96.20]:55449 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751705AbXKFNz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 08:55:59 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id F17A4173073C;
	Tue,  6 Nov 2007 14:54:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[AWL=0.000, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id raymG6SUsfOB; Tue,  6 Nov 2007 14:54:59 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 05D561730724;
	Tue,  6 Nov 2007 14:54:58 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071106134749.24233.qmail@809f27f669039a.315fe32.mid.smarden.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63680>

Gerrit Pape wrote:
> The update hook template intends to abort if the project description file
> hasn't been adjusted or is empty.  This patch fixes the check for 'being
> adjusted'.
> 
> Signed-off-by: Gerrit Pape <pape@smarden.org>
> ---
>  templates/hooks--update |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/templates/hooks--update b/templates/hooks--update
> index d8c7626..65e8c32 100644
> --- a/templates/hooks--update
> +++ b/templates/hooks--update
> @@ -34,8 +34,8 @@ fi
>  allowunannotated=$(git-repo-config --bool hooks.allowunannotated)
>  
>  # check for no description
> -projectdesc=$(sed -e '1p' "$GIT_DIR/description")
> -if [ -z "$projectdesc" -o "$projectdesc" = "Unnamed repository; edit this file to name it for gitweb" ]; then
> +projectdesc=$(sed -ne '1p' "$GIT_DIR/description")

Write this as 

	projectdesc=$(sed -e 1q "$GIT_DIR/description")

instead. It's a little shorter, a little faster and slightly more portable.

> +if [ -z "$projectdesc" -o "$projectdesc" = "Unnamed repository; edit this file to name it for gitweb." ]; then
>  	echo "*** Project description file hasn't been set" >&2
>  	exit 1

I must have missed when the default updatehook got this addendum, as it's
impossible to push to a repository that isn't named with this hook in
effect. I imagine this could lead to some fun problems when trying to
push to repositories on windows machines.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
