From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] submodule update: make use of the existing
 fetch_in_submodule function
Date: Wed, 25 May 2016 15:45:42 -0700
Message-ID: <CAGZ79kZHZPqKGW6MEt1QZa=3wb+6jQC=pZ4uJJq4KN=bFGFoeA@mail.gmail.com>
References: <20160525220006.27138-1-sbeller@google.com> <20160525220006.27138-2-sbeller@google.com>
 <xmqqa8jdzroz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 00:46:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5hZ7-0001yj-T9
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 00:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbcEYWqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 18:46:06 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35864 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207AbcEYWpo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 18:45:44 -0400
Received: by mail-ig0-f177.google.com with SMTP id ww4so80768681igb.1
        for <git@vger.kernel.org>; Wed, 25 May 2016 15:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AP5MFC46gQVqs3ax+bFlPuiPApmfSTCyROyQdnEwzr8=;
        b=HQ1AnRezhQXs7d1oiTrOCdMshl3UmZ9slCIlKoTJ5a9g5ttXYUARxrQi6HLidFqLdj
         hAp3Omsl6qRpymGRcx2j79fvzC8UKe0/bFQfaW3YqIu62MngczDes3UXg+w9Ie85HeqM
         Cv/ER2cIWXldBm9EI6oUOeCIr9wPI6UFsksSQafJmtt7UWuqXrblPKGvPgkgj1s7EcmT
         LRrQjpEavtVqtPaKR6ZHbTYUtTiX/J3CD8RkMgur84JOyvAt7kLg76NA/Fv9ngb7PjJx
         2bJbDjRXJP9kfoC/4f0fZlsYAOnUL/pCmDDtq4hfoHquGg+4jS0ypmex8k5bI1xI3Wgi
         jtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AP5MFC46gQVqs3ax+bFlPuiPApmfSTCyROyQdnEwzr8=;
        b=AaDrsGpGrAu+J8+4I0NlugE8+MKY8LsPk+fRr0hwI2SaL5WijaJc5xOMRulIjgDxS5
         0exVLG8a1HS6onQ2UrR3bPKOdjKnAY8AEgS/a6S1N8H8TtkxA6Xv4zYwysUvgF6OtPzN
         VSAI1ACU92ZFFz1kyWTrI829Qberg7npezjCfNNO0cyW6gI+IjzbbNzXKaUs4cM4KLz3
         498kBHTzk0iItjhi75UkevIUgu46U+V/TtOrHAYvqpCwvPutqZR9kSwMOoT4kYzVKO0P
         0o3N233TdtpKxjBngdCY4lC+WYr4nREBPJoKe6xgCRNBW8UKtukwtqvRx0/jJqdE4SsV
         kBFA==
X-Gm-Message-State: ALyK8tLxQfKA0IOWO7uwyA0zp8BisUQg3zERyVXbAFfms3pvSdEtYwRukmo1LEjxTU6PHhqfa1tBQXOcg7YF+fVu
X-Received: by 10.36.62.133 with SMTP id s127mr276387its.98.1464216342950;
 Wed, 25 May 2016 15:45:42 -0700 (PDT)
Received: by 10.107.136.19 with HTTP; Wed, 25 May 2016 15:45:42 -0700 (PDT)
In-Reply-To: <xmqqa8jdzroz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295606>

On Wed, May 25, 2016 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  git-submodule.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 5a4dec0..7698102 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -640,7 +640,7 @@ cmd_update()
>>                       if test -z "$nofetch"
>>                       then
>>                               # Fetch remote before determining tracking $sha1
>> -                             (sanitize_submodule_env; cd "$sm_path" && git-fetch) ||
>> +                             fetch_in_submodule "$sm_path" ||
>>                               die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
>>                       fi
>>                       remote_name=$(sanitize_submodule_env; cd "$sm_path" && get_default_remote)
>
> Makes sense.  The main topic does not depend on this change, I hope,
> as I think it is OK to queue this separately and have it graduate
> before 2.9-rc1.


It doesn't, I should have send this as an independent series/patch.

Thanks,
Stefan
