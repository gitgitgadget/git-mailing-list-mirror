From: "Tobi Stadelmaier" <tobi@stadeltobi.de>
Subject: Problem with git push on (somewhat) large binaries
Date: Sat, 3 Apr 2010 13:02:26 +0200
Message-ID: <005a01cad31d$25df8b80$719ea280$@de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 03 13:01:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ny16t-0003PZ-6H
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 13:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719Ab0DCLBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 07:01:35 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:52775 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab0DCLBd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 07:01:33 -0400
Received: from glauber (f054126202.adsl.alicedsl.de [78.54.126.202])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MgJWc-1O9euL0oVC-00NTX0; Sat, 03 Apr 2010 13:01:31 +0200
References: 
In-Reply-To: 
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AcrTHFRm2Is++oUpQPuO8T6gVKHVtQAAMRdg
Content-Language: de
x-cr-hashedpuzzle: Mtw= RgQ= Amr5 C3Be DgKL D73Q D9cr Gico GntS G4Co G/1B HLWt ICsq IYWY IzYr I2p6;1;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA=;Sosha1_v1;7;{F30DED36-EB9D-4074-BCB2-FBFBFC77479D};dABvAGIAaQBAAHMAdABhAGQAZQBsAHQAbwBiAGkALgBkAGUA;Sat, 03 Apr 2010 11:02:24 GMT;UAByAG8AYgBsAGUAbQAgAHcAaQB0AGgAIABnAGkAdAAgAHAAdQBzAGgAIABvAG4AIAAoAHMAbwBtAGUAdwBoAGEAdAApACAAbABhAHIAZwBlACAAYgBpAG4AYQByAGkAZQBzAA==
x-cr-puzzleid: {F30DED36-EB9D-4074-BCB2-FBFBFC77479D}
X-Provags-ID: V01U2FsdGVkX19+/XiRmPuBdPVMe8GIa48bc3LDA6Vx83XMFIv
 FHDFIBZps3H/FKkpS5eX4FLMG4+/FGubBXsVsKZdol3gJ5LC41
 vMtte+IQJswBMATLnU+0IsYIMX8fRGu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143887>

Hi,

I recently encountered a problem while pushing to a remote repository using
ssh
- this usually works fine (and did for the last ~500 or so commits with no
problem), and I was able to pin it down to one commit where somebody added a
bunch of somewhat large (but not *huge*) binaries - about 30 MBs of JPGs,
MOVs
and others overall in that commit.

What I see when I want to push out this branch is the expected:

Pushing to <xxx>
Counting objects: 172, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (72/72), done


..then gits starts to write objects, and gets to object 51 of 172. Then, all
of
a sudden, it gets progressively slower (Kib/s indicator drops from 600K/s to
200, then to 50, and further down) and then after a while it does nothing at
all
any more. Eventually, I get

Write failed: Connection reset by peer
error: pack-objects died of signal 13MiB | 47 KiB/s
error: pack-objects died with strange error
error: failed to push some refs to '<xxx>'


Everything works when I rebase that branch so that I drop that one commit
that
adds the binaries, and then push out the result.

Upgrading the server from git 1.6.1 to 1.7.0.4 didn't help. I first expected
a
cygwin problem (yeah, some of us are on Windows unfortunately), but I tried
it
with a fresh clone on Kubuntu Edgy with git 1.6.3 - same problem. I also
tried
-delta on the binary files in question with .gitattributes as suggested
somwhere, no luck.

SCPing my local repository to the server and then pushing "over the file
system"
there works, though.

Any ideas?

Thanks
Tobi
