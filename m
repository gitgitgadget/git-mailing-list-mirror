From: Tamas Csabina <tcsabina@gmail.com>
Subject: slow process of post-receive script on a remote (samba) share
Date: Thu, 13 Jun 2013 11:18:32 +0200
Message-ID: <CAH+Cn14TLpR1KT+3GND2Zmb8tDmFBP7AWpyrT7nVeMFw6V7FGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 13 11:18:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un3fy-0006DU-Mp
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 11:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758341Ab3FMJSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 05:18:34 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:38117 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756073Ab3FMJSd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 05:18:33 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so6391252oah.24
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 02:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=J1kHtm2KLvingS5fv/PfFAGBqEbSrD84Js8cQBrE1hw=;
        b=MWq1h7EchRVupos1w8OMKa/Ec0xaW46Fc8Ias+UsQfDnrsFcNDn+/NUbKlPtdJM4YW
         bBhG7FAl3ipGLDhKTjbN5+0IVZMGixYZGbpkoWqYdNNVyhSHOcisPprV7Yrhe1EPvxFo
         0J8HM6JZln2xNn2oj2yrL4I8xO1JPp7FLEasIbWjkjwMHaMJXQO/Y5wCAAgZ9mlerc7z
         ocGrSXWlRscaACHabfVTZNLvNq7xyLszfs5BAA6USk/+KHRCNUEYMmcrg1LCVHkqErcL
         Js6j/tH0s15uGQdeErg+DM0Aowl/CapMdte1hs693zQvfHzkwQMr5t4lQA2m2HASSBvn
         QwEw==
X-Received: by 10.60.143.41 with SMTP id sb9mr10895820oeb.102.1371115112845;
 Thu, 13 Jun 2013 02:18:32 -0700 (PDT)
Received: by 10.76.110.71 with HTTP; Thu, 13 Jun 2013 02:18:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227708>

Dear list,

I am using Git bash from version 1.8.3.msysgit.0, on a Windows 7x64 PC.
I have an issue with executing git push if I have a post-receive
script configured.
The content of the script is not really important, as if I have a
script that contains only commented out lines (around 70 lines), my
git push command is delayed with around 5 seconds.


I`ve tested the script on another PC and it is working fine. No delay
at all. So there are some issues on my PC regarding how git processes
remote scripts.

I took a wireshark trace with 2 scenarios on my PC:

 1. just execute `cat <path_to_the_script>\post-receive` command in the git bash
 2. did a `real` git push

Results of the wireshark traces shows:

 1. Read AndX Request, FID: 0x228f, 1024 bytes at offset 0 (1024 bytes
at time, always)
 2. Read AndX Request, FID: 0x21c9, 1 byte at offset 0 (1 byte, always)

Conclusion:
git push command reads the post-receive script in 1 byte chunks, which
dramatically slows down the execution process.


If more information is required about my setup or configuration, I
will provided it happily, but I think this 1 byte read is the main
reason for the issue.

Has anyone seen something similar? Or have any clues what is going on?


Thanks,
tamas

ps: this is my 3rd (or 4th) attempt to post on the mailing list, using
a different email account this time. If any of the previous attempt
also arrived, then sorry for the double posts.
