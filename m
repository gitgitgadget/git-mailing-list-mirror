From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-am: force egrep to use correct characters set
Date: Mon, 28 Sep 2009 11:53:02 +0200
Message-ID: <4AC0877E.7020204@viscovery.net>
References: <215cc4f241162377b9249c2b3d74050cc77bac16.1253893253.git.chressie@gmail.com> <f0bd48168975c3b2328cf26f9a37a0f54b898473.1253896646.git.chressie@gmail.com> <20090927074015.GB15393@coredump.intra.peff.net> <4AC06FFF.20008@viscovery.net> <20090928093216.GA31459@lamagra.informatik.uni-ulm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Christian Himpel <chressie@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 11:53:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsCvO-000893-LU
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 11:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbZI1JxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 05:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbZI1JxI
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 05:53:08 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:54819 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbZI1JxH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 05:53:07 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MsCul-0008WE-C7; Mon, 28 Sep 2009 11:53:09 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 16EBEA4A1; Mon, 28 Sep 2009 11:53:03 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20090928093216.GA31459@lamagra.informatik.uni-ulm.de>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 0.1 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129241>

Christian Himpel schrieb:
> After doing a quick:
> 
> LC_ALL=C find . -name '*.sh' -exec \
>          egrep -Hne '(grep|awk|sed).*\[.*-.*\]' {} \;
> 
> As far as I can see, range expressions are used:

0. The test suite scripts are not critical because test-lib.sh sets LANG=C
LC_ALL=C

> 1. to replace or grep hexadecimal numbers (SHA1 sums).  This shouldn't
> be a problem, if we can assume that these numbers are never malformed.

The assumption is valid if the input is piped from a git command, and such
uses aren't critical.

> 2. to replace or grep numbers (with digits).  This shouldn't be a
> problem, since digits should be in dictionary order in every language
> (?!).

I agree.

> 3. in git-rebase--interactive.sh:742 to grep for a previously generated
> string.  So it should be safe here.

I agree.

>> The case identified by Christian is certainly important because it is
>> applied to a file whose contents can be anything, and the purpose of the
>> check is to identify the text as an mbox file, whose header section can be
>> only US-ASCII by definition. So, I think it has merit to apply the patch.
> 
> Yes.  It seems that this is the only place where it is important to match
> just the ASCII printable characters.

There is another place in git-am.sh where a sed expression with a range
looks at the input file, doesn't it? Isn't it critical, too?

		if test -f "$dotest/rebasing" &&
			commit=$(sed -e 's/^From \([0-9a-f]*\) .*/\1/' \
				-e q "$dotest/$msgnum") &&
			test "$(git cat-file -t "$commit")" = commit
		then ...

-- Hannes
