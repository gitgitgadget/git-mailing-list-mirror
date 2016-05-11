From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 0/2] Support marking .git/ (or all files) as hidden on
 Windows
Date: Wed, 11 May 2016 10:43:25 +0200 (CEST)
Message-ID: <cover.1462956195.git.johannes.schindelin@gmx.de>
References: <cover.1462881473.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 11 10:45:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0PlP-0001Cq-1o
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 10:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbcEKIo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 04:44:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:58799 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbcEKIoy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 04:44:54 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MRTiG-1bBJpR2Jk8-00SfLF; Wed, 11 May 2016 10:44:33
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1462881473.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:UC5Z++4y++mbLTSCuhpGtYwq72pXsTi7KsjplUG0g5iS7AJ8Fea
 6nY49JMI6Z0rNLHCce/bcIdeRQ2W6tY1ZnqunDcmV4vD92OOWFKBCiFCrSKK97/Gda8g7tS
 iWH7A0tivBAGyAVyy+PitrZ5kNfQlq8F0C8zyMAW8gZAk6QXraYR6leOEi/qKJGArVoJgq6
 NdSX5cIun0RXPa60AHVIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a+FuO02mRa4=:FqFBAPlOgEEU//7apmEezJ
 Hi6Wz+Zg5isURgUEI54Loozor+9Y/deAyLtD5MXCdOj8a+uWRWlTLnuMghYduQ9Y68+mZ6YsT
 CCFl0evwghoITYrgRf+60yigACng6bU4Tf0DWN4iMJhse7ISgWzxOKDb0ws0KF2aEWG1Vj+gw
 ROFCZUfT3Z0fNKVd0ksQnLuepktRmn0SfatswrH5gheNop77qfPRwCMuvxPymPmh7Sp+AurXH
 UeB/xXBEruTjQw9r8UcrODbzmg+jiwflPkeSJMV3D5K5wpD4vyjY8GFSIvq7XVmeoasEDD506
 Hf9q0RQ4QY2PIOVF1t9z+EGh6ePgkWzcQtHGdzbxO2aCl85uaz0Gh3EIPnUyPS4u4gN6cFwlY
 wVDS7Eu0WDU8hfTNoIbDyEdMiPPzMUhCurOh2uHHE2a4EyIuoEr85nu/X6G1nyOgqeNFI53fE
 +LK400EIKdzCqaGNq401LuffiHrO6maVmRmudEiiGw/+PUlv5kQ8+Y+qavgTQVQGorrc+tYJv
 WuOunL4mmS7ZJhNm9blL0uIGQBBSh7oBG7niia7a4lSKcATLDZO2Z5C+N4rP4Vn/577gH/LfF
 rUzox5AlkSKTol0OyTCgHwr+rAZ4NMuWX85oLEGzBWpGGnkwmHYntlQszMB4sa5k6FnjWJ/sI
 16lUIbw3bZLgJ0ljLn6Kx724Uf2mVfpdvtzhuJVu9LIWCBPE1btwkzWnk9aUf/Kdz8rv1WW+U
 +kXQqtjXbNKBAZMOUVqTyiIUXVDAdC/P29oACkTDLhJW66JMlgtmqiCz8MXyXL9Yv1w3nKgF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294244>

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
