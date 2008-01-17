From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: What's in git.git (stable frozen)
Date: Thu, 17 Jan 2008 11:17:15 -0600
Message-ID: <478F8D9B.5080703@nrlssc.navy.mil>
References: <7vk5m9kvf7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 18:21:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFYQo-00049J-Gp
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 18:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbYAQRVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 12:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbYAQRVF
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 12:21:05 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53639 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbYAQRVE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 12:21:04 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m0HHHG1X008683;
	Thu, 17 Jan 2008 11:17:16 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 17 Jan 2008 11:17:16 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7vk5m9kvf7.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 17 Jan 2008 17:17:16.0051 (UTC) FILETIME=[CEA67E30:01C8592C]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15666001
X-TM-AS-Result: : Yes--10.425100-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMTQ1NS03MDEy?=
	=?us-ascii?B?OTgtNzAyMDIwLTcwMjA0Mi03MDAzMjQtNzA1MTExLTEzNzcxNy0x?=
	=?us-ascii?B?MjE1ODgtNzA4NzUyLTcwMDA3NS03MDQ3NDctNzAwOTcxLTE0ODAz?=
	=?us-ascii?B?OQ==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70876>



In lockfile.c:commit_locked_index()

You didn't include the portion of your patch that
assigned NULL to alternate_index_output before
attempting to close and rename.

Should that be included?

-brandon



Junio C Hamano wrote:

@@ -185,9 +198,15 @@ void set_alternate_index_output(const char *name)
 int commit_locked_index(struct lock_file *lk)
 {
 	if (alternate_index_output) {
-		int result = rename(lk->filename, alternate_index_output);
-		lk->filename[0] = 0;
-		return result;
+		const char *newname = alternate_index_output;
+		alternate_index_output = NULL;
