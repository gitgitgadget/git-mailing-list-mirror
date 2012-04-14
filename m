From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Explain how svn-fe parses filenames in SVN dumps
Date: Sat, 14 Apr 2012 12:14:31 -0500
Message-ID: <20120414171431.GA4161@burratino>
References: <4F89ADCD.6000109@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Sat Apr 14 19:14:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ6Yf-00009U-S4
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 19:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418Ab2DNROk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 13:14:40 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37041 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059Ab2DNROj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 13:14:39 -0400
Received: by iagz16 with SMTP id z16so5589438iag.19
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 10:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NJj3yDbAKnIhheeRFRBRkMWrjdBIHdPlCb7Zr7f9fBE=;
        b=W1F234JsPqlvuhXWW/+tX4Xa832peduUl9f2tMkPaeRVInrpzpzKNjLrJ6zzANPA+z
         THH+ZSIu0zTyQPrU6J8Wa/FQm8QJBfO+4R4lw7Yc7s3jsWCv8Ty4QZo4qShgDyE4vHKc
         k6jiQ1kQrpPClgu0wRSwAg+CsUgo1cTMSIFgqzkFYXZ5kC2GiXtkGCTo9O55EN7y41F1
         jAcEqlMkTY3jNSL8/ENTHKd+j3Lla8IP1TMoktqCIcf71jJkAFpbkP8cY+XBsL0jYsLV
         N5/Q9yFVPJDry/LfScaRM2Qoxy5gSaMoFfGKShvC+HHJLJGIoZRUQkGaZibSKquv9h2E
         pGpg==
Received: by 10.50.106.161 with SMTP id gv1mr1530700igb.67.1334423678748;
        Sat, 14 Apr 2012 10:14:38 -0700 (PDT)
Received: from burratino (remote.soliantconsulting.com. [67.109.75.130])
        by mx.google.com with ESMTPS id cg9sm7419959igb.17.2012.04.14.10.14.36
        (version=SSLv3 cipher=OTHER);
        Sat, 14 Apr 2012 10:14:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F89ADCD.6000109@pileofstuff.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195494>

Hi,

Andrew Sayers wrote:

> Before version 1.2.0, `svn add` supported files containing characters in the
> range 0x01-0x1F, and Subversion still supports existing files that contain
> those characters.

Because of the above,

[...]
> +++ b/contrib/svn-fe/svn-fe.txt
> @@ -59,6 +59,14 @@ to put each project in its own repository and to separate the history
>  of each branch.  The 'git filter-branch --subdirectory-filter' command
>  may be useful for this purpose.
>  
> +Filenames are interpreted by svn-fe as binary data, and may contain
> +any character except NUL (0x00) and newline (0x0A).  The NUL
> +character is not valid in git paths, and the newline character is
> +reserved for use by the (line-based) Subversion dumpfile format.
> +This differs from Subversion, which requires filenames to contain
> +only legal XML characters and disallows tabs characters, carriage
> +returns and newlines.
> +
>  BUGS

this description and the location of this description seem quite
misleading.  Isn't what the reader needs to know something like the
following?

	BUGS
	----
	Due to limitations in the Subversion dumpfile format, svn-fe
	does not support filenames with newlines.  Since version 1.2.0,
	"svn add" forbids adding such filenames but some historical
	repositories contain them.  An import can appear to succeed and
	produce incorrect results when such pathological filenames are
	present.

Thanks,
Jonathan
