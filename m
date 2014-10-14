From: Felipe Franciosi <felipe@paradoxo.org>
Subject: Re: [PATCH] Initialise hash variable to prevent compiler warnings
Date: Tue, 14 Oct 2014 12:44:17 +0100
Message-ID: <CANxchRQ=kR4N5s5S8eSJy2de__BydWDgowCNb6QQW6JZyvQAMw@mail.gmail.com>
References: <1413211041-28732-1-git-send-email-felipe@paradoxo.org>
	<xmqq38ar3f1o.fsf@gitster.dls.corp.google.com>
	<CANxchRS1mGapb77hc9Ywqj_-8UeexSAWK4UK9y9M76pvoN-Yeg@mail.gmail.com>
	<CAPc5daWmHe-EbgO-wjy9UsodTFERa1vpz-SEDF-UM_eLm7CuCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 13:44:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe0Wc-0006XY-SX
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 13:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148AbaJNLoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 07:44:18 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:52139 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846AbaJNLoR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 07:44:17 -0400
Received: by mail-oi0-f49.google.com with SMTP id a3so15824338oib.8
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 04:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Ng7DNU9oGx7N2UpkpF7lyCHXgatJ+Lwe3BH+9RK5gkY=;
        b=XwM3OoidJBgtpVkTwKxlEn/q9V14j2S7chg9+uz6mUErA7rmu9yhe33+AqRU24jvtm
         inOFueVMomazHK4aKlfbrvg3RkdXmaNVNf+DzlpAWKIShuv4UiMNpMcxGfSbt+ruvd8h
         vrWzGn8UlFTc9kgW04N7EwyZh7pCR7ZlqLO3tPcmAW+QvxBZaJOh6wlYD6jN60cyi141
         Y/dOSrNC5rMnRedCaMYT1iyxTtwvZMP57TM2pHEhoATg4++/A9cWudUkNIbquoIoC25W
         vPbl8w3+pKihAASoeCIm7fMzlb+ZPiUmeUV+cmBwYicoIGRjy6pUHdmf6d0OuKWJZxjN
         gI5A==
X-Gm-Message-State: ALoCoQkn5yr6qN06/lTiN0G/lLNz1u7QT+ngbGSwztYBk6OLIFQSDxOefRAIGlNyyUB3pgqRegJk
X-Received: by 10.202.1.80 with SMTP id 77mr3936884oib.31.1413287057156; Tue,
 14 Oct 2014 04:44:17 -0700 (PDT)
Received: by 10.182.250.201 with HTTP; Tue, 14 Oct 2014 04:44:17 -0700 (PDT)
X-Originating-IP: [185.25.64.249]
In-Reply-To: <CAPc5daWmHe-EbgO-wjy9UsodTFERa1vpz-SEDF-UM_eLm7CuCw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 14, 2014 at 2:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> On Mon, Oct 13, 2014 at 2:53 PM, Felipe Franciosi <felipe@paradoxo.org> wrote:
>>
>> On Mon, Oct 13, 2014 at 9:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> FNV/I/IDIV10/0 covers all the possibilities of (method & 3), I would
>>> have to say that the compiler needs to be fixed.
>>>
>>> Or insert "default:" just before "case HASH_METHOD_0:" line?
>>>
>>> I dunno.
>>
>> Hmm... The "default:" would work, but is it really that bad to initialise a
>> local variable in this case?
>>
>> In any case, the compilation warning is annoying. Do you prefer the default
>> or the initialisation?
>
> If I really had to choose between the two, adding a useless initialization
> would be the less harmful choice. Adding a meaningless "default:" robs
> another chance from the compilers to diagnose a future breakage we
> might add (namely, we may extend methods and forget to write a
> corresponding case arm for the new method value, which a smart
> compiler can and do diagnose as a switch that does not handle
> all the possible values.
>
> Thanks.

I see your point; the code is correct today because it covers all
cases. Nevertheless, some versions of gcc (the one I used was 4.1.2
from CentOS 5.10 -- haven't tested others) might generate an annoying
warning.

Noting that, I also like my code to compile as cleanly as possible in
all environments that it might be used. Being a bit defensive in that
sense and initialising local variables is what I would do. On top of
that (and putting the compiler flaw aside for a moment), having it
sensibly initialised is another way of protecting the code against
errors introduced in the future.

What do you think?

Cheers,
F.
