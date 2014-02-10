From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2 2/2] gc: config option for running --auto in background
Date: Mon, 10 Feb 2014 14:33:15 +0100
Message-ID: <CABPQNSaLQ4aU+46P5ceS1XAzXQ_4HpURF369fQe6ZuLQmFwZmQ@mail.gmail.com>
References: <xmqqd2j2afup.fsf@gitster.dls.corp.google.com> <1391843332-20583-1-git-send-email-pclouds@gmail.com>
 <1391843332-20583-2-git-send-email-pclouds@gmail.com> <CABPQNSb3=i8F+vPEG3RmH+snZVZ-xrPtcVY2Nx9uvyTCLXcy6g@mail.gmail.com>
 <CACsJy8BBQ3Bh6q6JM8V-QVKfzwp1w99+u4_55jjGbHLV3c62gA@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, chris <jugg@hotmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 10 14:34:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCr02-0007yC-52
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 14:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041AbaBJNd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 08:33:58 -0500
Received: from mail-ob0-f177.google.com ([209.85.214.177]:58003 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbaBJNd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 08:33:56 -0500
Received: by mail-ob0-f177.google.com with SMTP id wp18so7081802obc.8
        for <git@vger.kernel.org>; Mon, 10 Feb 2014 05:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Ai4UtpDyGA87PTm3MSMFiqnhN5bumOBmMTdsElg86Fk=;
        b=eCdI8oWzk67Bf0iv4Rv7S50mKHJ+si6QbAXqIJpu7PwOKgN5qN6Rpo82TpMLa7IPiW
         +6dxnTJ4DR7kdH0n273SwXf+ddm0pqB3FT5tq6oZkP3OWwHLRtFm3S/PzhrKnhWHp3nb
         qJV9qqhNqFSYogP3J7HqVVs13T7AHOlbt4CaEm20tKYKKVZU6laDFp40Svt8hPn5tBzk
         SH/7DBfVuik2rRLTI8CYikj/81U4W6tqR6ZJiX+91LEjXNAEYLswpAagIP8nRV1tjZCL
         XmpuZc731uC4hXibW4eQ95YMiRw5IlOmZTJPh1eUT3Nygh9wykHrRwZZaPqHb4sZN1R2
         bv0A==
X-Received: by 10.182.81.197 with SMTP id c5mr6902682oby.40.1392039235579;
 Mon, 10 Feb 2014 05:33:55 -0800 (PST)
Received: by 10.76.85.103 with HTTP; Mon, 10 Feb 2014 05:33:15 -0800 (PST)
In-Reply-To: <CACsJy8BBQ3Bh6q6JM8V-QVKfzwp1w99+u4_55jjGbHLV3c62gA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241913>

On Mon, Feb 10, 2014 at 2:17 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Feb 10, 2014 at 6:03 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>> `gc --auto` takes time and can block the user temporarily (but not any
>>> -               if (!quiet)
>>> -                       fprintf(stderr,
>>> -                                       _("Auto packing the repository for optimum performance. You may also\n"
>>> -                                       "run \"git gc\" manually. See "
>>> -                                       "\"git help gc\" for more information.\n"));
>>> +               if (!quiet) {
>>> +                       if (detach_auto)
>>> +                               fprintf(stderr, _("Auto packing the repository in background for optimum performance.\n"));
>>> +                       else
>>> +                               fprintf(stderr, _("Auto packing the repository for optimum performance.\n"));
>>> +                       fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
>>> +               }
>>> +               if (detach_auto)
>>> +                       /*
>>> +                        * failure to daemonize is ok, we'll continue
>>> +                        * in foreground
>>> +                        */
>>> +                       daemonize();
>>
>> While I agree that it should be OK, shouldn't we warn the user?
>
> If --quiet is set, we should not be printing anyway. If not, I thinkg
> we could only print "auto packing in background.." when we actually
> can do that, else just print the old message. It means an #ifdef
> NO_POSIX_GOODIES here again though..

Yuck, it's probably better to simply silently drop the detaching, I guess.
