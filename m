From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: [RFC/PATCH] Use compatibility regex library for OSX/Darwin
Date: Tue, 16 Sep 2008 17:42:11 -0600
Message-ID: <alpine.LNX.1.10.0809161738010.17105@suse104.zenez.com>
References: <20080907184537.GA4148@regex.yaph.org> <W_emvcr7ijntBMNCDV17_XHXotGkm1Bn-9Bw-ZixcXmFyBWlDj5vYg@cipher.nrlssc.navy.mil> <alpine.LNX.1.10.0809161722580.18110@suse104.zenez.com> <20080916233220.GA14173@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Arjen Laarhoven <arjen@yaph.org>, git@vger.kernel.org,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 17 01:43:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfkCW-000550-Rw
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 01:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbYIPXmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 19:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752416AbYIPXmN
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 19:42:13 -0400
Received: from suse104.zenez.com ([198.60.105.164]:22197 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbYIPXmM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 19:42:12 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id CFFABA7C8E9; Tue, 16 Sep 2008 17:42:11 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id C3E0AA7C8E2;
	Tue, 16 Sep 2008 17:42:11 -0600 (MDT)
In-Reply-To: <20080916233220.GA14173@coredump.intra.peff.net>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96051>

On Tue, 16 Sep 2008, Jeff King wrote:
> On Tue, Sep 16, 2008 at 05:25:46PM -0600, Boyd Lynn Gerber wrote:
>>> I wonder if this is the right fix? Right now the GNU regex library is
>>> necessary for Darwin, FreeBSD and AIX. I can add IRIX6.5 and Solaris 7
>>> to that list. Have newer Solaris's been tested yet? (Jeff?) I wonder if
>>> the new test which triggers this flaw has been tested on the other
>>> non-GNU platforms in the Makefile which have not been updated. Boyd
>>> Lynn Gerber and his 12 platforms comes to mind.
>>
>> Someone forwarded me this email and asked if I had tested it.  I have not.
>> Where is the easiest place to get it to test with the various platforms?
>> I will check it out on 3-5 of them.  I now have 1.6.0.2 on 5 platforms
>> running and working.  I have not had the time to get it on the other's
>> yet.
>
> The problematic test is in 1.6.0.2; if you can run t4018-diff-funcname
> successfully, then I believe you are not affected.

When I do a gmake test these 4 platforms all fail only these 2 tests.

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

* FAIL 11: init with --template

                 mkdir template-source &&
                 echo content >template-source/file &&
                 (
                         mkdir template-custom &&
                         cd template-custom &&
                         git init --template=../template-source
                 ) &&
                 test_cmp template-source/file template-custom/.git/file

*   ok 12: init with --template (blank)
* failed 2 among 12 test(s)
gmake[1]: *** [t0001-init.sh] Error 1
gmake[1]: Leaving directory `/home/zenez/build/osr6/git-1.6.0.2/t'
gmake: *** [test] Error 2

I have not had time to look into the failures.  How many tests should I 
see and pass.  The first 40 all pass.  Then 2 of 12 fail as above.

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
