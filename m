From: Kosenko Roman <madkite@gmail.com>
Subject: [bug] git-svn segmentation fault
Date: Tue, 11 Aug 2015 12:56:16 +0100
Message-ID: <CAB4xWX7R_FrFATqnwebRqAWsUrZd-ATU3rTGxjq6c-44XbRUgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 13:56:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZP8Ac-0007lt-6K
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 13:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbbHKL4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 07:56:37 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35896 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964863AbbHKL4g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 07:56:36 -0400
Received: by wicja10 with SMTP id ja10so72176698wic.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 04:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=YivQaFZBWVCLr52XBwdkKDjxGxWrywpGaQuaSxpzdo4=;
        b=YRmcW8d/yiEl4fY8i8bvB1lKM9zqEdfNGPXwjU2VuXw1vplHVf2lg+xYOo8Vao3gk1
         FBXQTNEQkxG/lzdvB92X4ORyl5hcj9LUBcF878NRlI/p/INZ140tWt2hUujM5AxmI+FJ
         qXFbqCeEuDmCiEbioD3NCn6PLsxKi0fotsPeQRLkEurbaIrYOHMZT9n3Y4WUEoKSpOIT
         KhFGyKQynaSePlBlt7eYYZE3JPmlNfXaxkGWMmNvMJNQYT2p9JSSVbdHiADZBlA1c77K
         1AotXtFNN7RjGzH7/9ZIb8n1XldXzHKXE+zg/+7fCe9z8HNkt1Jgsqp0aH1MImyBx7m3
         3Ipw==
X-Received: by 10.194.86.161 with SMTP id q1mr57421441wjz.18.1439294195451;
 Tue, 11 Aug 2015 04:56:35 -0700 (PDT)
Received: by 10.28.103.68 with HTTP; Tue, 11 Aug 2015 04:56:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275685>

Hello,
I use git-svn. I have used it without any problem for two month. Now
git starts crashing after "svn rebase" (maybe also after other
operations with a remote svn server, I'll check when will do "svn
dcommit" next time). It successfully done the operation and only then
it crashes:

$ git svn rebase
Current branch master is up to date.
error: git-svn died of signal 11

$ dmesg | tail -n5
[518105.393218] git-svn[25148]: segfault at 7f81c0775c50 ip
00007f81c0775c50 sp 00007ffca025adc8 error 14 in
Glob.so[7f81c0979000+6000]
[518113.627053] git-svn[25487]: segfault at 7f0547a76c50 ip
00007f0547a76c50 sp 00007ffe31c39958 error 14 in
Glob.so[7f0547c7a000+6000]
[518137.038469] git-svn[25677]: segfault at 7fe124d4fc50 ip
00007fe124d4fc50 sp 00007ffc821fc848 error 14 in
Glob.so[7fe124f53000+6000]
[518173.339068] git-svn[25864]: segfault at 7f0919006c50 ip
00007f0919006c50 sp 00007ffe78e51b58 error 14 in
Glob.so[7f091920a000+6000]
[519070.924619] git-svn[26467]: segfault at 7f119202ec50 ip
00007f119202ec50 sp 00007fff2af3a948 error 14 in
Glob.so[7f1192232000+6000]

This behaviour is persistent and I can reproduce it any time.

Versions info:

$ uname -a
Linux hs-arch 4.1.4-1-ARCH #1 SMP PREEMPT Mon Aug 3 21:30:37 UTC 2015
x86_64 GNU/Linux

$ git --version
git version 2.5.0

$ svn --version
svn, version 1.8.13 (r1667537)
   compiled Jun  3 2015, 05:30:35 on x86_64-unknown-linux-gnu

Copyright (C) 2014 The Apache Software Foundation.
This software consists of contributions made by many people;
see the NOTICE file for more information.
Subversion is open source software, see http://subversion.apache.org/

The following repository access (RA) modules are available:

* ra_svn : Module for accessing a repository using the svn network protocol.
  - with Cyrus SASL authentication
  - handles 'svn' scheme
* ra_local : Module for accessing a repository on local disk.
  - handles 'file' scheme
* ra_serf : Module for accessing a repository via WebDAV protocol using serf.
  - using serf 1.3.8
  - handles 'http' scheme
  - handles 'https' scheme

$ perl --version

This is perl 5, version 22, subversion 0 (v5.22.0) built for
x86_64-linux-thread-multi

Copyright 1987-2015, Larry Wall

Perl may be copied only under the terms of either the Artistic License or the
GNU General Public License, which may be found in the Perl 5 source kit.

Complete documentation for Perl, including FAQ lists, should be found on
this system using "man perl" or "perldoc perl".  If you have access to the
Internet, point your browser at http://www.perl.org/, the Perl Home Page.

I don't know exact version of Subversion on the remote server (web ui
doesn't show it).
Core dump: http://madkite.cc/git/core.git-svn.1000.e28aeb54778749879c9313b05ea040e8.26467.1439282047000000.lz4

I have tried on another environment (cygwin x64, git 2.4.5, svn
1.8.13, perl 5.14.4) - it works fine with the same repo.
Also my environment works fine with other repos.

Is there anything else you need from me?

Best regards, Roman.
