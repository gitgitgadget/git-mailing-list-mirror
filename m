From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 1/2] worktree: add 'for_each_worktree' function
Date: Mon, 31 Aug 2015 15:03:05 -0400
Message-ID: <CAPig+cTwtKgm4U64nZhRY+F5HuQvKk1RLdyAsS6sJfYp85go2A@mail.gmail.com>
References: <1440961839-40575-1-git-send-email-rappazzo@gmail.com>
	<1440961839-40575-2-git-send-email-rappazzo@gmail.com>
	<CAPig+cTHZrQn8LpfftcsAQhFAykgDorbR97tkcuSCFYD_ngs9g@mail.gmail.com>
	<1441046674.25570.15.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Rappazzo <rappazzo@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 21:03:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWUML-00050i-I7
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 21:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbbHaTDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 15:03:08 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34603 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbbHaTDH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 15:03:07 -0400
Received: by qkct7 with SMTP id t7so11892942qkc.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 12:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=clfDXRUq9MLY1EmQEPJuRn3/5KJtSLDyXxQuWqerUAo=;
        b=FLH+J2JQpLjcxisnwNedId01TSlk10kYoFm+FazJLguTEvv5F5/tIezIBTBhAxtcKK
         VFUoV0FDjcga0H+lnpQefl6PvEl8HWnjsV3TgENPn2/wbOGaD6phmJGPA1cGrcPhjQUV
         xvO/DAdlL41pS14N914E/ygqkam6V2hGRCyrW32T69mTpjB6WIF/zl+cxton39mWVCMQ
         w1h2QTel6t+invk5lq7S1CVbfDH5Yi9X8KZ4JNUXPorh7JDWI9A61K8939818YGPBN9o
         K0DKEQOtPW04nYMjzx53VZEKont/pHo+C/tChs4omi08wRtdjRhXufkz9vx1nn91bsDQ
         VO/A==
X-Received: by 10.129.134.3 with SMTP id w3mr22254568ywf.48.1441047785749;
 Mon, 31 Aug 2015 12:03:05 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Mon, 31 Aug 2015 12:03:05 -0700 (PDT)
In-Reply-To: <1441046674.25570.15.camel@twopensource.com>
X-Google-Sender-Auth: j4aAr4T128l_PIGY_EU0JczTaHM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276915>

On Mon, Aug 31, 2015 at 2:44 PM, David Turner <dturner@twopensource.com> wrote:
> On Mon, 2015-08-31 at 01:11 -0400, Eric Sunshine wrote:
>> Stepping back a bit, is a for-each-foo()-style interface desirable?
>> This sort of interface imposes a good deal of complexity on callers,
>> demanding a callback function and callback data (cb_data), and is
>> generally (at least in C) more difficult to reason about than other
>> simpler interfaces. Is such complexity warranted?
>>
>> An alternate, much simpler interface would be to have a function, say
>> get_worktrees(), return an array of 'worktree' structures to the
>> caller, which the caller would iterate over (which is a common
>> operation in C, thus easily reasoned about).
>>
>> The one benefit of a for-each-foo()-style interface is that it's
>> possible to "exit early", thus avoiding the cost of interrogating
>> meta-data for worktrees in which the caller is not interested,
>> however, it seems unlikely that there will be so many worktrees linked
>> to a repository for this early exit to translate into any real
>> savings.
>
> The other benefit is that there is no need to worry about deallocating
> the list.  But that might be too minor to worry about.

Probably. The burden of having to deallocate the returned array seems
quite minor compared to the complexity of the callback function
approach.

Also, unstated but implied with the suggestion of a get_worktrees()
function was that there would be a corresponding free_worktrees()
function to make cleanup easy.
