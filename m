From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v4 28/44] builtin-am: pass git-apply's options to git-apply
Date: Wed, 1 Jul 2015 18:22:33 +0800
Message-ID: <CACRoPnTeg08nJfMw6Lh6RUAOaKsSx30-=hhj2QD7_bPfKTHtTQ@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-29-git-send-email-pyokagan@gmail.com>
	<CAGZ79kbzwv8m47t5W+1djFEWGL_X1nHPf7FWcwcKAZ34oFszxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 12:22:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAFAE-0000je-NR
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 12:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbbGAKWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 06:22:38 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:34784 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbbGAKWg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 06:22:36 -0400
Received: by lagx9 with SMTP id x9so37497233lag.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 03:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8aVMIQ/pZGDXfmbp1WU4aym+w64czYFiM5bhDYVDYFg=;
        b=kDq6f09J/pmi5J7EVfTVonAILohXNUNvpuyqyYRXV48FobOOfJCeuERx1jwdovNv9o
         qN7gNRupPQuq1h/3m8Zgl+LPSuQRtHtLFC2StfH5JKTuU5Awq8fpOhhqff7wrJjmJ+J+
         RKzZrfuruqHCuW+XGd+St821enWjyx84ps7dVqedS+cgFRjqtxhets9A+YYgXFI3ecbq
         fWTuWcRz2ZSnvv78N6Y6z6A8vpS5YFOV6hek8488G2/Yyktnd80CZ4f3UvqPJ8SxuWZi
         tfeHUeniuvESaA+mZ+UxnfZefE2xyCrCljWo4DvMqaX+ygg3B9WXyYPptt7z2FBackSk
         preQ==
X-Received: by 10.112.199.133 with SMTP id jk5mr24974663lbc.32.1435746154203;
 Wed, 01 Jul 2015 03:22:34 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Wed, 1 Jul 2015 03:22:33 -0700 (PDT)
In-Reply-To: <CAGZ79kbzwv8m47t5W+1djFEWGL_X1nHPf7FWcwcKAZ34oFszxg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273148>

On Tue, Jun 30, 2015 at 7:56 AM, Stefan Beller <sbeller@google.com> wrote:
> I realize this was in am.sh as well, but I find the help strings a bit
> unfortunate.
> (Yes, you actually need to look them up at another place as most people are
> not familiar with the apply options).

Yeah I agree, it would be an improvement. I think the same can be said
for git-mailinfo's and git-mailsplit's options. e.g. "pass -k flag to
git-mailinfo" is not very descriptive either, so we should change
their help strings as well.

Since git-am combines most of the options from git-mailsplit,
git-mailinfo and git-apply together, I wonder if we should split their
options into different groups, e.g:

usage: git am [options] [(<mbox>|<Maildir>)...]
   or: git am [options] (--continue | --skip | --abort)

    -i, --interactive     run interactively
    -3, --3way            allow fall back on 3way merging if needed
    -q, --quiet           be quiet
    -s, --signoff         add a Signed-off-by line to the commit message
    --patch-format <format>
                          format the patch(es) are in
    --resolvemsg ...      override error message when patch failure occurs
    --continue            continue applying patches after resolving a conflict
    -r, --resolved        synonyms for --continue
    --skip                skip the current patch
    --abort               restore the original branch and abort the
patching operation.
    --committer-date-is-author-date
                          lie about committer date
    --ignore-date         use current timestamp for author date
    --rerere-autoupdate   update the index with reused conflict
resolution if possible
    -S, --gpg-sign[=<key-id>]
                          GPG-sign commits

options for git-mailsplit
    --keep-cr             pass --keep-cr flag to git-mailsplit for mbox format
    --no-keep-cr          do not pass --keep-cr flag to git-mailsplit
independent of am.keepcr

options for git-mailinfo
    -u, --utf8            recode into utf8 (default)
    -m, --message-id      pass -m flag to git-mailinfo
    -c, --scissors        strip everything before a scissors line
    -k, --keep            pass -k flag to git-mailinfo
    --keep-non-patch      pass -b flag to git-mailinfo

options for git-apply
    --whitespace <action>
                          detect new or modified lines that have
whitespace errors
    --ignore-space-change
                          ignore changes in whitespace when finding context
    --ignore-whitespace   ignore changes in whitespace when finding context
    --directory <root>    prepend <root> to all filenames
    --exclude <path>      don't apply changes matching the given path
    --include <path>      apply changes matching the given path
    -C <n>                ensure at least <n> lines of context match
    -p <num>              remove <num> leading slashes from
traditional diff paths
    --reject              leave the rejected hunks in corresponding *.rej files

We may wish to put these changes in their own preparatory patch series though.

What do you think?

Regards,
Paul
