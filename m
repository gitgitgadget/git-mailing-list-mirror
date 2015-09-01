From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v14 04/13] ref-filter: implement an `align` atom
Date: Tue, 1 Sep 2015 18:35:06 +0530
Message-ID: <CAOLa=ZQV63ZETPswEPYjSMrXcZAK+W-Jek+Psq7wtmSsQHtb3g@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
 <1440857537-13968-5-git-send-email-Karthik.188@gmail.com> <CAPig+cRHRPehkd+9PwOqpXkRUvaJa42zLtCKMEfv2W=ZJUZJzA@mail.gmail.com>
 <CAOLa=ZTHtps2gJb9asSzG_4NOwx_xiA7OuCzjW=BTTFfkaYoQg@mail.gmail.com>
 <CAPig+cQF=1FPFP_7Bn2m2J+ay5ZupG25USWc9LT9SqO1=VDZvg@mail.gmail.com>
 <CAOLa=ZS53BNNvnYv2TU6xQbEihi1GiKBaEEZ=KT6p_gDBR9Y9Q@mail.gmail.com>
 <CAPig+cRAYeF0ZDn5FsHioZr1g4pH3Ay69_3KDb8ZF1USZxzcEg@mail.gmail.com>
 <vpqpp235pvg.fsf@anie.imag.fr> <CAPig+cRig+zk=D1SDF7wBHuQgcQqb-4cHkmeVgLs5BaWzk9WRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 15:05:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWlFu-0006AS-Cx
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 15:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229AbbIANFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 09:05:37 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33053 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114AbbIANFg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 09:05:36 -0400
Received: by obcji4 with SMTP id ji4so23556891obc.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 06:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IZMQ1DQugdhs4ujQuXXO/IKkxsZnouAvD6dp70lMeFM=;
        b=tnlFdXLoV+QnoTOM9TnqwIbfqFtRSKPxTXAipJinhZTe0/vk7APn0MVblxFz5G/T10
         GHbKxDvEvRcLn4C2nqrEsfnE/6INcxSg7cg8XdO3UQawB/4l5wOjFSi7N9Lv4DNNFGyo
         Wx5lyD2KiL9hzAqo9RMqDzO3chxTurHXAPQTY5WtH3cKkevp103o8WUWMCkXVA/9RgQo
         jgY6Aoy+dWfgnxpzB9ZhdineIhpIw+LlueX6L7eF835YRVoH8aNRrkwAOo4HxsIjvQXq
         +MvHfHKwaOaUwP9g/k9XopsKSGaqYCB6l77chrVbF99Nx25xokXlqOCbee6OeHm3wYy0
         QWAA==
X-Received: by 10.60.92.199 with SMTP id co7mr11000566oeb.37.1441112736114;
 Tue, 01 Sep 2015 06:05:36 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Tue, 1 Sep 2015 06:05:06 -0700 (PDT)
In-Reply-To: <CAPig+cRig+zk=D1SDF7wBHuQgcQqb-4cHkmeVgLs5BaWzk9WRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276977>

On Mon, Aug 31, 2015 at 11:32 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Aug 31, 2015 at 1:28 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>>
>>> Warning about unrecognized atoms may indeed be a good idea, however,
>>> the current behavior isn't a huge problem since user discovers the
>>> error when the output fails to match his expectation.
>>
>> It's a bit worse than it seems: without this change, using --format
>> '%(align)%(end)' results in Git complaining about %(end) without
>> matching atom, which is really confusing since you do have a %(align) (I
>> got it for real while testing a preliminary version).
>>
>>> This behavior of ignoring unrecognized atoms predates your work,
>>> doesn't it? If so, it's probably not something you need to address in
>>> this series.
>>
>> I wouldn't insist in having it in the series, but now that it's here, I
>> think we can keep it (if only to shorten the interdiff for the next
>> iteration).
>
> The unstated subtext in my original question is that the approach
> taken by this patch of warning only about unrecognized %(align) is too
> special-case; if it's going to warn at all, it should do so
> generically for any unrecognized %(atom). Special-casing the warning
> about malformed %(align) sets a poor precedent; it's code which will
> eventually need to be removed anyhow when the generic warning
> mechanism is eventually implemented.

Probably, I could just have a check within the align block and maybe build a
general case later.

Like this:

 else if (skip_prefix(name, "align", &valp)) {
            struct align *align = &v->u.align;
            struct strbuf **s;

            if (valp[0] != ':')
                die(_("format: usage %%(align:<width>,<position>)"));
            else
                valp++;
            ......
            ........
}


-- 
Regards,
Karthik Nayak
