From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] diff: Fix rename pretty-print when suffix and prefix overlap
Date: Mon, 25 Feb 2013 20:50:24 +0100
Message-ID: <CALWbr2yviqF68zF7mBbhaXW7oFar0YRqROBWXwqjo7UNgZNVBQ@mail.gmail.com>
References: <1361638125-11245-1-git-send-email-apelisse@gmail.com>
	<7vzjyu3we1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:50:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA44Y-00057d-EI
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 20:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758612Ab3BYTuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 14:50:25 -0500
Received: from mail-qa0-f43.google.com ([209.85.216.43]:38603 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631Ab3BYTuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 14:50:25 -0500
Received: by mail-qa0-f43.google.com with SMTP id dx4so1833245qab.2
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 11:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=oafYwtasWxtU9ZXR3kV8ZB0VxHAlrOHp/i5kfEYffKI=;
        b=AC7ljaP+49Uh/TEB1Yx063EWqVK2vembkP8Ubx+CAEv/g6FltXvQYGp34nAEkJ4ibb
         6SlBZKwHtacGOFHTaq4UV1sJKs45KUrbY+/E2K55g5AaDQjSjLnFwriVOV3HfBPs2/aB
         sK7UxK6oYF2luNGcnaNh/9ns+Ud34jt3gLX1emaDMQktN6BEJAlTkbVJDdUOAK9JCOjm
         hHnSOM7I7zfkZqFcXqDg3zGNW/IsSbivcd4SVnJlQ2fFAeMm/MMmAzx2Cj/Nl7oaVDTO
         blfVMLR22YFpyLDjUJlMcdBhcUWM7rpzoYWm7/xrHc+uGWg1PqbbxBg6FYX92PU0HToj
         tzaw==
X-Received: by 10.224.180.15 with SMTP id bs15mr13046965qab.24.1361821824182;
 Mon, 25 Feb 2013 11:50:24 -0800 (PST)
Received: by 10.49.70.163 with HTTP; Mon, 25 Feb 2013 11:50:24 -0800 (PST)
In-Reply-To: <7vzjyu3we1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217098>

On Sun, Feb 24, 2013 at 10:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> When considering a rename for two files that have a suffix and a prefix
>> that can overlap, a confusing line is shown. As an example, renaming
>> "a/b/b/c" to "a/b/c" shows "a/b/{ => }/b/c".
>
> This would be vastly more readable if it had "It should show XXX
> instead" somewhere in the description, perhaps at the end of this
> sentence.  It can also be after "thus the { => }" below, but I think
> giving the expected output earlier would be more appropriate.

Good catch, this would probably be better:

    When considering a rename for two files that have a suffix and a prefix
    that can overlap, a confusing line is shown. As an example, renaming
    "a/b/b/c" to "a/b/c" shows "a/b/{ => }/b/c", instead of "a/b/{ => b}/c"

>> Currently, what we do is calculate the common prefix ("a/b/"), and the
>> common suffix ("/b/c"), but the same "/b/" is actually counted both in
>> prefix and suffix. Then when calculating the size of the non-common part,
>> we end-up with a negative value which is reset to 0, thus the "{ => }".
>
> In this example, the common prefix would be "a/b/" and the common
> suffix that does not overlap with the prefix part would be "/c", so
> I am imagining that "a/b/{ => b}/c" would be the desired output?

Yes, at least that's what I expected.

> This is a really old thinko (dating back to June 2005).  I'll queue
> the patch on maint-1.7.6 (because 1.7.6.6 is slightly more than one
> year old while 1.7.5.4 is a lot older) to allow distros that issue
> incremental fixes on top of ancient versions of Git to pick up the
> fix if they wanted to.  Perhaps we would want to add a few tests?

I can easily understand why that was missed.
I will try to resubmit with tests very soon.
