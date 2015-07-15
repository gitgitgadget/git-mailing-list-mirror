From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log fails to show all changes for a file
Date: Wed, 15 Jul 2015 12:22:32 -0700
Message-ID: <xmqqpp3tw7if.fsf@gitster.dls.corp.google.com>
References: <20150714073035.GA22707@aepfle.de>
	<20150714074508.GE1451@serenity.lan>
	<20150714075955.GA24577@aepfle.de>
	<CA+55aFzPvwAghGtA-WH8i1PcNe55XORokaXF9hNu7OUXBx++6Q@mail.gmail.com>
	<xmqq8uahxu3e.fsf@gitster.dls.corp.google.com>
	<CA+55aFy8urE+0w7mfgywcAnyoUu+6LMz-GGaOrUQYJ59gT9FfA@mail.gmail.com>
	<xmqqy4ihwbdr.fsf@gitster.dls.corp.google.com>
	<CA+55aFw=PJtc7jXLUx+tJhAeVO3vpQjsd+oYW+OwCU20_Qft-w@mail.gmail.com>
	<xmqqtwt5wai9.fsf@gitster.dls.corp.google.com>
	<20150715185717.GA11146@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Olaf Hering <olaf@aepfle.de>,
	John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 15 21:22:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFSGO-0006HZ-TQ
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jul 2015 21:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbbGOTWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2015 15:22:36 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37936 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279AbbGOTWg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 15:22:36 -0400
Received: by iggf3 with SMTP id f3so44082987igg.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2015 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=pTe1TmCJQx7kowVRDnkmID00/nmIyjrEU01Ic3YyzRg=;
        b=i/QtzkZQMT/2j1HP6+THjk4hbi+/Fj4tx708+rw3K/vk8RaEDnl5EimG03OVhs9rN4
         WQ+k9fyYfrqcGgYsXof/V7Cgr7fY+PbqL76f1UWG3DdMviTsek+KMQYmtKkUZ6Na117T
         K0GHGfToRd/Wf3D3q4NoHEF7F2MUj7b2vlyLyTsXcAwd32gJVdmcDIOCC+mztIBvvrI2
         JpDv9MGbSYzdx2wY0fIm/KG3pZgTV5RFlyDQhnSEgdwpU4KOh24zy0ykU4wlw4Ci7vgG
         +173yTl2w0q/kKAQGYb8qhTBakkXnUBP1/HmW29pUV8odqEunVPMV/gD9L3zAlc65L/M
         jFhQ==
X-Received: by 10.50.78.170 with SMTP id c10mr12674934igx.0.1436988155576;
        Wed, 15 Jul 2015 12:22:35 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91d4:b530:378d:909b])
        by smtp.gmail.com with ESMTPSA id j3sm3808734igx.21.2015.07.15.12.22.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 15 Jul 2015 12:22:33 -0700 (PDT)
In-Reply-To: <20150715185717.GA11146@peff.net> (Jeff King's message of "Wed,
	15 Jul 2015 11:57:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273995>

Jeff King <peff@peff.net> writes:

> On Wed, Jul 15, 2015 at 11:17:50AM -0700, Junio C Hamano wrote:
>
>> > So this is a suggested change to "-p -m" behavior?
>> 
>> Not really.  This is a suggested behaviour for "git log -p"; I
>> wasn't very enthused by the idea to turn --cc when user said -p
>> without telling them what we are doing.  In other words, if the
>> users want combined, they should say --cc (and they will get a
>> single-parent patch for non-merges with --cc) so there is no reason
>> not to do this, as long as we fix --cc so that "git log --cc"
>> implies "git log --cc -p".
>
> Like you, I frequently use "--first-parent -m". If I understand your
> proposal, a regular "git log" would have the first-parent-diff behavior
> of those options, but still traverse other parents.
>
> One oddity of that proposal is that the user ends up seeing any given
> change on a side-branch _twice_. Once in the original commit that
> introduced it, and once in the merge of the branch. And commit-selection
> tools like "git log -Ssome_code" will select both, too, and they'll see
> the merge commit along with the original. I can't decide if that's a
> good thing or not.

Hmm, you are right.  That may be a problem, and Linus's makes tons
of practical sense (especially for us experienced Git users).

It just is that '-p', that clearly stands for 'patch' but does more
than 'patch' to produce something that cannot be fed to 'apply' by
defaulting to '--cc', makes me hesitate.  By making it a lot more
convenient for experienced people who understand these issues, I
have this suspicion that it would make the options less orthgonal
and harder to explain to new people.
