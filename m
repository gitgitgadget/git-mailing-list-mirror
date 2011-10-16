From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH 2/6] git-p4: handle utf16 filetype properly
Date: Sun, 16 Oct 2011 11:52:31 +0200
Message-ID: <201110161152.32335.stefano.lattarini@gmail.com>
References: <20111015155358.GA29436@arf.padd.com> <20111015155641.GC29436@arf.padd.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 11:52:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFNOm-00029X-Th
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 11:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841Ab1JPJwp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 05:52:45 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54977 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677Ab1JPJwo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 05:52:44 -0400
Received: by wwe6 with SMTP id 6so820362wwe.1
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 02:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        bh=oMcrK5EEexbE6HnaJI/qEf9/6rxSsOs7SUTMCZUW400=;
        b=qC1z+kVrkNT1n5B0EHIBGh1/3pCL+ss4iKYfg7/bHZQOgR7c0bSCajdnToory0lFcG
         hsHUqfDMkeUbiykUsH24wTaRZh59n0muR8yoLxaL7DDpbDCFIaPijjBn/bkPGQAsya8u
         VE68EvSP4KQHtanu5OHpeYL61Ijm801vmB5/g=
Received: by 10.227.201.208 with SMTP id fb16mr5463657wbb.20.1318758762716;
        Sun, 16 Oct 2011 02:52:42 -0700 (PDT)
Received: from bigio.localnet (host72-38-dynamic.56-82-r.retail.telecomitalia.it. [82.56.38.72])
        by mx.google.com with ESMTPS id o7sm24460773wbh.8.2011.10.16.02.52.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Oct 2011 02:52:41 -0700 (PDT)
User-Agent: KMail/1.13.7 (Linux/2.6.30-2-686; KDE/4.6.5; i686; ; )
In-Reply-To: <20111015155641.GC29436@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183698>

Hello Pete.

One more "outsider nit" here ...

On Saturday 15 October 2011, Pete Wyckoff wrote:
>
> [SNIP]
> 
> Add a test case to check utf16 handling, and +k and +ko handling.
>
> [SNIP]
>
> diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
> new file mode 100755
> index 0000000..cf07e6d
> --- /dev/null
> +++ b/t/t9802-git-p4-filetype.sh
> @@ -0,0 +1,108 @@
> +#!/bin/sh
> +
> +test_description='git-p4 p4 filetype tests'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> +	start_p4d
> +'
> +
> +test_expect_success 'utf-16 file create' '
> +	(
> +		cd "$cli" &&
> +
> +		# p4 saves this verbatim
> +		echo -e "three\nline\ntext" >f-ascii &&
>
Not portable to (at least) solaris /usr/xpg4/bin/sh and /bin/ksh:

 $ /bin/ksh -c 'echo -e "three\nline\ntext"'
 -e three
 line
 text

In fact, use of options and/or escape sequences in "echo" arguments is
highly unportable (see the entry for `echo' in the "Limitations of Shell
Builtins" section of the autoconf manual); your best bet is to use printf,
which is more portable and well-behaved (at least on systems that are not
musuem pieces).

>
> [SNIP]
>
> +
> +build_smush() {
> +	cat >k_smush.py <<-EOF &&
> +	import re, sys
> +	sys.stdout.write(re.sub(r'(?i)\\\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\\\$', r'$\1$', sys.stdin.read()))
> +	EOF
>
This is a basically a stylistic nit, so fell free to disregard it completely,
but ... wouldn't it be simpler to quote the "EOF" at the here-doc beginning,
so that you don't have to escape all the backslashes in the here-doc itself?
Similarly for other later usages.

Regards,
  Stefano
