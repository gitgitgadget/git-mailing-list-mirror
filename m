From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] tests: use "env" to run commands with temporary
 env-var settings
Date: Tue, 18 Mar 2014 23:59:28 -0400
Message-ID: <CAPig+cT1c1HjsbN9PWB9Fn70v+qQOvE3A8bojbQNWw7jbD0BWQ@mail.gmail.com>
References: <244379@gmane.comp.version-control.git>
	<1395168845-1972-1-git-send-email-unsignedzero@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: David Tran <unsignedzero@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 05:00:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ7fY-00041I-Le
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 04:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758269AbaCSD7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 23:59:30 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:61047 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756662AbaCSD73 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 23:59:29 -0400
Received: by mail-yk0-f173.google.com with SMTP id 10so21748704ykt.4
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 20:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=S/RXSU1fXTu/TWerC27TkFLJZzcp26wfVq7j8k6XCMo=;
        b=pZwlK4bP8JXTCSTpX1pCL+D9r2wGTgQIqkRLbW0OW2uOOuFU12wRhKaL806NOsazVm
         SHbS8JtKiBlVWDkN4wM9Da+S6lkR5vHJAWtraJ27LIwhcOWOL+RAxuxSFEG42iZfAJXC
         grCdqdjAK+fuyVD3ALJG3+2uSNQlVGIzFAPF3Tanm8W5vJnxAelGxAGKJrYGSP0EG0Xb
         drck1qhMzR4hO3aoiWadgHoMi+y6Ma5PbYC0ddY2JajurOdmAroSGo9wjvsaSmTPQyF5
         it13Adl2gOcGhFckcmYvms81IKH8uKL+PLKUGDfi3jnm9XTl4c4RTLvKCwMhOOlP1XWA
         Gkkg==
X-Received: by 10.236.159.165 with SMTP id s25mr22969110yhk.24.1395201569002;
 Tue, 18 Mar 2014 20:59:29 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Tue, 18 Mar 2014 20:59:28 -0700 (PDT)
In-Reply-To: <1395168845-1972-1-git-send-email-unsignedzero@gmail.com>
X-Google-Sender-Auth: 2PyDoZCZtbhhNNBuZzb0PgAMfng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244408>

On Tue, Mar 18, 2014 at 2:54 PM, David Tran <unsignedzero@gmail.com> wrote:
> Originally, we would use "VAR=VAL command" to execute a test command with
> environment variable(s) only for that command. This does not work for commands
> that are shell functions (most notably test functions like "test_must_fail");
> the result of the assignment is retained and affects later commands.
>
> To avoid this, we assigned and exported the environment variables and run
> the test(s) in a subshell like this,
>
>         (
>                 VAR=VAL &&
>                 export VAR

Append && to this line.

>                 test_must_fail git command to be tested
>         )
>
> Using the "env" utility, we should be able to say
>
>         test_must_fail git command to be tested
>
> which is much short and easier to read.

s/short/shorter/

> Signed-off-by: David Tran <unsignedzero@gmail.com>
>
> ---
>
> Hopefully this should be all of it.

Much better. I didn't spot any errors in the patch this time around.

One final note for future submissions: As a courtesy to reviewers,
explain (below the "---" line) what changed in the current version,
and provide a reference to the previous attempt, like this [1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/244379

> Signed-off-by: David Tran <unsignedzero@gmail.com>
> ---
>  t/t1300-repo-config.sh        |   17 ++--------
>  t/t1510-repo-setup.sh         |    4 +--
>  t/t3200-branch.sh             |   12 +------
>  t/t3301-notes.sh              |   22 +++---------
>  t/t3404-rebase-interactive.sh |   69 ++++++++---------------------------------
>  t/t3413-rebase-hook.sh        |    6 +---
>  t/t4014-format-patch.sh       |   14 ++------
>  t/t5305-include-tag.sh        |    4 +--
>  t/t5602-clone-remote-exec.sh  |   13 ++------
>  t/t5801-remote-helpers.sh     |    6 +--
>  t/t6006-rev-list-format.sh    |    9 ++---
>  t/t7006-pager.sh              |   18 ++---------
>  12 files changed, 42 insertions(+), 152 deletions(-)
