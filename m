From: Benjamin Poirier <bpoirier@suse.com>
Subject: Different result with `git apply` and `patch`
Date: Wed, 8 Jul 2015 10:50:34 -0700
Message-ID: <20150708175034.GA16759@f1.synalogic.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 19:50:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCtUb-0005xs-G4
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 19:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbbGHRul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 13:50:41 -0400
Received: from cantor2.suse.de ([195.135.220.15]:44811 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934164AbbGHRuk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 13:50:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 82847AAC8
	for <git@vger.kernel.org>; Wed,  8 Jul 2015 17:50:39 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273698>

Hi,

Is it expected that `git apply` and `patch` produce a different result
when given a patch that applies cleanly but with offsets?

Specifically, using the source file and patch file found here:
https://gist.github.com/benthaman/d4e80e1e2e5e0273f874
https://gist.github.com/benthaman/d48d017179a8292c3f75

ben@f1:/tmp/report$ mkdir p g
ben@f1:/tmp/report$ cp ib_isert.c p
ben@f1:/tmp/report$ cp ib_isert.c g
ben@f1:/tmp/report$ cd p/
ben@f1:/tmp/report/p$ patch -p5 < ../0123-IB-isert-pass-scatterlist-instead-of-cmd-to-fast_reg.patch
patching file ib_isert.c
Hunk #1 succeeded at 2322 (offset 131 lines).
Hunk #2 succeeded at 2408 (offset 131 lines).
Hunk #3 succeeded at 2474 (offset 131 lines).
ben@f1:/tmp/report/p$ cd ../g
ben@f1:/tmp/report/g$ git apply -p5 -v < ../0123-IB-isert-pass-scatterlist-instead-of-cmd-to-fast_reg.patch
Checking patch ib_isert.c...
Hunk #1 succeeded at 2322 (offset 131 lines).
Hunk #2 succeeded at 2199 (offset -78 lines).
Hunk #3 succeeded at 2474 (offset 131 lines).
Applied patch ib_isert.c cleanly.


ben@f1:/tmp/report$ git --version
git version 2.4.3
ben@f1:/tmp/report$ patch --version
GNU patch 2.7.1
[...]

I see why it happens, but I'd like the two tools to produce the same
result!

Thanks,
-Benjamin
