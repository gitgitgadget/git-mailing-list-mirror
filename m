From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 2/6] git-p4: handle utf16 filetype properly
Date: Sun, 16 Oct 2011 10:38:44 -0400
Message-ID: <20111016143844.GB22144@arf.padd.com>
References: <20111015155358.GA29436@arf.padd.com>
 <20111015155641.GC29436@arf.padd.com>
 <201110161152.32335.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 16:39:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFRrn-0003mx-1R
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 16:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754423Ab1JPOjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 10:39:01 -0400
Received: from honk.padd.com ([74.3.171.149]:48064 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754305Ab1JPOjA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 10:39:00 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id AE7D62822;
	Sun, 16 Oct 2011 07:38:59 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 0A3B4313B8; Sun, 16 Oct 2011 10:38:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <201110161152.32335.stefano.lattarini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183714>

stefano.lattarini@gmail.com wrote on Sun, 16 Oct 2011 11:52 +0200:
> Hello Pete.
> 
> One more "outsider nit" here ...
> 
> On Saturday 15 October 2011, Pete Wyckoff wrote:
> >
> > [SNIP]
> > 
> > Add a test case to check utf16 handling, and +k and +ko handling.
> >
> > [SNIP]
> >
> > diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
> > new file mode 100755
> > index 0000000..cf07e6d
> > --- /dev/null
> > +++ b/t/t9802-git-p4-filetype.sh
> > @@ -0,0 +1,108 @@
> > +#!/bin/sh
> > +
> > +test_description='git-p4 p4 filetype tests'
> > +
> > +. ./lib-git-p4.sh
> > +
> > +test_expect_success 'start p4d' '
> > +	start_p4d
> > +'
> > +
> > +test_expect_success 'utf-16 file create' '
> > +	(
> > +		cd "$cli" &&
> > +
> > +		# p4 saves this verbatim
> > +		echo -e "three\nline\ntext" >f-ascii &&
> >
> Not portable to (at least) solaris /usr/xpg4/bin/sh and /bin/ksh:
> 
>  $ /bin/ksh -c 'echo -e "three\nline\ntext"'
>  -e three
>  line
>  text
> 
> In fact, use of options and/or escape sequences in "echo" arguments is
> highly unportable (see the entry for `echo' in the "Limitations of Shell
> Builtins" section of the autoconf manual); your best bet is to use printf,
> which is more portable and well-behaved (at least on systems that are not
> musuem pieces).

Indeed.  The t/ source consistently uses printf where \n is
needed.

> >
> > [SNIP]
> >
> > +
> > +build_smush() {
> > +	cat >k_smush.py <<-EOF &&
> > +	import re, sys
> > +	sys.stdout.write(re.sub(r'(?i)\\\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\\\$', r'$\1$', sys.stdin.read()))
> > +	EOF
> >
> This is a basically a stylistic nit, so fell free to disregard it completely,
> but ... wouldn't it be simpler to quote the "EOF" at the here-doc beginning,
> so that you don't have to escape all the backslashes in the here-doc itself?
> Similarly for other later usages.

Switched to using \EOF and got rid of the extranneous \.

Thanks,

		-- Pete
