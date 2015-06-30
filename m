From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 6/7] git-reflog: add create and exists functions
Date: Tue, 30 Jun 2015 14:28:05 -0700
Message-ID: <xmqqy4j0c2e2.fsf@gitster.dls.corp.google.com>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
	<1435609076-8592-7-git-send-email-dturner@twopensource.com>
	<CAPig+cROJJNTcZnZfMP0meA8ZWGcSHcQCMTCkuC+kn_+OQZ-zA@mail.gmail.com>
	<xmqqbnfx89iz.fsf@gitster.dls.corp.google.com>
	<CAPig+cQ7tQV6uG0sVMsPJX=8V3g+zufRCYcdfDo4ixwwUp5hZA@mail.gmail.com>
	<xmqq3819c6ze.fsf@gitster.dls.corp.google.com>
	<1435699146.30953.7.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 23:28:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZA34h-0004xg-EG
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 23:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbbF3V2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 17:28:11 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35123 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbbF3V2I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 17:28:08 -0400
Received: by igblr2 with SMTP id lr2so84637114igb.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 14:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ytRnG2P0bgRyPxIrTphBh2N9ewoJ4VBN/XtWPHUwnOw=;
        b=OEPuK5Ww+dadjGzEi5Gbk7wlGpNCVhSTA1qY/CUsoS/cq88JDpa6x3M2pHGZ1bgW6G
         HcEmsRI7Q1yrir684LqzJL2jlhVoKn9iREFVIJXO3/6myW28XUX7T+WiWl5XDBAh9m2C
         UyOB516ksCzfHzoaZxj6LdzZk20UQ9hGxG2Wjk1YjNbgHndG7J1GxNJgRrxLGLHCGTG5
         h2PgtgCXrt1te6Q+yVrlgym/uczYg5CQUyqoiF77PXaMyNnXi0jwJQcUcVluOIx/rwoz
         SoFSiENEHanQBe42fg0LMMMoao3ZPfOTZ9kOKGZgyJ/EqOWUx2aatzRN/7MNV8tk9jrT
         Jj5Q==
X-Received: by 10.42.170.74 with SMTP id e10mr26655120icz.71.1435699687528;
        Tue, 30 Jun 2015 14:28:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id 196sm30905858ioe.23.2015.06.30.14.28.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 14:28:06 -0700 (PDT)
In-Reply-To: <1435699146.30953.7.camel@twopensource.com> (David Turner's
	message of "Tue, 30 Jun 2015 17:19:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273105>

David Turner <dturner@twopensource.com> writes:

> On Tue, 2015-06-30 at 12:48 -0700, Junio C Hamano wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> 
>> >>> Alternatives would be strbuf_reset() or declaring and releasing the
>> >>> strbuf within the for-loop scope.
>> >>
>> >> Because _reset() just rewinds the .len pointer without deallocating,
>> >> you would need an extra _release() before it goes out of scope. If
>> >> it is expected that the strbuf will be reused for a number of times,
>> >> the length of the string each iteration uses is similar, and you
>> >> will iterate the loop many times, "_reset() each time and _release()
>> >> to clean-up" pattern would save many calls to realloc/free.
>> >
>> > Yep, that's why I suggested strbuf_reset() as an alternative (and
>> > likely would have chosen it myself).
>> 
>> OK, then let's do that by squashing this in.
>> 
>>  builtin/reflog.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> I squashed that into my repo on github:

I'm already deep into today's integration cycle, so it is unlikely
I'd pull that before I push the result out.  Please let me know if
the resulting tree looks wrong (I only queued it to be squashed,
haven't done the squashing two into one yet).

Thanks.  The 7-patch series with this fixup looks good to me.
