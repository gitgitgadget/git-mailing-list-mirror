From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: git-1.6.2-rc2 problems on t4034-diff-words.sh
Date: Fri, 27 Feb 2009 12:24:49 -0700
Message-ID: <alpine.LNX.2.00.0902271216090.19082@suse104.zenez.com>
References: <alpine.LNX.2.00.0902271103450.19082@suse104.zenez.com> <alpine.DEB.1.00.0902271936090.6600@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 27 20:26:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld8Ll-0005sJ-Td
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 20:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756207AbZB0TYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 14:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755503AbZB0TYx
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 14:24:53 -0500
Received: from suse104.zenez.com ([198.60.105.164]:49418 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906AbZB0TYw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 14:24:52 -0500
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id E81056C1A7A; Fri, 27 Feb 2009 12:24:49 -0700 (MST)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id D945A93817C;
	Fri, 27 Feb 2009 12:24:49 -0700 (MST)
In-Reply-To: <alpine.DEB.1.00.0902271936090.6600@intel-tinevez-2-302>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111699>

Thanks for your assistence.  I try to test each version before release. 
So I want to make sure no changes have broken things.

On Fri, 27 Feb 2009, Johannes Schindelin wrote:
> On Fri, 27 Feb 2009, Boyd Lynn Gerber wrote:
>> I just download and started to test this on SCO OpenServer 6.0.mp4
>
> Oh wow.  SCO...

Yes, I still have to support some SCO OS's.  I use git on all my OS's.  So 
I want to make sure it works on all of them.

> But as I did not forget your kind words, I'll try to help.
>
>> * FAIL 6: use regex supplied by driver
>>
>>
>>                 word_diff --color-words

Does the test suite use bash as it's shell?  I seem to have to use bash 
now to run the test.  I do not remember having to use bash on earlier 
1.6.0

> It might be a regex related issue.  Could you
>
> - run the test with -i -v (and if that does not help, "sh -x t...")?

I have to use bash to run the test or I get

$ ./t4034-diff-words.sh
./t4034-diff-words.sh: syntax error at line 52: `(' unexpected

But if I run

$ bash ./t4034-diff-words.sh
*   ok 1: setup
*   ok 2: word diff with runs of whitespace
*   ok 3: word diff with a regular expression
*   ok 4: set a diff driver
*   ok 5: option overrides .gitattributes
* FAIL 6: use regex supplied by driver


                 word_diff --color-words


*   ok 7: set diff.wordRegex option
*   ok 8: command-line overrides config
* FAIL 9: .gitattributes override config

                 word_diff --color-words

*   ok 10: remove diff driver regex
*   ok 11: use configured regex
* FAIL 12: test parsing words for newline


                 word_diff --color-words="a+"



* FAIL 13: test when words are only removed at the end


                 word_diff --color-words=.


* failed 4 among 13 test(s)
$ bash ./t4034-diff-words.sh -i -v
Initialized empty Git repository in /tmp/git-1.6.2.rc2/t/trash 
directory.t4034-diff-words/.git/
* expecting success:

         git config diff.color.old red
         git config diff.color.new green


*   ok 1: setup

* expecting success:

         word_diff --color-words


*   ok 2: word diff with runs of whitespace

* expecting success:

         word_diff --color-words="[a-z]+"


*   ok 3: word diff with a regular expression

* expecting success:
         git config diff.testdriver.wordRegex "[^[:space:]]" &&
         cat <<EOF > .gitattributes
pre diff=testdriver
post diff=testdriver
EOF

*   ok 4: set a diff driver

* expecting success:

         word_diff --color-words="[a-z]+"


*   ok 5: option overrides .gitattributes

* expecting success:

         word_diff --color-words


Binary files expect and output.decrypted differ
* FAIL 6: use regex supplied by driver


                 word_diff --color-words




Binary files expect and output.decrypted differ
* FAIL 6: use regex supplied by driver


                 word_diff --color-words

>
> - try with "make COMPAT_FLAGS=-Icompat/regex COMPAT_OBJS=compat/regex/regex.o"?

$ gmake COMPAT_FLAGS=-Icompat/regex COMPAT_OBJS=compat/regex/regex.o
     CC compat/regex/regex.o
     AR libgit.a
     LINK git-fast-import
Undefined                       first referenced
symbol                              in file
git_fopen                           fast-import.o
git_vsnprintf                       fast-import.o
git_snprintf                        fast-import.o
UX:ld: ERROR: Symbol referencing errors. No output written to 
git-fast-import
gmake: *** [git-fast-import] Error 1

-- 
Boyd Gerber <gerberb@zenez.com> 801 849-0213
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
