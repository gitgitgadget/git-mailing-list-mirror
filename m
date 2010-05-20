From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Git, Mac OS X and German special characters
Date: Thu, 20 May 2010 11:50:16 -0400
Message-ID: <AANLkTil2N2xP1CWj0xxskOn-KCN1JMpJS8d3WpT5Mdg2@mail.gmail.com>
References: <4BF4E40B.30205@math.tu-dortmund.de>
	 <AANLkTimYgkv6q6fTXqNOCq1ZbodxgCZ18Fum_NryyiO8@mail.gmail.com>
	 <4BF4F7D7.60002@drmicha.warpmail.net> <4BF4FA89.2040904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	matthias.moeller@math.tu-dortmund.de, git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <totte.enea@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 20 17:50:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF80u-00008w-P8
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 17:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000Ab0ETPuU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 May 2010 11:50:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60659 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab0ETPuS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 May 2010 11:50:18 -0400
Received: by iwn6 with SMTP id 6so4437956iwn.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 08:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9I++8jZi39MS6w/iJP0e7LRkydV2OZlSO+DSXckbnnM=;
        b=eKd5GIQN06it0P6IQ6FgZz/TNlOc5gwRypWXEjUdBNtLJFyuTQ3JoGDc4FBjST10dn
         cdzacJiFJOLplNBJzw10CCRcEJ1NEXxT1vBS0R+FzWFJUBf7PmZufB55URjjPSiNqCCc
         7tHlAAy3wt8E9n39N8OTZB7OEOLo2pKEkxQac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Buvl4+I20apsCaI0w9uVU7xrIzKLaUUqaTgGRWJz+KxtIJ4HUMIqgfQYm8ChXk2Js8
         fdVhIR+dqIH79TmA7wJ4i0zrj7dipUIqMeMm6XbuMwoMs/S4XLZAeEXcHaHdxdg20HLf
         TIrmoziVYIlbE85Yn0G5ws2DpMx72c1Lq3B9U=
Received: by 10.231.183.19 with SMTP id ce19mr215789ibb.35.1274370616895; Thu, 
	20 May 2010 08:50:16 -0700 (PDT)
Received: by 10.231.34.8 with HTTP; Thu, 20 May 2010 08:50:16 -0700 (PDT)
In-Reply-To: <4BF4FA89.2040904@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147394>

2010/5/20 Torsten B=C3=B6gershausen <totte.enea@gmail.com>:
> Improved interwork between Mac OS X and linux when umlauts are used
> When a git repository containing utf-8 coded umlaut characters
> is cloned onto an Mac OS X machine, the Mac OS system will convert
> all filenames returned by readdir() into denormalized utf-8.
> As a result of this conversion, git will not find them on disk.
> This helps by treating the NFD and NFD version of filenames as
> identical on Mac OS.

So this is an edge case, but what happens if a repo has both the NFC
and NFD representation of a given name? It should be handled the same
way as if a repo has both "File" and "file" and you try to check-out
onto a case-insensitive filesystem.

Additionally, note this paragraph from 1102952 (Make git-add behave
more sensibly in a case-insensitive environment, 2008-03-22):

    However, if we actually have *both* a file called "File" and one ca=
lled
    "file", and they don't have the same lstat() information (ie we're =
on a
    case-sensitive filesystem but have the "core.ignorecase" flag set),=
 we
    will error out if we try to add them both.

To be consistent, shouldn't we have a core.HFSPlusCompat that can be
set on non-braindamaged filesystems to prevent filenames which would
alias on HFS+ from entering the repo?

   http://developer.apple.com/mac/library/technotes/tn/tn1150.html#Unic=
odeSubtleties

j.
