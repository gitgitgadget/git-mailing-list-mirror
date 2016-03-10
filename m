From: Marcus Kida <marcus.kida@gmail.com>
Subject: Bug: git branch -D can be used to delete branch which is currently checked out
Date: Thu, 10 Mar 2016 19:20:21 +1100
Message-ID: <CE5AE06C-0909-414E-B901-7CCF3A259465@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 09:20:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1advpf-0005pC-Jk
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 09:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbcCJIU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 03:20:27 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34789 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbcCJIU0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2016 03:20:26 -0500
Received: by mail-pf0-f177.google.com with SMTP id 129so63233436pfw.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 00:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=98SKOAVxQRnmuiwVxIKTurpaKzzgh3hV2kfXhgCwD5I=;
        b=nx1i3QukxjOQhilpfb1Y/F5nr6phuAV04yUG79qFXcQ5wzgDVJpDqN1vOU99BnQLAW
         7i79UB0nM2jBF8ObNC3y1sFg5gBH/59qio2UZgSpUit5PMDxpU8pkTZeiRht5T6AgDcN
         6t9QC21n6xwKkuAlWLjQVKrNIXTlstvNIV4Ml3IXG+Tbww7YpbYZTLbegVDshRXMohMd
         8TiO7GnGP5UMEh9bOhUcQ2/tIdiSD2+oyg/XUbMyfrUvBO4HmDi7hXAkPb1lvd8xOYug
         615kXqdpl7u2bi7TnTmhZf3FePw9GhQZ4p/tGxNrhxqoS57cZ27Hhtwfk8kbVH/kQ2X0
         Qvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=98SKOAVxQRnmuiwVxIKTurpaKzzgh3hV2kfXhgCwD5I=;
        b=ErvSePlkWRyo6X7M+NA3KS9FzbxUf+ZYwpy75iY6GkqaRTyQcaFUi5ecgUAsyhkT9f
         /sWBL+TzNhUyN1GcdGkvCPGTFUKxWMczWjiz404BsJH6MNXjR0khQQ9D0rgKPjXAW95/
         0XdjIdKjoMGNX79LrTP5kwmnAr9ALQ263cOqNWMGUBQPJ71ve3Ra9NTO8Ra9ioMRDEAP
         mw49jdjsbXEq1apLwPXdJJWXKdkABf4jFD4cQROONi4YL1PNeeBNl/fZDOVkDLawId82
         Iu8rV7dJt+3G3p4w5NCQnWA4pGM59FJNtjybgPGO3XQk+uMTUnYwwpSAL8Sg4Xl6FUFZ
         M4ww==
X-Gm-Message-State: AD7BkJIIXtOPOY5GPX/3tz1dA/qogygAK0sWldJJghY1ci5XJLfqP3cAnjvvVsUwtIkGrw==
X-Received: by 10.98.93.12 with SMTP id r12mr3185294pfb.64.1457598025663;
        Thu, 10 Mar 2016 00:20:25 -0800 (PST)
Received: from [192.168.0.7] ([49.191.133.138])
        by smtp.gmail.com with ESMTPSA id 23sm3462760pfs.34.2016.03.10.00.20.23
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Mar 2016 00:20:25 -0800 (PST)
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288600>

Testes on: 

Mac OS X 10.11.3 (El Capitan) using Git 2.6.4

Issue:

git branch -D can be used to delete branch which is currently checked out

Steps to reproduce:

inside a git repository:

$ git checkout -b feature/myAwesomeFeature

-> you end up in feature/myAwesomeFeature branch

$ git checkout FEATURE/myAwesomeFeature

-> you end up in FEATURE/myAwesomeFeature branch

$ git branch -D feature/myAwesomeFeature branch

-> BOOM you just deleted the branch you were at. Congrats you repo is dirty again.

Actual behaviour:

It seems like checking out / deleting branches is case insensitive thus you can delete a branch you are on by just using a different capitalisation when specifying the branch to delete.

Expected behaviour:

error: Cannot delete the branch 'FEATURE/myAwesomeFeature' which you are currently on.

Thank you, please don't hesitate to contact me in case you need more info or if this has already been fixed in the meantime.

Cheers,
Marcus