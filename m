From: Angus Hammond <angusgh@gmail.com>
Subject: Git add on deleted file
Date: Mon, 13 Aug 2012 18:34:46 +0100
Message-ID: <CAOBOgRZRSk7+jxMg+v=GWcn3F9ZfDTGC89YhJ1s7o9=HaOx4Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 13 19:35:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0yXs-0001mJ-9V
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 19:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379Ab2HMRfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 13:35:09 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:36865 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750789Ab2HMRfI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Aug 2012 13:35:08 -0400
Received: by lagy9 with SMTP id y9so2170043lag.19
        for <git@vger.kernel.org>; Mon, 13 Aug 2012 10:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=MoywT9zWauNI/qU+/z/GOSTyhdg9hmBKJyVZmGTGASo=;
        b=ysdzgFnYYkXnyH/o09j7aYjq3dqNrg5JsKHlZc2oIoM0yVeSc3Lw+3hSM+Ks3OuWfB
         frDg7qwhkZ8XUFmtmOA6U1CKNhbxwyPAYbEapLuR7MlJ8T4qoSS94Gtn96LcrzNH0zMh
         pOqJvOCCf2J2tQbYtPZDlsTe2JzJK0Kz/yxYSPSWKKceBIiqUB1j12SXstsSbzcPOCig
         274uiBibLVsScaOsYam3FQbG7k/t8NmLENUvLlen1nRQTHbEOZk8tBVMj7qgirf/Fg7j
         0WUENNSP0o6VnC2fSGu54Sbgn8RMFE+kGm7VtPdJSTQFaJ6NWhZDbQKVLZtHUXvDQS93
         Zg4g==
Received: by 10.112.25.106 with SMTP id b10mr6650111lbg.36.1344879306700; Mon,
 13 Aug 2012 10:35:06 -0700 (PDT)
Received: by 10.114.28.233 with HTTP; Mon, 13 Aug 2012 10:34:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203348>

I was messing around with git add and how it interacts with deleted
files earlier today and came across this odd behavior.

$git init
Initialized empty Git repository in /tmp/test/.git/
$touch foo
$git add foo
$git commit -m"initial commit"
[master (root-commit) 0b5a193] initial commit
 0 files changed
 create mode 100644 foo
$rm foo
$git status
# On branch master
# Changes not staged for commit:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       deleted:    foo
#
no changes added to commit (use "git add" and/or "git commit -a")
$git add foo
$git status
# On branch master
# Changes not staged for commit:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       deleted:    foo
#
no changes added to commit (use "git add" and/or "git commit -a")

Notice that the two outputs from git status are identical, so git add
doesn't appear to have changed anything. Personally I'd like to see
"git add foo" here be equivalent "git rm --cached foo", but I can
understand how others might prefer git add not to be destructive like
that. Either way, I don't think it's right that the command exits
without any output (which would normally indicate success) yet has
failed to do anything. Perhaps it should act more like git add does
when the file doesn't exist in the working directory or the index:

$git add bar
fatal: pathspec 'bar' did not match any files

Thanks
Angus
