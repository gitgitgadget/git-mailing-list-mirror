From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/2] Let merge-file write out conflict markers with correct
 EOLs
Date: Fri, 22 Jan 2016 18:01:09 +0100 (CET)
Message-ID: <cover.1453482052.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 18:01:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMf5O-0003ji-UM
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 18:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754514AbcAVRBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 12:01:18 -0500
Received: from mout.gmx.net ([212.227.17.20]:58111 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754508AbcAVRBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 12:01:16 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M3R1g-1a58ER113A-00r1Fm; Fri, 22 Jan 2016 18:01:11
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:3193yiF9zlGa2o4kP8NQCG7URUzU1xKD0yu2q+R/0O02Lavf+YK
 NsnLQI8T+nFQjEvR6Tq/LX1wF+0Zc4CMvHT/f5Hi0vUqzKUlnxNgxjHd5v775CkS72oazt+
 SAUb4/RF81eP/ruVu0gt9UCU7Hu7Uv4yFhWiF5O7duiTJpbeW/3PaPnwxrKmRXKLFQOJ2G2
 IlyWrjF0F9P3/28zUxKKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EcuzDPrGbA0=:PBZ4R+/OxrD21nbhr5kcFg
 Eqj4+qmdumMhYai++CdASgSawiyRigcjfH8cNx2UPLELt2HOHAhm2cybjeWeHIh8V57cWymOo
 kzF4txRGbJAY2sLrBdVbphsrq6BpQMQH59ZAMoyxh29GHMuZ1vavq0wnfMVlSg5b+D8gr5baA
 oPs31YBtOmZfWHAwFN7+LZnuE9QlMYa/6+oMbD99JCH/KJxL1ANQQtsnRvRzTzI+dL1O5xsOm
 7pMDEyhURCaFzuGwFdvMObPBgWyyFreVg2NgJLfk3J+dCm+lDVbR/dwCq8oVoyWvBn3lyL2sh
 /9ZYDWsarnbnUZp2Xsz76MkVyQEifcToXZ6H1wC451vUu5aHmUx2gXyh4CRWCTb0Ciz8GrlY2
 R01pd/p/c273v+lQlzIpG1y2tnhdbi8zeWUwcmYrSbIH5iT8o/ZuRRfUowgvJCQCrOOlCmxt+
 F9E1//Jxm20RXDuWCplZ03VeLffZUEU/5f5nTM/QUk5NM9gig6RLcmI7qm+LRNJ4+upSAw78c
 CietSLUMMSonICKFUMMflIxQ44vQJ9iO4qwfKYMHNIo58zioFAAOhkd3rILu3LeJNvJGkxFaE
 y13JnrdV2x8bH9poDXbYCqjHH5uLRaxhjjbf1B14+aE8IR2ysTEHYWj+FJS4yScPBigu816iI
 IH9WjDN7DntZ6FX3VNOcZoHRUyI2y5V2vgcnYCAKkkAoAvgtNnZmYz+fHUiZ9ntjOwG7usq/Q
 V4HGs3+gKZdbKBZfBIrqyIdbi1EbjxHn8wwIpidOTCaddyGl4sTdcsAu1Q4EhYboU8v3CFF2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284563>

The original patch was sent by Beat Bolli in
http://thread.gmane.org/gmane.comp.version-control.git/281600

My suggestion to extend it to respect gitattributes led to
changes that broke the original patch.

Since there have been a couple of "What's cooking" mails
containing unheard calls for updates on this patch, I took it
on myself to fix things.

The most crucial fix is that ll-merge.c is now *untouched*,
as it works on blob contents (i.e. LF-only line endings),
*not* on file contents from the working directory.


Beat Bolli (1):
  merge-file: consider core.crlf when writing merge markers

Johannes Schindelin (1):
  convert: add a helper to determine the correct EOL for a given path

 builtin/merge-file.c  |  1 +
 convert.c             | 29 +++++++++++++++++++++++++++++
 convert.h             |  2 ++
 t/t6023-merge-file.sh | 14 ++++++++++++++
 xdiff/xdiff.h         |  1 +
 xdiff/xmerge.c        | 29 +++++++++++++++++++----------
 6 files changed, 66 insertions(+), 10 deletions(-)

-- 
2.7.0.windows.1.7.g55a05c8
