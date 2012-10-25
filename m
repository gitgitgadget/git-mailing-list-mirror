From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] Use character class for sed expression instead of \s
Date: Thu, 25 Oct 2012 22:09:39 +0200
Message-ID: <50899C83.6090008@web.de>
References: <508935CB.9020408@web.de> <1351180699-24695-1-git-send-email-bdwalton@gmail.com> <C2AB6973-7BC2-45A4-836E-BB1FAAE7501C@gernhardtsoftware.com> <5089689A.9070301@web.de> <CAP30j15n1hVn6zptDpAfM+Aqc3LnRR4PN6jHTHpTkcjYLgPnjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Brian Gernhardt <brian@gernhardtsoftware.com>, peff@peff.net,
	bosch@adacore.com, git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 22:10:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRTkr-0001IV-CG
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 22:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760220Ab2JYUKA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Oct 2012 16:10:00 -0400
Received: from mout.web.de ([212.227.17.12]:58079 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755951Ab2JYUJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 16:09:59 -0400
Received: from wanderer.site ([195.67.191.22]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MUncu-1TvFaR2gWa-00Ygz7; Thu, 25 Oct 2012 22:09:47
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <CAP30j15n1hVn6zptDpAfM+Aqc3LnRR4PN6jHTHpTkcjYLgPnjw@mail.gmail.com>
X-Provags-ID: V02:K0:fF6Uf8FFv5YxCrax2tX08AtOeflVGS4Utup1KI1gzG4
 jd4Gk2VsObQBMPGNsQL04l3iSBuw1fldC6xlbpss7BzkbSJC84
 0iXtSXwXJKpD+DXkVrwHlbQsZASkZjlEjfUtLPefCYnV6ZGhu5
 jOZ0GI8sFTZI+5l7Fp+Z/r7vVS98rZ7N5FLFWmKVnFJfpplN1O
 8y0YajJvHssaIG8F4vWxg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208417>

On 10/25/2012 08:08 PM, Ben Walton wrote:
> Hi Torsten,
>
> On Thu, Oct 25, 2012 at 5:28 PM, Torsten B=F6gershausen <tboegi@web.d=
e> wrote:
>
>> BTW: While we are talking CVS: (I installed a fresh version)
>> cvs --version
>> Concurrent Versions System (CVS) 1.11.23 (client/server)
>
> I have 1.12.13-MirDebian-8 here.
>
>> And t9200 fails:
>> git checkout t9200-git-cvsexportcommit.sh
>> tb@birne:~/projects/git/git.pu/t> ./t9200-git-cvsexportcommit.sh
>> cvs [init aborted]: Cannot initialize repository under existing CVSR=
OOT: `/Users/tb/projects/git/git.pu/t/trash directory.t9200-git-cvsexpo=
rtcommit'
>> FATAL: Unexpected exit with code 1
>
> I'm not able to reproduce this manually...are you able to make it fai=
l
> this way outside of the test harness?
>
> $ CVSROOT=3D$PWD/bw
> $ export CVSROOT
> $ mkdir $CVSROOT && cvs init && echo ok
> ok
> $ rm -rf $CVSROOT
> $ cvs init && echo ok
> ok
>
>>> (cvs init || mkdir "$CVSROOT" && cvs init ) &&
>
> If your version of cvs fails the checks above in manual testing, we
> could see if there is a flag that works in all (old and new) versions
> to override the failure if CVSROOT exists.  Otherwise, this isn't a
> bad fix, I don't think.
>
> If your version does fail the manual checks, I think it's likely a
> regression that was introduced and later reverted.  I don't see those
> strings inside my cvs binary at all...?
>
> HTH.
>
> Thanks
> -Ben
>
Hej Ben,
thanks for looking into that - here some short answers:

a) The manual test (as you describe it) succeeds
b) The test case 9200 failes, and now I know why:

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcomm=
it.sh
index b59be9a..d2c3c37 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -19,7 +19,7 @@ then
      test_done
  fi

-CVSROOT=3D$PWD/cvsroot
+CVSROOT=3D$PWD/xx
  CVSWORK=3D$PWD/cvswork
  GIT_DIR=3D$PWD/.git
  export CVSROOT CVSWORK GIT_DIR



c) I need to send a patch tomorrow

d) FYI: I compiled cvs from scratch, from a file called cvs-1.11.23.tar=
=2Egz
    and the code is in cvs-1.11.23/src/mkmodules.c:942

if (root_dir && strcmp (root_dir, current_parsed_root->directory))
   error (1, 0,
          "Cannot initialize repository under existing CVSROOT: `%s'",
          root_dir);
     free (root_dir);

/Torsten
