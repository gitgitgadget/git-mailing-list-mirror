From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Git in GSoC 2014 Suggestion: core.filemode always false for cygwin
Date: Wed, 26 Feb 2014 18:15:50 +0100
Message-ID: <530E2146.1000003@web.de>
References: <20140225154158.GA9038@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 26 18:16:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIi5W-0006Sf-Jq
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 18:16:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757AbaBZRQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 12:16:01 -0500
Received: from mout.web.de ([212.227.15.14]:60456 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752484AbaBZRQA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 12:16:00 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M8iH2-1WOBjm04wG-00CBhd for <git@vger.kernel.org>;
 Wed, 26 Feb 2014 18:15:58 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <20140225154158.GA9038@sigill.intra.peff.net>
X-Provags-ID: V03:K0:8ZBzux91b6yuueF7/w3iWBgvqMddIGrrdwx2qe41aesohdY+KcF
 r0ttF3jnCgsVF21rEiy+8WyOtSEij0VN3ox6wHOjl/kV5bP4Q/7WSyeNOufewRFqmUN6ELN
 /phsClIbhF6InOGXBjQD3T1E71kHtQw9tHtvEI4KTPH5ztiBXs6/oWnmoPAuZyE64LI3MGC
 ociZlDQc9wmvyxLNBkEHg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242738>

On 2014-02-25 16.41, Jeff King wrote:
> I'm pleased to announce that Git has been accepted to this year's Google
> Summer of Code.
I'm not sure if this is the right way to propose mini projects,
but in case the answer is not no, may I suggest one:

Motivation, the problem:
Since commit c28facd216b501d41ca76f 
"cygwin: stop forcing core.filemode=false" 
Git under cygwin initializes repos with core.filemode = true under NTFS

This allows a smooth workflow, when e.g. *.sh files are pushed and pulled between
Cygwin, Linux/Unix or Mac OS.

However when I visit such a repo under Mingw, then Mingw reads core.filemode =true,
but is unable to detect whether the X-bit is set, and reads it as not set.

Therefore "git status" thinks that e.g. all *.sh files have lost the executable
bit, abd reports them as changed.

Proposal:
Under Mingw, keep trust_executable_bit always false, regardless what
core.filemode says.
Activate  NO_TRUSTABLE_FILEMODE in config.mak.uname for Mingw
(currently it is not used to anything)

Keep the logic in init-db.c to initialize core.filemode = false under Mingw 


Language: C
Difficulty: easy
