From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: [PATCH 2/2] Quoting paths in tests
Date: Wed, 17 Oct 2007 18:07:38 +0100
Message-ID: <6E65762D-FBC4-4A7C-97A9-20F6744E25DE@steelskies.com>
References: <B495731E-C854-450B-943B-B96248B8F609@steelskies.com> <11926134961610-git-send-email-maillist@steelskies.com> <11926134961549-git-send-email-maillist@steelskies.com> <11926134961275-git-send-email-maillist@steelskies.com> <4715F2E6.1000708@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v907)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 17 19:08:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiCNE-0005ZZ-Cz
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 19:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762146AbXJQRHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 13:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762292AbXJQRHu
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 13:07:50 -0400
Received: from juliet.asmallorange.com ([207.210.105.70]:59564 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759810AbXJQRHt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 13:07:49 -0400
Received: from [89.105.122.147] (helo=gir.office.bestbefore.tv)
	by juliet.asmallorange.com with esmtpa (Exim 4.68)
	(envelope-from <maillist@steelskies.com>)
	id 1IiCMx-0005xN-5W; Wed, 17 Oct 2007 13:07:49 -0400
In-Reply-To: <4715F2E6.1000708@viscovery.net>
X-Mailer: Apple Mail (2.907)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61392>


On 17 Oct 2007, at 12:32, Johannes Sixt wrote:

> Jonathan del Strother schrieb:
>> --- a/t/lib-git-svn.sh
>> +++ b/t/lib-git-svn.sh
>> @@ -25,7 +25,7 @@ perl -w -e "
>> use SVN::Core;
>> use SVN::Repos;
>> \$SVN::Core::VERSION gt '1.1.0' or exit(42);
>> -system(qw/svnadmin create --fs-type fsfs/, '$svnrepo') == 0 or  
>> exit(41);
>> +system(qw/svnadmin create --fs-type fsfs/, \"$svnrepo\") == 0 or  
>> exit(41);
>
> Here you have to work harder: The reason is that this is part of a  
> perl expression (as opposed to an eval'd string), which does not  
> have access to $svnrepo of the shell by which it is invoked. The  
> original version failed if there were single-quotes in $svnrepo, the  
> new version fails if it contains double-quotes.
...
>
> May I recommend that you run the test suite in a directory named  
> like this:
>
> 	$ mkdir \"\ \$GIT_DIR\ \'
> 	$ ls
> 	" $GIT_DIR '


Eww.  I'm struggling a bit with paths this perverse, actually.

For instance, git_editor in git-sh-setup expects the editor path to be  
pre-quoted.  So in t3404, you need to produce escaped double quotes &  
dollar signs, resulting in unpleasantness like this :

VISUAL="`pwd`/fake-editor.sh"
VISUAL=${VISUAL//\"/\\\"}
VISUAL=${VISUAL//$/\\\$}
VISUAL=\"$VISUAL\"
export VISUAL


And I'm struggling to come up with neat ways of rewriting things like,  
eg, this bit from t5500 -
test_expect_success "clone shallow" "git-clone --depth 2 \"file:// 
`pwd`/.\" shallow"
- to handle paths like that properly.


Suggestions?

Jon
