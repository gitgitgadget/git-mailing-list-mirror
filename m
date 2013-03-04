From: Robert Irelan <rirelan@epic.com>
Subject: "git commit" fails due to spurious file in index
Date: Mon, 4 Mar 2013 18:15:36 +0000
Message-ID: <2D9BD788B02ABA478C57929170AF952B7622B5@EXCH-MBX-3.epic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 04 19:30:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCaA1-0006M5-Bk
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 19:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093Ab3CDSaR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Mar 2013 13:30:17 -0500
Received: from goon4.epic.com ([199.204.56.118]:38126 "EHLO goon4.epic.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757248Ab3CDSaP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Mar 2013 13:30:15 -0500
X-Greylist: delayed 874 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Mar 2013 13:30:14 EST
Received: from EXCH-HUB-1.epic.com (exch-hub-1.epic.com [10.8.7.181])
	by goon4.epic.com (8.13.8/8.13.8) with ESMTP id r24IFbqW024986
	for <git@vger.kernel.org>; Mon, 4 Mar 2013 12:15:39 -0600
Received: from EXCH-MBX-3.epic.com ([fe80::89d9:a0e3:3740:4f53]) by
 EXCH-HUB-1.epic.com ([fe80::90c1:a07:c011:1fde%10]) with mapi id
 14.02.0342.003; Mon, 4 Mar 2013 12:15:37 -0600
Thread-Topic: "git commit" fails due to spurious file in index
Thread-Index: Ac4Y/ss6LRrQulaXQ/6loYEIwo4Ndw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.191.131]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217404>

Hello all:

This is my first time posting to this mailing list, but it appears to
me, through a Google search, that this is where you go to report what
might be bugs. I'm not sure if this is a bug or not, but it is
mysterious to me.

My git repository has this directory structure (I don't know if the fil=
e
names are necessary or not; only the leaf directories contain files):

    $ tree -ad -I.git
    .
    =84=80=80 admin_scripts
        =86=80=80 integchk
        =81=9A=9A =86=80=80 2012
        =81=9A=9A =84=80=80 2014
        =86=80=80 jrnadmin
        =81=9A=9A =86=80=80 2012
        =81=9A=9A =84=80=80 2014
        =84=80=80 logarchiver
         =9A=9A =86=80=80 2012
         =9A=9A =84=80=80 2014

    10 directories

The last commit in this repo was a rearrangement of the hierarchy
carried out using `git mv`.  Before, the directory structure went
`admin_scripts/version/script_name` instead of
`admin_scripts/script_name/version`.

Now I'm attempting to some new files that I've already created into the
repository, so that the repo now looks like this (`setup/2012`
contains files, while `setup/2014` is empty):

    $ tree -ad -I.git
    .
    =84=80=80 admin_scripts
        =86=80=80 integchk
        =81=9A=9A =86=80=80 2012
        =81=9A=9A =84=80=80 2014
        =86=80=80 jrnadmin
        =81=9A=9A =86=80=80 2012
        =81=9A=9A =84=80=80 2014
        =86=80=80 logarchiver
        =81=9A=9A =86=80=80 2012
        =81=9A=9A =84=80=80 2014
        =84=80=80 setup
            =86=80=80 2012
            =84=80=80 2014

    13 directories

Now, when I run 'git add admin_script/setup' to add the new directory t=
o
the repo and then try to commit, I receive the following message:

    $ git commit
    mv: cannot stat `admin_scripts/setup/2012/setup': No such file or d=
irectory

The error message is correct in that `admin_scripts/setup/2012/setup`
does not exist, either as a file or as a directory. However, I'm not
attempting to add this path at all. Using grep, I've confirmed that the
only place this path appears in any of my files is in `.git/index`.

Also, I can commit to other places in the repository without triggering
any error. In addition, I can clone the repository to other locations
and apply the problematic commit manually. This is how I've worked
around the problem for now, and I've moved the repository that's
exhibiting problems to another directory and started work on the cloned
copy.

Why is this spurious path appearing in the index? Is it a bug, or a
symptom that my repo has been somehow corrupted? Any help would be
greatly appreciated.

Robert Irelan | Server Systems | Epic | (608) 271-9000
