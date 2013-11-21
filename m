From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Can a git push over ssh trigger a gc/repack? Diagnosing pack explosion
Date: Thu, 21 Nov 2013 10:21:26 -0500
Message-ID: <CACPiFC+TqD_DhMaG+posoK4fTOLCoi=3jhJUPjt_72HTm9xjeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 21 16:21:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjW4l-0005vl-Ef
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 16:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314Ab3KUPVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 10:21:47 -0500
Received: from mail-vc0-f171.google.com ([209.85.220.171]:44086 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab3KUPVr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 10:21:47 -0500
Received: by mail-vc0-f171.google.com with SMTP id ik5so1524489vcb.16
        for <git@vger.kernel.org>; Thu, 21 Nov 2013 07:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=y8a5SncvxV4tTyiQ1B2kM6ciB7SjdGkIn1bFaY5eM4w=;
        b=jKBwLR9RfUU3+QCW8au2isYitBV4fDsFwehz/dC4VlD1ZwNdFNexnR4NIn9mtb4muZ
         N3GTYVnLu6K+rceJU5pLV2A50FvotJAvVZmAWiknwAqNnEWyW+/X9ERKH2ODu74yeVrY
         7RFizqtE587StzQ8TmR1W2JrRjKbAYrf5vngCXA4QvfwQEu40yhWefSVmnrZm/EuhziU
         dSr97Jwsc84kRdQYW4h8gHki84rDT8MFLyZ/wKx3ZzC8ssT6Z5zVVbIR6bRtO1S7bQ4E
         R8w49WErWFHxSMdGgSPJ62L5W1JPC1fcFkAByC1zBkR2V3Mxst6DL6X9jBVPDPg4SPYO
         bPyA==
X-Received: by 10.58.143.17 with SMTP id sa17mr6458555veb.14.1385047306263;
 Thu, 21 Nov 2013 07:21:46 -0800 (PST)
Received: by 10.221.61.210 with HTTP; Thu, 21 Nov 2013 07:21:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238125>

Hi git list,

I am trying to diagnose a strange problem in a VM running as a 'git
over ssh server', with one repo which periodically grows very quickly.

The complete dataset packs to a single pack+index of ~650MB. Growth is
slow, these are ASCII text reports that use a template -- highly
compressible. Reports come from a few dozen machines that log in every
hour.

However, something is happening that explodes the efficient pack into
an ungodly mess.

Do client pushes over git+ssh ever trigger a repack on the server? If
so, these repacking processes are racing with each other and taking
650MB to 7GB at which point we hit ENOSPC, sometimes pom killer joins
the party, etc.

pack dir looks like this, ordered by timestamp:
http://fpaste.org/55730/04636313/

cheers,



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
