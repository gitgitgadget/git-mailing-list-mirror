From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: checkout/update boiler plate for --filter-index?
Date: Tue, 24 Mar 2009 08:21:06 +0100
Message-ID: <49C889E2.2080208@viscovery.net>
References: <580660BE-FDAB-4947-B409-1E8D5CBEF8EE@earth.care2.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Marcel Cary <marcel@earth.care2.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 08:22:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm0yE-00055i-Gu
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 08:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbZCXHVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 03:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752287AbZCXHVN
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 03:21:13 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:39561 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbZCXHVM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 03:21:12 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Lm0wc-0008Jr-MG; Tue, 24 Mar 2009 08:21:06 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 62A5A69F; Tue, 24 Mar 2009 08:21:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <580660BE-FDAB-4947-B409-1E8D5CBEF8EE@earth.care2.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114405>

Marcel Cary schrieb:
> I'm trying to do a historical find-and-replace on my code:
> 
> git grep -F foo > files
> git filter-branch --index-filter "
>   cat `pwd`/files | xargs git checkout  --
>   cat `pwd`/files | xargs sed -i 's/foo/bar/g; '
>   cat `pwd`/files | xargs git update-index --
> " ancestor..HEAD
> 
> When I instead use --tree-filter and skip the checkout/update-index, it
> works how I want (but it takes a while...).  But when I use
> --index-filter, the resulting history shows the "foo" to "bar" change
> happening *after* new code is added, rather than originally adding "bar".
> 
> How can I checkout just a few files and update them to take advantage of
> the speed of index operations?

You cannot do that with the index filter because you need actual blob
contents to operate on, but the index filter doesn't give you an
opportunity to do that. The tree filter is the right filter to use. But
you neither need 'git checkout' nor 'git update-index' in the filter -
filter-branch calls them for you. (Oh, and get rid of that useless use of
cat.)

-- Hannes
