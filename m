From: Tobias Preuss <tobias.preuss@googlemail.com>
Subject: Bug report: Folder and files are deleted by git stash -u
Date: Thu, 5 Feb 2015 10:56:03 +0100
Message-ID: <CADEaiE8zSptYy9GTi4ZZ2bZptbretW6kDM4srmrSqaYeavfFhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 05 10:56:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJJAk-0008DF-Im
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 10:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757154AbbBEJ40 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2015 04:56:26 -0500
Received: from mail-wg0-f54.google.com ([74.125.82.54]:63425 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757140AbbBEJ4Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Feb 2015 04:56:24 -0500
Received: by mail-wg0-f54.google.com with SMTP id b13so6500905wgh.13
        for <git@vger.kernel.org>; Thu, 05 Feb 2015 01:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=QWLHEdy9YNb0klT8OvNjI34m0hIyTnJOiawm1vz6aIE=;
        b=ifm7wWr41LOx+Uz/ZqEqjjeLxRzFOc2hWAz4xrOLhPXJt8GGDkiX8HD9tsXVtRGUTg
         zMMoJ7VJ+d42zaEt7wjp2MmqtvR85ajuzYTvEvmmNPdwYOkU8Zox+2P9Ew+mSsZNORTy
         Dxp3dZde9UKV8cgU5c7UMOcxrHrjmcm8yqM5ukLekrZh2TnGLWrdpFzWc3eYUbUFSOwi
         UAwSPCkXGaAFL8PUzOk1YUI9yeJM9rxqLhyCKg/liANRaAb/KdMmhyoPZk4b7lpUqTOu
         gKGX4Zm4C7owPWIiJGm3jF0wp/bVm4+H2TKqmmeAsyX9tbpFGeNVHBL+tVSeLd4GAFA4
         vpUA==
X-Received: by 10.194.19.197 with SMTP id h5mr5536596wje.109.1423130183601;
 Thu, 05 Feb 2015 01:56:23 -0800 (PST)
Received: by 10.194.220.225 with HTTP; Thu, 5 Feb 2015 01:56:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263369>

Hello.

I noticed some bizarre behaviour when using: git stash -u.
It deletes folders which contain files configured to be ignored. I
actually lost files by this which I could not restore.

Here is how you can reproduce the case.

1. Create a project folder to act as the root of the repository. `cd`
into the directory
2. Create a folder `tracked-folder` with a file `tracked-file` in it.
Add some content to the file.
3. Create a folder `untracked-folder` with a file `untracked-file` in
it. Add some content to the file.
4. Create a file `to-be-stashed`, add some content to the file.
5. Create a `.gitignore` file with the following content: `untracked-fi=
le`.
6. Initialize the Git repository: `git init .`
7. Add all files to be tracked: `git add . & git commit`
8. List the current content of the repository: `tree`. It should show
the following:

=E2=94=9C=E2=94=80=E2=94=80 to-be-stashed
=E2=94=9C=E2=94=80=E2=94=80 tracked-folder
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 tracked-file
=E2=94=94=E2=94=80=E2=94=80 untracked-folder
    =E2=94=94=E2=94=80=E2=94=80 untracked-file

9. Run `git stash -u` and inspect the folder again:

=2E
=E2=94=94=E2=94=80=E2=94=80 tracked-folder
    =E2=94=94=E2=94=80=E2=94=80 tracked-file

10. Run `git stash pop` and inspect the folder once again:

=2E
=E2=94=9C=E2=94=80=E2=94=80 to-be-stashed
=E2=94=94=E2=94=80=E2=94=80 tracked-folder
    =E2=94=94=E2=94=80=E2=94=80 tracked-file

There you are - you just lost the whole folder.

Can you please confirm or deny if this is a bug? Thank you.
Best regards, Tobias
