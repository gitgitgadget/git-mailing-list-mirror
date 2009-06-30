From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] Add option to not delete a .git directory in remove_dir_recursively()
Date: Tue, 30 Jun 2009 08:48:09 +0200
Message-ID: <4A49B529.7030900@viscovery.net>
References: <1246327845-22718-1-git-send-email-jason.k.holden@gmail.com> <1246327845-22718-2-git-send-email-jason.k.holden@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jason Holden <jason.k.holden@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 08:48:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLX8c-0001Bk-T5
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 08:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbZF3GsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 02:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbZF3GsI
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 02:48:08 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:61914 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbZF3GsI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 02:48:08 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MLX8T-0006ky-Le; Tue, 30 Jun 2009 08:48:09 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6F2BD795; Tue, 30 Jun 2009 08:48:09 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1246327845-22718-2-git-send-email-jason.k.holden@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122493>

Jason Holden schrieb:
> @@ -812,6 +812,19 @@ int remove_dir_recursively(struct strbuf *path, int only_empty)
>  		strbuf_addch(path, '/');
>  
>  	len = path->len;
> +
> +	if (keep_dot_git) {
> +		char end_of_path[6]; /* enough space for ".git/"*/
> +		memset(end_of_path, '\0', 6);
> +		if (len >= 5) {
> +			strncpy(end_of_path, path->buf + len - 5, 5);
> +			if (strcmp(end_of_path, ".git/") == 0) {
> +				printf("********Found .git!!!!  Skipping delete\n");

I see no reason to ***shout!!!*** here. IOW:

				warning("not removing %s", dir);

is enough. This also sends the text to stderr.

> +				return 0;
> +			}
> +		}
> +	}
> +
>  	while ((e = readdir(dir)) != NULL) {
>  		struct stat st;
>  		if (is_dot_or_dotdot(e->d_name))

I think it is even better to move the check for ".git" below this 'if'. It
should not make a difference in practice.

-- Hannes
