From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: [RFC/PATCH] Use compatibility regex library for OSX/Darwin
Date: Tue, 16 Sep 2008 18:10:30 -0600
Message-ID: <alpine.LNX.1.10.0809161808011.17105@suse104.zenez.com>
References: <20080907184537.GA4148@regex.yaph.org> <W_emvcr7ijntBMNCDV17_XHXotGkm1Bn-9Bw-ZixcXmFyBWlDj5vYg@cipher.nrlssc.navy.mil> <alpine.LNX.1.10.0809161722580.18110@suse104.zenez.com> <20080916233220.GA14173@coredump.intra.peff.net>
 <alpine.LNX.1.10.0809161738010.17105@suse104.zenez.com> <20080916234624.GA14405@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Arjen Laarhoven <arjen@yaph.org>, git@vger.kernel.org,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 17 02:11:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfkdw-0004ot-2O
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 02:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbYIQAKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 20:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752432AbYIQAKc
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 20:10:32 -0400
Received: from suse104.zenez.com ([198.60.105.164]:11516 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbYIQAKb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 20:10:31 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id 96AB9A7C8EF; Tue, 16 Sep 2008 18:10:30 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 8178AA7C8E9;
	Tue, 16 Sep 2008 18:10:30 -0600 (MDT)
In-Reply-To: <20080916234624.GA14405@coredump.intra.peff.net>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96056>

On Tue, 16 Sep 2008, Jeff King wrote:
> On Tue, Sep 16, 2008 at 05:42:11PM -0600, Boyd Lynn Gerber wrote:
>> When I do a gmake test these 4 platforms all fail only these 2 tests.
>> * FAIL 10: reinit
>> [...]
>> * FAIL 11: init with --template
>> [...]
>> gmake[1]: *** [t0001-init.sh] Error 1
>>
>  1. Run t0001 in verbose mode and report the results so we can get a
>     better idea of what's failing:
>
>       gmake test GIT_TEST_OPTS=--verbose


* expecting success:

         (
                 unset GIT_CONFIG GIT_WORK_TREE GIT_CONFIG

                 mkdir again &&
                 cd again &&
                 git init >out1 2>err1 &&
                 git init >out2 2>err2
         ) &&
         grep "Initialized empty" again/out1 &&
         grep "Reinitialized existing" again/out2 &&
         >again/empty &&
         test_cmp again/empty again/err1 &&
         test_cmp again/empty again/err2

Initialized empty Git repository in 
/home/zenez/build/osr6/git-1.6.0.2/t/trash directory/again/.git/
Reinitialized existing Git repository in 
/home/zenez/build/osr6/git-1.6.0.2/t/trash directory/again/.git/
diff: ERROR: Illegal option -- u
Usage: diff [ -bcefhrC<n> ] file1 file2
* FAIL 10: reinit
                 (
                         unset GIT_CONFIG GIT_WORK_TREE GIT_CONFIG

                         mkdir again &&
                         cd again &&
                         git init >out1 2>err1 &&
                         git init >out2 2>err2
                 ) &&
                 grep "Initialized empty" again/out1 &&
                 grep "Reinitialized existing" again/out2 &&
                 >again/empty &&
                 test_cmp again/empty again/err1 &&
                 test_cmp again/empty again/err2

* expecting success:
         mkdir template-source &&
         echo content >template-source/file &&
         (
                 mkdir template-custom &&
                 cd template-custom &&
                 git init --template=../template-source
         ) &&
         test_cmp template-source/file template-custom/.git/file

Initialized empty Git repository in 
/home/zenez/build/osr6/git-1.6.0.2/t/trash directory/template-custom/.git/
diff: ERROR: Illegal option -- u
Usage: diff [ -bcefhrC<n> ] file1 file2
* FAIL 11: init with --template

                 mkdir template-source &&
                 echo content >template-source/file &&
                 (
                         mkdir template-custom &&
                         cd template-custom &&
                         git init --template=../template-source
                 ) &&
                 test_cmp template-source/file template-custom/.git/file

* expecting success:
         (
                 mkdir template-plain &&
                 cd template-plain &&
                 git init
         ) &&
         test -f template-plain/.git/info/exclude &&
         (
                 mkdir template-blank &&
                 cd template-blank &&
                 git init --template=
         ) &&
         ! test -f template-blank/.git/info/exclude

Initialized empty Git repository in 
/home/zenez/build/osr6/git-1.6.0.2/t/trash directory/template-plain/.git/
Initialized empty Git repository in 
/home/zenez/build/osr6/git-1.6.0.2/t/trash directory/template-blank/.git/

>  2. Run t4018 individually and report on the results:
>
>       cd t && gmake t4018-diff-funcname.sh


3 systems all give me this.

$ cd t && gmake t4018-diff-funcname.sh
*** t4018-diff-funcname.sh ***
t4018-diff-funcname.sh: syntax error at line 52: `(' unexpected
gmake: *** [t4018-diff-funcname.sh] Error 2


--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
