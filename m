From: "Kees-Jan Dijkzeul" <k.j.dijkzeul@gmail.com>
Subject: gitk doesn't start due to cygwin wish not following symlinks?
Date: Tue, 3 Jul 2007 21:02:35 +0200
Message-ID: <fa0b6e200707031202g4a1248d8na22fbf99b215804@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 21:02:47 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5ne8-0005Hh-FS
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 21:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757371AbXGCTCi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 15:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757253AbXGCTCi
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 15:02:38 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:10380 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756837AbXGCTCh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 15:02:37 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1320642nze
        for <git@vger.kernel.org>; Tue, 03 Jul 2007 12:02:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iCts+r6FSsQhNOQYmWQBlrazsd0droZwOOCo5rEEJzlC+p7n+AWeldSXSqAbRNR1aNhjO7NWaUka1Pm+70LPmitESndJXwL5iPjCgTpNS2ADBwFLNSnqMOku1ApnLfwE5fi13ZTfnHUc1dgcFTITACnt1ZTsa68ci0MdcK1skjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hEd3egybqG2vCuBnl73llXW0VUwn0el3nFdwvsiaQ7jWdG4zY/EXiV6LxoX83mSv3mc/fbiu2+AiQnwXYH0gQJpLA5a46E6OMNa5+s4boNfoE5HIUy5Q8YgL6qrKKooYMSjjVRtIZ/B//eywV26LPMiV2rUfpJyh53JimyeRLiE=
Received: by 10.143.161.3 with SMTP id n3mr461134wfo.1183489355907;
        Tue, 03 Jul 2007 12:02:35 -0700 (PDT)
Received: by 10.143.5.9 with HTTP; Tue, 3 Jul 2007 12:02:35 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51524>

Hi,

I'm using "stow" to manage several versions of git on my cygwin
system. As a result, my /usr/local/bin contains a bunch of symlinks to
the actual binaries in /usr/local/stow/git-1.5.2.2/bin.

This works like a charm, except that gitk won't start up, claiming, in
turn, that it is unable to start git itself. After some investigation,
I found that the "wish" that is supplied with cygwin isn't a true
cygwin one, and hence doesn't understand cygwin style simlinks, and
thus cannot start the /usr/local/bin/git symlink. It needs the true
binary.

So for now, I've worked around this by updating the first few lines of
the gitk script to read:

   #!/bin/sh
   # Tcl ignores the next line -*- tcl -*- \
   export PATH=$PATH:/usr/local/stow/git-1.5.2.2/bin
   # Tcl ignores the next line also \
   exec wish "$0" -- "$@"

This works for me, but is admittedly butt-ugly. Any tips on how to
handle this kind of situation?

Thanks a lot!

Groetjes,

Kees-Jan
