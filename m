From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] Documenation update: use of braces in if/else
 if/else chain
Date: Sun, 10 Jun 2012 15:22:05 -0500
Message-ID: <20120610202205.GA2052@burratino>
References: <1339349190-84552-1-git-send-email-muhtasib@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	konglu@minatec.inpg.fr
To: Leila Muhtasib <muhtasib@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 22:22:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdoeQ-0005Uw-NU
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 22:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352Ab2FJUWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 16:22:14 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33894 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab2FJUWN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 16:22:13 -0400
Received: by yenm10 with SMTP id m10so2116263yen.19
        for <git@vger.kernel.org>; Sun, 10 Jun 2012 13:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ejvudi2/CVH7IliKuPn9JGae8+BAU7YihV4a5zn6wy0=;
        b=vOdztd3v7hUwykZ/cMbObfa/8gJa6jIaWyLasOut+7pNLIQ78KuMzjVHCqo/Lpz5OJ
         Q5YIGLBPJ6YDu87JOOI6pE1BRdYqTN1lcFmGD9faJaX07+7nze0vAJk3iEWr7/n55m3I
         WN4kSbx+MMtLaQdAD/GGkUN9G1AtC9NedTvtR72flnzgKMyOUMpUCDmAytQ4d55/L5ly
         4E6pEIDzjwvkUo01jHggrpxZgV3Ss11SojDmihlvGOH61jg6HvGUcdriz6AiwCfCO15H
         vXnZn+Jr32ET/t10SbZ5tDhGdell69FLopVM6rOFWvgkPwZ7K5y8Ufaak3RSp+WyTbxg
         jEzQ==
Received: by 10.236.191.2 with SMTP id f2mr17551882yhn.120.1339359732968;
        Sun, 10 Jun 2012 13:22:12 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id j34sm21683062ani.14.2012.06.10.13.22.11
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Jun 2012 13:22:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1339349190-84552-1-git-send-email-muhtasib@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199622>

Hi,

Leila Muhtasib wrote:

> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -117,9 +117,26 @@ For C programs:
>  
>     is frowned upon.  A gray area is when the statement extends
>     over a few lines, and/or you have a lengthy comment atop of
> -   it.  Also, like in the Linux kernel, if there is a long list
> -   of "else if" statements, it can make sense to add braces to
> -   single line blocks.
> +   it.  Also, like in the Linux kernel, if one of the
> +   "if/else if/else" chain has a multiple statement block, use {}
> +   even for a single statement block in that chain. And "else"
> +   should come on the same line as the closing "}" of its "if" block.

I don't think that's quite accurate.  Current best practice in both
git and the Linux kernel is a little looser than that.

> +
> +	//correct
> +	if (bla) {
> +		x = 1;
> +		...
> +	} else {
> +		x = 2;
> +	}

True.

> +
> +	//incorrect
> +	if (bla) {
> +		x = 1;
> +		...
> +	}
> +	else
> +		x = 2;

Also true.  But:

	/* correct */
	if (bla) {
		x = 1;
		...
	} else
		x = 2;

And:

If you have a long "if" with a one-line "else", consider whether you
are needlessly keeping the reader in suspense about something simple.
It might be more pleasant to read with the exceptional case up front:

	if (!bla) {
		x = 2;
	} else {
		x = 1;
		...
	}

This is especially true when the exceptional case returns or exits.

	if (bla && no_bla)
		return error("--blah and --no-blah cannot be used together");
	x = 1;
	...

Hope that helps,
Jonathan
