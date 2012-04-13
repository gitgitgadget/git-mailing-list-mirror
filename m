From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2] fetch: Only call a new ref a "branch" if it's under
 refs/heads/.
Date: Fri, 13 Apr 2012 15:07:21 -0500
Message-ID: <20120413200721.GA3549@burratino>
References: <1334336904-18649-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Fri Apr 13 22:07:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SImmO-0000VK-1D
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 22:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756614Ab2DMUHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 16:07:31 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59230 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756243Ab2DMUHa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 16:07:30 -0400
Received: by gghe5 with SMTP id e5so1863114ggh.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 13:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SaVNRcQrg37oE10mYA8LMe+m0f4k9foir3CQc478cng=;
        b=yr7XhIEmjjP6PE1N8T4T/it1vBvVEF9S2nKDB5laHwLnPAKP2RFb6Xoe8O28CCSnYn
         DF1zX2NlfvCJ/baSe5PR6+9EED02+564qXKjLJpjzJvSV6cjFG6pgnUI/N52hYjI4ACz
         iIvrY9xqb0SaQLRsXaef4+B4xnNpIFolaz78z6814o+aHnJM5PTsMXOPWVDFose5QcMG
         CU8YN/uHqCiq42d8QXsgWUsozFdGjup08hgLCgRym44KWZYHw1j3dCGT/juK4iBH9eSe
         ufmmYjWTcGgT0wPDMFFxHJd4Kh5B9BKGXWdUzeFq4SHgQa5/gHiCgRyH5soS+i5caCrQ
         T8Eg==
Received: by 10.50.156.130 with SMTP id we2mr2737216igb.26.1334347649635;
        Fri, 13 Apr 2012 13:07:29 -0700 (PDT)
Received: from burratino (adsl-99-24-202-99.dsl.chcgil.sbcglobal.net. [99.24.202.99])
        by mx.google.com with ESMTPS id df1sm4383827igb.12.2012.04.13.13.07.26
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Apr 2012 13:07:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334336904-18649-1-git-send-email-marcnarc@xiplink.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195441>

marcnarc@xiplink.com wrote:

> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -293,14 +293,18 @@ static int update_local_ref(struct ref *ref,
>  		const char *msg;
>  		const char *what;
>  		int r;
> -		if (!strncmp(ref->name, "refs/tags/", 10)) {
> +		if (!prefixcmp(ref->name, "refs/tags/")) {

This part is just a clean-up, right?

>  			msg = "storing tag";
>  			what = _("[new tag]");
>  		}
> -		else {
> +		else if (!prefixcmp(ref->name, "refs/heads/")) {
>  			msg = "storing head";
>  			what = _("[new branch]");
>  		}
> +		else {
> +			msg = "storing ref";
> +			what = _("[new ref]");
> +		}

Neat.  I like it, for what it's worth.

Sincerely,
Jonathan
