From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: BUG? git log --no-merges shows grafted merges in shallow clones
Date: Fri, 26 Feb 2016 20:49:45 +0100
Message-ID: <vpq4mcvs146.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 26 20:49:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZOOf-0007sC-PE
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 20:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988AbcBZTtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 14:49:49 -0500
Received: from mx1.imag.fr ([129.88.30.5]:47744 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754984AbcBZTts (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 14:49:48 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1QJnhVd002686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 26 Feb 2016 20:49:43 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1QJnjQZ012202;
	Fri, 26 Feb 2016 20:49:45 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 26 Feb 2016 20:49:43 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1QJnhVd002686
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457120983.93253@aTE+DuUOJ673zuELk58pKQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287615>

Hi,

I don't think that's intended. When running "git log --no-merges" in a
shallow clone, and the last commit in the history is a merge commit,
"git log --no-merges" still shows it.

I've just hit this in a test running on a --depth=50 clone on Travis-CI
on git-multimail:

$ git cat-file -p c3c1cc25b27d448e9ef67b265a11be8735ff2df4
tree c341dd60c4b639eac1d6dcc3caffb5d7201c2245
parent b312e3f90dfef73ba0288999981694b09affdf6b
parent 842ac6e867885af041499723dc46f2197705204c
author Matthieu Moy <Matthieu.Moy@imag.fr> 1441031540 +0200
committer Matthieu Moy <Matthieu.Moy@imag.fr> 1441031540 +0200

Merge remote-tracking branch 'edward/utf-8-email-support4'

$ git log --no-merges c3c1cc25b27d448e9ef67b265a11be8735ff2df4
commit c3c1cc25b27d448e9ef67b265a11be8735ff2df4 (grafted)
Author: Matthieu Moy <Matthieu.Moy@imag.fr>
Date:   Mon Aug 31 16:32:20 2015 +0200

    Merge remote-tracking branch 'edward/utf-8-email-support4'

I guess Git counts the number of parents that are actually in the
repository, but it could check the number of "parents" field in the
object (cat-file -p was still able to show 2).

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
