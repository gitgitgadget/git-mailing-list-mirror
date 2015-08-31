From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v14 04/13] ref-filter: implement an `align` atom
Date: Mon, 31 Aug 2015 13:16:23 -0400
Message-ID: <CAPig+cRAYeF0ZDn5FsHioZr1g4pH3Ay69_3KDb8ZF1USZxzcEg@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
	<1440857537-13968-5-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRHRPehkd+9PwOqpXkRUvaJa42zLtCKMEfv2W=ZJUZJzA@mail.gmail.com>
	<CAOLa=ZTHtps2gJb9asSzG_4NOwx_xiA7OuCzjW=BTTFfkaYoQg@mail.gmail.com>
	<CAPig+cQF=1FPFP_7Bn2m2J+ay5ZupG25USWc9LT9SqO1=VDZvg@mail.gmail.com>
	<CAOLa=ZS53BNNvnYv2TU6xQbEihi1GiKBaEEZ=KT6p_gDBR9Y9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 19:16:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWShH-0005Wr-L9
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 19:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474AbbHaRQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 13:16:25 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36314 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415AbbHaRQY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 13:16:24 -0400
Received: by qkbp67 with SMTP id p67so6816619qkb.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 10:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Egu2mbDYY+TjN9puNKIZPDxx+AXsYCJ0a2Er9e2FNTE=;
        b=f+Od0+eGNyjH4PnBHWF4K99rAG6C7HqCotwKoHfrB4I23Thh1/WPySn81s0ZKRmfx1
         ulrtlstnXUC9Dm2GWKj3m++a4NJjW9EEfTdUx3r7jAZgQ7vO2CCptEa2To3+FRJgRbgs
         EC4UkC5+5GKam8zOfPkRph+YdwY6TZFBmmdf4tRWZFHphJaKCVLzWLyYUVeqVsUMy2ST
         PuX5bw/b6hg2IIwyVSauxumFay8pcmE2A+QQZUkFnacBIjYyIfyhGESsEomKGbUjMG3e
         ZCcALcbizQuq1JTtbZVCh1wWTaKE6NrPpvr/nhae4ra+G7irziHazDHAHYi7E9r0BroP
         EceQ==
X-Received: by 10.129.41.209 with SMTP id p200mr15196761ywp.131.1441041383638;
 Mon, 31 Aug 2015 10:16:23 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Mon, 31 Aug 2015 10:16:23 -0700 (PDT)
In-Reply-To: <CAOLa=ZS53BNNvnYv2TU6xQbEihi1GiKBaEEZ=KT6p_gDBR9Y9Q@mail.gmail.com>
X-Google-Sender-Auth: 3gtZ_1HkNgnLsb4NjOWZjxhl4cc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276892>

On Mon, Aug 31, 2015 at 5:55 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Sun, Aug 30, 2015 at 3:10 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sun, Aug 30, 2015 at 9:38 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> On Sun, Aug 30, 2015 at 8:57 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> On Sat, Aug 29, 2015 at 10:12 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>>> +               } else if (!strcmp(name, "align"))
>>>>> +                       die(_("format: incomplete use of the `align` atom"));
>>>>
>>>> Why does %(align) get flagged as a malformation of %(align:), whereas
>>>> %(color) does not get flagged as a malformation of %(color:)? Why does
>>>> one deserve special treatment but not the other?
>>>
>>> Didn't see that, I think its needed to add a check for both like :
>>>
>>> else if (!strcmp(name, "align") || !strcmp(name, "color"))
>>>             die(_("format: improper usage of %s atom"), name);
>>>
>>> I had a look if any other atoms need a subvalue to operate, couldn't
>>> find any.
>>
>> Hmm, I'm not convinced that either %(align) or %(color) need to be
>> called out specially. What is the current behavior when these
>> "malformations" or any other misspelled atoms are used? Does it error
>> out? Does it simply ignore them and pass them through to the output
>> unmolested?
>
> It just simply ignores them currently, which is kinda bad, as the user
> is given no warning, and the atom is ineffective.

Warning about unrecognized atoms may indeed be a good idea, however,
the current behavior isn't a huge problem since user discovers the
error when the output fails to match his expectation. This behavior of
ignoring unrecognized atoms predates your work, doesn't it? If so,
it's probably not something you need to address in this series.
