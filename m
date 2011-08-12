From: Pete Wyckoff <pw@padd.com>
Subject: open files limit
Date: Fri, 12 Aug 2011 08:15:48 -0700
Message-ID: <20110812151548.GA14385@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 17:15:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrtSk-0000Iq-D5
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 17:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382Ab1HLPPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 11:15:49 -0400
Received: from honk.padd.com ([74.3.171.149]:54947 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab1HLPPs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 11:15:48 -0400
Received: by honk.padd.com (Postfix, from userid 7770)
	id 343B65B31; Fri, 12 Aug 2011 08:15:48 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179231>

Somebody at $work found this problem:

    $ git ls-files -s | wc
    error: packfile .git/objects/pack/pack-1627e77da82bbb36118762649c8aa88c05664b1e.pack cannot be accessed
    [..lots more similar errors..]

Turns out his shell's open file descriptor limit was 500.  And
there are 1600 pack files in the repo.

Increasing the descriptor limit to 1024 fixed it.  I could
probably get him to repack, which may also fix it.

Does it seem feasible to look for EMFILE errors and close
some packs?  Or at least spit out a more intuitive error?

		-- Pete
