From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC PATCH 0/2] Teach fetch and pull to recursively fetch submodules
 too
Date: Sun, 29 Aug 2010 17:49:47 +0200
Message-ID: <4C7A819B.3000403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 29 17:50:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Opk8r-0002KQ-Bp
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 17:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725Ab0H2Ptu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 11:49:50 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:60522 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707Ab0H2Ptu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 11:49:50 -0400
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 3A0F5166D950A;
	Sun, 29 Aug 2010 17:49:48 +0200 (CEST)
Received: from [93.246.33.247] (helo=[192.168.178.29])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #24)
	id 1Opk8i-0001ro-00; Sun, 29 Aug 2010 17:49:48 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18J8I8yh4Zcsay6/0o8+XeLn2NGa+liUQYdTd1U
	OHmT8LRSM4fqHXErEKyo7p8GpSTqQilUDSNPn0Yn+rhq5wd1/b
	Bp6c9f/vU/xBN6MNOMpQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154694>

Before we can take advantage of a recursive checkout for
submodules, we have to make sure that new commits are
present in the submodules. And even now after a fetch in the
superproject one sees "(commits not present)" output from
"git diff --submodule" (and thus in "git gui" and "gitk")
when the superproject recorded new submodule commits that
are not yet fetched there. Currently the time they do get
fetched is when the user does a "git submodule update". But
that makes it really hard to see beforehand what changes in
the submodule you will get by running that command, you have
to do something like "git submodule foreach git fetch" to
achieve that.

So I extended the fetch command to fetch populated submodules
too. I also added a command line option to fetch and pull and
the second patch introduces a per submodule config option to
give users the chance to control that behavior.

And maybe we need a config option to customize that behavior
for all submodules or all repos too?

Opinions?


Jens Lehmann (2):
  fetch/pull: Recursively fetch populated submodules
  Submodules: Add the new "fetch" config option for fetch and pull

 Documentation/config.txt        |    6 ++
 Documentation/fetch-options.txt |    6 ++
 Documentation/gitmodules.txt    |    8 +++
 builtin/fetch.c                 |   17 ++++++-
 git-pull.sh                     |   10 +++-
 submodule.c                     |   60 ++++++++++++++++++++++-
 submodule.h                     |    2 +
 t/t5526-fetch-submodules.sh     |  104 +++++++++++++++++++++++++++++++++++++++
 t/t7403-submodule-sync.sh       |    2 +-
 9 files changed, 210 insertions(+), 5 deletions(-)
 create mode 100755 t/t5526-fetch-submodules.sh

-- 
1.7.2.2.527.gdf3084
