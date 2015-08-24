From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Mon, 24 Aug 2015 15:35:57 -0700
Message-ID: <xmqq37z82u2a.fsf@gitster.dls.corp.google.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<xmqqy4h04mx4.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZRYWNVmMeMCZSa+GcOTQ7NzuVB9RH_TFJ6-u7aFhrU=NA@mail.gmail.com>
	<xmqq8u904ix0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 00:36:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZU0LV-0008L9-4H
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 00:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbbHXWgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 18:36:00 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36371 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754275AbbHXWf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 18:35:59 -0400
Received: by pdbmi9 with SMTP id mi9so58249814pdb.3
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 15:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=jTFjnm6enhkBSfXHzH9liK2OSk6rZ/KnjZEgYvURk+Q=;
        b=vezeuc+yOR21evs6Tlp/MiQUS/ou2hWwXgU+Kl2JvwpzHt9S4EV2akYCDkye0XQ7LC
         mNA81Lm8oKL1Cb1+cTAo+eTFYW9Po67KDhzEGmo1frFxRGs0gVubCY3H6uW+WtUFLIMY
         TVS6FZWlgKz26y2aF6BpyVy1IK8o+Bu0JULx22HZ/OQMPeycjUhrVucV/IVm90DdY8dE
         +I1a1vDrZnLcT1SMOMdrwocv833gXfxBWTH13Yso7J12vLjoFryOe/6MIfJCqQ1dKv5h
         59LvLjIZS/iI2BYsGJtfFS2AViouyMFHQJbtHwEdZdM7vdyUToMaIA3LulNcwHqgP5FE
         2tyQ==
X-Received: by 10.70.9.225 with SMTP id d1mr50060487pdb.127.1440455758538;
        Mon, 24 Aug 2015 15:35:58 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id bz1sm18507532pbb.85.2015.08.24.15.35.57
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 15:35:57 -0700 (PDT)
In-Reply-To: <xmqq8u904ix0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 24 Aug 2015 11:53:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276495>

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Mon, Aug 24, 2015 at 10:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>> ...
>>>> +     performed. If used with '--quote' everything in between %(align:..)
>>>> +     and %(end) is quoted.
>> ...
>> I might have misunderstood you, But based on the discussion held here
>> (thread.gmane.org/gmane.comp.version-control.git/276140)
>> I thought we wanted everything inside the %(align) .... %(end) atoms
>> to be quoted.
>
> Perhaps I misunderstood your intention in the doc.
> 	
> I took "everything in between %(align:...) and %(end) is quoted" to
> mean that
>
> 	%(if:empty)%(align)%(end)%(then)Empty%(else)Not Empty%(end)
>
> can never satisfy %(if:empty), because %(align)%(end) would expand
> to a string that has two single-quotes, that is not an empty string.
>
> If that is not what would happen in the "branch --list" enhancement,
> then the proposed behaviour is good, but the above documentation would
> need to be updated when it happens, I think.  It at least is misleading.

OK, now I checked the code, and I _think_ the recursive logic is
doing the right thing (modulo minor nits on comment-vs-code
discrepancy and code structure I sent separately).
