From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 3/3] make commit --verbose work with --no-status
Date: Mon, 24 Feb 2014 12:24:42 +0800
Message-ID: <CALUzUxrO-=a5u-NpPVcQdnc2sp9dq3St0PZm=QOWr7oMWDz-Jw@mail.gmail.com>
References: <1393009762-31133-1-git-send-email-rctay89@gmail.com>
 <1393009762-31133-2-git-send-email-rctay89@gmail.com> <1393009762-31133-3-git-send-email-rctay89@gmail.com>
 <1393009762-31133-4-git-send-email-rctay89@gmail.com> <20140222083110.GE1576@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 24 05:25:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHn6u-0001fK-PQ
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 05:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbaBXEZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Feb 2014 23:25:05 -0500
Received: from mail-la0-f52.google.com ([209.85.215.52]:50380 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbaBXEZE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Feb 2014 23:25:04 -0500
Received: by mail-la0-f52.google.com with SMTP id c6so5013044lan.11
        for <git@vger.kernel.org>; Sun, 23 Feb 2014 20:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QAdO/wxnOCrCjotwWwLapfruMXo+HJ9BsIzdbh9SyP0=;
        b=t5R69k0r2QWcvg90+z6+S6ZSDa/6gRYHxJuCan2fiLfPkPujFY1ra6sFxyjO3eUDeC
         aayNkhy0k67IglFHPvbYE5MB+DHFj8x2EXmWBci+UTI5b61tQ0X13kFE4hxzHPW8FZIO
         yYqTn+y5Mu4HwBTgy+rnKdr3uMc2R0UREsam2c7oVtggEqibFNnZMFW+wR4EU+x6iVec
         zTHOzCOKLN3zMzyyUnC8u57VeuXz0F5NR+jK9mGqXfE+FYIYm7zoubhLxcZVw1fEitSD
         Cdpyy1eG5dkUZbCKZ2d9rXkdvbw/73Q4IsvZFn36nl5L3vW+oC+Z2E+KnlDDezZgM43D
         UH3w==
X-Received: by 10.112.99.74 with SMTP id eo10mr10190874lbb.15.1393215902429;
 Sun, 23 Feb 2014 20:25:02 -0800 (PST)
Received: by 10.114.64.15 with HTTP; Sun, 23 Feb 2014 20:24:42 -0800 (PST)
In-Reply-To: <20140222083110.GE1576@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242557>

On Sat, Feb 22, 2014 at 4:31 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 22, 2014 at 03:09:22AM +0800, Tay Ray Chuan wrote:
>
>> @@ -1141,7 +1146,12 @@ static int parse_and_validate_options(int argc, const char *argv[],
>>       if (all && argc > 0)
>>               die(_("Paths with -a does not make sense."));
>>
>> -     if (status_format != STATUS_FORMAT_DEFAULT)
>> +     if (verbose && !include_status) {
>> +             include_status = 1;
>> +             status_format = STATUS_FORMAT_NONE;
>> +     }
>> +
>> +     if (status_format != STATUS_FORMAT_DEFAULT && !verbose)
>>               dry_run = 1;
>
> What happens here when there is an alternate status format _and_
> --verbose is used? If I say "git commit --porcelain" it should imply
> --dry-run. But "git commit --porcelain --verbose" no longer does so
> after your patch.

I should have just left the --dry-run inference alone, like this.

-->8--

@@ -1141,7 +1146,12 @@ static int parse_and_validate_options
        if (all && argc > 0)
                die(_("Paths with -a does not make sense."));

-       if (status_format != STATUS_FORMAT_DEFAULT)
+       if (verbose && !include_status) {
+               include_status = 1;
+               status_format = STATUS_FORMAT_NONE;
+       } else if (status_format != STATUS_FORMAT_DEFAULT)
                dry_run = 1;

        return argc;
