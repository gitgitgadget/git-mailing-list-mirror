From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 1/4] mergetool--lib: Simplify command expressions
Date: Tue, 29 Jan 2013 19:22:04 +0000
Message-ID: <20130129192204.GC1342@serenity.lan>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <1359334346-5879-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 20:22:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0GlO-0002U5-G3
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 20:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566Ab3A2TWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 14:22:12 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:51483 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511Ab3A2TWM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 14:22:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 45BFB60654F;
	Tue, 29 Jan 2013 19:22:11 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q9OQCYqt7SHy; Tue, 29 Jan 2013 19:22:11 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id CB35860652A;
	Tue, 29 Jan 2013 19:22:06 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <1359334346-5879-2-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214960>

On Sun, Jan 27, 2013 at 04:52:23PM -0800, David Aguilar wrote:
> Update variable assignments to always use $(command "$arg")
> in their RHS instead of "$(command "$arg")" as the latter
> is harder to read.  Make get_merge_tool_cmd() simpler by
> avoiding "echo" and $(command) substitutions completely.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> @@ -300,9 +292,9 @@ get_merge_tool_path () {
>  	fi
>  	if test -z "$merge_tool_path"
>  	then
> -		merge_tool_path="$(translate_merge_tool_path "$merge_tool")"
> +		merge_tool_path=$(translate_merge_tool_path "$merge_tool")
>  	fi
> -	if test -z "$(get_merge_tool_cmd "$merge_tool")" &&
> +	if test -z $(get_merge_tool_cmd "$merge_tool") &&

This change should be reverted to avoid calling "test -z" without any
other arguments, as Johannes pointed out in v1.

The rest of this patch looks good to me.

>  		! type "$merge_tool_path" >/dev/null 2>&1
>  	then
>  		echo >&2 "The $TOOL_MODE tool $merge_tool is not available as"\
