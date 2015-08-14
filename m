From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 4/4] notes: teach git-notes about notes.<ref>.mergestrategy
 option
Date: Fri, 14 Aug 2015 18:10:48 -0400
Message-ID: <CAPig+cTxmFCRChzahQZVpMeJ=3N0PjHAcamFBm394OgTR8LnLw@mail.gmail.com>
References: <1439586835-15712-1-git-send-email-jacob.e.keller@intel.com>
	<1439586835-15712-5-git-send-email-jacob.e.keller@intel.com>
	<xmqq8u9dh6lq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jacob Keller <jacob.keller@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 00:10:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQNBd-0001Kh-JF
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 00:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbbHNWKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 18:10:49 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:33024 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbbHNWKt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 18:10:49 -0400
Received: by ykll84 with SMTP id l84so17602016ykl.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 15:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=i9AEhJN1DJDzuYOG3kkWHl0DbzkCjFS/1g4BxjRrWl0=;
        b=mxZ6ot2tVMB6nLNfq6s6kjCNtIxUDvpXooz6KhfsRlRoLnQpaI7EogroK7EGBAYN7b
         P6kGwRvebMqkzBok+cGccYln0epZZw2BOO+x3wNwtTDZUVGK7TBKundVPYQtns9o0wzK
         Vn8t/ZhKpknJtecNBS9Ejqk8BZgJ16rE4bzlzp90It8kqX4DE2CF5pDM0MRxQeJdeyki
         6Mr9e1M6B4deJj/rWSBcOMF+gfbQ9Lx6a3gnMy5qm72Qjp4tz3cCMbvIEPPT39VMv1HB
         LypNdtbRJ5Dga4Mi5Z55eDyqKYYl+1+zb/SJnAtBpwj8D4erUyLltrRqOO5jP+MLAZLo
         /0cg==
X-Received: by 10.170.172.84 with SMTP id o81mr18139207ykd.69.1439590248546;
 Fri, 14 Aug 2015 15:10:48 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Fri, 14 Aug 2015 15:10:48 -0700 (PDT)
In-Reply-To: <xmqq8u9dh6lq.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: M5vAHugatt7G7QhnzQHJXmpZFEg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275966>

On Fri, Aug 14, 2015 at 6:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>> diff --git a/builtin/notes.c b/builtin/notes.c
>> index 12a42b583f98..bdfd9c7d29b4 100644
>> --- a/builtin/notes.c
>> +++ b/builtin/notes.c
>> +             strbuf_addf(&merge_key, "notes.%s.mergestrategy", short_ref);
>> +
>> +             if (git_config_get_notes_strategy(merge_key.buf, &o.strategy))
>> +                     git_config_get_notes_strategy("notes.mergestrategy", &o.strategy);
>>       }
>
> I think you are leaking merge_key after you are done using it.

In addition to fixing the leak, since 'merge_key' is only used within
this block, it might also make sense to declare it in this block
rather than at the top of the function.
