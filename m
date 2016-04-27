From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 05/15] submodule-config: check if submodule a submodule is
 in a group
Date: Wed, 27 Apr 2016 16:00:12 -0700
Message-ID: <CAGZ79kZRf=fTbPh5_Qx8dHfiD9gxeDhQqvqDnyZRrMfv_adHXQ@mail.gmail.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-6-git-send-email-sbeller@google.com>
	<xmqq37q8c6zz.fsf@gitster.mtv.corp.google.com>
	<xmqqvb34arjj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 01:00:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avYRR-000406-Ri
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 01:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbcD0XAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 19:00:15 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35630 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbcD0XAO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 19:00:14 -0400
Received: by mail-ig0-f171.google.com with SMTP id bi2so142952937igb.0
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 16:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=wjDABtLjWStPcWaF9AB5/kt6cmBKpTd1Ezpvj4QQKSc=;
        b=m7GiUi+4pZuU7jzfTZolwcLRN+880+kC/9/xljpx+IK1ATvSUWrEjNXbdCqu1Rv30J
         occoCh9SIt1MMg60/tDy7yrKGQsSBf00VPp5Kt+Fk5QIXJ/IOYTUaSyPdYIVwZZ4DwMB
         Uk6XUYkuqlhLRIioYY0R4NijUU/dIdGvfJTRY8n87TvibPp9zaQGz8hICe/cIzeR2oi3
         vkADzWZoIY7Z4PVCk7SBDUMI0CN1lpW3P8yGQxrbennLSFfB91LJkBtU7loHb8oGAVCi
         LLLQ9kee+qInhtBNH+ZHwUl5vJ/UKY+/vEo0lpkKbwv+s4Yn6UF19kP/PwEdlaw2A+Ja
         dmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=wjDABtLjWStPcWaF9AB5/kt6cmBKpTd1Ezpvj4QQKSc=;
        b=FsKrqiggRk8R6BSWB9/nDzeVWasXXpndlp7jZpedTxEaxh53tCYae2439s+bDzsnSb
         RAvugNpaLixt1Ph6JQNaQZC8+dW79UuAski6xdHzl/AwxjcFq6BNSS3UGUNL1t+qUhUm
         luj5XVaEEDyof1e3LDF8cFkfn59xqgojC6N9ZcOM+24k0POBmIpLKjh3hOdLKHQFP8xA
         GmlsoyiACweLqWRWfNe/oWp/7x55uth3CxRbe979IpvksfKQP1aUkE/2tbnLs0l5euuz
         RquD7qQVi8YESuICRGRwur1MyKwDOPBs3mxKpmMt/StASAoizD5NRJn0YC1JHUuWgiwN
         tOoQ==
X-Gm-Message-State: AOPr4FVqymAEqBqf3QEpEEGZq1J7xyEWFJPZ3nhqR+JD3ywMHh2aRisf4zW+pDi5eiG8/uWVTG/1WBBhqSL8wXKy
X-Received: by 10.50.111.15 with SMTP id ie15mr14409514igb.94.1461798013006;
 Wed, 27 Apr 2016 16:00:13 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 27 Apr 2016 16:00:12 -0700 (PDT)
In-Reply-To: <xmqqvb34arjj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292839>

On Tue, Apr 26, 2016 at 4:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I see room for bikeshedding here, but the material to bikeshed
>> around is not even documented yet ;-)
>>
>>  * a token prefixed with '*' is a label.
>>  * a token prefixed with './' is a path.
>>  * a token prefixed with ':' is a name.
>>
>> Hopefully I will see some description like that in later patches.
>> I'll read on.
>
> Extending this on a bit, I would suggest tweaking the above slightly
> and make the rule more like this:
>
>   * a token prefixed with '*' is a label.
>
>   * a token prefixed with ':' is a name.
>
>   * everything else is a path, but "./" at the front is skipped,
>     which can be used to disambiguate an unfortunate path that
>     begins with ':' or '*'.
>
> A bigger thing I am wondering is if it is bettter to do _without_
> adding a new --group=X option everywhere.  I am assuming that most
> if not all submodule subcommands already use "module_list" aka
> "submodule--helper list" that takes paths, and to them, extending
> that interface to also understand the groups and names would be a
> more natural way to extend the UI, no?  e.g.
>
>         $ git submodule update -- 'path1' 'path2'
>         $ git submodule update -- '*default'
>         $ git submodule update -- ':named'
>
> instead of
>
>         $ git submodule update -- 'path1 'path2'
>         $ git submodule update --group='*default' --
>         $ git submodule update --group=':named' --
>
> which special-cases the way to specify a set of submodules by
> listing their paths.

This is indeed a better way.

Currently there is no way to initialize another group as that group
specified by submodule.defaultGroup. But having the possibility
to use the grouping in such a way is more flexible.

Thanks,
Stefan
