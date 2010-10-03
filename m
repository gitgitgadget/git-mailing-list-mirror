From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv5 15/16] Add missing &&'s throughout the testsuite
Date: Sun, 3 Oct 2010 09:46:50 -0500
Message-ID: <20101003144650.GE17084@burratino>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
 <1286082644-31595-16-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 16:50:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2PtJ-0006y6-8V
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 16:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330Ab0JCOuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 10:50:11 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41614 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab0JCOuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 10:50:09 -0400
Received: by qyk36 with SMTP id 36so1770448qyk.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=f3IsfL09iReLuTaUqboS0EJ0rQ8u8vlrjbLmrkHrImc=;
        b=AArtZPa+3ZrvPyPA2l+WuY1Q3dtqkldAXML/2ulQAuIv0LyXVNcXDiQkDZyLGSzZM5
         URiT8SqCuxpgDvf32caHfxJ68q8nWTcwFEMDVA1vqPTR1njF3DnCcuqgXmWPiQXK32ju
         oFdNRzXwDVwK4eAEU+dax/9wAebTP1rESxH28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tloD4yXnPc1iyD6d53zcrOzkjp3IkF7XUzX8N147WOPIyATuoeo2NgTApjmduOi25x
         RRsbiyZFhKBjwmyzDT5rOSZa/1g4soQqIcKHEu32Qj/N1TI6v6oWecyA08sHgvgtxSI8
         ozNlnOvzss9aE1y/5grZ0fP7ieLtxNfi1zzUE=
Received: by 10.224.10.70 with SMTP id o6mr5839065qao.72.1286117408473;
        Sun, 03 Oct 2010 07:50:08 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id e6sm4108321qcr.29.2010.10.03.07.50.06
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 07:50:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286082644-31595-16-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157877>

Elijah Newren wrote:

> --- a/t/t1509-root-worktree.sh
> +++ b/t/t1509-root-worktree.sh
> @@ -232,8 +232,8 @@ say "auto bare gitdir"
>  
>  # DESTROYYYYY!!!!!
>  test_expect_success 'setup' '
> -	rm -rf /refs /objects /info /hooks
> -	rm /*
> +	rm -rf /refs /objects /info /hooks &&
> +	rm /* &&

I'm worried that this would fail:

	$ mkdir foo
	$ cd foo
	$ >bar
	$ mkdir baz
	$ rm *
	rm: cannot remove `baz': Is a directory
	$ echo $?
	1

[...]
> --- a/t/t5550-http-fetch.sh
> +++ b/t/t5550-http-fetch.sh
> @@ -93,8 +93,8 @@ test_expect_success 'fetch notices corrupt idx' '
>  '
>  
>  test_expect_success 'did not use upload-pack service' '
> -	grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/access.log >act
> -	: >exp
> +	! grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/access.log >act &&
> +	>exp &&
>  	test_cmp exp act

Or better:

	test_expect_success 'did not use upload-pack service' '
		! grep '/git-upload-pack' <"$HTTPD_ROOT_PATH"/access.log
	'

This way, (like before) one would get to see the git-upload-pack lines
when the test fails while running with -v.

> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -183,7 +183,7 @@ test_expect_success 'git clean symbolic link' '
>  
>  	mkdir -p build docs &&
>  	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
> -	ln -s docs/manual.txt src/part4.c
> +	ln -s docs/manual.txt src/part4.c &&
>  	git clean &&
>  	test -f Makefile &&
>  	test -f README &&

Missing SYMLINKS prereq?
