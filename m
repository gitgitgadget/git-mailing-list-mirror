From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: "git svn mkdirs" is very slow
Date: Mon, 28 Mar 2011 17:05:14 +0200
Message-ID: <4D90A3AA.3050601@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 28 17:05:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4E0U-0004ZD-HE
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 17:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163Ab1C1PFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 11:05:18 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41447 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119Ab1C1PFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 11:05:16 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p2SF5EZs020665
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 28 Mar 2011 17:05:14 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Lightning/1.0b2 Thunderbird/3.1.8
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170135>

Hello,

I've noticed that in our repository, "git svn mkdirs" or any other
command that calls mkemptydirs() is very slow (approximately 8.5 s even
with a warm disk cache).  Presumably this is related to the fact that
the unhandled.log.gz for our Subversion trunk is almost 10 Mb.

Of course it would be nice if this were faster.

But we have laid out our repository to make the presence/absence of
empty directories irrelevant, so we would be just as happy if git-svn
would *not* create empty directories, like in the good old days.  So I
wanted to implement the following feature:

1. An svn.autoMkdirs / svn-remote.<name>.autoMkdirs configuration
variable.  The value should default to true for backwards compatibility.

2. Only call mkemptydirs() if this variable is set to true.

3. Make an exception for "git svn mkdirs", which should do its thing
regardless of how this configuration option is set.

I think it should only be about a 10-line change, plus documentation and
tests.  Unfortunately, my perl-foo is very limited, and it will take me
a while to figure out how option parsing and handling works in git-svn.

Would this feature be welcome?

Is there anybody willing to make the Perl changes?  I would be willing
to work on the documentation and test suite changes.

Thanks,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
