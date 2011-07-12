From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 22/48] merge-recursive: Fix sorting order and directory
 change assumptions
Date: Tue, 12 Jul 2011 09:27:56 +0200
Message-ID: <4E1BF77C.2020207@viscovery.net>
References: <1307518278-23814-1-git-send-email-newren@gmail.com> <1307518278-23814-23-git-send-email-newren@gmail.com> <4E1AA085.9010908@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 09:32:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgXRz-0008SU-Au
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 09:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758181Ab1GLH2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 03:28:01 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:61849 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753539Ab1GLH2A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 03:28:00 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QgXNt-0004BJ-Fc; Tue, 12 Jul 2011 09:27:57 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 382D01660F;
	Tue, 12 Jul 2011 09:27:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <4E1AA085.9010908@viscovery.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176936>

Am 7/11/2011 9:04, schrieb Johannes Sixt:
> A heads-up: This test case fails here on Windows. The messages produced are:

> As you can see, "Removing letters..." is missing on Windows, and the file
> 'letters' is indeed left in the working tree. Any quick ideas where to
> begin debugging this?

And the reason for this is that the qsort call in record_df_conflict_files
assumes that qsort is a stable sort; but this is not guaranteed. In
particular, the entry "letters" can be moved after "letters/file", which
is not expected by the loop that follows the qsort.

-- Hannes
