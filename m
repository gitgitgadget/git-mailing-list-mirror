From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v16 00/14] port tag.c to use ref-filter APIs
Date: Tue, 08 Sep 2015 11:20:25 -0700
Message-ID: <xmqqd1xs93iu.fsf@gitster.mtv.corp.google.com>
References: <1441479135-5285-1-git-send-email-Karthik.188@gmail.com>
	<xmqqh9n6agcf.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQFZRKY_hHEVQQ6CuYC9XNWHJFYg1CFZCGUr-68phDMHQ@mail.gmail.com>
	<vpqfv2qqq7y.fsf@scolette.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 08 20:20:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZNVP-0000Iw-VE
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 20:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983AbbIHSU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 14:20:29 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36447 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014AbbIHSU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 14:20:28 -0400
Received: by padhk3 with SMTP id hk3so45735994pad.3
        for <git@vger.kernel.org>; Tue, 08 Sep 2015 11:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9RIkOswxn9088Anm9tuOngztxJAYN8zUzedbnXrmwxw=;
        b=W9AX8my8g6lNZLdM6r+x1JrkINZkbhsMOLWHhNlfiEBjmiZRUgtT5LMjBWPaeQWM9Y
         4wsUEFL7hib1afUCD2xVX7Ap2yQW5nWmESi1C0kEQcrukH/NVa3/qmECFtr0+Tn7O469
         eGTZPBwMzlSZd390jGYziIGaY7dypuy8MRi9+mGiZ7BUGWsARZnDrZTKEsmAWoxzZdDF
         2Ok5yc2LCf/lmenR53HW9Hui5x5cnyolN85X+X62C/DvRYiktc7Hiy/x//32sGIyi4SB
         T47w+hLJht3psG2u6nT9EJn4LXy4+5yRQY6Eo3NhdktCLOQO9XvArjkWjDGNGmZf19E/
         tzZg==
X-Received: by 10.68.202.72 with SMTP id kg8mr60698437pbc.42.1441736427687;
        Tue, 08 Sep 2015 11:20:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:40ca:ccb5:4636:e6d])
        by smtp.gmail.com with ESMTPSA id cg2sm4178271pbb.86.2015.09.08.11.20.25
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 08 Sep 2015 11:20:26 -0700 (PDT)
In-Reply-To: <vpqfv2qqq7y.fsf@scolette.imag.fr> (Matthieu Moy's message of
	"Mon, 07 Sep 2015 16:05:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277514>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>>> This line still looks overlong.  Would it help to stop spelling this
>>> as a double "a = b = overlong expression" assignment?
>>>
>>
>> I'm not sure, I get what you mean.
>
> I guess
>
> format = xstrfmt("%%(align:15,left)%%(refname:short)%%(end) %%(contents:lines=%d)",
>                  filter->lines);
> to_free = format;
>
> (still 83 columns + indentation, but that's a bit shorter than your
> version).

Sure.  This may also be possible

	xstrfmt("%s %%(contents:lines=%d)",
                "%(align:15,left)%(refname:short)%(end)", filter->lines);

and highlights that the only thing that is variable is the number
of lines, which might be better.
