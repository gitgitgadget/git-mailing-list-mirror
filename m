From: Andrius Bentkus <andrius.bentkus@gmail.com>
Subject: Idea, Transparent commits, easier "code style" commits
Date: Fri, 4 Jul 2014 15:12:05 +0200
Message-ID: <CAAwotL2a=2syXMCjPsNB9Tzaw1Rrr4UqDyLX9+JYDE-izpJnLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 04 15:12:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X33Hg-0001rE-N2
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jul 2014 15:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758543AbaGDNMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2014 09:12:08 -0400
Received: from mail-ve0-f182.google.com ([209.85.128.182]:57634 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758500AbaGDNMH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2014 09:12:07 -0400
Received: by mail-ve0-f182.google.com with SMTP id oy12so1686275veb.27
        for <git@vger.kernel.org>; Fri, 04 Jul 2014 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=Tn2UaknozoiugcfbVfvYIh31czJpTj4poycOdUfq31Q=;
        b=lxcof73ML61ph61StCxCsa0B5N0EWwrbX+bC+M/vlQdS597kDBq8Zl9gv3r6mDrrYR
         X9a7O8WNia0eUyusNcruRpkltgBZ8jkuolDky7azhS1Fd4AOMPTAip5yWUm0jL12T89G
         c7Hh9ntKrsE7MjRzrX7FlyQ+NHQeqpJTn4uVkJCIFy6+hoTKsr+kfEhMcAWmCGPN1Yjv
         D44qNBoYleBWyEB1KBkttdu5k129SmlWOPXj1t/XW0r5HEk6qZwI5gGXIQmgp9s7NPJJ
         riKp5J7aDwxMMv0PzAcHZ7NHI3yLHk+AUqW+mIdoKz+JbB1rlTRQWPmLw1Q0htHLRpzb
         2bkw==
X-Received: by 10.58.187.19 with SMTP id fo19mr272499vec.45.1404479525553;
 Fri, 04 Jul 2014 06:12:05 -0700 (PDT)
Received: by 10.52.113.41 with HTTP; Fri, 4 Jul 2014 06:12:05 -0700 (PDT)
X-Google-Sender-Auth: 76ssdL0o0jyC1eMOBRSqSIbu9vc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252896>

I have worked on projects which only after a while (a year or so)
established a consistent code style.
After the consensus was established there was still some code left
which did not fit the newly established standard.
Now the problem is, if I create a new patch to actually fix it, it
will pollute the blame history.
And most of the projects just reject these kind of patches because of this.

Imagine that you would have a type conversion "(int)value" and wanted
it to change to "(int) value".
The patch will have hundreds of occurrences of this one line changes
and will make the git blame look like swiss cheese.
It doesn't add much information to the line (you'd rather have
technical explanations in the commit) and actually hides all the
original comments of the line.

So you kinda want to have that style fix patch because inconsistent
code style just triggers your OCD, but you can't do anything about it
because it doesn't add any value to the program when it executes and
actually makes it harder to browse the source code using git blame.

My proposal is to add "transparent" commits.
If you write git blame these commits will not be shown, instead git
blame will show a merged version of the code style commit and the
actual commit while only showing the commit id of the original commit.

A little visualized example:

Imagine your first commit is:

58461d5a float yolo(void *i) {
58461d5a   return (float)*i;
58461d5a }

And you want it to change to (float) *i, so you patch it and the blame
history looks now like this:

58461d5a float yolo(void *i) {
263da519   return (float) *i;
58461d5a }

But what you really want to have when you do a git blame is this:

58461d5a float yolo(void *i) {
58461d5a   return (float)*i;
58461d5a }

I hope I expressed myself clearly enough.
Maybe this was already proposed, but I couldn't find anything in the archives.
