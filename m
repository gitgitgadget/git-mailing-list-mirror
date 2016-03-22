From: "Boettger, Heiko" <Heiko.Boettger@karlstorz.com>
Subject: git and concurrent access to local repository
Date: Tue, 22 Mar 2016 08:00:13 +0000
Message-ID: <8C0042D8869AEA4AA334B49AFBBCEF82B53CF505@TUT-EX02-PV.KSTG.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 22 09:00:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiHEk-0007aT-1q
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 09:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756085AbcCVIAS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2016 04:00:18 -0400
Received: from mx0.karlstorz.com ([62.134.46.134]:49657 "EHLO
	mx0.karlstorz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755935AbcCVIAQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2016 04:00:16 -0400
X-IronPort-AV: E=Sophos;i="5.24,376,1454972400"; 
   d="scan'208";a="24444902"
Received: from tut-ex03-pv.kstg.corp ([10.0.10.233])
  by mx0.karlstorz.com with ESMTP; 22 Mar 2016 09:00:14 +0100
Received: from TUT-EX02-PV.KSTG.corp ([169.254.2.132]) by
 TUT-EX03-PV.KSTG.corp ([10.0.10.233]) with mapi id 14.03.0266.001; Tue, 22
 Mar 2016 09:00:14 +0100
Thread-Topic: git and concurrent access to local repository
Thread-Index: AdGEEMCWaucNZLm3Qs67LnHJXT7YGA==
Accept-Language: de-CH, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.3.60.52]
x-kse-serverinfo: TUT-EX03-PV.KSTG.corp, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 3/22/2016 5:55:00 AM
x-kse-attachment-filter-scan-result: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289492>

Hi,

I always thought git allows concurrent access to a repository and expec=
ted that this also is true when working with local repositories. The on=
ly problem I was aware of is that the use of NFS and windows shares mig=
ht cause problems. However I sometime see the following error messages =
in our concurrent build process.

message 1:

=46etching origin
error: cannot lock ref 'refs/remotes/origin/branchname =A0Unable to cre=
ate '/home/workingcopy/.git/refs/remotes/origin/ branchname.lock': File=
 exists.

If no other git process is currently running, this probably means a
git process crashed in this repository earlier. Make sure no other git
process is running and remove the file manually to continue.
=46rom servername:gitrepo
! ccea072...349809e branchname =A0-> origin/branchname =A0(unable to up=
date local ref)
error: Could not fetch origin

message 2:

error: cannot lock ref 'refs/remotes/origin/master': ref refs/remotes/o=
rigin/master is at 07cd4a461229f9352d16063ff209e828cba592ea but expecte=
d 7c4ddcf998bad94f4f7e8e806baaa475f2069e60

message 3 (on git pull --rebase):

Cannot rebase onto multiple branches

Does that mean there is an issue inside git's locking or is concurrent =
access to the same workingcopy not supported =A0at all? I expected the =
commands would blocking until they can acquire the lock, but It seems l=
ike there are other command which are either aborting or not locking at=
 all (git pull -reabase). I think git pull --rebase is just a chain of =
other git commands where the lock is done on the individual steps.

Am I doing something wrong or is it concurrent access just not support =
this way? Does that mean I have to use my own locks such as putting flo=
ck around each call?

Best Regards
Heiko B=F6ttger
