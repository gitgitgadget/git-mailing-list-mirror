From: Mikael Magnusson <mikachu@gmail.com>
Subject: [PATCH] Make tig call the correct git config command
Date: Sun, 8 Feb 2009 08:46:55 +0100
Message-ID: <237967ef0902072346x4537f70dua37ba897fac99361@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sun Feb 08 08:54:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW4Ub-0008TQ-VY
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 08:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbZBHHq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 02:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbZBHHq6
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 02:46:58 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:33465 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbZBHHq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 02:46:57 -0500
Received: by ewy14 with SMTP id 14so2039644ewy.13
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 23:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=FpM5yQA0kmse/yq5moOdPdf4F0tyrWpCIZDc2KEixnU=;
        b=IYUhDH94uQ7pOL6+VcUK1ZzDDfWPgickSjw1LGvSM8D8ppTuKm2hVZ+Gty8dhE5bci
         hLmRo9SE9+H++N/t1O8bTHbEd8iNJlAxyJ6ntlw5HXhSNvlwPnljpttzl4Y/tFsN2tLk
         l5EcPf5GoFXrR+CiRctCxMuoViKoGdR95yRh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=coHs6GowF4RgZ39aL/r63ZPblLZjhq1edlY4gDkjVKWUDXKnyVP7Cey9WE2rUQ3GXM
         v3Mt3bzK1GzXyRf2g4i/0UhjJbNvYDYTZyvUBRp/fhT3LnwAamwSW3i9QuWPz6TbIRpE
         EgAhr0RuHyNbUxHynAzDX2hrBGvcv+jSsvQks=
Received: by 10.210.133.19 with SMTP id g19mr2842722ebd.52.1234079215649; Sat, 
	07 Feb 2009 23:46:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108926>

2009/2/7 Mikael Magnusson <mikachu@gmail.com>:
> 2009/2/5 Jonas Fonseca <fonseca@diku.dk>:
>> Hello,
>>
>> Here is a much needed update fixing multiple regressions from the
>> introduction of the IO API in 0.13. Among improvements is the much
>> requested ability to restore the position in the stage view when staging
>> diff hunks. Also noteworthy is the many optimizations of the screen
>> updating to make it work better across slow links. Finally, beware that
>> a handful of incompatibilities can cause problems.
>
> I'm having a problem with tig taking 2 seconds to start up, which
> seems to be related to the 'typo checking' feature of git. After
> figuring out how to stop strace from helpfully saying
> write(2, "WARNING: You called a Git program"..., 137) = 137
> I got this (with -s 100):
> [pid 29708] write(2, "WARNING: You called a Git program named 'git
> config', which does not exist.\nContinuing under the assu"..., 137) =
> 137
> [pid 29708] write(2, "in 2.0 seconds automatically...\n"..., 32) = 32
>
> The output however also contains lots of git config strings, which is
> confusing. Is tig running git config twice and failing one of the
> times? (Running git config from the cmdline works fine).

Turns out it was as simple as this:

diff --git a/configure.ac b/configure.ac
index b179389..bdea8de 100644
--- a/configure.ac
+++ b/configure.ac
@@ -28,7 +28,7 @@ AC_MSG_CHECKING([which config
 GIT_CONFIG="repo-config"
 git config --list >/dev/null && GIT_CONFIG="config"
 AC_MSG_RESULT([$GIT_CONFIG])
-AC_DEFINE_UNQUOTED(GIT_CONFIG,"$GIT_CONFIG",[git config subcommand])
+AC_DEFINE_UNQUOTED(GIT_CONFIG,"$GIT_CONFIG",[config subcommand])

 AC_CHECK_PROGS(ASCIIDOC, [asciidoc false])
 AC_CHECK_PROGS(XMLTO, [xmlto false])

-- 
Mikael Magnusson
