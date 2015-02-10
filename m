From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [msysGit] Missing inversion in Makefile (ee9be06)
Date: Tue, 10 Feb 2015 22:51:19 -0000
Organization: OPDS
Message-ID: <C928DF3E5D7D423588EF2C2BA09D8A73@PhilipOakley>
References: <E3DB9AD2A8914C379FB3371494B0B816@PhilipOakley> <549F0355.5020805@kdbg.org> <4C7BB65E9EE445F08645582230EA9782@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git MsysGit" <msysgit@googlegroups.com>
To: "Philip Oakley" <philipoakley@iee.org>,
	"Johannes Sixt" <j6t@kdbg.org>, "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 23:51:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLJeK-0003Da-Dp
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 23:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008AbbBJWvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 17:51:15 -0500
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:23595 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754994AbbBJWvN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Feb 2015 17:51:13 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ar4LAKmK2lRcFj9qPGdsb2JhbABbgwZSTwuDAYQXvACFJREzBAKBIEQBAQEBAQEFAQEBATg7hAcFAQEBAQIBCAEBGRUeAQEhBQYCAwUCAQMVAQQCBSECAhQBBBoGBwMGAQ0GARIIAgECAwGIFAwJuh6GU5AFAQEBAQEBAQMBAQEBAQEBARYEgSGOVoJvLoEUBY8gVYJ8hnWLHYV0TYQQPjEBBII+AQEB
X-IPAS-Result: Ar4LAKmK2lRcFj9qPGdsb2JhbABbgwZSTwuDAYQXvACFJREzBAKBIEQBAQEBAQEFAQEBATg7hAcFAQEBAQIBCAEBGRUeAQEhBQYCAwUCAQMVAQQCBSECAhQBBBoGBwMGAQ0GARIIAgECAwGIFAwJuh6GU5AFAQEBAQEBAQMBAQEBAQEBARYEgSGOVoJvLoEUBY8gVYJ8hnWLHYV0TYQQPjEBBII+AQEB
X-IronPort-AV: E=Sophos;i="5.09,553,1418083200"; 
   d="scan'208";a="129511549"
Received: from host-92-22-63-106.as13285.net (HELO PhilipOakley) ([92.22.63.106])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 10 Feb 2015 22:51:10 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263656>

Another go at this XY-Problem...


From: "Philip Oakley" <philipoakley@iee.org>
Sent: Saturday, December 27, 2014 8:17 PM
> From: "Johannes Sixt" <j6t@kdbg.org>
>> Am 27.12.2014 um 19:49 schrieb Philip Oakley:
>>> Hi,
>>>
>>> In ee9be06 (perl: detect new files in MakeMaker builds, 2012-07-27)
>>> there is a step to detect if there has been an update to the PM.* 
>>> files,
>>> however it appears that the logic is inverted in the comparison.
>>>
>>> I need some extra eye's on this to be sure I have it right (I'm 
>>> trying
>>> to debug an old Windows breakage...).
>>>
>>> The resultant output of a make dry run included (on my m/c)..:
>>>
>>>  find perl -type f -name '*.pm' | sort >perl/PM.stamp+ && \
>>>   { cmp perl/PM.stamp+ perl/PM.stamp >/dev/null 2>/dev/null || mv
>>> perl/PM.stamp+ perl/PM.stamp; } && \
>>>   rm -f perl/PM.stamp+
>>>  make -C perl  PERL_PATH='/usr/bin/perl' prefix='/c/Documents and
>>> Settings/Philip' perl.mak
>>>
>>> Shouldn't it be `{ ! cmp ` so that when the files are not identical, 
>>> the
>>> move is performed?
>>>
>>> https://github.com/git/git/blob/ee9be06770223238c6a22430eb874754dd22dfb0/Makefile#L2097
>>
>> The existing code looks correct to me. cmp succeeds when the files 
>> are
>> identical and fails when they are different: When it succeeds (files 
>> are
>> equal), the mv is not executed. When it fails, either because a file
>> does not exist or they are different, the mv is executed.
>>
> Thanks. The inverse logic had me confused.
> It's like 7400's again, for those that remember;-)
>

Here's where the real problem starts...

> I was getting errors from
> `cd $git_dir && make -n MSVC=1 V=1 2>MakeDryErrs.txt 1>MakeDry.txt` 
> (borrowed from 'msvc-build') which reported the PM.stamp as a problem, 
> with the quoted code being the last part of the MakeDry.txt (and no 
> PM.stamp seen).
>
> Now that I've been poking and investigating the error's stopped! It's 
> all getting rather frustrating. Time to go again on a clean and 
> rebuild..

I'm trying to get the msysgit msvc-build script[1], which essentially 
implements the Git 'compat/vcbuild/README', to work again in terms of 
creating a Visual Studio [2008] project file (.sln).

If I run the code (find perl -type f -name '*.pm' ...) manually then the 
PM.stamp file is created allowing future dry-runs to succeed - hence 
some of my confusion.

The script uses git's 'contrib/buildsystems/engine.pl' to parse the 
output of:
 `make -n MSVC=1 V=1 2>\dev\null` [2]

This appears to no longer work because the -n (dry-run) option fails to 
run the required 'perl/PM.stamp' during the dry-run. At least that's now 
my understanding.

The 
https://www.gnu.org/software/make/manual/html_node/Instead-of-Execution.html 
page indicates that adding a + to the right rule would be needed to also 
run the PM.stamp process during dry-run.

At the moment I'm getting (on my old WinXP machine, using Msysgit 1.9.5 
as a basis)

$ make -n MSVC=1 V=1 1>makedry.txt
make[1]: *** No rule to make target `PM.stamp', needed by `perl.mak'. 
Stop.
make: *** [perl/perl.mak] Error 2

i.e. PM.stamp was not created so can't be the target of the dry-run make 
rule.

The makedry.txt file generated ends with the

find perl -type f -name '*.pm' | sort >perl/PM.stamp+ && \
 { cmp perl/PM.stamp+ perl/PM.stamp >/dev/null 2>/dev/null || mv 
perl/PM.stamp+ perl/PM.stamp; } && \
 rm -f perl/PM.stamp+
make -C perl  PERL_PATH='/usr/bin/perl' prefix='/c/Documents and 
Settings/Philip' perl.mak
make[1]: Entering directory `/c/msysgit195/git/perl'
make -C .. GIT-CFLAGS
make[2]: Entering directory `/c/msysgit195/git'
FLAGS='compat/vcbuild/scripts/clink.pl:  -Imsvcgit/32bits/include [...]
     if test x"$FLAGS" != x"`cat GIT-CFLAGS 2>/dev/null`" ; then \
  echo >&2 "    * new build flags"; \
  echo "$FLAGS" >GIT-CFLAGS; \
            fi
make[2]: Leaving directory `/c/msysgit195/git'
make[1]: Leaving directory `/c/msysgit195/git/perl'

i.e. the commands for the PM.stamp process are listed, rather than 
executed as may have been hoped.

I've tried hacking the plus(+) prefix onto the "perl/PM.stamp: FORCE" 
rule, but it gave the same error.


What would be the right way of making a dry-run produce a suitable 
complete output? Make files are not something I normally delve into.

--
Philip

[1] https://github.com/msysgit/msysgit/blob/master/bin/msvc-build
[2] 
https://github.com/git/git/blob/master/contrib/buildsystems/engine.pl#L75
