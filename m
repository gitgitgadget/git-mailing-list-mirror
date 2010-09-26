From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What happens if someone modifies repository without me knowing?
Date: Sun, 26 Sep 2010 21:16:33 +0200
Message-ID: <AANLkTimUCGcM+OXqBOfHmGCaBamG27fjjz098-7GZ1G7@mail.gmail.com>
References: <i7o5rc$t3$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
X-From: git-owner@vger.kernel.org Sun Sep 26 21:17:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozwib-0001LE-Uz
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 21:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757469Ab0IZTQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 15:16:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34434 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757090Ab0IZTQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 15:16:56 -0400
Received: by gyd8 with SMTP id 8so1383172gyd.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 12:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=Ng3eszmG6jQxZbk7fAkzVjstfdl8sSGITxMm8xvdQD4=;
        b=dUKFvyHX3i6U4b8eOYSHgy5l26FYKk47zbmUBnjpi4uc4m/bS2I2wUpSiB7qJ206hD
         crS5iRzSymsXDlwtG1J7YzlBYCMKlQYZU8guvmzM+8Ia1VJH0BlUryjKkl+EaszG7WwO
         g5dxNpfHK9Uh/ujPjDFi7j5vB2J+AVIvI4RRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=O83r+fO+enB2cpCxHXTH0L+UWNp0fp9lxVsNi/uk9KbESqKrwLwom33d2fMYozZ5oZ
         e8DxiJbkUqNIciBixoF4+jl34+d9n8FxlkQ40KK1uCcdKHiFoiVLPdwQZQKb3sX+ciw3
         AYrPBTrW5icGCf2Qkj8lSNdFPjl8HD+Fdc8cA=
Received: by 10.150.206.10 with SMTP id d10mr7534937ybg.350.1285528614973;
 Sun, 26 Sep 2010 12:16:54 -0700 (PDT)
Received: by 10.151.82.3 with HTTP; Sun, 26 Sep 2010 12:16:33 -0700 (PDT)
In-Reply-To: <i7o5rc$t3$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157254>

Heya,

On Sun, Sep 26, 2010 at 21:07, Manuel Reimer <Manuel.Spam@nurfuerspam.de> wrote:
> How will GIT tell me about this hidden change? Will a "git pull" just bring
> this change into my working copy, whithout telling me about the change?

It will tell you it did a "forced update", assuming the other side has
been set as your upstream. If you do a pull (rather than a fetch) it
will try to apply the changes right away too.

Demonstration:

sverre@laptop-sverre:~/code
$ git init test
Initialized empty Git repository in /home/sverre/code/test/.git/
sverre@laptop-sverre:~/code
$ cd test/
sverre@laptop-sverre:~/code/test
$ echo "content" > foo
sverre@laptop-sverre:~/code/test
$ git add foo
sverre@laptop-sverre:~/code/test
$ git commit -m "Initial"
[master (root-commit) 9d48240] Initial
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 foo
sverre@laptop-sverre:~/code/test
$ echo "second line" >> foo
sverre@laptop-sverre:~/code/test
$ git commit -am "Proper second modification"
[master 8367122] Proper second modification
 1 files changed, 1 insertions(+), 0 deletions(-)
sverre@laptop-sverre:~/code/test
$ cd ..
sverre@laptop-sverre:~/code
$ git clone test/ foo
Cloning into foo...
done.
sverre@laptop-sverre:~/code
$ cd test/
sverre@laptop-sverre:~/code/test
$ echo "and a third" >> content
sverre@laptop-sverre:~/code/test
$ git commit --amend -am "Tampered second modification"
[master 87d8e8a] Tampered second modification
 1 files changed, 1 insertions(+), 0 deletions(-)
sverre@laptop-sverre:~/code/test
$ cd ../foo/
sverre@laptop-sverre:~/code/foo
$ git pull
remote: Counting objects: 5, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From /home/sverre/code/test
 + 8367122...87d8e8a master     -> origin/master  (forced update)
Merge made by recursive.

-- 
Cheers,

Sverre Rabbelier
