From: Thell Fowler <git@tbfowler.name>
Subject: [PATCH-v2/RFC 0/6] improvements for trailing-space processing on incomplete lines
Date: Sat, 22 Aug 2009 22:47:59 -0500
Message-ID: <1250999285-10683-1-git-send-email-git@tbfowler.name>
References: <1249428804.2774.52.camel@GWPortableVCS>
Cc: Johannes.Schindelin@gmx.de, Thell Fowler <git@tbfowler.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 23 05:49:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf45M-0006DC-Gg
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 05:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933452AbZHWDso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 23:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933446AbZHWDso
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 23:48:44 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:42986 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S933442AbZHWDso (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 23:48:44 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=localhost.localdomain)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1Mf44T-0003YG-Ei; Sat, 22 Aug 2009 22:48:45 -0500
X-Mailer: git-send-email 1.6.4.176.g556a4
In-Reply-To: <1249428804.2774.52.camel@GWPortableVCS>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126832>

These patches are directly aimed at making it possible to validate the
results of git apply --whitespace=fix which is currently not possible
in files with incomplete lines in various situations (demonstrated in
the test in PATCH 1).

The goal is to be able to validate the application of a patch generated
from a dirty whitespace source to a clean target.

        D2  C2
        | \/ |
        | /\ |
        D1  C1

where D1..D2, C1..C2, C1..D2, D1..C2 should all yield the same patch-id
when passed a diff ignoring the applicable whitespace changes.

Applying these patches does nothing to fix the case of differences when
apply --whitespace=fix limits new blank lines at eof as can happen when
foo\r\n\r\n\r\n is fixed to foo\n\n.


Thell Fowler (6):
  Add supplemental test for trailing-whitespace on incomplete lines
  xutils: fix hash with whitespace on incomplete line
  xutils: fix ignore-all-space on incomplete line
  xutils: fix ignore-space-change on incomplete line
  xutils: fix ignore-space-at-eol on incomplete line
  t4015: add tests for trailing-space on incomplete line

 t/t4015-diff-trailing-whitespace.sh |   95 +++++++++++++++++++++++++++++++++++
 t/t4015-diff-whitespace.sh          |   33 ++++++++++++
 xdiff/xutils.c                      |   39 ++++++++++-----
 3 files changed, 154 insertions(+), 13 deletions(-)
 create mode 100755 t/t4015-diff-trailing-whitespace.sh
