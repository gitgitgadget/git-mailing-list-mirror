From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 2/2] worktree: add 'list' command
Date: Mon, 24 Aug 2015 21:07:43 -0400
Message-ID: <CAPig+cRQ0bwhx9dB=j6VWY4EieJ6Emzqru9Wmwy=4tAFRt6Otg@mail.gmail.com>
References: <1440280294-50679-1-git-send-email-rappazzo@gmail.com>
	<1440280294-50679-3-git-send-email-rappazzo@gmail.com>
	<xmqqpp2c4l5u.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Rappazzo <rappazzo@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 03:07:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZU2iM-0008G8-IF
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 03:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbbHYBHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 21:07:45 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:36740 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbbHYBHo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 21:07:44 -0400
Received: by ykfw73 with SMTP id w73so140816219ykf.3
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 18:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xeLqJ/BLiJkPbw0X8jgXgB0NRZjvRmPNQplkepgKNrI=;
        b=bxPmr/410bUxGrMR+xac/bWh4CNmaEEbfuttJVk4LA+Py5L9o0QFJ5q8tmfkVEx0J1
         JG0AB0C2d/hCLEXzo7GjqG/u9CydFG7iz0iYT0rGrg7spSyHgLzaztC41ccyGGqP2zzJ
         FiIOZFPtoPA0TXnNeUgiUXF0X6VXUoxvihqfJYWbJ+w2qvFhpQzSKs2EkgsNtflvKLzZ
         271+wOaC/08r0y446yZfT8W+9erHZw2FB2gFtyOzAh0jiGPDAtqF8PagQZhE9hN5RVcA
         Lc1GCXDh3iQeBpKML30lIaX4bCUw1qdnSgGnXFrB/RZFaPQyI+MCoQkAA6cs8xGGsGl6
         qz8g==
X-Received: by 10.129.83.136 with SMTP id h130mr34216032ywb.95.1440464864007;
 Mon, 24 Aug 2015 18:07:44 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Mon, 24 Aug 2015 18:07:43 -0700 (PDT)
In-Reply-To: <xmqqpp2c4l5u.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: rLdMeAK7fz1TsduzkoZG-BvKkYw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276501>

On Mon, Aug 24, 2015 at 2:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Rappazzo <rappazzo@gmail.com> writes:
>> +             strbuf_strip_suffix(&head_ref, "\n");
>> +
>> +             if (starts_with(head_ref.buf, ref_prefix)) {
>> +                     /* branch checked out */
>> +                     strbuf_remove(&head_ref, 0, strlen(ref_prefix));
>> +             /* } else {
>> +              *  headless -- no-op
>> +              */
>> +             }
>> +             printf("%s  (%s)\n", path, head_ref.buf);
>
> Is this new command meant to be a Porcelain?  This would not work as
> a plumbing that produces a machine-parseable stable output.
>
> I am not saying that it _should_; I do not know if we even need a
> 'list' command that is driven from an end-user script that gives
> anything more than "where the work trees are".
>
> My inclination is to suggest dropping the "which branch" code
> altogether and only give "path_only" behaviour.

The "which branch" was probably added in response to this [1] review,
which suggested that at some point, we might want to provide the user
with interesting information about each worktree, such as
branch/detached head, tag, locked status (plus lock reason and whether
currently accessible), prune-able status (plus reason). This could
optionally be controlled by --verbose or some other extended
formatting option.

The same review also suggested a --porcelain option for script writers.

[1]: http://article.gmane.org/gmane.comp.version-control.git/275528
