From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/40] Windows: Use the Windows style PATH separator ';'.
Date: Thu, 28 Feb 2008 09:57:32 -0800
Message-ID: <7vhcftj75f.fsf@gitster.siamese.dyndns.org>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
 <1204138503-6126-5-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Feb 28 18:58:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUn1X-0004lC-Ds
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 18:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247AbYB1R5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 12:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753882AbYB1R5r
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 12:57:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40406 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968AbYB1R5r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 12:57:47 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6C75A1FBF;
	Thu, 28 Feb 2008 12:57:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CDDEE1FBE; Thu, 28 Feb 2008 12:57:39 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75431>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> diff --git a/exec_cmd.c b/exec_cmd.c
> index e189cac..343545d 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -37,7 +37,11 @@ static void add_path(struct strbuf *out, const char *path)
>  		else
>  			strbuf_addstr(out, make_absolute_path(path));
>  
> +#ifdef __MINGW32__
> +		strbuf_addch(out, ';');
> +#else
>  		strbuf_addch(out, ':');
> +#endif
>  	}
>  }

If it were only these two places it might be Ok, but together
with 10/40 you may want to do

        #if WINDOWS
        #define PATH_SEP ';'
        #else
        #define PATH_SEP ':'
        #endif

in a header so that the C files do not have to suffer.

