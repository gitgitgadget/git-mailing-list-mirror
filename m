From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Initialise hash variable to prevent compiler warnings
Date: Mon, 13 Oct 2014 18:13:31 -0700
Message-ID: <CAPc5daWmHe-EbgO-wjy9UsodTFERa1vpz-SEDF-UM_eLm7CuCw@mail.gmail.com>
References: <1413211041-28732-1-git-send-email-felipe@paradoxo.org>
 <xmqq38ar3f1o.fsf@gitster.dls.corp.google.com> <CANxchRS1mGapb77hc9Ywqj_-8UeexSAWK4UK9y9M76pvoN-Yeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Felipe Franciosi <felipe@paradoxo.org>
X-From: git-owner@vger.kernel.org Tue Oct 14 03:13:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdqgX-0000D5-Td
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 03:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbaJNBNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 21:13:53 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34428 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946AbaJNBNw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 21:13:52 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so7319556lbg.4
        for <git@vger.kernel.org>; Mon, 13 Oct 2014 18:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=bHObKCksFVhepjGnGN3ns4VcDfRbYTHMVlKBskHBkGI=;
        b=NIFxtiaQJQ0h4zpFBGB7zW9JHEcmWI8R3EAJzoerO+wVI0WOviw1otshZNE3VYm8v/
         YHvrpfqZJJleMF/JUaTFpsBpwwNYfCk7H/9tHswbKBg7pJkzasMg3WMwp4xqXtqoPRKO
         7mozuYmmzXch69LfIk2TZEp816RFlLj6rwUPUrN9s4zRX8hU7PCmPjYPT7V2Yv6Pfk97
         l4cMuQco78OM+iUtvYIQXA2EfogpOnkZI9Lo8YBPJowsN3DxJwJ6lkSkcnEOYS4CVpq4
         s4fi+S9dqgiRq3rS+V9sLBU9jx6N1wil6tsm5I7n2lVIVLBu5VM/fgQlYw/th14P0Xku
         RSbg==
X-Received: by 10.112.47.132 with SMTP id d4mr1922492lbn.64.1413249231188;
 Mon, 13 Oct 2014 18:13:51 -0700 (PDT)
Received: by 10.112.209.35 with HTTP; Mon, 13 Oct 2014 18:13:31 -0700 (PDT)
In-Reply-To: <CANxchRS1mGapb77hc9Ywqj_-8UeexSAWK4UK9y9M76pvoN-Yeg@mail.gmail.com>
X-Google-Sender-Auth: ZTd5_XmsDXWDlU1lFzfXxak7C5U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 13, 2014 at 2:53 PM, Felipe Franciosi <felipe@paradoxo.org> wrote:
>
> On Mon, Oct 13, 2014 at 9:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> FNV/I/IDIV10/0 covers all the possibilities of (method & 3), I would
>> have to say that the compiler needs to be fixed.
>>
>> Or insert "default:" just before "case HASH_METHOD_0:" line?
>>
>> I dunno.
>
> Hmm... The "default:" would work, but is it really that bad to initialise a
> local variable in this case?
>
> In any case, the compilation warning is annoying. Do you prefer the default
> or the initialisation?

If I really had to choose between the two, adding a useless initialization
would be the less harmful choice. Adding a meaningless "default:" robs
another chance from the compilers to diagnose a future breakage we
might add (namely, we may extend methods and forget to write a
corresponding case arm for the new method value, which a smart
compiler can and do diagnose as a switch that does not handle
all the possible values.

Thanks.
