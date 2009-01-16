From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: autoconf: C99 format check
Date: Fri, 16 Jan 2009 10:41:10 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20090116094110.GD25275@ins.uni-bonn.de>
References: <loom.20090115T123123-915@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julius Naperkowski <j.nap@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 16 11:02:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNlXM-0006tn-Fg
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 11:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765939AbZAPKA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 05:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755250AbZAPKAz
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 05:00:55 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:41964 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756483AbZAPKAw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 05:00:52 -0500
X-Greylist: delayed 1178 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Jan 2009 05:00:52 EST
Received: from ins.uni-bonn.de (gibraltar [192.168.193.254])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id CE2DC40004774;
	Fri, 16 Jan 2009 10:41:11 +0100 (CET)
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Julius Naperkowski <j.nap@gmx.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <loom.20090115T123123-915@post.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105934>

Hello Julius,

* Julius Naperkowski wrote on Thu, Jan 15, 2009 at 02:22:54PM CET:
> I am trying to cross-compile git for mips on a x86 host. But it seems that it is
> impossible to pass the C99 Format check in the configure script when
> cross_compile mode is activated because the script quits even before it starts
> the testprogramm. Is this behavior intentional?

Cross compilation assumes that test programs can be compiled and linked,
but not executed on the build system, i.e., at configure time.  The
fourth argument of AC_RUN_IFELSE may be used to set a default test
result value in the cross compilation case, typically either a
pessimistic default, or one based on $host or so (using $host requires
AC_CANONICAL_HOST, and the config.{guess,sub} scripts).

As a workaround, you the user can pass preset results if you know what
features the host system will have, to configure.  git's configure
script uses three runtime tests.  You can set them with something like
  ./configure ac_cv_c_c99_format=yes \
              ac_cv_fread_reads_directories=no \
              ac_cv_snprintf_returns_bogus=no --host=... ...

although I'm not quite sure if uclibc's *printf functions indeed do
support C99 size specifiers (I think they do though).

I can post a patch to add sane default settings for AC_RUN_IFELSE in
cross compile setups, this weekend.

Cheers,
Ralf
