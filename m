From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v4 04/14] Add new simplified git-remote-testgit
Date: Fri, 02 Nov 2012 14:55:41 +0100
Message-ID: <5093D0DD.3050801@gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com> <1351821738-17526-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 14:56:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUHjE-0001uU-UW
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 14:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762772Ab2KBNz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 09:55:56 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44009 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab2KBNzz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 09:55:55 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1393578bkc.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 06:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=x1ZOwYFi2W3YswONoA+1/owt58eXadT/o/0Ws87qpe0=;
        b=IIDT195MCycVoWkQ/4u/PJ3xeBi/a5Wa9NN8miPmdMdYJNILa/Q61V2x/L7L1cRLMF
         0FkvMfqoZr8Hs9G+s4cCj7jzi3NAhab+L7Refu+18QibiVa3Dw0ZuEdVhVnDpvraoQTj
         vkZqP8aC/qIRAB4x/dZr7QDHE7EAAEkVgVMg/HBua5r3EzbjT29vYPETmsu00uH9F7h2
         9gp7KeEE938AAN2zdxD8jyyBpEr5htp2gKNz2JOYzcIpazYAZrVdPJtCHHON0hg/QhDs
         O00Cg24/Q9G3qFmLfdGJu8WeevzeApcfvatcBV4NtIPn63r+HnCeUArMLygTjqIP82oI
         bLRw==
Received: by 10.204.156.13 with SMTP id u13mr414360bkw.113.1351864554188;
        Fri, 02 Nov 2012 06:55:54 -0700 (PDT)
Received: from [192.168.178.21] (host247-100-dynamic.8-87-r.retail.telecomitalia.it. [87.8.100.247])
        by mx.google.com with ESMTPS id gy18sm6688642bkc.4.2012.11.02.06.55.51
        (version=SSLv3 cipher=OTHER);
        Fri, 02 Nov 2012 06:55:53 -0700 (PDT)
In-Reply-To: <1351821738-17526-5-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208933>

On 11/02/2012 03:02 AM, Felipe Contreras wrote:
> It's way simpler. It exerceises the same features of remote helpers.
> It's easy to read and understand. It doesn't depend on python.
> 
> It does _not_ exercise the python remote helper framework; there's
> another tool and another test for that.
> 
> For now let's just copy the old remote-helpers test script, although
> some of those tests don't make sense for this testgit (they still pass).
> 
> In addition, this script would be able to test other features not
> currently being tested.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-remote-testgit.txt |   2 +-
>  git-remote-testgit                   |  62 ++++++++++++++++
>  t/t5801-remote-helpers.sh            | 134 +++++++++++++++++++++++++++++++++++
>  3 files changed, 197 insertions(+), 1 deletion(-)
>  create mode 100755 git-remote-testgit
>  create mode 100755 t/t5801-remote-helpers.sh
> 
> diff --git a/git-remote-testgit b/git-remote-testgit
> new file mode 100755
> index 0000000..6650402
> --- /dev/null
> +++ b/git-remote-testgit
> @@ -0,0 +1,62 @@
> +#!/bin/bash
>
I think git can't assume the existence of bash unconditionally, neither
in its scripts, nor in its tests (the exception being the tests on
bash completion, of course).  This script probably need to be re-written
to be a valid POSIX shell script.

It almost is, anyway, apart from the nits below ...

> +# Copyright (c) 2012 Felipe Contreras
> +
> +alias="$1"
>
Just FYI: the double quoting here (and in several variable assignments
below) is redundant.  You can portably write it as:

    alias=$1

and still be safe in the face of spaces and metacharacters in $1.
I'm not sure whether the Git coding guidelines suggest the use of
quoting in this situation though; if this is the case, feel free
to disregard my observation.

> +url="$2"
> +
> +# huh?
> +url="${url#file://}"
> +
> +dir="$GIT_DIR/testgit/$alias"
> +prefix="refs/testgit/$alias"
> +refspec="refs/heads/*:${prefix}/heads/*"
> +
> +gitmarks="$dir/git.marks"
> +testgitmarks="$dir/testgit.marks"
> +
> +export GIT_DIR="$url/.git"
> +
I believe this should be rewritten as:

  GIT_DIR="$url/.git"; export GIT_DIR

in order to be portable to all the POSIX shells targeted by Git.

> +mkdir -p "$dir"
> +
> +test -e "$gitmarks" || echo -n > "$gitmarks"
> +test -e "$testgitmarks" || echo -n > "$testgitmarks"
> +
The '-n' option to echo is not portable.  To create an empty
file, you can just use

   : > file

or

   true > file

> +while read line; do
> +    case "$line" in
>
Useless double quoting (my previous observation about Git coding
guidelines applies here as well, of course).

> +    capabilities)
> +        echo 'import'
> +        echo 'export'
> +        echo "refspec $refspec"
> +        echo "*import-marks $gitmarks"
> +        echo "*export-marks $gitmarks"
> +        echo
> +        ;;
> +    list)
> +        git for-each-ref --format='? %(refname)' 'refs/heads/'
> +        head=$(git symbolic-ref HEAD)
> +        echo "@$head HEAD"
> +        echo
> +        ;;
> +    import*)
> +        # read all import lines
> +        while true; do
> +            ref="${line#* }"
> +            refs="$refs $ref"
> +            read line
> +            test "${line%% *}" != "import" && break
> +        done
> +
> +        echo "feature import-marks=$gitmarks"
> +        echo "feature export-marks=$gitmarks"
> +        git fast-export --use-done-feature --{import,export}-marks="$testgitmarks" $refs | \
>
Better avoid the tricky {foo,bar} bashism:

    git fast-export --use-done-feature \
                    --import-marks="$testgitmarks" \
                    --export-marks="$testgitmarks" \
		    $refs | \

> +            sed -e "s#refs/heads/#${prefix}/heads/#g"
> +        ;;
> +    export)
> +        git fast-import --{import,export}-marks="$testgitmarks" --quiet
>
Here too.

> +        echo
> +        ;;
> +    '')
> +        exit
>
I'd put an explicit exit status here, for clarity (this is a matter
of personal preference, so feel free to disregard this nit).

> +        ;;
> +    esac
> +done

Regards,
  Stefano
