From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/7] tests: subshell indentation stylefix
Date: Mon, 6 Sep 2010 22:44:17 -0500
Message-ID: <20100907034417.GL1182@burratino>
References: <4C85357A.8090000@web.de>
 <20100906190655.GG25426@burratino>
 <4C854B36.6010606@web.de>
 <20100907014135.GA1182@burratino>
 <20100907014254.GB1182@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 07 05:46:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osp8X-0000Kl-WD
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 05:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab0IGDqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 23:46:17 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:65501 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab0IGDqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 23:46:16 -0400
Received: by gxk23 with SMTP id 23so1807367gxk.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 20:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gJvAOdROlRPKH0E9wujIqxe17gHYYC1i9AWfAfPnLFA=;
        b=mQ0M3QYqENIpz98d+TxSY1HZbw7UYzjnVfzSccgcGnMPU7cWgwjZrC3VMRuKEFBQZg
         EPeBqswuYmV6ZwLK+fwMhhrlf0JtAdpZEKNgxPvxM+rVLt8iaUa3aavrjStd8m0k76bQ
         9H8TA/+Br2A/Kcr41njcfRZpcWKr4Wajjc0Qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hwF4kxN4IrMLbtPAiFUAxRGvEfPojcxscnPL7BZJQm1MxPASZ8Fh/2ibF6wkMcNG/a
         eej5LY5+M4alcqAu8aXgCfabnW/yoxRrcwoZm0sbykmqJDQ0TexUtA9U11rzokfRRFJZ
         52KzTs8TZrq94Fw278jqpUAR5zzw5yknktsOI=
Received: by 10.150.98.10 with SMTP id v10mr16734ybb.387.1283831175711;
        Mon, 06 Sep 2010 20:46:15 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q38sm4469585yba.6.2010.09.06.20.46.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 20:46:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100907014254.GB1182@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155670>

Jonathan Nieder wrote:

> Format the subshells introduced by the previous patch (Several tests:
> cd inside subshell instead of around, 2010-09-06)

Review of said previous patch follows.  Sorry for the confusing diffs.

> --- a/t/t1020-subdirectory.sh
> +++ b/t/t1020-subdirectory.sh
> @@ -27,12 +27,13 @@ test_expect_success 'update-index and ls-files' '
>  	one) echo pass one ;;
>  	*) echo bad one; exit 1 ;;
>  	esac &&
> -	(cd dir &&
> -	git update-index --add two &&
> -	case "`git ls-files`" in
> -	two) echo pass two ;;
> -	*) echo bad two; exit 1 ;;
> -	esac
> +	(
> +		cd dir &&
> +		git update-index --add two &&
> +		case "`git ls-files`" in
> +		two) echo pass two ;;
> +		*) echo bad two; exit 1 ;;
> +		esac
>  	) &&

Trapping the "exit" in a subshell improves behavior.  I wonder why the
script does not use "false" or "(exit 1)"; the tests outside the
subshell have the same problem...

> --- a/t/t4041-diff-submodule-option.sh
> +++ b/t/t4041-diff-submodule-option.sh
> @@ -85,9 +85,10 @@ EOF
>  "
>  
>  commit_file sm1 &&
> -head3=$(cd sm1 &&
> -git reset --hard HEAD~2 >/dev/null &&
> -git rev-parse --verify HEAD | cut -c1-7
> +head3=$(
> +	cd sm1 &&
> +	git reset --hard HEAD~2 >/dev/null &&
> +	git rev-parse --verify HEAD | cut -c1-7

Unrelated: the --verify here does not have much effect on the upstream
of a pipeline.  Maybe "git log -1 --abbrev=7 --format=%h", or even
better, "git log -1 --format=%h" (for DEFAULT_ABBREV) would do the
trick.

> --- a/t/t9100-git-svn-basic.sh
> +++ b/t/t9100-git-svn-basic.sh
> @@ -22,16 +22,17 @@ esac
>  test_expect_success \
>      'initialize git svn' '
>  	mkdir import &&
> -	(cd import &&
> -	echo foo > foo &&
> -	ln -s foo foo.link
> -	mkdir -p dir/a/b/c/d/e &&
> -	echo "deep dir" > dir/a/b/c/d/e/file &&
> -	mkdir bar &&
> -	echo "zzz" > bar/zzz &&
> -	echo "#!/bin/sh" > exec.sh &&
> -	chmod +x exec.sh &&
> -	svn_cmd import -m "import for git svn" . "$svnrepo" >/dev/null
> +	(
> +		cd import &&
> +		echo foo >foo &&
> +		ln -s foo foo.link

Missing SYMLINKS prerequisite?

> --- a/t/t9107-git-svn-migrate.sh
> +++ b/t/t9107-git-svn-migrate.sh
> @@ -6,14 +6,16 @@ test_description='git svn metadata migrations from previous versions'
>  test_expect_success 'setup old-looking metadata' '
>  	cp "$GIT_DIR"/config "$GIT_DIR"/config-old-git-svn &&
>  	mkdir import &&
> -	(cd import &&
> -		for i in trunk branches/a branches/b \
> -		         tags/0.1 tags/0.2 tags/0.3; do
> -			mkdir -p $i && \
> -			echo hello >> $i/README || exit 1
> -		done && \
> +	(
> +		cd import &&
> +		for i in trunk branches/a branches/b tags/0.1 tags/0.2 tags/0.3
> +		do
> +			mkdir -p $i &&
> +			echo hello >>$i/README ||
> +			exit 1

An "exit" to avoid wasting time after a failing setup test might seem
appropriate, but I am happier to see it trapped by the subshell.

> --- a/t/t9116-git-svn-log.sh
> +++ b/t/t9116-git-svn-log.sh
> @@ -8,14 +8,16 @@ test_description='git svn log tests'
>  
>  test_expect_success 'setup repository and import' '
>  	mkdir import &&
> -	(cd import &&
> -		for i in trunk branches/a branches/b \
> -		         tags/0.1 tags/0.2 tags/0.3; do
> -			mkdir -p $i && \
> -			echo hello >> $i/README || exit 1
> -		done && \
> +	(
> +		cd import &&
> +		for i in trunk branches/a branches/b tags/0.1 tags/0.2 tags/0.3
> +		do
> +			mkdir -p $i &&
> +			echo hello >>$i/README ||
> +			exit 1

Likewise.

> --- a/t/t9119-git-svn-info.sh
> +++ b/t/t9119-git-svn-info.sh
> @@ -179,11 +186,13 @@ test_expect_success 'info --url added-directory' '
>  	'
>  
>  test_expect_success 'info added-symlink-file' "
> -	(cd gitwc &&
> +	(
> +		cd gitwc &&
>  		ln -s added-file added-symlink-file &&
>  		git add added-symlink-file
>  	) &&
> -	(cd svnwc &&
> +	(
> +		cd svnwc &&
>  		ln -s added-file added-symlink-file &&

More missing SYMLINKS prerequisites.

To summarize, wherever you change behavior, it is improved.  Thanks.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
