From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: git-diff/git-diff-files: Turn off copy-detection?
Date: Tue, 29 Sep 2009 14:50:14 +0200
Message-ID: <4AC20286.6020108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 29 14:50:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MscA6-0007ID-Ga
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 14:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbZI2MuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 08:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754083AbZI2MuY
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 08:50:24 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:50147 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041AbZI2MuX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 08:50:23 -0400
Received: by ewy7 with SMTP id 7so5367473ewy.17
        for <git@vger.kernel.org>; Tue, 29 Sep 2009 05:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=SB/cVfh8GZB9OVgkDSCLIPK1PLa3ufaQ15P2Qr1hQxs=;
        b=BFG16l1hG7zTJemO5KiNPDooYXIhOD/0hc+NLIutnpG2574UkvPZfsImw/X6mcew2h
         yyUIJ2gOBsaSW5aYO4IYopv/4Ac9K/UYmHqHXS7C7FeY9o5F8B3Jx/dMX67RFvuh55Wh
         wFwLBG+2dOMzm8FcsNNMVFFilVNGMNONZXuj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=dIm2ht+qVAFl9tOO6w8HNJFuLXWqA4w4jX5ckqYC7C8BZ9L9Z0qaypP1ASo503IAYM
         wvD7n/8LxGR+oZp1wu+Pg428fNEesexHnBkgYHwFB6QjcnrUAnHml+TD0TQ4Twdh3Wxa
         tpUBQEMefhFNoyEd4pKva+t53fbcndOzolpEs=
Received: by 10.211.173.11 with SMTP id a11mr5159526ebp.42.1254228624657;
        Tue, 29 Sep 2009 05:50:24 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 5sm144eyh.24.2009.09.29.05.50.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Sep 2009 05:50:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129298>

Hi,

I'm trying to diff the header files between two version of a repo, to 
do an ABI review, but get too many diffs from 'similar copy', which 
makes the review hard. These are generally unrelated files, but due to 
large copyright header, and spaces, the actual changes are not large 
enough to be detected as new files. I'd therefore like to turn off 
copy detection completely, or at least set some kind of threshold 
before a file is considered a copy in the diff.

Doing a 'git diff origin/4.5..origin/4.6 -- src/corelib' gives me this 
excerpt:

diff --git origin/4.5/src/corelib/tools/qtimeline.h 
origin/4.6/src/corelib/animation/qabstractanimation.h
similarity index 58%
...
diff --git origin/4.5/src/corelib/kernel/qsystemsemaphore.h 
origin/4.6/src/corelib/animation/qanimationgroup.h
similarity index 63%
...
diff --git origin/4.5/src/corelib/kernel/qsystemsemaphore.h 
origin/4.6/src/corelib/animation/qparallelanimationgroup.h
similarity index 63%
...
diff --git origin/4.5/src/corelib/io/qresource_iterator_p.h 
origin/4.6/src/corelib/animation/qpauseanimation.h
similarity index 68%
...
diff --git origin/4.5/src/corelib/kernel/qsystemsemaphore.h 
origin/4.6/src/corelib/animation/qpropertyanimation.h
similarity index 60%
...
diff --git origin/4.5/src/corelib/kernel/qsystemsemaphore.h 
origin/4.6/src/corelib/animation/qsequentialanimationgroup.h
similarity index 55%
...
diff --git origin/4.5/src/corelib/animation/qvariantanimation.h 
origin/4.6/src/corelib/animation/qvariantanimation.h
new file mode 100644
...
diff --git origin/4.5/src/corelib/arch/qatomic_arch.h 
origin/4.6/src/corelib/arch/qatomic_arch.h
index 52ab101..548a5e9 100644

So, not even related. They should really had shown up as new files, 
IMO. (I guess git stores the creation of the file as a delta of the 
indicated 'copy', but in this case I don't care about that :)

Thanks!

--
.marius
