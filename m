From: Assen Totin <assen.totin@gmail.com>
Subject: Gitignore file exceptions are not applied to untarcked files
Date: Fri, 29 Jan 2016 17:25:13 +0200
Message-ID: <CAMrYpX5n1LHBnr+bMhV=8Eu1K2npKctVZrHxJcStBhSVC70OBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 16:26:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPAvK-0005Ne-1J
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 16:25:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbcA2PZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 10:25:15 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:36757 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254AbcA2PZO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 10:25:14 -0500
Received: by mail-io0-f180.google.com with SMTP id g73so93466548ioe.3
        for <git@vger.kernel.org>; Fri, 29 Jan 2016 07:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=tPYCerFxKKNm69LOdRTHt6xRlkl6xffVMFzuOnBcvbE=;
        b=QzWGUzCPqcdKAD7aiMfPJs2fVARYZutopehkDHsJPER7NlgDoUbZUAfd/viXHouIWE
         HcojJBjy0s9SOtzwHvdpLjpfdjt/pMMh4K9o04L5eDtYkVDHXEJ6ikoBs5+XGkChfu7l
         SarQeykpLSy4k2Kl2CjGmJaXc8cxaSdqJ5ivf5UjRgjje9DUTKaDwTV1FEWTJamCcZGf
         ZUElP7diyK6Xckdjsn5oYLA05f4MJCH+MIWatAW9tZRYR2bWZTPw/uc/f4Tbl8tbv/5Z
         kjMlwPa085bMG9lonMp5/BBL8gWuh3o8jcD9I5QzLq20/dpo6nFnArSLOujXIUJRjwtz
         D+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=tPYCerFxKKNm69LOdRTHt6xRlkl6xffVMFzuOnBcvbE=;
        b=BH8CzGmokPxeUPLMesGMXHgzhRkpT3PEkHupKqvwylMT7HTSAykffg5mKYeYMBNQLX
         CAjRrmDOAPXGILwlAZqji55shfQHzfb7iWsHpuEdbRyaxU/rexxIDA4tlQkxXo9ZH172
         wYJqYmCdER5l6MbLmqhlN5GMCKIkG2hbCeioSDMPXDln8DIDa0bYQd8tEzx7Hp+FrJAa
         bgsGDhOVVUOE74LwVtdlCs3RaHa4NfWW11SkCO6qxKfwNGIR4itNVn6wnUXRC9/3naLg
         me5giMFDumGPd0GIbFTHrnGQSWg7tevIbJ+XELNxupxsXQoz7SLSUinvcse6yNY9tObl
         ByVw==
X-Gm-Message-State: AG10YOSfjSwk1uQZXUiWWLPVDgrUVq9NtR+AJLpli3BMy8MMDI8eqI1NZncr4fbpyVeE5H661dWVzjEPzv26nQ==
X-Received: by 10.107.136.208 with SMTP id s77mr10416779ioi.142.1454081114016;
 Fri, 29 Jan 2016 07:25:14 -0800 (PST)
Received: by 10.107.131.210 with HTTP; Fri, 29 Jan 2016 07:25:13 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285078>

Hi,

I'm not sure if the described issue is a bug or a feature; if it is the
latter, please, excuse the report.

I'm dealing with git 1.7.12.4. If this has been addressed in the later
issue, please, point me so.

The problem: I have a directory tree with lots of files and dirs, of which
I only track certain files in subdirs of a specific subdir. It goes like
this:

/untracted_file1
/untracked_file2
/untracked_dir1/...
/untracked_dir2/...
/tracked_dir/subdir1/config
/tracked_dir/subdir1/another_untracked_file
/tracked_dir/subdir2/config
/tracked_dir/subdir2/another_untracked_file

I'm only interested in /tracked_dir/.../config files. My .gitignore is as
follows:

# Ignore everything first
*
# Do not ignore tracked files
!/tracked_dir/*/config
# Don't ignore .gitignore
!.gitignore

This works fine until a new directory with a config file is created inside
/tracked_dir:

/tracked_dir/new_subdir/config

This config file is not seen by git at all (git status returns no changes
to add), although it matches the exclusion pattern.

While I can use various workarounds, I'm interested whether this actual
phenomenon occurs - why does the exclusion pattern not match an untracked
file in untracked directory? Is it because the exclusion pattern is never
applied to untracked files? Or is it because the directory new_subdir is
itself untracked?

WWell,

Assen Totin
