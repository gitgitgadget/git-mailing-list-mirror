From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Disk waste with packs and .keep files
Date: Tue, 10 Jun 2014 10:21:03 +0200
Message-ID: <vpqmwdljhu8.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 10:21:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuHJ5-0006ZJ-RK
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 10:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936053AbaFJIVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 04:21:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42408 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932209AbaFJIVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 04:21:16 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s5A8L2Fk022489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Jun 2014 10:21:02 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s5A8L3Hc024650;
	Tue, 10 Jun 2014 10:21:03 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 10 Jun 2014 10:21:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s5A8L2Fk022489
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1402993266.30698@2zJxW77WD+SodQK2LNnx2g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251174>

Hi,

To minimize useless on-disk changes, I have a script that periodically
creates .keep files for pack files greater than 10 Mb (so than tools
like unison and incremental backup remain efficient). From time to time,
I delete these .keep files and "git gc" each repo. This worked well for
years.

Since a few weeks however, Git started wasting my disk space: instead of
creating small .pack files next to the big .keep-ed pack files, it seems
to create redundant, big .pack files (i.e. I get N pack files of similar
size). "git verify-pack" confirms that, for example, the object
corresponding to the root commit is contained in each of the .pack file.

I don't have a reproducible way to get the situation so I didn't bisect,
but "git log --grep .keep" points me to this which seems related:

  commit ee34a2beadb94a9595f09af719e3c09b485ca797
  Author: Jeff King <peff@peff.net>
  Date:   Mon Mar 3 15:04:20 2014 -0500

    repack: add `repack.packKeptObjects` config var

Now, my questions:

Is the behavior I observed actually the intended behavior? Should Git be
fixed, or should I fix my flow (I guess, stop using .keep files and
start using pack.packSizeLimit or so)?

Or is my message not clear enough and do I need to investigate a bit
more?

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
