From: Daniel Finnie <dan@danfinnie.com>
Subject: git ls-files -X option is relative to repo root
Date: Fri, 13 Feb 2015 14:23:40 -0500
Message-ID: <CAG4vEKM-2sy0z3=YLS+rgH99w6ukdcNBode9CAh4C4t9eSa02A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 20:24:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMLqm-0004z2-Ey
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 20:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892AbbBMTYY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Feb 2015 14:24:24 -0500
Received: from mail-wi0-f170.google.com ([209.85.212.170]:44163 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbbBMTYX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Feb 2015 14:24:23 -0500
Received: by mail-wi0-f170.google.com with SMTP id hi2so14173971wib.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2015 11:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=gXp7XaS6Ow2ZTrsXEPvZnZW5xYK+GNzDtm/2wqjsNVk=;
        b=XKIl70BE9XxuB16hQhryzIEzBDWJu00lEYfONPBEUTL1lYcbiFZGqQgnUuVUCgphBF
         VofiY7NysQKBS3t6cGPXfJdaWLW2vPsT7ZytvwDUduTX5ryp7WifGE+wzXAMafhNaB9C
         vD/euXHo4O+nO9l6/bDlj7pZe6+9PWw2f6d1nvEWxjvjC2ujB7V206eQFuW9Wdgr8Odr
         GcTkoT4xNcQBGJZjLwZfdDK4B2c562WLJBzAD6w3aMlUWH9LZ/VSXy75ZSg2qMrxX1Kf
         sRT9pFt7BA8PUsm6mFLLvxKNk8KD7rcy9QYQRPg/K4nHAsgr+6JY9sZdu3pMGX7/iNek
         JNKA==
X-Gm-Message-State: ALoCoQmQpP/2NlF7U+2N24CMekZNMz3c8pBlgCSaQxufMw593vKxw4EDFctxkRfSvCEkH48uhnJf
X-Received: by 10.180.109.46 with SMTP id hp14mr18920862wib.50.1423855460983;
 Fri, 13 Feb 2015 11:24:20 -0800 (PST)
Received: by 10.216.191.19 with HTTP; Fri, 13 Feb 2015 11:23:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263822>

I encountered some unexpected behavior with Git today and was hoping
to either a) clear up my misconception or b) make a bug report.

My question deals with the --exclude-from option to git-ls-files.  It
appears that paths passed to this option are relative to the root of
the repository, not your current working directory.  I would have
expected the opposite, that the paths are relative to the working
directory.  I would expect to put a colon at the beginning of the path
to make it relative to the repository root.  Here's an example:

$ tree -a -I .git
=2E
=E2=94=9C=E2=94=80=E2=94=80 .gitignore
=E2=94=94=E2=94=80=E2=94=80 example_dir
    =E2=94=9C=E2=94=80=E2=94=80 .gitignore
    =E2=94=94=E2=94=80=E2=94=80 example_file

# (all of these files are checked in, including example_file which is
also in .gitignore)

$ cat .gitignore
# empty gitignore

$ cat example_dir/.gitignore
example_file

$ (cd example_dir && git ls-files --ignore --exclude-from=3D.gitignore)
# No output because this references the git ignore at the project
root, not example_dir.  I expected this to output "example_file".

$ (cd example_dir && git ls-files --ignore
--exclude-from=3Dexample_dir/.gitignore)
example_file # works for the reason above, but I expected this to
break because example_dir/example_dir/.gitignore is not a file

So, what do you think?  Am I missing a git/*nix convention explaining
options would be specified relative to the repository root?  Or is
this a git bug?

Thanks for your time,
Dan Finnie
