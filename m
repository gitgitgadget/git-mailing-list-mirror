From: Dominik Vogt <vogt@linux.vnet.ibm.com>
Subject: Setting file timestamps to commit time (git-checkout)
Date: Mon, 9 Dec 2013 12:25:28 +0100
Message-ID: <20131209112528.GA5309@linux.vnet.ibm.com>
Reply-To: vogt@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 09 12:25:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vpyy3-0004DR-AO
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 12:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670Ab3LILZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 06:25:35 -0500
Received: from e06smtp17.uk.ibm.com ([195.75.94.113]:39314 "EHLO
	e06smtp17.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab3LILZe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 06:25:34 -0500
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <vogt@linux.vnet.ibm.com>;
	Mon, 9 Dec 2013 11:25:32 -0000
Received: from d06dlp01.portsmouth.uk.ibm.com (9.149.20.13)
	by e06smtp17.uk.ibm.com (192.168.101.147) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Mon, 9 Dec 2013 11:25:31 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id C041417D805C
	for <git@vger.kernel.org>; Mon,  9 Dec 2013 11:25:24 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rB9BPIK952887622
	for <git@vger.kernel.org>; Mon, 9 Dec 2013 11:25:18 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id rB9BPU4C030265
	for <git@vger.kernel.org>; Mon, 9 Dec 2013 04:25:30 -0700
Received: from bl3ahm9f.de.ibm.com (dyn-9-152-212-171.boeblingen.de.ibm.com [9.152.212.171])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id rB9BPTFA030203
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 9 Dec 2013 04:25:29 -0700
Received: from dvogt by bl3ahm9f.de.ibm.com with local (Exim 4.76)
	(envelope-from <vogt@linux.vnet.ibm.com>)
	id 1Vpyxs-0002IY-St
	for git@vger.kernel.org; Mon, 09 Dec 2013 12:25:28 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 13120911-0542-0000-0000-00000755AC97
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239067>

Me and some colleagues work on gcc in lots of different branches.
For each branch there is a separate build directory for each
branch, e.g. build-a, build-b and build-c.  Let's assume that all
branches are identical at the moment.  If a file in branch a is
changed that triggers a complete rebuild of gcc (e.g.
<target>.opt), rebuilding in build-a takes about an hour.  Now,
 when I switch to one of the other branches, said file is not
identical anymore and stamped with the _current_ time during
checkout.  Although branch b and c have not changed at all, they
will now be rebuilt completely because the timestamp on that files
has changed.  I.e. a chance on one branch forces a rebuild on n
other branches, which can take many hours.

I think this situation could be improved with an option to
git-checkout with the following logic:

$ git checkout <new branch>
  FOR EACH <file> in working directory of <new branch>
    IF <file> is identical to the version in the <old branch>
      THEN leave the file untouched
    ELSE IF <commit timestamp> of the HEAD of the <new branch>
            is in the future
      THEN checkout the new version of <file> and stamp it with
           the current time
    ELSE (commit timestamp is current or in the past)
      THEN checkout the new version of <file> and stamp it with
           the commit timestamp of the current HEAD of <new branch>

Any comments?  Is there already a way to do this?

(Please do not cc me on replies, I'm subscribed to the list.)

Ciao

Dominik ^_^  ^_^

-- 

Dominik Vogt
IBM Germany
