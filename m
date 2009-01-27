From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: git 1.6.1 on AIX 5.3
Date: Tue, 27 Jan 2009 10:10:39 +0000
Message-ID: <e2b179460901270210q69fe1e42xb801553e4e9005e9@mail.gmail.com>
References: <A8D76E61-4442-4640-BD0C-84085375E6F1@gmail.com>
	 <20090126210027.GG27604@coredump.intra.peff.net>
	 <e2b179460901261432r601fa006iaf04fc42487e7235@mail.gmail.com>
	 <9E98493A-B17A-4905-8BEA-3E0B837961D6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Perry Smith <pedzsan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 11:12:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRkvP-0004om-7j
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 11:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbZA0KKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 05:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbZA0KKl
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 05:10:41 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:47864 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbZA0KKk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 05:10:40 -0500
Received: by qw-out-2122.google.com with SMTP id 3so3058792qwe.37
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 02:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W2mv604PHSZX+7IDULKCnlfe9hQlf4d3RsC8CdHwu2I=;
        b=j1vDOqKDG0VKbhHkFuxBj1z5d0Uf7NZDgIgVuG3MArU1JUDXPYVLKb/8dtvGRAhaeV
         14lwWcBEwFRmnXtjyz3TE055xvYYU/AmdXB1MuGiEIjcFWsXSU2qck+h7TTjeI/+/pbd
         sV0Bx7HKmDPIDq1OOA1okXQlzADySBYigBWxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PAdAb1VIqssghATS+9yvQ6eN/5yapdZBe9w3SqeX+kNWyEW3/I364oIK9kHwWwaEhk
         /O/9HjWEJA1dlZdhwW+jLFHPufAog6CO5d0sqYQyEZGag6TsJ447yCtTLzkDmwPHS8Hr
         GvqoturYiL5SRmpzqgC3fg+wdDzdklrszqfuM=
Received: by 10.229.74.83 with SMTP id t19mr3130833qcj.53.1233051039313; Tue, 
	27 Jan 2009 02:10:39 -0800 (PST)
In-Reply-To: <9E98493A-B17A-4905-8BEA-3E0B837961D6@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107329>

2009/1/26 Perry Smith <pedzsan@gmail.com>:
> Thanks guys.  I picked up coreutils version 7.   I didn't
> install them but just moved ginstall over to /usr/local/bin.
>
> A few other comments:  I had to add in the --without-tcltk flag.  I don't
> have tcl installed but the config did not autodetect that it was not present.

Yup, I usually build with NO_TCLTK=YesPlease in my config.mak, which
you can see from the link Peff posted.

When you said 'out of tree builds' I thought you meant using the AIX
defaults in the Makefile without running ./configure, but it seems
not, you meant is a clone of the tree buildable by itself or are only
release snapshots buildable. Sorry.

./configure is (deliberately) a second-class citizen in the world of
git, and may still get you a slightly suboptimal build compared with
the defaults on platforms such as AIX... e.g. it doesn't test for
performance-related switches such as INTERNAL_QSORT. If you have run
configure, there's some file you need to blow away to get back to a
non-autoconf world... is it config.mak.autogen?

Despite that, your problem with --without-tcltk falling back to wish,
but not falling back if that isn't installed does look like something
we should fix, as per Peff's mail.

> I can't tell if make test is happy or not.  The output looks like its happy
> but the exit code is 2.
>
> Below is my "configure" script if anyone is interested.
>
> #!/usr/bin/env bash
>
> export CONFIG_SHELL=/usr/local/bin/bash
> export LDFLAGS='-L/usr/local/lib -L/usr/local/ssl/lib'
> export CFLAGS='-I/usr/local/include -I/usr/local/ssl/include'
> export CC=gcc
> echo CONFIG_SHELL set to ${CONFIG_SHELL}
>
> ${CONFIG_SHELL} ../../src/git-1.6.1/configure --without-tcltk
>
> #
> # Note that to install you need to do:
> # make INSTALL=ginstall install
> # to use GNU's install program

I build with SHELL_PATH={path}/bash as well. If I don't, the test
suite exits after t0000-basic.sh with an unexpected error despite
passing all the tests.

gmake -C t/ all
gmake[1]: Entering directory `/usr/local/src/gitbuild/t'
rm -f -r test-results
gmake aggregate-results-and-cleanup
gmake[2]: Entering directory `/usr/local/src/gitbuild/t'
*** t0000-basic.sh ***
* passed all remaining 40 test(s)
FATAL: Unexpected exit with code 0
gmake[2]: *** [t0000-basic.sh] Error 1
gmake[2]: Leaving directory `/usr/local/src/gitbuild/t'
gmake[1]: *** [all] Error 2
gmake[1]: Leaving directory `/usr/local/src/gitbuild/t'
gmake: *** [test] Error 2

Is that what you're seeing? There's many more test scripts than that 8-)

With GIT_SKIP_TESTS='t3900 t3901 t5100.[12] t8005' (to omit some cases
not handled by the version of iconv I have access to on all the AIX
boxes I deploy to) the test suit runs to completion on AIX 5.3 for me.

BTW Are you running AIX's make or GNU make?

Mike
