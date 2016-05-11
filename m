From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 0/2] Support marking .git/ (or all files) as hidden on
 Windows
Date: Wed, 11 May 2016 10:40:55 +0200 (CEST)
Message-ID: <cover.1462956033.git.johannes.schindelin@gmx.de>
References: <cover.1462881473.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 10:42:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Pj1-0006w2-G1
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 10:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbcEKImb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 04:42:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:57415 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414AbcEKIm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 04:42:29 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MGBB1-1anzn01WRr-00FA5y; Wed, 11 May 2016 10:42:05
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462881473.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:BO7kfnimqhdcur7owKBAdGCsnQnt4a0teh8q3UjRlDfPAEE5C+h
 qEU18ehVBEjVyHyClykS08BEKCOBNDBlCmMpDuqTr4QsJkDoC5ajUjy2mM+TC+f7/Cm8qf7
 hBUjaMLbFohQ9PKCoNjj80LFx+O8hyvnhcl2cCWIlZQXXvEyYvnUFZYfKYAKChBUl2m2euw
 hceNoifTO5+5l2Z/4TBIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CPj/QS1Dyfw=:CI2tupt/BTQTKNVKjrbaXP
 /TndHZIGN7v8Qxm/OOBY0G5LC9fv54Y1p2qxDdhIlKodKKYly9ROwvjPiN3Dph6PyOOpbTxq7
 eASCPom0F5CCmv0QBZG07d7GRcWP/1zpsyXrT0NVewyZq5sPwYRHBnK2zdnVzZej0aQn74yTM
 X35QHz0Wj1qu7ZfoqOQUM4TD606HKCmCvMlYoRY0S2/4pGkDLXd8/+ZbV2TBP3yaDCh89oG7p
 0BmWRFQeae1t33CAn57WEvFW3xh+KMAXDxC4ZTmpSLbATTftck+8MDf5kv7EAVLt3RMXmF9Dx
 fuiYqIzbRTlKSUECTsjyr+6wlwexAt+gHATuvlTEq7iNPvbiPQ7zszw56H8p8D0shV30ylqv7
 2V/IHO4hbWmo5EP385JocR9iG4hmyWkbCM7wHEmxHHBNd/XYcMW5nXuwdXALysinI/m+A5HYP
 NdJDk5kRf1VgcbPM8ePN61KMptwa/oGH5zeQ4ydCQSw7ViG95ANdtIWe52E9UtjqzmXer3ZWU
 x2Cn9bb0jKbXtFwZSGWB4DLo8IB5Xppt5MJfnMUbXGhHQzBom2i6bRIx/KZa+IeaGwtMgYllY
 1DZO0BBl3HKk3K24nJkotRwNbgwJI72CCPdStpC6pDW5UpwqCLEGUh9NkjvZdTXk1M0IkkTHb
 eycOm4eFNqMjFpIsu/vYdTBLky9dbprFtC3HLTBBlIMB/xIE86NgAPeOWRJ+z1VraNBgt8HDj
 UyVNLsj1bsjPMq+Fma6iM5pX+nt8bDX+HtFFfor0Xo7yQWSzfS2YAPIkegzofNtsp25B4cRj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294240>

Windows does not share Unix' convention that files and directories whose
names start with a dot are hidden. Hence `.git/`, for example, is in
plain view, and caused quite a bit of trouble: some users wanted to peek
inside and did not understand what it contains, others modified files.

There was a stream of bug reports, until Git for Windows introduced the
(opt-out) option to hide at least the .git/ directory by default. The
option is configured via the config setting core.hideDotFiles, with the
possible values false, true and dotGitOnly (the latter being the
default).

This is a heavily version of patches we carried in Git for Windows for
way too long without submitting them upstream.

This iteration addresses Junio's most recent round of concerns.


Johannes Schindelin (2):
  mingw: introduce the 'core.hideDotFiles' setting
  mingw: remove unnecessary definition

 Documentation/config.txt |  6 ++++
 cache.h                  |  7 +++++
 compat/mingw.c           | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 compat/mingw.h           |  3 --
 config.c                 |  8 ++++++
 environment.c            |  1 +
 t/t0001-init.sh          | 30 ++++++++++++++++++++
 t/t5611-clone-config.sh  | 20 +++++++++++++
 8 files changed, 146 insertions(+), 3 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/hide-dotgit-v4
Interdiff vs v3:

 diff --git a/Documentation/config.txt b/Documentation/config.txt
 index 10c0088..acd0b56 100644
 --- a/Documentation/config.txt
 +++ b/Documentation/config.txt
 @@ -273,7 +273,7 @@ core.hideDotFiles::
  	(Windows-only) If true, mark newly-created directories and files whose
  	name starts with a dot as hidden.  If 'dotGitOnly', only the `.git/`
  	directory is hidden, but no other files starting with a dot.  The
 -	default mode is to mark only the `.git/` directory as hidden.
 +	default mode is 'dotGitOnly'.
  
  core.ignoreCase::
  	If true, this option enables various workarounds to enable

-- 
2.8.2.465.gb077790
