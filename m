From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: git am and CRLF files
Date: Fri, 13 Nov 2009 10:44:47 +0100
Organization: ATLAS Elektronik GmbH
Message-ID: <4AFD2A8F.7000806@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 11:09:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8t6G-0005QC-JG
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 11:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755774AbZKMKJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 05:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755752AbZKMKJg
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 05:09:36 -0500
Received: from lxsrv96.atlas.de ([194.156.172.86]:41161 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755741AbZKMKJf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 05:09:35 -0500
X-Greylist: delayed 1476 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Nov 2009 05:09:34 EST
Received: from VSSRV01.atlas.de (vssrv01.atlas.de [10.200.101.18])
	by mail96.atlas.de (Postfix) with ESMTP id 9B78D138F3
	for <git@vger.kernel.org>; Fri, 13 Nov 2009 10:45:02 +0100 (CET)
X-AuditID: 0ac86512-000000d4000005bc-6d-4afd2a9d4ad4
Received: from mgsrv01.atlas.de ([10.200.101.16]) by VSSRV01.atlas.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Nov 2009 10:45:01 +0100
Received: from mgsrv01.atlas.de (localhost [127.0.0.1])
	by mail01-int.atlas.de (Postfix) with ESMTP id 9812227172
	for <git@vger.kernel.org>; Fri, 13 Nov 2009 10:45:01 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on mgsrv01.atlas.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=disabled version=3.2.5
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mail01.atlas.de (Postfix) with ESMTP id 892612716A
	for <git@vger.kernel.org>; Fri, 13 Nov 2009 10:45:01 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
X-Enigmail-Version: 0.96.0
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132829>

Hi there.
I have:

$ git version
git version 1.6.5.1.1367.gcd48

$ git config --get core.autocrlf
false

A repository with some UNIX (LF) and some Windows (CRLF) files.
(and no: I will not change the files. My editors handle CRLF and LF correctly)

My problem:

'git am' can't handle changes in CRLF files because the patch
gets converted (by git mailsplit) to contain only LF.

Which is wrong IMHO.

git-am on my msysgit version looks like this (lines: 214++)

<---------->
split_patches () {
	case "$patch_format" in
	mbox)
		case "$rebasing" in
		'')
			keep_cr= ;;
		?*)
			keep_cr=--keep-cr ;;
		esac
		git mailsplit -d"$prec" -o"$dotest" -b $keep_cr -- "$@" > "$dotest/last" ||
		clean_abort
		;;
<---------->

The '--keep-cr' flags is passed to git mailsplit when git am is in 'rebasing' mode.
By looking through git-am I found that I can pass "--rebasing" to git am to get my
patch applied correctly.
But why is git am behaving that way ?

Puzzled,

Stefan
-- 
----------------------------------------------------------------
/dev/random says: I'm dangerous when I know what I'm doing.
