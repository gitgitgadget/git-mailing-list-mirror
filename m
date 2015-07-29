From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-add-interactive: edit current file in editor
Date: Wed, 29 Jul 2015 15:05:02 -0400
Message-ID: <CAPig+cRRda=DVGAqpUjOsFk9Fqjqxi-apvWLuEW5xK1XCu5_+g@mail.gmail.com>
References: <1438040482-4599-1-git-send-email-siadat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Sina Siadat <siadat@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 21:05:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKWf9-0004ng-8j
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 21:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628AbbG2TFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 15:05:04 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:33131 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbbG2TFD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 15:05:03 -0400
Received: by ykba194 with SMTP id a194so16108468ykb.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 12:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+aYosS7vue7kJLhkIAfwwRrYT/rel49x/H3nGO3rMNQ=;
        b=aeGD6aO1niHooijhnlzGipdrxccm8vYmUdjIKEA0KveZiFyQBYPos4gb5ak6Z1zjPB
         kbaBMCHNMWaWZpYVeB5fute15tvvSg3xxIuWUvM61hADy4AirFaz67nbDjX+NrO2hkE+
         4ijh5SzAe+SLJqnFde0bAmSumu5a3W9VWimfvHCBhm0daM4ShaW3WcQnFWGZd2IAYlXk
         3mp56pS/zWOfdBn96JMREOCRWyWHw60qJxWgLMszEHheAS5g/eThJBhrxtuWG7S7MEPq
         j9odUU03uwZL2tCEHCPO9IW5OD/JHdmLIKWzc8/faYH4nQpWQNTGu+Ikb6rnPdNSvmSH
         WMdQ==
X-Received: by 10.170.138.134 with SMTP id f128mr46785783ykc.90.1438196702369;
 Wed, 29 Jul 2015 12:05:02 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Wed, 29 Jul 2015 12:05:02 -0700 (PDT)
In-Reply-To: <1438040482-4599-1-git-send-email-siadat@gmail.com>
X-Google-Sender-Auth: DH4LJ4jQqg-eSPTqJyR0W5G7_Yo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274939>

Aside from whether or not this change is desirable, see a few pointers
below to improve the patch...

On Monday, July 27, 2015, Sina Siadat <siadat@gmail.com> wrote:
> Adds a new option 'o' to the 'add -p' command that lets you open and edit the
> current file.

Imperative mood: "Add a new option..."

> The existing 'e' mode is used to manually edit the hunk.  The new 'o' option
> allows you to open and edit the file without having to quit the loop. The hunks
> are updated when the editing is done, and the user will be able to review the
> updated hunks.  Without this option you would have to quit the loop, edit the
> file, and execute 'add -p filename' again.

This descriptive material belongs in the commit message. Good.

> I would appreciate it if you could let me know what you think about this
> option. I will write more tests if there is any interest at all.

This, however, is commentary, which, while useful as part of the
submission process, does not belong in the commit message. Therefore,
it should be placed below the "---" line just before the diffstat.

> Thank you. :)

Missing sign-off. See Documentation/SubmittingPatches.

More below...

> ---
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index deae948..e5dd1c6 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -98,6 +98,12 @@ test_expect_success 'dummy edit works' '
>         test_cmp expected diff
>  '
>
> +test_expect_success 'dummy open works' '
> +       (echo o; echo a) | git add -p &&

Some alternatives, which may or may not read better, but at least
avoid a process creation or two:

    { echo o; echo a; } | git add -p &&

    printf "%s\n" o a | git add -p &&

    printf "o\na\n" | git add -p &&

Those are just suggestions; not necessarily a request for change.

> +       git diff > diff &&

Style: >diff

> +       test_cmp expected diff
> +'
> +
>  test_expect_success 'setup patch' '
>  cat >patch <<EOF
>  @@ -1,1 +1,4 @@
> --
> 2.5.0.rc3.2.g6f9504c.dirty
