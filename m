From: Doug Kelly <dougk.ff7@gmail.com>
Subject: Question: .idx without .pack causes performance issues?
Date: Tue, 21 Jul 2015 13:41:58 -0500
Message-ID: <CAEtYS8QWCg5_DtrJw-e+c50vcG0OpciR6LWon-3GgyngGn+0pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 20:42:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHcUQ-00041W-Fs
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 20:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933454AbbGUSmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 14:42:00 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36597 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933274AbbGUSl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 14:41:59 -0400
Received: by iehx8 with SMTP id x8so69579733ieh.3
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 11:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=UdjhqScIdZCsvoEQUQWiZidH7drN6Bx3+FkVFzccBhI=;
        b=EYC5yX/rR1dzqRslghbUCFa6oZlBjbKRvPrcbOHJ/6wCyGzXRg01jQHglDMspy7iGO
         wpI+U2YqFM1Zzl5Y/UbICvh7xD4vIQQXywGErlo4AvYp71wc8fcbT090rMEGtde1/UF7
         JCM2iKFfaxckOrR0vDRC8NcQoVG8UcS5CP2P5OdYKWdM5R6NZRxZPLMFMQbwBGTMiJGC
         vl1ifmYL++IsdcDQf6ckPbu959Xz9mjOyCHjMimv1BKTKV0FRO9ijrt7Z+W96teGXSCh
         2lMPOBNRjb7r/++PhP64XufgCgb64UjSLGFCfHh/Q+KQkH+OjU+w/t3JowuXRFPqvIJC
         oEhA==
X-Received: by 10.50.132.70 with SMTP id os6mr26555864igb.27.1437504118978;
 Tue, 21 Jul 2015 11:41:58 -0700 (PDT)
Received: by 10.50.12.166 with HTTP; Tue, 21 Jul 2015 11:41:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274393>

Hi all,

I just wanted to relay an issue we've seen before at my day job (and
it just recently cropped up again).  When moving users from Git for
Windows 1.8.3 to 1.9.5, we found a few users started having operations
take an excruciatingly long amount of time.  At some point, we traced
the issue to a number of .pack files had been deleted (possibly
garbage collected?) -- but their associated .idx files were still
present.  Upon removing the "orphaned" idx files, we found performance
returned to normal.  Otherwise, git fsck reported no issues with the
repositories.

Other users have noted that using git gc would sometimes correct the
issue for them, but not always.

Anyway, has anyone else experienced this performance degradation? I
have some feeling that it's an issue that may be exclusive to Windows
(or at least, only slow enough to matter on Windows), but I have no
proof, and I've never heard of an issue like this outside work. (One
idea that came to mind was even the .idx files were locked, and thus
not deleted.)  Something tells me deleting the orphaned .idx files
isn't the "nicest" solution, either.

Thanks!

--Doug

P.S. In addition to running the Git for Windows/msysgit builds, we
have a handful of users running Git Extensions as well, and also have
been seeing an increase in use of Visual Studio 2013 -- which of
course has libgit2 integrated. So, I think the chance that any one of
these might be using the repo or holding files open is very high.
