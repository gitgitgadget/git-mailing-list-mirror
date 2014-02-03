From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [WIP/PATCH 0/9] v2 submodule recursive checkout]
Date: Mon, 03 Feb 2014 20:47:42 +0100
Message-ID: <52EFF25E.6080306@web.de>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>	<52CC3E16.4060909@web.de> <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 03 20:48:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAPUv-0007re-4L
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 20:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbaBCTr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 14:47:57 -0500
Received: from mout.web.de ([212.227.17.11]:61199 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912AbaBCTr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 14:47:56 -0500
Received: from [192.168.178.41] ([84.132.165.229]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0LnB9V-1Vbth73DUz-00hRgI for <git@vger.kernel.org>;
 Mon, 03 Feb 2014 20:47:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <xmqqvbxvekwv.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:BBcPAm9qqB1/99XApV9fF2hljtPA80ObxDifUOpwaTZCDmuvLsQ
 FGblZ4ytH4gqQoJFeK/58TOKJ0PaxkF5KIlDVSEoBqD7xH98V5rgg5Z7thEW0gi3CXC6F3e
 Sv4rbtDY4JP+U7YY8vZ6GpnrzBeoEoJxHz7zqqVbWHxrDbi4E3sXwcdLtyESRBp7kFeZeWb
 7+rHriheTRfgsBn5MefNg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241455>

Am 07.01.2014 18:55, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 06.01.2014 23:36, schrieb Junio C Hamano:
>>> * jl/submodule-recursive-checkout (2013-12-26) 5 commits
>>>  - Teach checkout to recursively checkout submodules
>>>  - submodule: teach unpack_trees() to update submodules
>>>  - submodule: teach unpack_trees() to repopulate submodules
>>>  - submodule: teach unpack_trees() to remove submodule contents
>>>  - submodule: prepare for recursive checkout of submodules
>>>
>>>  What is the doneness of this one???
>>
>> It's still work in progress. Currently I'm working on a test
>> framework so we can reuse recursive submodule checkout tests
>> instead of rewriting them for every command that learns the
>> --recurse-submodule option. Will reroll this series as soon
>> as I have something presentable.
> 
> Thanks.

Ok, time for another round. This is still WIP/RFC and not
ready to be merged yet, but I believe this round makes it a
bit more clear where this is heading.

Changes to the first version are:

- Reordered the commits according to Jonathan's proposal
  (this currently makes the checkout tests fail until the
  last commit completes the functionality; this will be
  fixed when the test framework is added)

- Fixed calling parse_fetch_recurse_submodules_arg() where
  parse_update_recurse_submodules_arg() must be used.

- Moved the documentation of the --[no-]recurse-submodule
  option into an include file so different commands can
  reuse it.

- Added the --[no-]recurse-submodule option to bisect, merge
  and reset too.

Tests, documentation and commit messages are not complete yet,
I'll work on them in the next rounds. The wiki page in my Github
repository will describe the current status of this series:

  https://github.com/jlehmann/git-submod-enhancements/wiki/Recursive-submodule-checkout


Jens Lehmann (9):
  submodule: prepare for recursive checkout of submodules
  Teach reset the --[no-]recurse-submodules option
  Teach checkout the --[no-]recurse-submodules option
  Teach merge the --[no-]recurse-submodules option
  Teach bisect--helper the --[no-]recurse-submodules option
  Teach bisect the --[no-]recurse-submodules option
  submodule: teach unpack_trees() to remove submodule contents
  submodule: teach unpack_trees() to repopulate submodules
  submodule: teach unpack_trees() to update submodules

 Documentation/git-bisect.txt                |   5 +
 Documentation/git-checkout.txt              |   2 +
 Documentation/git-merge.txt                 |   2 +
 Documentation/git-reset.txt                 |   4 +
 Documentation/recurse-submodules-update.txt |   8 +
 bisect.c                                    |  33 ++--
 bisect.h                                    |   3 +-
 builtin/bisect--helper.c                    |   9 +-
 builtin/checkout.c                          |  14 ++
 builtin/merge.c                             |  14 ++
 builtin/reset.c                             |  14 ++
 entry.c                                     |  19 ++-
 git-bisect.sh                               |  29 +++-
 submodule.c                                 | 238 +++++++++++++++++++++++++++-
 submodule.h                                 |  12 ++
 t/t2013-checkout-submodule.sh               | 215 ++++++++++++++++++++++++-
 unpack-trees.c                              |  95 +++++++++--
 unpack-trees.h                              |   1 +
 wrapper.c                                   |   3 +
 19 files changed, 676 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/recurse-submodules-update.txt

-- 
1.9.rc0.28.ge3363ff
