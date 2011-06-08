From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] t3703: skip more tests using colons in file names on
 Windows
Date: Wed, 08 Jun 2011 08:22:36 +0200
Message-ID: <4DEF152C.5060005@viscovery.net>
References: <BANLkTik3K2GVZ5rzegYSXRrvROU_bzBdVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 08:22:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUCAD-000763-FG
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 08:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316Ab1FHGWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 02:22:44 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:50019 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752104Ab1FHGWn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 02:22:43 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QUCA1-0005AU-9z; Wed, 08 Jun 2011 08:22:37 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 0B7191660F;
	Wed,  8 Jun 2011 08:22:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <BANLkTik3K2GVZ5rzegYSXRrvROU_bzBdVw@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175295>

Am 6/7/2011 15:43, schrieb Alex Riesen:
> Use the same test and prerequisite as introduced in similar
> fix in 650af7ae8bdf92bd92df2.
> 
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
> 
> Why didn't Johannes noticed it, I wonder. The failing test was
> here all the time.

Good catch! Here's the explanation:

> -test_expect_success 'a file with the same (long) magic name exists' '
> -	: >":(icase)ha" &&

":foo" is the name of an alternate data stream on the current directory.
Bash can successfully open and write such a "file". (But there is no way
to list it, even though test -f detects its existence.)

> -	test_must_fail git add -n ":(icase)ha" &&

This 'git add' fails, either for the intended reason, or because regular
directory listing functions do not detect the alternate data stream; I do
not know.

> -	git add -n "./:(icase)ha"

This obviously succeeds because a regular open() call can open the
alternate data stream just like any file.

Therefore, the test passes. This is on Windows XP with NTFS.

-- Hannes
