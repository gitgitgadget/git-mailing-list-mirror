From: Nils Adermann <naderman@naderman.de>
Subject: subtree merge tries to merge into wrong directory
Date: Thu, 10 Dec 2009 04:41:03 +0100
Message-ID: <4B206DCF.90202@naderman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 10 04:48:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIa1P-0005WT-MI
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 04:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759515AbZLJDso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 22:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759509AbZLJDso
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 22:48:44 -0500
Received: from naderman.de ([85.119.157.185]:49178 "EHLO naderman.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759507AbZLJDsn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 22:48:43 -0500
X-Greylist: delayed 463 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Dec 2009 22:48:43 EST
Received: by naderman.de (Postfix, from userid 65534)
	id 50ACCBE9B187; Thu, 10 Dec 2009 03:40:58 +0000 (UTC)
Received: from [192.168.1.3] (e180075127.adsl.alicedsl.de [85.180.75.127])
	by naderman.de (Postfix) with ESMTPA id 956D6BE9B180
	for <git@vger.kernel.org>; Thu, 10 Dec 2009 03:40:57 +0000 (UTC)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.1.7
   int  cnt   prob  spamicity histogram
  0.00   67 0.021546 0.020194 ################################################
  0.10    1 0.118975 0.021849 #
  0.20    0 0.000000 0.021849 
  0.30    0 0.000000 0.021849 
  0.40    0 0.000000 0.021849 
  0.50    0 0.000000 0.021849 
  0.60    0 0.000000 0.021849 
  0.70    0 0.000000 0.021849 
  0.80    0 0.000000 0.021849 
  0.90    4 0.993514 0.247973 ###
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135009>

Following 
http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html 
I have subtree merged a 3rd party library (ezc-reflection) into my 
repository (pflow). The prefix I used was lib/ezc/trunk/Reflection. Now 
there have been changes to ezc-reflection but merging them into my 
repository fails. The merge is attempted in example/ rather than 
lib/ezc/trunk/Reflection.

I originally set this up with:

git remote add -f ezc-reflection /path/to/ezc-reflection
git merge -s ours --no-commit ezc-reflection/master
git read-tree --prefix=lib/ezc/trunk/Reflection -u ezc-reflection/master

Reproduce my problem by executing the following:

git clone git://github.com/naderman/pflow.git
cd pflow
git reset --hard f3e001e3
git fetch git://github.com/naderman/ezc-reflection.git master
git merge -s subtree FETCH_HEAD

As you see this results in:

CONFLICT (delete/modify): example/src/doc_comment_parser.php deleted in 
HEAD and modified in FETCH_HEAD. Version FETCH_HEAD of 
example/src/doc_comment_parser.php left in tree.
Automatic merge failed; fix conflicts and then commit the result.

As long as I don't make any changes to lib/ezc/trunk/Reflection that I 
want to merge I can work around this by simply repeating my original 
process like this:

git clone git://github.com/naderman/pflow.git
cd pflow
git reset --hard f3e001e3
git fetch git://github.com/naderman/ezc-reflection.git master
git merge -s ours --no-commit FETCH_HEAD
git rm -r lib/ezc/trunk/Reflection/
git read-tree --prefix=lib/ezc/trunk/Reflection/ -u FETCH_HEAD

Why does this problem occur and how can I get the merge to work properly?

Cheers,
Nils Adermann
