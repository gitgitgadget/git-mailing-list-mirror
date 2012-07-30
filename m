From: Mojca Miklavec <mojca.miklavec.lists@gmail.com>
Subject: inconsistent logs when displayed on screen / piped to a file
Date: Mon, 30 Jul 2012 14:25:42 +0200
Message-ID: <CALBOmsYh5AgpRQe28yUcChqemQ7HFMHahesGj_MPwQXDF-EM=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 14:25:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svp2l-0000lZ-Sc
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 14:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500Ab2G3MZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 08:25:43 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:60006 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab2G3MZm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 08:25:42 -0400
Received: by qcro28 with SMTP id o28so2845681qcr.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 05:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=rzEup6hN1QfVmfFf7gqq+Z0vGYViMK1LxCgZya0Ts3g=;
        b=Ra6RSFHsRHujajVpNy3AqQQxg+cJ89fZkC6GOoxRCy4g6UNDeMtlJJDPNMqyxilVDh
         089qgKrp5leQkuyY8BuVVAKjHNnZFoGJ0m8xk4KKh2Pt/zGguw1GsFHlQY9b28QkpxeX
         pAKB3dMer11Pd9tDiNEHqiWNX7O+wXzx8D3F9pyCcM9VuTi9uVOD6m0aPJ0+ei68oOoi
         EL61WxUFeviymO9O6JitomnmtrUNn0knDT6+64YMCLYX++qDU6zhMmiryzxJKGMl16Yr
         tU2ETxF8mjgD4PPAVQyiQNH+kI2velF9sVscu/n/tNxvhqKwmcPIpjhMca7hoktIQW7U
         17iw==
Received: by 10.224.203.197 with SMTP id fj5mr22571196qab.98.1343651142117;
 Mon, 30 Jul 2012 05:25:42 -0700 (PDT)
Received: by 10.229.242.131 with HTTP; Mon, 30 Jul 2012 05:25:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202536>

Hello,

I'm trying to use "git log" to generate ChangeLog for a project
recently migrated from CVS.

The problem is that
    git log --summary --stat --no-merges --date=short --decorate=short
behaves differently when the result is displayed on screen and when it
is piped to a file.

For example, running the commands:
    a) git log --summary --stat --no-merges --date=short
--decorate=short e9f65aa976
    b) git log --summary --stat --no-merges --date=short
--decorate=short e9f65aa976 > /tmp/log.txt
would result in two different outputs:

a)

 aquaterm/Docs/gptProtocol.rtf                         |  316
++++++++++++++++++++++++++
 aquaterm/English.lproj/GPTInfoWindow.nib/classes.nib  |   12 +
 aquaterm/English.lproj/GPTInfoWindow.nib/info.nib     |   12 +
 aquaterm/English.lproj/GPTInfoWindow.nib/objects.nib  |  Bin 0 -> 1010 bytes
 aquaterm/English.lproj/GPTInfoWindow~.nib/classes.nib |    4 +
 aquaterm/English.lproj/GPTInfoWindow~.nib/info.nib    |   12 +
 aquaterm/English.lproj/GPTInfoWindow~.nib/objects.nib |  Bin 0 -> 1232 bytes
 aquaterm/English.lproj/GPTWindow.nib/classes.nib      |   13 ++
 aquaterm/English.lproj/GPTWindow.nib/info.nib         |   12 +

b)

 aquaterm/Docs/gptProtocol.rtf                      |  316 ++++++
 .../English.lproj/GPTInfoWindow.nib/classes.nib    |   12 +
 aquaterm/English.lproj/GPTInfoWindow.nib/info.nib  |   12 +
 .../English.lproj/GPTInfoWindow.nib/objects.nib    |  Bin 0 -> 1010 bytes
 .../English.lproj/GPTInfoWindow~.nib/classes.nib   |    4 +
 aquaterm/English.lproj/GPTInfoWindow~.nib/info.nib |   12 +
 .../English.lproj/GPTInfoWindow~.nib/objects.nib   |  Bin 0 -> 1232 bytes
 aquaterm/English.lproj/GPTWindow.nib/classes.nib   |   13 +
 aquaterm/English.lproj/GPTWindow.nib/info.nib      |   12 +


The project where the results could be easily reproduced is the following:
    https://github.com/AquaTerm/AquaTerm
    git://github.com/AquaTerm/AquaTerm.git

It is possible that I screwed up something when importing the project
from CVS. In that case I would be happy if someone could point me out
what exactly I did wrong, and I can still rewrite the history before
the first release of the project using git.

But in any case I find it weird that I get two different outputs.

I would be grateful for any clues or hints about what goes wrong.

Mojca
