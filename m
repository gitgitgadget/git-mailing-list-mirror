From: Orgad Shaneh <orgads@gmail.com>
Subject: Re: git gui replaces amend message when prepare-commit-msg hook is used
Date: Thu, 4 Jul 2013 13:59:10 +0300
Message-ID: <CAGHpTB+ObJjqvQ-xfQOdGG+ZSZdCijVZXh1NBp97TZ=hO-QVgQ@mail.gmail.com>
References: <CAGHpTBKOX8G1PZqE2njQ1UbFJeC_L6WxjnTC5NyT8LSbiBNGXw@mail.gmail.com>
	<20130704103440.GH9161@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jul 04 12:59:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuhFr-0000jC-Ke
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 12:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666Ab3GDK7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 06:59:12 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:57877 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab3GDK7L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 06:59:11 -0400
Received: by mail-ob0-f173.google.com with SMTP id wc20so1457137obb.4
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 03:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KsDbCmnodBPOKmJLXVNwD+IVkLB4rfocCD5yN3+cp5Y=;
        b=F60z83c84Gs215ebHQn+dtvIyDH5lw2wGQw+CELhRSfQ4laf9JHnQ4QO/BlwCGY068
         xXgpBlzyoG3uN+sI8zrnivz3Qeu8JPi6rqtetTfhMyq0GKE9C8KNsv3iHMgy0M+g1XnZ
         T78MJW7TNWRGgVYBW6d2BPARN+s1ttiZlCx9ACtVoTyU5+uNDW3IHaJFNJHAt4tr6q/X
         nMurqva+MChIALRCSDLeRDRcdIUCLVkQOg7SCdsx94IANJ31s5p3jsnwIDW8NzDW9OpJ
         hfuUcy5BZhyFjumdjDL1egRNV57gnBf+RZQ8F69aS94fqbA9AjCo381YGxM1p2g8H8ob
         d99A==
X-Received: by 10.60.133.235 with SMTP id pf11mr5448250oeb.38.1372935550292;
 Thu, 04 Jul 2013 03:59:10 -0700 (PDT)
Received: by 10.182.128.72 with HTTP; Thu, 4 Jul 2013 03:59:10 -0700 (PDT)
In-Reply-To: <20130704103440.GH9161@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229570>

On Thu, Jul 4, 2013 at 1:34 PM, John Keeping <john@keeping.me.uk> wrote:
> On Thu, Jul 04, 2013 at 12:47:28PM +0300, Orgad Shaneh wrote:
>> Hi,
>>
>> If a prepare-commit-msg hook is used, git gui executes it for "New Commit".
>>
>> If the "New Commit" is selected, and then immediately "Amend" (before
>> the hook returns), when the hook returns the message is replaced with
>> the one produced by the hook.
>
> I think this is a problem with the hook you are running.  The hook is
> given arguments specifying the message file and optionally the source of
> whatever is already in the file (see githooks(5) for details).
>
> It sounds like your hook is blindly overwriting the file, rather than
> preserving its contents in the cases where you wish to do so.

Let me try to explain.

When git gui is executed, it calls the prepare-commit-msg script with
.git/PREPARE_COMMIT_MSG as an argument.

When amend is selected, the hook is *not* called at all (what would it
prepare? The message is already committed)

Use the following hook to reproduce:
--- snip ---
#!/bin/sh

sleep 5
echo "$@" >> /tmp/hook.log
echo 'Hello hook' > "$1"
--- snip ---

Now run git gui (or press F5 if it is already running), and before 5
seconds pass, click Amend last commit. You'll see the commit's
message, but when the 5 seconds pass it is replaced with "Hello hook".
That's the bug.

- Orgad
