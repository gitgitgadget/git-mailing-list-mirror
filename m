From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3 0/3] Teach fetch and pull to recursively fetch submodules
Date: Thu, 11 Nov 2010 00:53:07 +0100
Message-ID: <4CDB3063.5010801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 11 00:53:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGKTj-0001Es-8Z
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 00:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757411Ab0KJXxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 18:53:18 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:34845 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757116Ab0KJXxR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 18:53:17 -0500
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate01.web.de (Postfix) with ESMTP id 0EFAA17757FC3;
	Thu, 11 Nov 2010 00:53:16 +0100 (CET)
Received: from [93.246.41.165] (helo=[192.168.178.29])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PGKTb-00062C-00; Thu, 11 Nov 2010 00:53:16 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19+5HSAyHmb3vS+BGOucy3I0YHDtk0yRnnEvuA2
	gSu00ERAkp8VwhfU1Sa+WbqQbtKl9AUjn5tZl6ByJRkwulqtiB
	RZbZ3js1nqldtvKaIr4g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161193>

So here is the third iteration of the recursive fetch/pull series.

Changes since v2:

* The default now is to not recurse into submodules (also see "Still
  to do")

* The command line option has been renamed to "--recurse-submodules" as
  proposed at the GitTogether

* The config options are named "submodule.<name>.fetchRecurseSubmodules"
  and "fetch.recurseSubmodules" now

* Switched the order of the two patches adding the config options


Question:

* Should the "--submodule-prefix" option - which is only used internally
  now - be a hidden option to "git fetch"?


Still to do:

* Add a mode to only fetch those submodules where new recorded commits
  are fetched in the superproject (and maybe later even fetch only those
  commits in the submodule which are referenced in the superprojects
  fetch). This could be a sane default - especially for projects having
  lots of submodules - and could be enabled by using then to be added
  "--recurse-submodules=changed" and "fetch[.]recurseSubmodules=changed"
  options where the configuration uses other defaults (I'm not really
  convinced yet 'changed' is a very good name but couldn't come up with
  a better one yet. So suggestions for alternatives are very welcome :-)

* Boost performance by concurrently fetching submodules (after my first
  experiments this must be configurable, e.g. how many fetch commands
  to run at the same time, as some git servers barf on too many fetches
  run at the same time)


But nonetheless I think this patch series is ok for inclusion as it does
not change default behavior and gives people the opportunity to play with
recursive fetch/pull by enabling one of the introduced config options.


Jens Lehmann (3):
  fetch/pull: Add the --recurse-submodules option
  Add the 'fetch.recurseSubmodules' config setting
  Submodules: Add the "fetchRecurseSubmodules" config option

 Documentation/config.txt        |   12 +++
 Documentation/fetch-options.txt |   13 +++
 Documentation/gitmodules.txt    |    8 ++
 builtin/fetch.c                 |   64 ++++++++++---
 git-pull.sh                     |   10 ++-
 submodule.c                     |   98 +++++++++++++++++++-
 submodule.h                     |    5 +
 t/t5526-fetch-submodules.sh     |  195 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 388 insertions(+), 17 deletions(-)
 create mode 100755 t/t5526-fetch-submodules.sh

-- 
1.7.3.2.337.g9376c
