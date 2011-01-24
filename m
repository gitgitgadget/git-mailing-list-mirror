From: Shuang He <shuang.he@intel.com>
Subject: [RFC] Add bad-branch-first option for git-bisect
Date: Mon, 24 Jan 2011 10:03:37 +0800
Message-ID: <4D3CDDF9.6080405@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: shuang.he@intel.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 24 03:03:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhBmY-0005qD-SW
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 03:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504Ab1AXCDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jan 2011 21:03:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:6472 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753302Ab1AXCDj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jan 2011 21:03:39 -0500
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 23 Jan 2011 18:03:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.60,367,1291622400"; 
   d="scan'208";a="650353609"
Received: from she4-mobl3.ccr.corp.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by fmsmga002.fm.intel.com with ESMTP; 23 Jan 2011 18:03:38 -0800
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165433>

Hi
      The default git-bisect algorithm will jump around the commit tree,
on the purpose of taking least steps to find the first culprit commit.
We may find it sometime would locate a old culprit commit that we're not
concerned about anymore.
      In most software development, there's one or two main branch which
is maintained for release, and a bunch of feature branches are created
for new feature development or bug fix.  For the reason that sometime
git-bisect will locate a old culprit commit would be:
          1. Quality of those branches may not match the main branch,
some functionality are broken at first and fixed later on the feature
branch. If git-bisect jump to there by chance, git-bisect will only find that old
culprit commit which only exists on that feature branch
          2. Some of those branches may not synchronized with main
branch in time.  Say feature1 is broken when feature2 branch is created, and
feature1 is fixed just a moment later after feature2 branch is created,
and when feature2's development is done, and developer want to merge
feature2 branch back to master branch, feature2 will be firstly
synchronized to master branch tip, then merge into master.  For the same
reason addressed in issue 1, this will also lead git-bisect into wrong
direction.

      In all, we think we do not care about branches that we're not
currently working, unless we're sure the regression is caused by that
branch.

      To address those issue, we propose to add a new config option:
          core.bisectbadbranchfirst::
              With this algorithm, git-bisect will always try to select
commits
              that on the same branch current bad commit sits. And will
fall back
              to default git-bisect algorithm when bad-branch-first
algorithm does
              not apply
          +
          This setting defaults to "false".

      The draft patch will be sent out in a later email, so it could be
reviewed inline.
      Any question or suggestion is welcome  :-)

Thanks
      --Shuang
