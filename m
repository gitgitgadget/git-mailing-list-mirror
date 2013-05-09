From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v8 00/12] Interactive git clean
Date: Fri, 10 May 2013 01:14:04 +0800
Message-ID: <cover.1368118918.git.worldhello.net@gmail.com>
References: <CANYiYbEvYXiRE0OeR5vqBAaOFFpJTPBetQbawZD5EcMCj8veFw@mail.gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 09 19:14:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaUQN-0002P2-UM
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 19:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170Ab3EIROb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 13:14:31 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:53408 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab3EIROb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 13:14:31 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so2270085pab.34
        for <git@vger.kernel.org>; Thu, 09 May 2013 10:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=9jkT3FYmQirvR8yxypjOWRE9FkKAD++DAllVmGNZLGA=;
        b=ApObViyc819Z+xUvfWe1SyuYBbaBWIY5OCkPt4Gh7Xup89+zctU3xS2FHFvo0Iomc+
         OGz+J10iBocy3ri3U8DBL9JEoZhzJ+bpHbjIT/Wty3Y4giohLM3SEQxBLLWjdB1ZnNOi
         CrNznMj7znU2xKQy8pT/SDXNzvx6kgZO507cBcG9uzHeIoDxNhnswzFGtpf+aUbiCkjv
         O8ZYjHAtLbaZ3RMJWopn8Hj9zvjGIpXZHS7aquM7iXgF/YVfbIyyqoBBCDgXYNHGRhrO
         WeItVcocbmg2qvZqf7vGJqsrKGIcoXFFkQTSIEE2YVXbR2FX7oaWvRpIfyLJYADl2O3X
         xKRg==
X-Received: by 10.66.158.74 with SMTP id ws10mr13802433pab.8.1368119670528;
        Thu, 09 May 2013 10:14:30 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id pa2sm4407182pac.9.2013.05.09.10.14.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 May 2013 10:14:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g24a8a0f
In-Reply-To: <CANYiYbEvYXiRE0OeR5vqBAaOFFpJTPBetQbawZD5EcMCj8veFw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223749>

Updates since v7 series:

 * Eliminate global variable "**the_prefix".
 * Save relative paths in del_list.
 * Split 1/10 of v7 into 3 patches for readability.
 * Change orders of patches, thanks to Eric.
 * Update menu and hotkeys with the help of Eric.

Usage:

When the command enters the interactive mode, it shows the
files and directories to be cleaned, and goes into its
interactive command loop.

The command loop shows the list of subcommands available, and
gives a prompt "What now> ".  In general, when the prompt ends
with a single '>', you can pick only one of the choices given
and type return, like this:

    *** Commands ***
      1: clean         2: filter by pattern     3: select by numbers
      4. ask each      5. toggle flags: none    6. quit
      7: help
    What now> 2

You also could say `c` or `clean` above as long as the choice is unique.

The main command loop has 7 subcommands.

clean::

   Start cleaning files and directories, and then quit.

filter by pattern::

   This shows the files and directories to be deleted and issues an
   "Input ignore patterns>>" prompt. You can input space-seperated
   patterns to exclude files and directories from deletion.
   E.g. "*.c *.h" will excludes files end with ".c" and ".h" from
   deletion. When you are satisfied with the filtered result, press
   ENTER (empty) back to the main menu.

select by numbers::

   This shows the files and directories to be deleted and issues an
   "Select items to delete>>" prompt. When the prompt ends with double
   '>>' like this, you can make more than one selection, concatenated
   with whitespace or comma.  Also you can say ranges.  E.g. "2-5 7,9"
   to choose 2,3,4,5,7,9 from the list.  If the second number in a
   range is omitted, all remaining patches are taken.  E.g. "7-" to
   choose 7,8,9 from the list.  You can say '*' to choose everything.
   Also when you are satisfied with the filtered result, press ENTER
   (empty) back to the main menu.

ask each::

  This will start to clean, and you must confirm one by one in order
  to delete items. Please note that this action is not as efficient
  as the above two actions.

toggle flags::

  This lets you change the flags for git-clean, such as -x/-X/-d/-ff,
  and refresh the cleaning candidates list automatically.

quit::

  This lets you quit without do cleaning.

help::

  Show brief usage of interactive git-clean.



Jiang Xin (12):
  git-clean refactor: hold cleaning items in del_list
  git-clean: add support for -i/--interactive
  git-clean: show items of del_list in columns
  git-clean: add colors to interactive git-clean
  git-clean: use a git-add-interactive compatible UI
  git-clean: add filter by pattern interactive action
  git-clean: add select by numbers interactive action
  git-clean: add ask each interactive action
  git-clean refactor: save some options in clean_flags
  git-clean refactor: add wrapper scan_clean_candidates
  git-clean: add toggle flags interactive action
  git-clean: update document for interactive git-clean

 Documentation/config.txt    |    4 +
 Documentation/git-clean.txt |   77 +++-
 builtin/clean.c             | 1019 +++++++++++++++++++++++++++++++++++++++----
 3 files changed, 1023 insertions(+), 77 deletions(-)

-- 
1.8.3.rc1.341.g24a8a0f
