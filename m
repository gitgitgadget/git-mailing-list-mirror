From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 00/12] Pulling signed/annotated tags
Date: Mon, 7 Nov 2011 21:31:05 -0800
Message-ID: <CA+55aFyEuuT25m00uakL66YKSpT-zjoiBreymFSbuHmtARq6yw@mail.gmail.com>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
 <1320721245-13223-1-git-send-email-gitster@pobox.com> <CA+55aFxVsgNjGv2zAGR1VK34uG59+euJec_3i9JNyQ0VUdjyeA@mail.gmail.com>
 <7vsjlzyza7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 06:31:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNeHW-0007N5-8B
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 06:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281Ab1KHFb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 00:31:28 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45066 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957Ab1KHFb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 00:31:28 -0500
Received: by wyh15 with SMTP id 15so108055wyh.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 21:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=9djK9atReE9cILzAMgWdOiHHGdcawakurHE0NQJHCRs=;
        b=PtJcfiT0YbpZjNwYFYJRo/5FmIsC2y3IRXbAyli+1PY3XtrYPDUXUke41M7/h/eeQN
         d/MJ3nTqRw+H8E+DDX/7S6eKYP2YlpO0HaHFcYctBYwRVbZZKTe/lpu14dVWhm9AvYZs
         hIACueff/XA69jM6xyW5lkrhpuLUsaOIq73vk=
Received: by 10.216.230.137 with SMTP id j9mr2477892weq.112.1320730287091;
 Mon, 07 Nov 2011 21:31:27 -0800 (PST)
Received: by 10.216.166.3 with HTTP; Mon, 7 Nov 2011 21:31:05 -0800 (PST)
In-Reply-To: <7vsjlzyza7.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: q8_1PzE1C3g7I1iubGYqVHE8vus
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185066>

On Mon, Nov 7, 2011 at 9:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Eek.
>
> The mergetag stuff is a dump of "cat-file tag" so if you have a line that
> begins with "object " the parsing side (which does not exist yet) would
> have trouble. We would need to devise e.g. adding number of lines at the
> beginning, or something.

Might I suggest making it simpler still to parse?

Change "strbuf_add_lines()" to have two *different* prefixes: one for
the first line, and one for "continuation lines".

Then you can just use the same prefix if you want to - and get the
semantics you have now for that helper.

But instead of just having "mergetag" as the prefix for all the lines
copied from the merge, wouldn't it be nice and easy to have "mergetag"
as the prefix for the *first* line of each copied tag, but then have
some other tag for lines 2..n?

I think that would be *way* easier to parse, and I think something
like that could be a good generic model for any multi-line thing -
have the first line tagged, and the rest have just the continuation
marker. You don't really need to repeat the tag over and over again
each line, it just causes ambiguoity as shown by this example.

But I don't have any really strong opinions on it. I just think it's a
good idea to make it easy to parse both mechanically and
human-visually, and "number of lines" doesn't strike me as being very
human-friendly.

         Linus
