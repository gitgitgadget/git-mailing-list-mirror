From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Speedup prefixcmp() common case
Date: Sat, 29 Dec 2007 11:32:48 -0800
Message-ID: <7v63yhb8kf.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 20:33:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8hR1-0001x4-HN
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 20:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbXL2TdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 14:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbXL2TdB
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 14:33:01 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59209 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbXL2Tc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 14:32:59 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3852343C3;
	Sat, 29 Dec 2007 14:32:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B660B43C2;
	Sat, 29 Dec 2007 14:32:54 -0500 (EST)
In-Reply-To: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com>
	(Marco Costalba's message of "Sat, 29 Dec 2007 19:01:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69327>

"Marco Costalba" <mcostalba@gmail.com> writes:

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 79eb10e..e26b684 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -398,6 +398,10 @@ static inline int sane_case
>
>  static inline int prefixcmp(const char *str, const char *prefix)
>  {
> +	// shortcut common case of a single char prefix
> +	if (prefix && *(prefix + 1) == '\0' && str)
> +		return *str - *prefix;
> +

Why isn't it like this?

	if (!prefix[1])
		return *str - *prefix;

>  	return strncmp(str, prefix, strlen(prefix));
>  }
>
> -- 
> 1.5.4.rc2-dirty
