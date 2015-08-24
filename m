From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Mon, 24 Aug 2015 11:53:47 -0700
Message-ID: <xmqq8u904ix0.fsf@gitster.dls.corp.google.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<xmqqy4h04mx4.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZRYWNVmMeMCZSa+GcOTQ7NzuVB9RH_TFJ6-u7aFhrU=NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 20:54:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTwsT-0005fx-UN
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 20:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbbHXSxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 14:53:51 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34359 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbbHXSxt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 14:53:49 -0400
Received: by pabzx8 with SMTP id zx8so12590654pab.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 11:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=sbx40DdGNPldLSzqVNwqWmJkGSvI9JpssSM32s7tNm0=;
        b=ZMhMuJHdLr3qQkbtFYOxPt5tWiEeHAXfuGrxz5ozPZ/LDGReBpEzCT4jHeWOm6pOY7
         vUcKmeIRphpGb6DKohVQ3qUyGmUetg0V9SMqyY1PWCARXAwYwFPhtuhntJ4YCwHpVcq7
         K085ak/2DisoEPQsEn3UsbcysSjUzJIuLv8fKz+p8xIUhXHs9S9yhvFkzxbS6CvaZPjv
         y9YLJMagOgUlUAgPuyuKLwcYo2EkxkwiPFP4x2uGIoZ3InaIi3ut5uYVg18fXe9Fh0/5
         UCbZ7jyWNU+Jdpyg9i+6qXkOfXUOzc4HdUJF6wTN/M6iGsc6itA2s+8oXc7yN5EIGL0g
         MLmw==
X-Received: by 10.68.117.142 with SMTP id ke14mr48748351pbb.93.1440442429206;
        Mon, 24 Aug 2015 11:53:49 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id cn1sm18241234pdb.91.2015.08.24.11.53.47
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 11:53:48 -0700 (PDT)
In-Reply-To: <CAOLa=ZRYWNVmMeMCZSa+GcOTQ7NzuVB9RH_TFJ6-u7aFhrU=NA@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 24 Aug 2015 23:39:06 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276478>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Mon, Aug 24, 2015 at 10:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>> ...
>>> +     performed. If used with '--quote' everything in between %(align:..)
>>> +     and %(end) is quoted.
> ...
> I might have misunderstood you, But based on the discussion held here
> (thread.gmane.org/gmane.comp.version-control.git/276140)
> I thought we wanted everything inside the %(align) .... %(end) atoms
> to be quoted.

Perhaps I misunderstood your intention in the doc.
	
I took "everything in between %(align:...) and %(end) is quoted" to
mean that

	%(if:empty)%(align)%(end)%(then)Empty%(else)Not Empty%(end)

can never satisfy %(if:empty), because %(align)%(end) would expand
to a string that has two single-quotes, that is not an empty string.

If that is not what would happen in the "branch --list" enhancement,
then the proposed behaviour is good, but the above documentation would
need to be updated when it happens, I think.  It at least is misleading.

Thanks.
