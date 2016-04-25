From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] Update git-p4 to be compatible with git-lfs 1.2
Date: Mon, 25 Apr 2016 18:25:02 +0200
Message-ID: <20160425162502.31558-1-szeder@ira.uka.de>
References: <E230B4FD-79B5-4CA7-9F0D-A4F8F3470296@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Ben Woosley <Ben.Woosley@gmail.com>,
	Luke Diamand <luke@diamand.org>,
	Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 18:25:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aujKL-0004eR-VK
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 18:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933116AbcDYQZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 12:25:25 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:58626 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932882AbcDYQZY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 12:25:24 -0400
Received: from x4db01c0d.dyn.telefonica.de ([77.176.28.13] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aujK2-0001hJ-6U; Mon, 25 Apr 2016 18:25:20 +0200
X-Mailer: git-send-email 2.8.1.339.g9380849
In-Reply-To: <E230B4FD-79B5-4CA7-9F0D-A4F8F3470296@gmail.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1461601520.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292509>


> > * One option on the Travis front would be to just test one combination
> > of the 1.1 build - e.g. linux + clang + 1.1, so you'll stay within the
> > 5 parallel builds while also having some coverage on lfs 1.1.
> TBH I still think testing an outdated Git LFS version does not justify
> +10 extra minutes of computing.

I agree that checking compatibility with an older Git LFS version
doesn't worth the extra 10 minutes.  However, since Git LFS is only
involved in two test scripts and for the rest of the test suite it
doesn't matter at all, doing a full build and running the whole test
suite for the sole sake of a different Git LFS version is definitely
unnecessary.

The Bash completion and prompt scripts are in a similar situation:
there are only two test scripts involved and the rest of the test
suite couldn't care less.  However, we definitely want to support
older Bash versions as well, all the way back to v3.0, and there are a
few commits fixing breakages reported by users of old Bash versions.

As I somehow grew fond of those Bash scripts over the years, I put
together a couple of patches allowing me to say 'cd t && make -j4
full-bash-test', which runs the completion and prompt tests with
multiple Bash versions.  For the seven major and minor releases
including and after v3.0 it usually takes less than 8 seconds.  As far
as runtime goes, I think that's well worth it.

You can have a look at these patches at

  https://github.com/szeder/git completion-test-multiple-bash-versions

and perhaps you could even adapt it to LFS and/or p4 somehow.

> Plus if we want to be consistent we would
> need to do the same for LFS 1.0, 1.2, and for pretty much every other
> dependency...  

I'm not sure we should be consistent in this case, at least not solely
for consistency's sake and not in git.git. Taking what I did for Bash
and doing it for different versions of LFS, p4, etc. could perhaps
keep the runtime under control, but t/Makefile would surely get out
of control rather quickly.  Putting these into a travis-ci matrix is
so much simpler, but the runtime makes it infeasible, of course.

I think the best we can do is to keep this out of git.git and let
(hope?) developers interested in a particular subsystem do this
"multiple version compatibility" tests as they see fit.
