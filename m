From: Stefan Beller <sbeller@google.com>
Subject: [PATCHV2 0/2] Decouple rebase --exec from --interactive
Date: Thu, 17 Mar 2016 14:44:18 -0700
Message-ID: <1458251060-311-1-git-send-email-sbeller@google.com>
Cc: j6t@kdbg.org, johannes.schindelin@gmail.com, gitster@pobox.com,
	Matthieu.Moy@grenoble-inp.fr, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 22:44:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agfic-00017F-PF
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 22:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031056AbcCQVo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 17:44:27 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36626 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935552AbcCQVoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 17:44:25 -0400
Received: by mail-pf0-f177.google.com with SMTP id u190so137464976pfb.3
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 14:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=x8P0fnfY4A2RUokg8+m8PFGRc2KelrP8fJyny7pc76Y=;
        b=QPYdymPD+5vG4C75OXJ65fZRR+/bRe7zonOSrgZwRuM4Kfx5EH9vzJSs9+KCogZjgH
         LEtiHl70gmijFy/bp/214HRmPjgi+qCM4tRATW0wjQxmDAhReM5+hfo6nRXJMPNwyozD
         LCn6p7lkNAJ2mPBcqi99a/3lxwCrifu2O6zRSa8Y7t/RuAGhqmVNEYOqma2whqx8ONcW
         25ynFl8y/w8OFQdHBk71N01MG4NfMgA1Qrc4kPo8waBmoN0WLNALY74jOkx9nSJus3kO
         VY5zA9Ffq+F9iL6kec2oaisuEpofnrKHNBy+Q2qcX4Z0imwHRulV1IibJd5hspd/Qmwg
         2oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x8P0fnfY4A2RUokg8+m8PFGRc2KelrP8fJyny7pc76Y=;
        b=jV30zyrLQ39n6FlZlt4rtvKKjdU0MderugJSZpCK056/jbTiFm+ud2l7GJVWP8a0KE
         BpH4iiBcoGvTwnHRyOgaBeAT8GW9WQdYPkJYQsvU9+Nlgi6X3ltWc766dacjZxnwKlhX
         nDQVEXewUXqhZwvErZCu2esFwZN8fg52rcPXslKkD3fe7Idel8Ytq1VIPfwEzuKm6w7m
         DfsWYIGoB9MMQ02+cozZHn7Ix6Q7/TGE230MX/s4fsaYj5VuxzKitlXhag/qqR1r8sgZ
         XcEIhlhff5/ycztvjYzY1tZZdWwPywieQ9Hl5ncKrqV4W3+YH/rVLhRFFTiHjmk5qwKG
         DU8Q==
X-Gm-Message-State: AD7BkJKTQHEhGjOTGlxdYvJNq3SSlomPWLFFFEDmEsykjhLrkV03e18adLPx9MvgzKjuiH9v
X-Received: by 10.98.89.22 with SMTP id n22mr18383884pfb.55.1458251064741;
        Thu, 17 Mar 2016 14:44:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d62:319:527b:e183])
        by smtp.gmail.com with ESMTPSA id v14sm15652015pas.10.2016.03.17.14.44.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 17 Mar 2016 14:44:24 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc3.2.ga804a9e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289159>

Johannes Sixt:
 * Using test_i18ngrep instead of test_i18ncmp
 * test_line_count on the lines of the execution output instead
   of rebase stdout

Johannes Schindelin:
 * It's a patch series now (whitespace fixes are in patch 2)
 * you proposed '--exec "touch executed", I'd go with
   --exec "echo foo >>file" so I can count it was executed twice.

Junio:
 * added words to the commit message. :)
   (Essentially quoting Johannes that I am not just testing but also
   stopping for failure at the right point.)

Matthieu: (who preferred responding "private reply, top posting and probably HTML, sent from a phone" ;)
> Your patch makes the user feel like he is using non-interactive
> rebase while we internally go through the interactive code path.
> Did you make sure that the difference between interactive and non
> interactive do not show up by surprise? For example, iirc the interactive
> rebase does not accept --preserve-merges. What happens if the user asks
> --exec --preserve-merges?
>
> Also, does the doc need update? 

I (as a user) did not know there is a non-interactive mode for rebase,
assuming -i would show the editor and that would have been the only
difference.

I think it won't show up as a surprise (in v1) as the changed code is testing for
being non explicit via:

  if test -n "$cmd" &&
     test "$interactive_rebase" != explicit
  then
  -	die(...) 
  +	interactive_rebase=implied
  fi

and that is the last occurrence where interactive_rebase is touched for writing.

Quoting from the man page for `--preserve-merges`:
    This uses the --interactive machinery internally, but combining it with
    the --interactive option explicitly is generally not a good idea unless
    you know what you are doing (see BUGS below).

The docs have a similar explanation just the other way round [--exec is supposed
to be used with --interactive, but I avoided using the word "suppose" as that
sounds like preaching to me (Thou' shall not use --exec without --interactive);
I did not copy over the "if you know what you're doing" as it doesn't help the
user here. How are they supposed to know if they are proficient enough for using
it without -i? And we don't have a BUGS section to point at.]

> What happens if the user asks --exec --preserve-merges?

We're fine. When parsing `--preserve-merges`:
	--preserve-merges)
		preserve_merges=t
		test -z "$interactive_rebase" && interactive_rebase=implied

Essentially we did the same with --exec in v1 just after parsing all options,
now I realize we can do it the same way instead of afterwards, just tossing
in:

  test -z "$interactive_rebase" && interactive_rebase=implied


Stefan Beller (2):
  rebase -x: do not die without -i
  t3404: cleanup double empty lines between tests

 Documentation/git-rebase.txt  |  6 +++---
 git-rebase.sh                 |  7 +------
 t/t3404-rebase-interactive.sh | 18 +++++-------------
 3 files changed, 9 insertions(+), 22 deletions(-)

-- 
2.8.0.rc3.2.ga804a9e
