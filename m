From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] help: add help_unknown_ref
Date: Thu, 2 May 2013 02:02:43 +0530
Message-ID: <CALkWK0nJSoBoAXR=ViGan6keFzXjmDGkfKqqWkTHqF89mHDDOQ@mail.gmail.com>
References: <1367407327-5216-1-git-send-email-vikrant.varma94@gmail.com>
 <1367407327-5216-2-git-send-email-vikrant.varma94@gmail.com>
 <CALkWK0nMMi-nmAMUGXCaJDCV29G3dOzYTosKqSw+bFzc0osiaA@mail.gmail.com> <51817319.6060201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Vikrant Varma <vikrant.varma94@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 22:33:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXdiT-0005lv-VP
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 22:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757373Ab3EAUd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 16:33:26 -0400
Received: from mail-ia0-f171.google.com ([209.85.210.171]:38643 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278Ab3EAUdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 16:33:25 -0400
Received: by mail-ia0-f171.google.com with SMTP id r13so1692328iar.16
        for <git@vger.kernel.org>; Wed, 01 May 2013 13:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6mUSSoH5liRcYAzWupm34kgw6N2CdXy8Yc88bUNzZb0=;
        b=v4d/KweWFcxerpJMpZMSh1LGS3hNpMs51biVpMv0zIfbBZfQqXzVjXSP+J1DP2yhR+
         5tSpS+vxM7bXCovygqFHw4k4VvlSF/ddPEF9DbDYYfLuPUF6jqKUlAkIS2uQTqBK5aHJ
         XcIQQy6/jV6f4BfO/GYYvyZO9hGIKu83kXFoHrG931cWqODSEEAaFlTXaPUoYYwCzEpH
         aiPq5r/afUKXOM+fkyUikg5smlWdiOZ44Aj/1e5dmxxHTflItqU81oxyYnHgB4JdoboB
         EyqcRciv0KOyRK1vaqLSwTX5KPaXZO84Yaq1vj9EmqHX5haQjGOx9HcQVycMAG84vzSX
         7J2g==
X-Received: by 10.50.57.200 with SMTP id k8mr13911428igq.44.1367440404207;
 Wed, 01 May 2013 13:33:24 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 1 May 2013 13:32:43 -0700 (PDT)
In-Reply-To: <51817319.6060201@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223138>

Vikrant Varma wrote:
> I agree with Matthieu, the people who don't want to see this advice never
> will, because they won't make that mistake. Maybe advice is the wrong word,
> corrections might be more appropriate.

Makes sense.

Perhaps it would make sense to hook into help.autocorrect.  I would
definitely like that.

>> I see that there are other structs in our codebase suffixing _cb, to
>> indicate "callback data".  I normally reserve _cb for callback
>> functions.
>
>
> I'm following the convention (builtin/merge.c: struct append_ref_cb). If
> there's a better way to name it, I'll use that.

Fine leaving it as it is.

> ref_cb.similar_refs has already been defined. The compiler won't let me
> assign to it unless I cast first. However, I think compound literals are a
> C99/gcc feature. Is this better?
>
>         struct similar_ref_cb ref_cb = {ref, STRING_LIST_INIT_NODUP};

As Johannes pointed out, ref is a variable and that is problematic.
Leave the cast on: I didn't notice the compiler warning in my head.

> Q_ is a pluralization helper that picks one of the two strings based on
> ref_cb.similar_refs.nr. It's used in help.c:help_unknown_cmd for the same
> reason.

Thanks.

> Again, because help_unknown_cmd exited with 1. I've tried to follow the
> convention as laid down there.

Ah, I didn't notice that.

> What's the significance of the error code for
> die()?

When something _really_ bad happens, exit() with 128, without
bothering to go up the callstack.  Return error() is a common idiom to
print an error message immediately, and propagate the return status -1
up the callstack.

> When is it correct to use die(), and when to use error() followed by
> exit(128)?

exit(128) is a bit rare [grep for it yourself].  It's for when you
want to die(), but exit() only after doing an important task in the
caller.
