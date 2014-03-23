From: Per Cederqvist <cederp@opera.com>
Subject: Re: [GUILT 04/28] Allow "guilt import-commit" to run from a dir which
 contains spaces.
Date: Sun, 23 Mar 2014 20:57:08 +0100
Message-ID: <CAP=KgsSBcsG1kMfyc=MbUDCuC+4W9Boa2Fwf-FSg6XNxaCAt8g@mail.gmail.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
	<1395387126-13681-5-git-send-email-cederp@opera.com>
	<20140323170409.GG1661@meili.valhalla.31bits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Sun Mar 23 20:57:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRoWA-0004Bz-VT
	for gcvg-git-2@plane.gmane.org; Sun, 23 Mar 2014 20:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbaCWT5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2014 15:57:10 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:40779 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbaCWT5I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2014 15:57:08 -0400
Received: by mail-ie0-f180.google.com with SMTP id as1so4423152iec.25
        for <git@vger.kernel.org>; Sun, 23 Mar 2014 12:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EulQmev2YEGvl0WKV3QMlD9F4Q8xQkAdLJaHFWjf2M0=;
        b=H0WcIbPinzY7z78oTVtOrOBy5Qb7y1dMdCkZrt4d1SObIq/DckNrA+/yXcIgX9Xbpr
         9M0vlIj48d5kJRVdRNi5kisPzZ6rGqO1JCVF0BkwBhxwj0E2iafZiKCnV8yIZse9H6kW
         yQaZwjLOy5uc+qBp5uWj2haecMFDDs39iyrBQuB0/WWiygCweJD6fs6ei0RtHax/Ubbv
         fYUF9ZiaoiF8H4XnlaaPJ8fRWzkf1gQnfZvk3xF7fhiFKLNlZGhezkINmqipC8/Wujfj
         z/6jpHAh04WJ9f7Rcf7iXilmuI4qYoR0R1N5bO9wpfodEMlBNfCP97vdvu2ge3k+Lqdw
         KAwQ==
X-Gm-Message-State: ALoCoQkx6zVClv1MWzN5buyr0tgaBcc0zYo8524JTGjOTF6Kxq2GAAgq9Ar5/gRpYmwKZB6GI++b
X-Received: by 10.50.143.107 with SMTP id sd11mr8100003igb.39.1395604628165;
 Sun, 23 Mar 2014 12:57:08 -0700 (PDT)
Received: by 10.42.44.198 with HTTP; Sun, 23 Mar 2014 12:57:08 -0700 (PDT)
In-Reply-To: <20140323170409.GG1661@meili.valhalla.31bits.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244803>

On Sun, Mar 23, 2014 at 6:04 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:

> On Fri, Mar 21, 2014 at 08:31:42AM +0100, Per Cederqvist wrote:
>
>> Signed-off-by: Per Cederqvist <cederp@opera.com>
>> ---
>>  guilt-import-commit | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/guilt-import-commit b/guilt-import-commit
>> index 20dcee2..9488ded 100755
>> --- a/guilt-import-commit
>> +++ b/guilt-import-commit
>> @@ -23,7 +23,7 @@ if ! must_commit_first; then
>>  fi
>>
>>  disp "About to begin conversion..." >&2
>> -disp "Current head: `cat $GIT_DIR/refs/heads/\`git_branch\``" >&2
>> +disp "Current head: `cat \"$GIT_DIR\"/refs/heads/\`git_branch\``" >&2
>
> I wonder if it'd be better to use 'git rev-parse' here instead of looking at
> the refs directly.
>
> IOW,
>
> disp "Current head: `git rev-parse \`git_branch\``" >&2

That is probably a good idea. I only made the minimum change
required to get the test suite to pass.

> Maybe even $() instead of the inner `` to clean it up some more.

Yes, given that that construct is already used in several places
it is apparently portable enough for guilt. (I guess nobody uses
/bin/sh on Solaris to run guilt. It doesn't support the $(...)
construct.)

> Jeff.

    /ceder

>>
>>  for rev in `git rev-list $rhash`; do
>>       s=`git log --pretty=oneline -1 $rev | cut -c 42-`
>> @@ -46,7 +46,7 @@ for rev in `git rev-list $rhash`; do
>>               do_make_header $rev
>>               echo ""
>>               git diff --binary $rev^..$rev
>> -     ) > $GUILT_DIR/$branch/$fname
>> +     ) > "$GUILT_DIR/$branch/$fname"
>>
>>       # FIXME: grab the GIT_AUTHOR_DATE from the commit object and set the
>>       # timestamp on the patch
>> @@ -68,6 +68,6 @@ for rev in `git rev-list $rhash`; do
>>  done
>>
>>  disp "Done." >&2
>> -disp "Current head: `cat $GIT_DIR/refs/heads/\`git_branch\``" >&2
>> +disp "Current head: `cat \"$GIT_DIR\"/refs/heads/\`git_branch\``" >&2
>>
>>  }
>> --
>> 1.8.3.1
>>
>
> --
> It used to be said [...] that AIX looks like one space alien discovered
> Unix, and described it to another different space alien who then implemented
> AIX. But their universal translators were broken and they'd had to gesture a
> lot.
>                 - Paul Tomblin
