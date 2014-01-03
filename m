From: Matt Burke <spraints@gmail.com>
Subject: Re: Bug report: stash in upstream caused remote fetch to fail
Date: Fri, 3 Jan 2014 16:12:51 -0500
Message-ID: <CAECVvXYD69Xrp85bVJg6XogvctUTwrFDae+3tawFgoCAUGhwGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 03 22:13:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzC3Q-0004mj-L7
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 22:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbaACVMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 16:12:53 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:48083 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbaACVMw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 16:12:52 -0500
Received: by mail-lb0-f181.google.com with SMTP id q8so8362276lbi.40
        for <git@vger.kernel.org>; Fri, 03 Jan 2014 13:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=7jbq5PV2ocoj0QbAZIDCjZCpWGRMGCvN9lJPgp7GdXo=;
        b=OqhBKlmBSkgg+eopxcpU0JZNnYdRjYUrAqQNB6EKTpFLncn4pjh4WVPvCe8Uo7ZCKY
         /Djo00fiUbH7ZOMeVh/oYwZFsj0OrG1lp1iueNWVvKlZjYaoalpFDM7oD0wape4Y3mlV
         C5nmxPFaEbYHOc6ceDlBuljtJ5nZIKRI31Cc6ZlXdkrvv5KYIlZisROUYmOhKVYny2xM
         ATDsF4o2+aURkTcChyWgoScwObBg+P53V9KVS7hDzk4rAS97/nVODXDbwYqwoAZtbT/B
         QzTCHsCFXa/Pg27RbwS7SM8RzuLMJbCyyMt/5Z8X63iCTLK7E14kabaQYCcCOnf1N4Ax
         Wqqg==
X-Received: by 10.152.120.102 with SMTP id lb6mr22279867lab.37.1388783571283;
 Fri, 03 Jan 2014 13:12:51 -0800 (PST)
Received: by 10.114.181.164 with HTTP; Fri, 3 Jan 2014 13:12:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239938>

I ran into the same (or similar) problem as reported in
<http://www.spinics.net/lists/git/msg173391.html>. I have a script
that, among other things, clones a git repository. Here's where it
does that:

+ git init -q
+ git fetch -q -fu ../../../other '+refs/*:refs/*'
fatal: bad object 9b985fbe6a2b783c16756077a8be261c94b6c197
error: ../../../other did not send all necessary objects

In ../../../other:

$ git rev-parse stash@{0}
9b985fbe6a2b783c16756077a8be261c94b6c197
$ grep stash .git/packed-refs
9b985fbe6a2b783c16756077a8be261c94b6c197 refs/stash
$ cat .git/refs/stash
9b985fbe6a2b783c16756077a8be261c94b6c197

I removed the line from packed-refs and removed the refs/stash file,
and the problem went away. Restoring packed-refs or refs/stash makes
the error occur again.

When this was reported before, Thomas Rast wrote:

> Do you, by any chance, still have a copy of the upstream repo before you
> trashed the stash?  It would be interesting to know whether there was
> actually some repository corruption going on (that went unnoticed by
> fsck, no less) or if there was a bug in the transmission.

I've still got the repository, and am happy to help debug this.

--
Matt
