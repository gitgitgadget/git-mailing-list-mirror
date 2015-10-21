From: =?UTF-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
Subject: git ls-files should not show worktree files as untracked
Date: Wed, 21 Oct 2015 12:58:17 +0800
Message-ID: <CAHtLG6SDrk9Kw2edTVhY2M_8-O09_=VbZhsJYeQXY7No660VDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 07:00:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZolVJ-00009q-Ru
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 07:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183AbbJUE6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 00:58:42 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35275 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbbJUE6S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 00:58:18 -0400
Received: by vkfw189 with SMTP id w189so22695959vkf.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 21:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=28yedpijy/FqGdUnJy/W5AxXjd3xz4qVE6+UBjIlrm4=;
        b=rrUMa5mR7KoizadBxThGTDBGjybzEx8CdPUpWWQPRm/zHK+mtSiXObrbGWXIzvi8rQ
         bf5mUF1CZdcvbH7dkVQxZmrShRQsXR+O/ZkjpCkMGNqYQX16Fa715MSDNJoCNBHpQl4w
         vLWW9X7hOViSEro7qgTB8Fuv09Cd28aNd2Q3k16Dz/7/DMBckywMJepKHVcAkGmyihiP
         v/7NXWuyLIx8wj4uDrD6uup3YsqlMyQ97P4ppQjHO1YGuKmhAWtUDEwPzvy82eo+kuAL
         35DsmuuFEO7SGn6eHjlDkvz/Mr0XZJLtgAJsqRe5qjLauB8NfR83AZUUXZJTK6YwGI+m
         ktpw==
X-Received: by 10.31.154.131 with SMTP id c125mr4603594vke.96.1445403497531;
 Tue, 20 Oct 2015 21:58:17 -0700 (PDT)
Received: by 10.31.9.133 with HTTP; Tue, 20 Oct 2015 21:58:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279966>

Hi,
Using git 2.6.2
I think worktree should behave consistently like submodule

Run following commands
```
echo 1 > 1.txt
git init
git add 1.txt
git commit -m "initial commit"
echo 2 > 2.txt # untracked file
mkdir def
cd def
git clone --separate-git-dir ../.git/ghi .. . # simulate an untracked submodule
cd ..
git worktree add abc

git ls-files --exclude-standard --full-name --others
```

Actual: list all the files of abc
2.txt
abc/1.txt
def/

Expected: just the directory of abc
2.txt
abc/
def/


Hint: path.c: git_path_submodule() should read "commondir" ?
