From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: exit code from git reset
Date: Sun, 9 Dec 2012 14:23:41 -0800
Message-ID: <CANiSa6i0LXE18Pyb5norRTm7PM+TMo3JvxDjoS5JOWt_qjHLHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 09 23:25:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThpJ9-00064E-82
	for gcvg-git-2@plane.gmane.org; Sun, 09 Dec 2012 23:25:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759113Ab2LIWXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2012 17:23:42 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:40201 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab2LIWXl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2012 17:23:41 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so6300836ieb.19
        for <git@vger.kernel.org>; Sun, 09 Dec 2012 14:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=KZ6TLYOdg1om2YxXQJ+i/mi9f3MR2+o5WkO9PR8bMNw=;
        b=bvS0pyb6jDH8TMMMGkG1fxu3jaRQ1ufvRYwQz5MozpX/N5sVC7ibsEm2GmvYdqhJgf
         8D/tiZj+hH1f7Dt4vYAaGNUDGNL3J5xuzvGuiUuxj0eSyBPYnphPmfZSaTPXej/vRRYS
         b28x+5XXMS7SULMx/2xJI4YC8QMFXsBsBqKqc6s08g1m2Zuw1iFGGkF4wSNgkP2OpFnW
         3gtnUDgL6J+jjBArT+UaY3itsvNNZrZ2WheT0oSSVOv4fj9asS0Gt4vhKOxqX4C5AuKd
         Ajt8Ty7NkhRNitPYKl21H1yxcReFGyDbxqbmXuzdH+SihBEzJ6VzogPDxX5/X5PzSp3t
         vJpg==
Received: by 10.42.153.70 with SMTP id l6mr9633628icw.50.1355091821289; Sun,
 09 Dec 2012 14:23:41 -0800 (PST)
Received: by 10.64.91.99 with HTTP; Sun, 9 Dec 2012 14:23:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211242>

Hi,

"git reset" currently returns 0 (if successful) while "git reset
$pathspec" returns 0 iff the index matches HEAD after resetting (on
all paths, not just those matching $pathspec). The exit code doesn't
seem to be documented. Is there a reason they should behave
differently? If not, what would be the better behavior? I don't see
when the "git reset $pathspec" behavior" would be useful and it seems
safer for any existing scripts out there not to change the status code
for "git reset" (w/o paths). Scripts that run "git reset $pathspec"
probably already know to ignore (or use?) the exit code. Also, having
any non-zero exit code signal failure might actually be useful.

Changing "git reset $pathspec" to return 0 on success, regardless of
diff between HEAD and index, breaks 10 test cases (in
t2013-checkout-submodule.sh and t7102-reset.sh). These seem to do
"test_must_fail git reset $pathspec", but I have not been able to find
any motivation for expecting the failure.

It seems like this behavior has been there at least since the tests
were added in 359048d (Add tests for documented features of "git
reset"., 2007-09-11), just before reset became built-in.

Would a patch to change the exit code from "git reset $pathspec" be appreciated?

Martin
