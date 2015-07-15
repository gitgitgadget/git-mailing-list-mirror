From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log fails to show all changes for a file
Date: Wed, 15 Jul 2015 11:17:50 -0700
Message-ID: <xmqqtwt5wai9.fsf@gitster.dls.corp.google.com>
References: <20150714073035.GA22707@aepfle.de>
	<20150714074508.GE1451@serenity.lan>
	<20150714075955.GA24577@aepfle.de>
	<CA+55aFzPvwAghGtA-WH8i1PcNe55XORokaXF9hNu7OUXBx++6Q@mail.gmail.com>
	<xmqq8uahxu3e.fsf@gitster.dls.corp.google.com>
	<CA+55aFy8urE+0w7mfgywcAnyoUu+6LMz-GGaOrUQYJ59gT9FfA@mail.gmail.com>
	<xmqqy4ihwbdr.fsf@gitster.dls.corp.google.com>
	<CA+55aFw=PJtc7jXLUx+tJhAeVO3vpQjsd+oYW+OwCU20_Qft-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Olaf Hering <olaf@aepfle.de>, John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 15 20:17:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFRFl-00033D-3D
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jul 2015 20:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbbGOSRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2015 14:17:52 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33317 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbbGOSRw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 14:17:52 -0400
Received: by ietj16 with SMTP id j16so39665213iet.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2015 11:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=id/sxfSEcob0jWl2QioiKo/M43gZn9q35j1vWBDe9Zo=;
        b=Re4+OkWSZGUQqMQXrPCktIP42m2R5BaqMgB9dlchg0yERyPbHfF4F49Ewxw7dApLdC
         raLryW5RiapIm45YE4D7J0rpnHw0qIqlcnwtoRa9u6QiGaIrAfEzkqVJDLCoLEZM9zqy
         qMxOuq+cUthkFQy3E65yIs98pFI0clzcadmfgekLujwb+Ld90IiV1+qhuDoO7pFonlZi
         KQKOe2zYJT6aiZ2mv63kkiXJGwVfzqav2HUZCEPROEPgjlvsfYeb7PY0R42ALvcQvfn5
         dwqFFnuWbTGMEmD75OAeM6TBjL6l7gExNOQKXDKEF+NjBvI8O8cLVN2gc8QS7yRjPyHx
         Govw==
X-Received: by 10.50.3.6 with SMTP id 6mr25652820igy.28.1436984271626;
        Wed, 15 Jul 2015 11:17:51 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91d4:b530:378d:909b])
        by smtp.gmail.com with ESMTPSA id q187sm3267577ioe.37.2015.07.15.11.17.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 15 Jul 2015 11:17:51 -0700 (PDT)
In-Reply-To: <CA+55aFw=PJtc7jXLUx+tJhAeVO3vpQjsd+oYW+OwCU20_Qft-w@mail.gmail.com>
	(Linus Torvalds's message of "Wed, 15 Jul 2015 11:11:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273992>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Jul 15, 2015 at 10:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>  * When '-p' is given, we show only diff with first-parent by
>>    default, regardless of the traversal (i.e. --first-parent option
>>    currently controls both traversal and patch display, but in the
>>    new world order, it reverts back to purely a traversal option).
>
> So this is a suggested change to "-p -m" behavior?

Not really.  This is a suggested behaviour for "git log -p"; I
wasn't very enthused by the idea to turn --cc when user said -p
without telling them what we are doing.  In other words, if the
users want combined, they should say --cc (and they will get a
single-parent patch for non-merges with --cc) so there is no reason
not to do this, as long as we fix --cc so that "git log --cc"
implies "git log --cc -p".

> Yes, that sounds sane. The current "-p -m" behavior is not useful at all.
>
> So if I understand rightly, we'd have:
>
>  "-p" would be what is currently  "-p --cc"

Not really.

>  "-p -m" would be what is currently "-p --first-parent"

Not really.  I was dropping "-m" entirely with "we could do -p -m2
but I do not think we should bother".

>  "-p --no-show-merge-diffs" would be what is currently "-p"

Yes.

> and the rationale would be that
>
>  (a) the current "-p" is hiding things, and while you can add "--cc",
> that requires that you really understand what is being hidden, which
> is a bad default (the complaint that started this discussion)
>
>  (b) the current "-p -m" is useless crazy stuff, and you'd rather use
> it for something that you actually find very common and useful
>
> If so, I agree entirely.
>
>               Linus
