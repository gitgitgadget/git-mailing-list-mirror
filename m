From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Sat, 14 Apr 2012 21:33:37 -0500
Message-ID: <4F8A3381.803@gmail.com>
References: <20120330203430.GB20376@sigill.intra.peff.net> <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com> <4F76E430.6020605@gmail.com> <4F772E48.3030708@gmail.com> <20120402210708.GA28926@sigill.intra.peff.net> <4F84DD60.20903@gmail.com> <20120411213522.GA28199@sigill.intra.peff.net> <4F872D24.8010609@gmail.com> <20120412210315.GC21018@sigill.intra.peff.net> <4F8A2EBD.1070407@gmail.com> <20120415021550.GA24102@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Bo Chen <chen@chenirvine.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 15 04:34:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJFI7-0006f7-0o
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 04:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756739Ab2DOCdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 22:33:40 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59621 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756725Ab2DOCdj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 22:33:39 -0400
Received: by obbta14 with SMTP id ta14so2205471obb.19
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 19:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=DJbNIV2sRJ9/zu/3LE3el0Vb640Vp/vf6xqoNKPhM/c=;
        b=zGxrziGZo5XuS/600pvByl4ArPyJSfDXxSA7CxPjVK88shdfdNMa8ydnoc/YO8Td6T
         maWaTHo8SdfvA9Y9EhSqgHwDGyZR2CsMRHM/pcgfUxb1eX2ZxAbuK9SB4Of7MYj2x9gC
         5Kz1378J9GIUGEvqvWzSEj+sF/jkucXUPsiMLns5lNADiKYP0sw0XVIYvI5yBBdgcHeq
         m3Q3jiIevL7Xj70KUBCf1zxUOuz6UMVCdhXEMTgGuyI7tIJ1QH3pb4PV/dgum1zxh6Ze
         b0JcxeXOFHQye/8SRyQUPLVY0kGN49bAexv/3aqb2bk4GUjs9umkuRsmenj4CCx0mxbl
         Rhsg==
Received: by 10.60.13.196 with SMTP id j4mr9591214oec.14.1334457218846;
        Sat, 14 Apr 2012 19:33:38 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id h2sm15112959obn.20.2012.04.14.19.33.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 Apr 2012 19:33:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <20120415021550.GA24102@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195543>

On 4/14/2012 9:15 PM, Jeff King wrote:
> On Sat, Apr 14, 2012 at 09:13:17PM -0500, Neal Kreitzinger wrote:
>
>> Does a file's delta-compression efficiency in the pack-file directly
>> correlate to its efficiency of transmission size/bandwidth in a
>> git-fetch and git-push?  IOW, are big-files also a problem for
>> git-fetch and git-push by taking too long in a remote transfer?
> Yes. The on-the-wire format is a packfile. We create a new packfile on
> the fly, so we may find new deltas (e.g., between objects that were
> stored on disk in two different packs), but we will mostly be reusing
> deltas from the existing packs.
>
> So any time you improve the on-disk representation, you are also
> improving the network bandwidth utilization.
>
We use git to transfer database files from the dev server to 
qa-servers.  Sometimes these barf for some reason and I get called to 
remediate.  I assumed the user closed their session prematurely because 
it was "taking too long".  However, now I'm wondering if the git-pull 
--ff-only is dying on its own due to the big-files.  It could be that on 
a qa-server that hasn't updated database files in awhile they are 
pulling way more than another qa-server that does their git-pull more 
requently.  How would I go about troubleshooting this?  Is there some 
log files I would look at?  (I'm using git 1.7.1 compiled with git 
makefile on rhel6.)  When I go to remediate do git-reset --hard to clear 
out the barfed worktree/index and then run git-pull --ff-only manually 
and it always works.  I'm not sure if that proves it wasn't git that 
barfed the first time.  Maybe the first time git brought some stuff over 
and barfed because it bit off more than it could chew, but the second 
time its really having to chew less food because it already chewed some 
of it the first time and therefore works the second time.

v/r,
neal
