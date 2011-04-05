From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation: enhance gitignore whitelist example
Date: Tue, 5 Apr 2011 14:40:05 -0500
Message-ID: <20110405194005.GA32427@elie>
References: <1302032214-11438-1-git-send-email-eblake@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 21:40:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7C6t-00038d-Gb
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 21:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab1DETkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 15:40:14 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51666 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab1DETkM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 15:40:12 -0400
Received: by vxi39 with SMTP id 39so561994vxi.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 12:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=CnE7Ltr341C86vGXGqiRyAkZO3007bEwiYz/e8XB1gA=;
        b=kz0fmQXzqPk7V8h1FXMbnmkL2dpWuAmddLZ59eXmLoO3US6Yfoupsid9YiEBQerOen
         K9P/nESpRdvdtyeszjqaYnMJlncAqsKQKG5q3iMcD11PHHrojDON/Dn3iSZwnc8DvXtB
         DHDL2WqwFN2SeyT40rxZ+TSOrZJ0/sLOz8fno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LxWNdm5gO0cqe7WS23nX7cCxp6Y59c29abHKTVrbqlCY5SLGd8BgA0Yfk6CTHMfCSQ
         ItNUJvg91gyAy3OfGBg5NzAsaRsc+TPwHn4odqW0A5yMz421GqI3VMA2AZkdB1Zf9IYZ
         4Uz96UT+1hsUFkdWpZshuy9gBInB7uZqINPFs=
Received: by 10.220.95.139 with SMTP id d11mr15888vcn.261.1302032411670;
        Tue, 05 Apr 2011 12:40:11 -0700 (PDT)
Received: from elie (adsl-69-209-53-77.dsl.chcgil.ameritech.net [69.209.53.77])
        by mx.google.com with ESMTPS id p29sm1508611vcr.7.2011.04.05.12.40.09
        (version=SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 12:40:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1302032214-11438-1-git-send-email-eblake@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170906>

Eric Blake wrote:

> I was trying to whitelist a single file pattern in a directory
> that I was otherwise content to ignore, but when I tried:
> 
> /m4/
> !/m4/virt-*.m4
> 
> then 'git add' kept warning me that I had to use -f.  I finally
> figured out that ignoring a directory is much different than ignoring
> all files in a directory, when it comes to later negation patterns:
> 
> /m4/*
> !/m4/virt-*.m4
> 
> Improving the documentation will help others learn from my mistake.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Yes.

Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Cc-ing Hannes, in case he has thoughts on how to explain this more
intuitively.

> ---
>  Documentation/gitignore.txt |   19 +++++++++++++++++--
>  1 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index 2e7328b..2f49989 100644
> --- a/Documentation/gitignore.txt
> +++ b/Documentation/gitignore.txt
> @@ -70,7 +70,9 @@ PATTERN FORMAT
>   - An optional prefix '!' which negates the pattern; any
>     matching file excluded by a previous pattern will become
>     included again.  If a negated pattern matches, this will
> -   override lower precedence patterns sources.
> +   override lower precedence patterns sources.  However, a
> +   file negation does not override a path that has already
> +   been excluded by a directory match.
> 
>   - If the pattern ends with a slash, it is removed for the
>     purpose of the following description, but it would only find
> @@ -87,7 +89,8 @@ PATTERN FORMAT
> 
>   - Otherwise, git treats the pattern as a shell glob suitable
>     for consumption by fnmatch(3) with the FNM_PATHNAME flag:
> -   wildcards in the pattern will not match a / in the pathname.
> +   wildcards in the pattern will not match a / in the pathname,
> +   and do not ignore files with a leading . in the pathname.
>     For example, "Documentation/{asterisk}.html" matches
>     "Documentation/git.html" but not "Documentation/ppc/ppc.html"
>     or "tools/perf/Documentation/perf.html".
> @@ -116,8 +119,11 @@ EXAMPLES
>      [...]
>      # Untracked files:
>      [...]
> +    #       Documentation/build
>      #       Documentation/foo.html
>      #       Documentation/gitignore.html
> +    #       build/log
> +    #       build/.file
>      #       file.o
>      #       lib.a
>      #       src/internal.o
> @@ -125,6 +131,10 @@ EXAMPLES
>      $ cat .git/info/exclude
>      # ignore objects and archives, anywhere in the tree.
>      *.[oa]
> +    # ignore files in the immediate child directory build,
> +    /build/*
> +    # except for the log.
> +    !/build/log
>      $ cat Documentation/.gitignore
>      # ignore generated html files,
>      *.html
> @@ -134,10 +144,15 @@ EXAMPLES
>      [...]
>      # Untracked files:
>      [...]
> +    #       Documentation/build
>      #       Documentation/foo.html
> +    #       build/log
>      [...]
>  --------------------------------------------------------------
> 
> +Note that using `!/build/log' works with an earlier `/build/*' but
> +would have no effect if there were an earlier `/build/'.
> +
>  Another example:
> 
>  --------------------------------------------------------------
> -- 
> 1.7.4
> 
