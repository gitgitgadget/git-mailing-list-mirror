From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] guard config parser from value=NULL
Date: Sat, 09 Feb 2008 13:07:53 -0800
Message-ID: <7vhcghet3q.fsf@gitster.siamese.dyndns.org>
References: <12025767241532-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Sat Feb 09 22:08:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNwwL-0004UO-JM
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 22:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755493AbYBIVIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 16:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755352AbYBIVIP
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 16:08:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40183 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209AbYBIVIO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 16:08:14 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A9DC3E23;
	Sat,  9 Feb 2008 16:08:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C1EA3E22;
	Sat,  9 Feb 2008 16:08:05 -0500 (EST)
In-Reply-To: <12025767241532-git-send-email-mkoegler@auto.tuwien.ac.at>
	(Martin Koegler's message of "Sat, 9 Feb 2008 18:05:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73266>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> @@ -416,7 +416,7 @@ int git_default_config(const char *var, const char *value)
>  		return 0;
>  	}
>  
> -	if (!strcmp(var, "user.name")) {
> +	if (value && !strcmp(var, "user.name")) {
>  		strlcpy(git_default_name, value, sizeof(git_default_name));
>  		return 0;
>  	}

This is wrong, isn't it?  When somebody says

	[user]
        	name

we should not silently ignore it, but instead say "user.name is
not a bool!" and error out.

The same comment applies to all other

	if (value && !strcmp(var, "<varname>"))

conversions.
