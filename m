From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [RFC 2/3] merge: Add hints to tell users about "git merge --abort"
Date: Wed, 5 Mar 2014 10:30:40 -0500
Message-ID: <CADgNjak3aqPDV0iZYc8b6QJ9y+6bUd28n0UJOm6WjufQhjfuwA@mail.gmail.com>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<1393437985-31401-3-git-send-email-andrew.kw.w@gmail.com>
	<20140226203836.GM7855@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 16:30:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLDmY-0008Lo-GS
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 16:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759363AbaCEPap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 10:30:45 -0500
Received: from mail-wg0-f42.google.com ([74.125.82.42]:51440 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755657AbaCEPal (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 10:30:41 -0500
Received: by mail-wg0-f42.google.com with SMTP id y10so1434861wgg.13
        for <git@vger.kernel.org>; Wed, 05 Mar 2014 07:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uJKFX2UaTjc8H1lFpiEWOfk92WaPHDbfyEZoK4+4sew=;
        b=LGtU7oLZCPCJRLfIFEAYEBIUxT+0ExGNT1uZtP7Jx38EgKk5/X1DY/G3U1xxt2wXn7
         nPgb9hYprHU0QVv0WVRcR8Z13yB3eUHLaX8bQJJ7LS1kPNlvir3nFSNi5eRQQFMxI7qs
         GLE5jtV1by9vB7MD/xTcmDkW8Rm0//9u5tXVeS9M3ciKiEYNtm1D2fxDehFNEc7swuiP
         vJnp0ZqqVeFIQM9xCCk+HyCuDdEih5ogaDcdfKRrxoHFpNXekFvEqsAlpGsKkwEuOT2K
         Xd5PhuH3p8Oojc6wR7nifRvh6dWhLqoD2wAWmR6PLxO06i0+dRqF4RTxQvYZgW1HdMYA
         hzFQ==
X-Received: by 10.194.71.203 with SMTP id x11mr356777wju.93.1394033440087;
 Wed, 05 Mar 2014 07:30:40 -0800 (PST)
Received: by 10.194.81.65 with HTTP; Wed, 5 Mar 2014 07:30:40 -0800 (PST)
In-Reply-To: <20140226203836.GM7855@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243441>

On Wed, Feb 26, 2014 at 3:38 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Andrew Wong wrote:
>
>> --- a/builtin/merge.c
>> +++ b/builtin/merge.c
>> @@ -909,7 +909,8 @@ static int suggest_conflicts(int renormalizing)
>>       fclose(fp);
>>       rerere(allow_rerere_auto);
>>       printf(_("Automatic merge failed; "
>> -                     "fix conflicts and then commit the result.\n"));
>> +                     "fix conflicts and then commit the result.\n"
>> +                     "To abort the merge, use \"git merge --abort\".\n"));
>
> Seems reasonable, but I worry about the command growing too noisy.
>
> Could this be guarded by an advice.<something> setting?  (See advice.*
> in git-config(1) for what I mean.)

I was planning to use advice.resolveConflict, but as I went through
merge.c, I noticed there could be a few other situations where we
could print out the same message:
1. when prepare_to_commit() fails, due to hook error, editor error, or
empty commit message
2. "git commit --no-commit"

This means contexts are no longer only about "resolving conflict", so
I was thinking of renaming advice.resolveConflict to something like
advice.mergeHints.

Any thoughts?
