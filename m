From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/8] Making reflog modifications part of the transactions API
Date: Fri, 12 Dec 2014 12:51:44 -0800
Message-ID: <CAGZ79kZB9TbygBM47Ug5i_FeR1c5w9btbayNEU3D2PeObCwzMw@mail.gmail.com>
References: <1417833995-25687-1-git-send-email-sbeller@google.com>
	<548B150C.2090606@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 12 21:51:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzXBl-00046a-US
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 21:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934887AbaLLUvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 15:51:46 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:58401 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754941AbaLLUvp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 15:51:45 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so7610914iec.16
        for <git@vger.kernel.org>; Fri, 12 Dec 2014 12:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=p18eoqsNDjmI51AXh6az1cGT+b4KKgKeGheT5IVWiVs=;
        b=UxyxG9yAr1R1o0kX0RQW+O9x8SsqYUrXE2TtMq8yKY7SOGBca/+vmMS9Qkf6uFMits
         oI/BRJKsqs++CNsf6c7XHoTQJWuHCN7UZrknzkeYLSpORWQvoy3tgSaFjiiNF8JLB+wk
         qyWz6/JYao7KpisDOSv6Qh76e4VklOTp5kdotBLV5Qa6DDpbfC4dwR6+k/Z7B+Ej6XHN
         hOtdwBrXR7psSLLkX6RsFkceeAj1n2+cs7a2/QML66LKu8uP7JlsGZ2fSf6NLOtFrgx3
         22tBNTCk2V89HTYePu8bJV09tK3z0IN8Il4bP0Py+ZtJTbuXZRVHXrYbqeAY8Ynn0ufr
         pslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=p18eoqsNDjmI51AXh6az1cGT+b4KKgKeGheT5IVWiVs=;
        b=ml3E9thoivmcsXGqWZlMKtPLkZssXWTRswDPhIqXUgOTL0vYuVuhV/xSV08bhBeCHP
         RfXt/BesPh2cmUbUgw/690OKi+dXhPeavkHWyzEeoN6g4O52A7PowyN3NaR8vz+f/O8m
         obh4qZC0OvglvIqi9russPgj2n+PziIw6/vTsxVPLfw1TXTT5+FVrqbgqC5G8Nxlf/4k
         P5AtWfX5r953h+31JeJZSi9Hu+txOUD1vqr7NBLttfy5Q8cnKYkHRj0XJw9T0sQKwCuu
         B2X+Vh5DDblRwq9FvQFIrP84WIlJg9YGUhKeRMQU9bKetOow+JwtfCWxIxjkKcqZvItv
         HZdQ==
X-Gm-Message-State: ALoCoQk8MM/yWbhKdU1A8LKqsTupRunOggd2tv3MKkb0ke/xLwCVl4esXnUjwKSJVjjbcEpaMyyq
X-Received: by 10.50.171.194 with SMTP id aw2mr6730687igc.25.1418417504637;
 Fri, 12 Dec 2014 12:51:44 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Fri, 12 Dec 2014 12:51:44 -0800 (PST)
In-Reply-To: <548B150C.2090606@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261371>

On Fri, Dec 12, 2014 at 8:17 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 12/06/2014 03:46 AM, Stefan Beller wrote:
>> This goes on top of Michaels series. The idea of this series is make the
>> reflogs being part of the transaction API, so it will be part of the contract
>> of transaction_commit to either commit all the changes or none at all.
>>
>> Currently when using the transaction API to change refs, also reflogs are changed.
>> But the changes to the reflogs just happen as a side effect and not as part of
>> the atomic part of changes we want to commit altogether.
>
> Would you please explain why this patch series is still needed if my
> "reflog_expire()" series is accepted?

If we can live with the fact that reflog and refs have different APIs
then, we can probably
drop that series. That series may also have performance issues, Junio
pointed out.
Most likely I'll look at the remaining 4 patch series from Ronnie, if
I can put them on
top of your series now.

>
> reflog_expire() already has its own little transaction. Reflog
> expiration never needs to be combined with other reference changes, so
> there is no need for reflog expiration to be done via a ref_transaction.
>
> ref_transaction_commit() already updates the reflog if necessary when a
> reference is updated. That update is part of the containing
> ref_transaction, because it is locked by the lock on the reference
> itself at the beginning of the transaction and unlocked at the end of
> the transaction [1]. It can't fail in normal circumstances because the
> preconditions for the transaction have already been checked.


>
> As far as I can tell, the only thing left to do is provide a substitute
> for log_ref_setup() a.k.a. create_reflog() that can be triggered within
> a transaction. In my opinion the easiest way to do that is to give
> ref_transaction_update()'s flag parameter an additional option,
> REF_CREATE_REFLOG, which forces the reference's reflog to be created if
> it does not already exist.

I already ported the patch which replaces log_ref_setup() by create_reflog()
on top of your series-v1, but I refrained to send it out as Junio
seems to dislike
invasive patches[1] or possible merge conflicts so I was waiting for
discussion on
your patch series calm down and be merged to next at least.

Apart from that rename, I also looked into flagging REF_CREATE_REFLOG
additionally.
Though I run into problems there (test suite doesn't pass and I did
not find the mistake for 5 hours :/)

>
> What am I missing?

I think the original plan of Ronnie was to have one and only one transaction
API, which would be used for anything eventually (refs, reflogs,
config, what have you)
If we go for a relaxed version of that, we'd be fine.

Thanks,
Stefan


[1] http://www.spinics.net/lists/git/msg243451.html
     The patch in question is not an invasive patch, but still touching places
     which may be touched currently by your series. So I just wanted
to wait a bit.
