From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Re: Gitk --all error when there are more than 797 refs
 in a repository
Date: Mon, 21 Sep 2009 17:59:35 +0200
Message-ID: <4AB7A2E7.5000601@viscovery.net>
References: <6F87406399731F489FBACE5C5FFA04584BFA53@ex2k.bankofamerica.com> <878wgcbb52.fsf@users.sourceforge.net> <19124.8378.975976.347711@cargo.ozlabs.ibm.com> <6F87406399731F489FBACE5C5FFA0458518DE8@ex2k.bankofamerica.com> <4AB78910.7010402@viscovery.net> <6F87406399731F489FBACE5C5FFA0458518E11@ex2k.bankofamerica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org
To: "Murphy, John" <john.murphy@bankofamerica.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 18:01:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MplIp-00059Q-2R
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 17:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbZIUP7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 11:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbZIUP7h
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 11:59:37 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:11042 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbZIUP7h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 11:59:37 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MplIg-0006NB-1V; Mon, 21 Sep 2009 17:59:38 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9C1056D9; Mon, 21 Sep 2009 17:59:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <6F87406399731F489FBACE5C5FFA0458518E11@ex2k.bankofamerica.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128893>

Murphy, John schrieb:
> Johannes Sixt writes:
> 
>> But in order to have a $revs that exceeds 32K, you would already have
> to
>> invoke gitk with a huge command line that exceeds the limit (but this
> is
>> not possible), no?
> 
>> How do you run gitk?
> 
> gitk --all

I see it. Here is a bash script that creates a repository that reproduces
the error. It is important that refs which sort alphabetically earlier
also point to earlier commits.

-- snip --
#!/bin/bash
git init
echo initial > file && git add file && git commit -m initial
for ((i = 0; i < 1000; i++))
do
	echo $i > file &&
	git commit -m $i file > /dev/null &&
	printf -v l "branch-%04d" $i &&
	git update-ref refs/heads/$l HEAD
done
git gc
-- snip --

On Windows, 'gitk --all' starts with branch-0797, on Linux it starts with
branch-0999 aka master.

I'm just throwing this out to interested parties; I'll not look into it at
this time.

Thanks,
-- Hannes
