From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: send-pack does not respect http.signingkey
Date: Thu, 16 Jul 2015 14:10:23 -0700
Message-ID: <xmqq8uaf4xmo.fsf@gitster.dls.corp.google.com>
References: <CAD0k6qQ=ovEBZn_wje-exBhvW8brRbTgULDr68rmeiw-ZdsozQ@mail.gmail.com>
	<xmqqlhef50kz.fsf@gitster.dls.corp.google.com>
	<CAD0k6qS_uQk5KZVJYA7BVZ9sRPRj=cZ3rbYRfJ3vhgSh2drEMA@mail.gmail.com>
	<xmqqh9p350ad.fsf@gitster.dls.corp.google.com>
	<CAD0k6qSZtZN60ExQQfH0mq_rZrOA4Fw0ZeWfX_gr=2btbSYHQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 23:10:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFqQK-0001st-7S
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 23:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755959AbbGPVK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 17:10:28 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34139 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbbGPVK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 17:10:27 -0400
Received: by pactm7 with SMTP id tm7so5283092pac.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 14:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=BwiUkWfcTbBI7uxHRBEUkX4z8TpI6oS/KXiZ9+0Wyok=;
        b=clS7bt9frtRquqCMFVRGC61UFavYN6hupP1lsW06SAYU+r6eyD7US/if6e5Ez7dFpT
         kIMsxQzMSMeiegAl1aw//ho1neOn4UoyCHjKhxhPfUlpR2kpSR+yzeVHYAEedlXUSvED
         NZM73s2B84/GwgbXNz8fQPKCEinC9idjNXsG7hU/xXqV/R2jIwEDYt7l4hADsNB9HJ+K
         ORkN9Z0X6Vb7jI1qoi+4oUEfwBALpDqGE1r9IWme6o13fFTx5fCjMbcgk7FkOemHzcBm
         Y3u6p9T7SqeN0GPzPNgraxoJECjFcHQvB/KTT+zNp8isJ9Mci+YCUoNU2RIoUCTYJ4hh
         rU1A==
X-Received: by 10.67.5.2 with SMTP id ci2mr22143216pad.97.1437081027058;
        Thu, 16 Jul 2015 14:10:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:117b:74b0:a5d4:7d4c])
        by smtp.gmail.com with ESMTPSA id j4sm8902890pdo.62.2015.07.16.14.10.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 Jul 2015 14:10:26 -0700 (PDT)
In-Reply-To: <CAD0k6qSZtZN60ExQQfH0mq_rZrOA4Fw0ZeWfX_gr=2btbSYHQw@mail.gmail.com>
	(Dave Borowitz's message of "Thu, 16 Jul 2015 13:31:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274045>

Dave Borowitz <dborowitz@google.com> writes:

> On Thu, Jul 16, 2015 at 1:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Dave Borowitz <dborowitz@google.com> writes:
>>
>>> On Thu, Jul 16, 2015 at 1:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>>> Perhaps something like this?
>>>
>>> Seems like it should work.
>>>
>>> Jonathan had suggested there might be some principled reason why
>>> send-pack does not respect config options, and suggested passing it in
>>> as a flag. But that would be more work, certainly, as it would also
>>> have to get passed through git-remote-http somehow.
>>
>> I actually was wondering about exactly the same thing as Jonathan,
>> and that is where my "Perhaps" came from.
>
> I will say, though, as the maintainer of a handful of custom remote
> helpers, I would prefer a solution that does not involve changing the
> implementation of those just to pass this configuration through. 

That is not a controversial part ;-)

> So my
> vote would be for send-pack to respect the normal config options.

The thing is what should be included in the "normal" config options.

The "something like this?" patch was deliberately narrow, including
only the GPG thing and nothing else.  But anticipating that the ref
backend would be per repo configuration, and send-pack would want to
read from refs (and possibly write back tracking?), we may want to
prepare ourselves by reading a bit wider than "GPG thing and nothing
else", e.g. git_default_config() or something like that.
