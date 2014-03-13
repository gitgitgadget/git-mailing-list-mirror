From: Quint Guvernator <quintus.public@gmail.com>
Subject: Re: [PATCH] general style: replaces memcmp() with proper starts_with()
Date: Wed, 12 Mar 2014 23:33:50 -0400
Message-ID: <CALs4jVHTBH3wTAQsv8+jb15Do1_oy0pcThsDL8ssE7fgrx5NxA@mail.gmail.com>
References: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>
 <20140312175624.GA7982@sigill.intra.peff.net> <xmqqiorjky0a.fsf@gitster.dls.corp.google.com>
 <20140312194943.GA2912@sigill.intra.peff.net> <xmqq61njkwnw.fsf@gitster.dls.corp.google.com>
 <20140312211415.GA10305@sigill.intra.peff.net> <20140312220640.GA14802@sigill.intra.peff.net>
 <xmqqd2hrjb4d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 04:34:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNwPQ-0000KL-NR
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 04:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbaCMDeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 23:34:12 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37986 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbaCMDeL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 23:34:11 -0400
Received: by mail-wi0-f179.google.com with SMTP id f8so525127wiw.6
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 20:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ngUwk3EyoChYO695byuY2C1hBs49tatbiNzucCxMeYY=;
        b=rFuwxYxqMrNlP7+g9/j4hBZUH8E6JIQez3FjjRQN+C25o/f/0nQLxe4AlJbzOgrCCa
         uyaaRhuRFlNr8VtASjRQnkB137+tmXWEQEFaEiFJ++ezCduO8eVAX8W2EEd6KXukpup0
         uD5u0vnr5ciPq4YzZjBPLPDxsiWJQCCgPtudHAFDiuSe0LOoHt50FQ9Xl0eNSD6TMhoo
         tG9jrCgWp28QaX+Bdv8v6EQF/MOVLshIQtdhkpW9ZfAWMz+5PIC3TWktExygRbY6iBMV
         MSwm60KANMZNN4Q8tIoQ5ns1OfC8WdsSc5B66XTENvU2AVNZ6c4+CLQeRJ6zWu4S8rmn
         graw==
X-Received: by 10.180.109.231 with SMTP id hv7mr762443wib.38.1394681650477;
 Wed, 12 Mar 2014 20:34:10 -0700 (PDT)
Received: by 10.216.231.138 with HTTP; Wed, 12 Mar 2014 20:33:50 -0700 (PDT)
In-Reply-To: <xmqqd2hrjb4d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244017>

>From what I can gather, there seems to be opposition to specific
pieces of this patch.

The following area is clearly the most controversial:

>  static inline int standard_header_field(const char *field, size_t len)
>  {
> -    return ((len == 4 && !memcmp(field, "tree ", 5)) ||
> -            (len == 6 && !memcmp(field, "parent ", 7)) ||
> -            (len == 6 && !memcmp(field, "author ", 7)) ||
> -            (len == 9 && !memcmp(field, "committer ", 10)) ||
> -            (len == 8 && !memcmp(field, "encoding ", 9)));
> +    return ((len == 4 && starts_with(field, "tree ")) ||
> +            (len == 6 && starts_with(field, "parent ")) ||
> +            (len == 6 && starts_with(field, "author ")) ||
> +            (len == 9 && starts_with(field, "committer ")) ||
> +            (len == 8 && starts_with(field, "encoding ")));

I am happy to submit a version of this patch excluding this section
(and/or others), but it seems I've stumbled into a more fundamental
conversation about the place for helper functions in general (and
about refactoring skip_prefix()). I am working on this particular
change as a microproject, #14 on the list [1], and am not as familiar
with the conventions of the Git codebase as many of you on this list
are.

Junio said:

> The result after the conversion, however, still have the same magic
> numbers, but one less of them each.  Doesn't it make it harder to
> later spot the patterns to come up with a better abstraction that
> does not rely on the magic number?

It is _not_ my goal to make the code harder to maintain down the road.
So, at this point, which hunks (if any) are worth patching?

Quint


[1]: http://git.github.io/SoC-2014-Microprojects.html
