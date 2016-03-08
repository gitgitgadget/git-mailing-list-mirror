From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 08/15] ref-filter: make "%(symref)" atom work with the
 ':short' modifier
Date: Mon, 7 Mar 2016 17:56:40 -0800
Message-ID: <CA+P7+xqqA=aZ5Nr7YuMnLKAc2E3F4Y31oOb06aAcvunqw+gH4A@mail.gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
 <1457265902-7949-9-git-send-email-Karthik.188@gmail.com> <xmqqtwkhnaxg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 02:57:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad6tZ-0001oj-Pi
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 02:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbcCHB5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 20:57:03 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:36313 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932116AbcCHB5B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 20:57:01 -0500
Received: by mail-io0-f196.google.com with SMTP id m184so792895iof.3
        for <git@vger.kernel.org>; Mon, 07 Mar 2016 17:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SqvbmTKmdRNCcsVuPvCWG5GwQP/ASPzvW5MXu0IhGj4=;
        b=OiFKQqKNHki4r2yYLCDlrqVhYr8X1xGm3mKNWa6OSd/fgKdlt/DZPQvzeWPlAMHhue
         Cka6kyMOcESeYbit/MmQR6eeEOKZRmG6uxusHhm/RZUNe5+To2UJsvhAb6RM7NjFwypr
         D7JlqzWufevs+f9h25pEHfKWKs8DAEbiuS1/xZOF2y6OkuetCSXX+YWDmQ5ncKkWaAxg
         5+p90V8YOl3qbcTvUtSyjbGysBViFT69pkRybSPUch3ZUIDigxvw7WGA7dIO6a6NK1q1
         7a/Sp81+6uP6NDSe3G5YgqQYuMiT2hQ4sj0fgEHsxquDc77ebey6I6sAodtT7f228R6e
         lrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SqvbmTKmdRNCcsVuPvCWG5GwQP/ASPzvW5MXu0IhGj4=;
        b=Uo7Z/T/aISOgRxgWSUYXMZBB+f4559qAjYcjHvpHVf5MkaasoE7+CP2MIV2dLGDHDd
         ktOTDUp7yhPxn+BnJvRh5JGynZzi1L63G2rcHzHyb0bn7UF/5lT71+yYU/+xHi9JfYY/
         4HpXKfQfTRZRDfUZk1Qt6mhXgg61qo1EtPZIL8LO2n1cj8vbAUTdS0hbdqRaHZSu8x34
         GxPzhCILDQUwB6a9YP475R65rsQhCq75YF00KjI6XOz+j+q0ewEXqZ/sRt77e1q3zXOr
         caXKOp94BzdocGK/BfjgMyUdmiqRtrwchcqnx7GIYiblafhiAXsEVhYtkyHNwJWq6D3E
         Cl6w==
X-Gm-Message-State: AD7BkJLCes6zS+HvPTb2I7IskjQ7EXu0Juzg1NO14FeAG0Ih480R4N+QtaJxnzVdtT5NZlICixFhlcJjJCHAUA==
X-Received: by 10.107.170.6 with SMTP id t6mr29606487ioe.71.1457402219914;
 Mon, 07 Mar 2016 17:56:59 -0800 (PST)
Received: by 10.107.10.202 with HTTP; Mon, 7 Mar 2016 17:56:40 -0800 (PST)
In-Reply-To: <xmqqtwkhnaxg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288412>

On Mon, Mar 7, 2016 at 3:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The "%(symref)" atom doesn't work when used with the ':short' modifier
>> because we strictly match only 'symref' for setting the 'need_symref'
>> indicator. Fix this by using 'starts_with()' rather than 'strcmp()'.
>
> Does that mean you also accept %(symrefgarbage) without complaining?
>
>

Looks like patch 9 fixes this by introducing symref_atom_parser.

Regards,
Jake
