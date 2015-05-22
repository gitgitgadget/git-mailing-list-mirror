From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/5] Fix verify_lock() to report errors via strbuf
Date: Sat, 23 May 2015 01:34:52 +0200
Message-ID: <1432337697-29161-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 23 01:35:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvwTI-0003OS-Fy
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 01:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757386AbbEVXfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 19:35:13 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:52746 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757328AbbEVXfI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2015 19:35:08 -0400
X-AuditID: 12074411-f796c6d000000bc9-d2-555fbd281506
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 8E.A2.03017.82DBF555; Fri, 22 May 2015 19:35:04 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3AFA.dip0.t-ipconnect.de [93.219.58.250])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4MNZ2Pr007402
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 22 May 2015 19:35:03 -0400
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsUixO6iqKuxNz7U4HCvtEXXlW4mi4beK8wW
	t1fMZ7bYvLmdxYHF4+/7D0weCzaVely8pOzxeZNcAEsUt01SYklZcGZ6nr5dAnfG3cv72AtW
	8FUcetbG0sD4iLuLkZNDQsBEYvrCh8wQtpjEhXvr2boYuTiEBC4zSsz+toYdJCEkcIJJYtqW
	HBCbTUBXYlFPMxOILSKgJjGx7RALiM0skCuxYd8psLiwgJPE+5M7wOIsAqoSn58fBpvDK+Ai
	sWTmFHaIZXIS54//ZJ7AyL2AkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6pXm5miV5qSukm
	RkgwCO5gnHFS7hCjAAejEg+vwcG4UCHWxLLiytxDjJIcTEqivKtWxIcK8SXlp1RmJBZnxBeV
	5qQWH2KU4GBWEuE9uxkox5uSWFmVWpQPk5LmYFES5+Vbou4nJJCeWJKanZpakFoEk5Xh4FCS
	4D20B6hRsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhTo8cXAUAdJ8QDtNQJp5y0u
	SMwFikK0nmJUlBLntd4NlBAASWSU5sGNhcX4K0ZxoC+FeY+DVPEA0wNc9yugwUxAg1dNiAUZ
	XJKIkJJqYIyO7VUzTflYwapybV2bROn1j//vm6Y+XhuUZsi/58qusqRYQf4bb11ObchY8l/S
	MnaJ7ZM9/224Xn+X1f86sy4i47XDrSBJb/NLcxbOWO3XZxDIuN7X7P08xkBFTaubodOczsgs
	rM9uzrsYsKne3SX//NTV5x58exA18Rf/IvbKxyndL7T3aCqxFGckGmoxFxUnAgAN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269770>

verify_lock() is a helper function called while committing reference
transactions. But when it fails, instead of recording its error
message in a strbuf to be passed back to the caller of
ref_transaction_commit(), the error message was being written directly
to stderr.

Instead, report the errors via a strbuf so that they make it back to
the caller of ref_transaction_commit().

The last two patches remove the capitalization of some error messages,
to be consistent with our usual practice. These are a slight backwards
incompatibility; if any scripts are trying to grep for these error
message strings, they might have to be adjusted. So feel free to drop
them if you think consistency across time is more important than
consistency across commands.

This is the patch series that I mentioned here [1]. It applies on top
of mh/ref-directory-file [2] and is thematically a continuation of
that series in the sense that it further cleans up the error handling
within reference transactions. It would be easy to rebase to master if
that is preferred.

These patches are also available on my GitHub account [3] as branch
"verify-lock-strbuf-err".

[1] http://article.gmane.org/gmane.comp.version-control.git/269006
[2] http://thread.gmane.org/gmane.comp.version-control.git/268778
[3] https://github.com/mhagger/git

Michael Haggerty (5):
  verify_lock(): return 0/-1 rather than struct ref_lock *
  verify_lock(): on errors, let the caller unlock the lock
  verify_lock(): report errors via a strbuf
  verify_lock(): do not capitalize error messages
  ref_transaction_commit(): do not capitalize error messages

 refs.c                | 40 ++++++++++++++++++++++++++--------------
 t/t1400-update-ref.sh | 14 +++++++-------
 2 files changed, 33 insertions(+), 21 deletions(-)

-- 
2.1.4
