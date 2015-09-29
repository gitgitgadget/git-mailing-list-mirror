From: Nazri Ramliy <ayiehere@gmail.com>
Subject: 2.6.0: Comment in rebase instruction has become too rigid
Date: Tue, 29 Sep 2015 22:02:37 +0800
Message-ID: <CAEY4ZpN0C96jU4Tgvqt-hWEviR-sapDoyAv88H+opPSr-cs=mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 29 16:03:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgvV0-0004Sy-52
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 16:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756554AbbI2ODM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2015 10:03:12 -0400
Received: from mail-yk0-f194.google.com ([209.85.160.194]:35862 "EHLO
	mail-yk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965098AbbI2OCi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2015 10:02:38 -0400
Received: by ykdz138 with SMTP id z138so645701ykd.3
        for <git@vger.kernel.org>; Tue, 29 Sep 2015 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=4RMS2NWo1OSr/bBMKh7DS3LN3uuvmoo/k4S+SRKkAYk=;
        b=H7PJT7dFkW5j5ponLF0nwgJsgH6plphNkxeaPmrjJ53FQGD9OGVmXQ5gfsxNPRD9h6
         2XTPnpDijmg/WyDOY7ixtJ8itgSYgCLuoPO5gD7Ogd9QOkLCjRugV3+E7SkbH+mjNdDq
         3M3CUaDkvIc/ojT+1xFkZ75sjBXUTFMPwHFq4GlNsR3LhBe18v0cN2k7kq8DhTezQnyG
         1GCS/FlWXcRyOz+keyC1p0U8eI2ZUGt5BuTYJ/G8aA3wjLNCf9HvvAkvYVlHkTQp2rL0
         ebV36UBcUR3rbJVVJ7n3IucD18KiZfH+MQMo44IAJmUA28llW9seRCIK55XYKInag2l8
         Z3/Q==
X-Received: by 10.13.210.5 with SMTP id u5mr22672627ywd.154.1443535357747;
 Tue, 29 Sep 2015 07:02:37 -0700 (PDT)
Received: by 10.37.103.135 with HTTP; Tue, 29 Sep 2015 07:02:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278824>

Hi,

I noticed that the format of the comment lines in a rebase instruction
sheet has become stricter - it could no longer begin with spaces or
tabs. The comment char ("#" for example) has to appear on the first
column.

This break my little script (activated via some key binding in my
$EDITOR) for adding the list of modified files under each "pick"
command. The way I have it setup is something like this, given the
following rebase intruction:

  pick deadbeef some commit message
  pick cafebabe another commit message

I'd hit that key in my editor that filters the pick instructions add
inserts the list of the modified files in each commit so that the
instruction sheet becomes like this:

  pick deadbeef some commit message
     # M path/to/foo.txt | 15 ++++----------
  pick cafebabe another commit message
     # M bar.txt | 2 +-


IIRC before git 2.6.0 this worked fine. With git 2.6.0 the rebase
stops midway with warning about invalid instruction due to the now
no-longer recognized indented comments.

I could work around this by changing my script so that it removes the
indentation prefix so that the instruction would become like this:

  pick deadbeef some commit message
  # M path/to/foo.txt | 15 ++++----------
  pick cafebabe another commit message
  # M bar.txt | 2 +-

but this would make it harder to read because of the increased clutter
between the rebase instructions and the informative "what files were
changed in this commit" comment.

Looking at git-rebase--interactive.sh it seems that this is due to
"git stripspace --strip-comments".

Would it be okay if the behavior is reverted to the old one - which is
to recognize indented comments in the rebase instruction?

Nazri
