From: =?ISO-8859-1?Q?S=E9bastien_Barth=E9lemy?= <barthelemy@crans.org>
Subject: rebase converts merge commits
Date: Tue, 12 Oct 2010 16:55:48 +0200
Message-ID: <AANLkTikz0yUv9+EcT-kVwniUf9xnRe=_y96euNb=stzP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 12 16:58:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5gIz-00046V-BE
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 16:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757335Ab0JLOzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 10:55:50 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55596 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265Ab0JLOzu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 10:55:50 -0400
Received: by gwj17 with SMTP id 17so1440341gwj.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 07:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=irkgs3z3z4aUneCnipjmvyfCijc1jF0EJusaI6eDE8s=;
        b=XcnyW2OSsx26qZpNWOIapLdwP8pa/JsIsAvlpFKdFd0OYc56S3Zx/8Voar744Dv+zc
         O6oad2o68SNt9eoIzLOuRM0cSUxqaPNjCQdUGMxUfzs3WmKrk0Mz/0aQJPaFL3E7NPra
         gGWNkOmgPzZhB9Gh6n4Da9MxogAtD1nMhl+DY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=qVHQcivRHfaJYtQMqTdXf4gg7nbH0P+EHsACGLHymbeX7GfBbhwXEwxhHHB+Qf5YnV
         6UnjuZMZwv8zOQ88ypom6oOz4zGM/bnxh97QnDTqDkDPifiZBy76gRb95AkhH8VUORk+
         pkq99K5AgOnJBFysoqH2dPSCvd+tx15UO4pxY=
Received: by 10.42.12.138 with SMTP id y10mr2737358icy.128.1286895348879; Tue,
 12 Oct 2010 07:55:48 -0700 (PDT)
Received: by 10.231.168.8 with HTTP; Tue, 12 Oct 2010 07:55:48 -0700 (PDT)
X-Google-Sender-Auth: csftirwjXY3iAWdXU1VG5CjxTXk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158852>

Hello,

first of all, thank you for git this is a wonderful tool.

Yet, I have a problem while trying to rebase a bit of history which contains
merge commits.

I'm not sure whether I misuse something or whether this is a know (but
not documented?) limitation.

Here is more context.

I have the following history

* commit e1adb4bcd07372024689c697c56249ca6c044009
|
|     fixed  maintainer field
|
* commit 6aca4f53e8b7647df96dcd2caacde5883f9c67c5
|
|     updated changelog for release 2.9.9-0ubuntu1
|
* commit 96d69d992afae69a8caba07ab9b5b6e5ed7d35d8
|
|     updated lintian warning override
|
*   commit 53171e21222b6a7fcb25620b1c30e427b9ada6a6
|\  Merge: 2d58bfe 4f3385d
| |
| |     merged release 2.9.9
| |
| * commit 4f3385dd9cf129cb0d65c9fb3895fe61a03b8b59
| |
| |     upstream 2.9.9 (developer) release
| |
* | commit 2d58bfed1cc234b5a76bde8216298a72db29aacc
| |
| |     updated maintainer field
| |
* | commit 05b4de27b993dde0cc779364fa24223f29e66b0e
| |
| |     changelog for 2.9.8-0ubuntu5
| |
...


commit 2d58bfe introduced a trivial error that got fixed in commit e1adb4b.

I would like to manipulate the history to get these two commits subsequent
(or even merge them). Eventually I'd like to get this history

* commit 6aca4f53e8b7647df96dcd2caacde5883f9c67c5'
|
|     updated changelog for release 2.9.9-0ubuntu1
|
* commit 96d69d992afae69a8caba07ab9b5b6e5ed7d35d8'
|
|     updated lintian warning override
|
*   commit 53171e21222b6a7fcb25620b1c30e427b9ada6a6'
|\  Merge: e1adb4' 4f3385d
| |
| |     merged release 2.9.9
| |
| * commit 4f3385dd9cf129cb0d65c9fb3895fe61a03b8b59
| |
| |     upstream 2.9.9 (developer) release
| |
* | commit e1adb4bcd07372024689c697c56249ca6c044009'
| |
| |     fixed  maintainer field
| |
* | commit 2d58bfed1cc234b5a76bde8216298a72db29aacc
| |
| |     updated maintainer field
| |
* | commit 05b4de27b993dde0cc779364fa24223f29e66b0e
| |
| |     changelog for 2.9.8-0ubuntu5
| |
...

I tried with rebase -i, but it converts the merge commit into a normal commit.
Moreover, it asks me to resolve the merge conflict again.

I think this is a limitation of rebase, but I haven't read it stated anywhere,
so here I am, asking for a confirmation.

By the way, if there is a way to do what I want, please tell me.

I'm using git version 1.7.0.4.

Cheers

-- 
Sebastian
