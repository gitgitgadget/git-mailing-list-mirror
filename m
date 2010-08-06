From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] test-lib: user-friendly alternatives to test [!]
 [-d|-f]
Date: Fri, 6 Aug 2010 17:57:05 -0500
Message-ID: <20100806225705.GA2534@burratino>
References: <1281027281-21055-2-git-send-email-Matthieu.Moy@imag.fr>
 <1281027831-22739-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Aug 07 00:58:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhVs3-00070J-Oe
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 00:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201Ab0HFW6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 18:58:31 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:60623 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964904Ab0HFW63 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 18:58:29 -0400
Received: by qyk7 with SMTP id 7so4314715qyk.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 15:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/Te4qpC/6RwYL4NCY+vqqCEk5r95cVQ0oHj0+cOW7XQ=;
        b=onO1AeHwbVYbCEsDTnKOJ2EA+0HTP2KaNrYz5gOJtexGkQ+gk8ItdZe1A+jzZEb0QW
         dQT4haiok7rQ9H9fstTwAX8oUlK2yAFKYNRaeLQvB/nWQu8zdEEdKm0QL6nWubse/E1v
         JQv47UWGs/14sn1YmcM/1cMpixatSFr9nXHlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=c9S6fkHBFSnjUn9wU+OmCaUg7FPp57fiz4IFinoh5LDed5s1ShzQpEd1Wg9fsL+A4E
         9FaPGj+V2z5fobdbcOuo7GfSQ7TjX1GHgbhJHeEpiJhv53jRcvM6OCn+BmJFV0Cp8H+z
         VT4h+1IaleacBwi8iEVWuWQEp7xx2VXzLjeHY=
Received: by 10.220.127.4 with SMTP id e4mr8730347vcs.95.1281135508983;
        Fri, 06 Aug 2010 15:58:28 -0700 (PDT)
Received: from burratino ([64.134.175.203])
        by mx.google.com with ESMTPS id e1sm804401vch.20.2010.08.06.15.58.27
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 15:58:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1281027831-22739-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152823>

Matthieu Moy wrote:

> The helper functions are implemented, documented, and used in a few
> places to validate them

When I first read this, I thought you were saying these helpers
already existed.  This is where the rationale goes, anyway, so maybe:

	Add new test_file_must_not_exist et al helpers for
	use by tests to more loudly diagnose failures that
	manifest themselves by the existence or nonexistence
	of a file or directory.

	So now you can use

		test_file_must_exist foo "so there"

	from your test, and when it fails due to foo being
	absent or being a symlink instead, instead of silence
	you will get (if debugging with "-v") the helpful message

		file foo does not exist. so there.

> +++ b/t/README
> @@ -467,6 +467,14 @@ library for your script to use.
>     <expected> file.  This behaves like "cmp" but produces more
>     helpful output when the test is run with "-v" option.
>  
> + - test_file_must_exist <file> [<diagnosis>]
> +   test_file_must_not_exist <file> [<diagnosis>]
> +   test_dir_must_exist <dir> [<diagnosis>]
> +   test_dir_must_not_exist <dir> [<diagnosis>]
> +
> +   check whether a file/directory exists or doesn't. <diagnosis> will
> +   be displayed if the test fails.

Maybe:

	- test_file_exists <name> [<diagnosis>]
	- test_dir_exists <name> [<diagnosis>]

	  Check that <name> exists and is a file or directory,
	  printing a diagnostic if it does not.  The <diagnosis>
	  if present will be used to give some added context to
	  the diagnostic.

	- test_does_not_exist <name> [<diagnosis>]

	  Check that <name> does not exist, printing a
	  diagnostic if it does.  The <diagnosis> will be
	  printed on failure as added context if present.

I think the ..._must_exist names put the emphasis in the
wrong place, and they look funny in "if" statements.

> +++ b/t/t3404-rebase-interactive.sh
> +++ b/t/t3407-rebase-abort.sh
[examples]

Makes sense.

> +++ b/t/test-lib.sh
> @@ -541,6 +541,38 @@ test_external_without_stderr () {
>  	fi
>  }
>  
> +# debugging-friendly alternatives to "test [!] [-f|-d]"
> +# The commands test the existence or non-existance of $1. $2 can be
> +# given to provide a more precise diagnosis.
> +test_file_must_exist () {
> +	if ! [ -f "$1" ]; then
> +		echo "file $1 doesn't exist. $*"
> +		false
> +	fi
> +}

Style nitpick: if statementss in the test-lib have tended to look like

 if [ foo ]
 then
	bar
 fi

so far.  Here the whole function is a glorified "test -f", so I wonder
if

	[ -f "$1" ] ||
	{
		echo >&2 "file $1 doesn't exist. $*"
		false
	}

would not be clearer.  I dunno.

> +test_file_must_not_exist () {
> +	if [ -f "$1" ]; then
> +		echo "file $1 exists. $*"
> +		false
> +	fi
> +}

What should happen if $1 exists and is not a file?

I have often run into silent test failures of the sort your patch
is designed to avoid.  Thanks for tackling it.
