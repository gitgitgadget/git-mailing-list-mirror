From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 08/10] git-mergetool.sh: don't use the -a or -b option
 with the test command
Date: Fri, 16 May 2014 01:24:39 -0700
Message-ID: <20140516082438.GA2673@gmail.com>
References: <1400163457-28285-1-git-send-email-gitter.spiros@gmail.com>
 <1400163457-28285-8-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 10:24:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlDRp-0005Zy-7b
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 10:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756778AbaEPIYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 04:24:50 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:61993 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756356AbaEPIYo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 04:24:44 -0400
Received: by mail-pa0-f47.google.com with SMTP id lf10so2263105pab.34
        for <git@vger.kernel.org>; Fri, 16 May 2014 01:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=H2P5vhBY6XuLgPtrNVkzCzm1mobbKI0BMI8rI9a0Y+c=;
        b=LTluYsXvxrrqsVLMLLKYNcchxXbIDJfw9vwV4KpV3W4CbftQDe3doSmpc2txZLb9uM
         Ds/5gc8YoWBmApAiU0vWOVxnwzMnWBJH+PfZwdQeTrB6pRkBQ8gjynFwMhBtGyYGG6I5
         pNcIF+d/FBh9CsLOhOxCyvH+NvSpeLggCbPvzpVum+MQrfOPIEiJPMsIRW8V20UIPOKD
         BEI+Q3Bc2l8vfx0mGNMoJkTo9DtXv6JxQ+Pq33nHqBzF9ct1g49H2OgAQjqaeRyRkWTt
         tiavEmZDnO9qGtU4kGr9X2IXhTOTlEFGhj6ioW9E1RgH+xHwqW8bUa3pRXw7QS/3LufH
         N6uA==
X-Received: by 10.68.136.226 with SMTP id qd2mr18853495pbb.72.1400228683899;
        Fri, 16 May 2014 01:24:43 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id pl10sm13186848pbb.56.2014.05.16.01.24.42
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 16 May 2014 01:24:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400163457-28285-8-git-send-email-gitter.spiros@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249277>

On Thu, May 15, 2014 at 07:17:35AM -0700, Elia Pinto wrote:
> Even though POSIX.1 lists -a/-o as options to "test", they are
> marked "Obsolescent XSI". Scripts using these expressions
> should be converted  as follow:
> 
> test "$1" -a "$2"
> 
> should be written as:
> 
> test "$1" && test "$2"
> 
> Likewise
> 
> test "$1" -o "$2"
> 
> should be written as:
> 
> test "$1"  test "$2"
> 
> But note that, in test, -a has higher precedence than -o while
> "&&" and "||" have equal precedence in the shell.
> 
> The reason for this is that the precedence rules were never well
> specified, and this made many sane-looking uses of "test -a/-o" problematic.
> 
> For example, if $x is "=", these work according to POSIX (it's not
> portable, but in practice it's okay):
> 
>    $ test -z "$x"
>    $ test -z "$x" && test a = b
> 
> but this doesn't
> 
>    $ test -z "$x" -a a = b
>    bash: test: too many arguments
> 
> because it groups "test -n = -a" and is left with "a = b".
> 
> Similarly, if $x is "-f", these
> 
>    $ test "$x"
>    $ test "$x" || test c = d
> 
> correctly adds an implicit "-n", but this fails:
> 
>    $ test "$x" -o c = d
>    bash: test: too many arguments
> 
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> Inspired from this discussion http://permalink.gmane.org/gmane.comp.version-control.git/137056

Looks good, thanks.

Acked-by: David Aguilar <davvid@gmail.com>


>  git-mergetool.sh |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 332528f..88e853f 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -205,7 +205,7 @@ checkout_staged_file () {
>  		"$(git checkout-index --temp --stage="$1" "$2" 2>/dev/null)" \
>  		: '\([^	]*\)	')
>  
> -	if test $? -eq 0 -a -n "$tmpfile"
> +	if test $? -eq 0 && test -n "$tmpfile"
>  	then
>  		mv -- "$(git rev-parse --show-cdup)$tmpfile" "$3"
>  	else
> @@ -256,7 +256,7 @@ merge_file () {
>  	checkout_staged_file 2 "$MERGED" "$LOCAL"
>  	checkout_staged_file 3 "$MERGED" "$REMOTE"
>  
> -	if test -z "$local_mode" -o -z "$remote_mode"
> +	if test -z "$local_mode" || test -z "$remote_mode"
>  	then
>  		echo "Deleted merge conflict for '$MERGED':"
>  		describe_file "$local_mode" "local" "$LOCAL"
> -- 
> 1.7.10.4
-- 
David
