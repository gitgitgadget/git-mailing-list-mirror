From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: [PATCH 2/3] contrib/subtree/t: Added tests for .gitsubtree support
Date: Fri, 15 Feb 2013 23:16:29 +0000
Message-ID: <CALeLG_nLz9Gfqcfk4EcWixRXbWC0x0GUVFDAKD20DGbkhRNWvQ@mail.gmail.com>
References: <CALeLG_=ir-kBTYpsRr_Hf8q2UY2ZtjShbTkO_tH=YiWSskfPOw@mail.gmail.com>
	<20130215225624.GB21165@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Adam Tkac <atkac@redhat.com>,
	"David A. Greene" <greened@obbligato.org>,
	"Jesper L. Nielsen" <lyager@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Techlive Zheng <techlivezheng@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 00:16:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6UWU-0005k5-M4
	for gcvg-git-2@plane.gmane.org; Sat, 16 Feb 2013 00:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319Ab3BOXQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 18:16:31 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:47420 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278Ab3BOXQa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2013 18:16:30 -0500
Received: by mail-ob0-f175.google.com with SMTP id uz6so4186459obc.34
        for <git@vger.kernel.org>; Fri, 15 Feb 2013 15:16:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=MQjp5/tAPjNSAT/MuX5rkH4mEoI3aA7r92O0BbhD73E=;
        b=UISzu+JdYZSBfm53Vh6sIYiBNWlMU0fNcmfnKOO5Osr9Gk1Gby8W+LSVkt6ruxXfa2
         Xda8lc4SaPjbfr61hS67nV0I3/tSzJDDjn2i+QNbwVNaPPfKuR3sMWBaguZCMmu9SHW2
         +TG+HrxqgNM3zwf0TlwVAxNd0pGoC7Gbzkjv6BNMXm4MHZ6gJr0FZn9L4B64i3HMeIWA
         E/WTy1k0fxqc4OdZTw8f6VMTLa4ac+9hlUeW2UEEA3Q5hmH99NOd2lnreRgEnIG3QuzU
         BVWvG3OwHULXbTQjI53hdDe8yl7ZDBH+UKO1g/6vrQl1MKlS4xZKCzL/u2KcwlORMz/x
         mW8w==
X-Received: by 10.60.30.131 with SMTP id s3mr3007177oeh.106.1360970189979;
 Fri, 15 Feb 2013 15:16:29 -0800 (PST)
Received: by 10.76.143.67 with HTTP; Fri, 15 Feb 2013 15:16:29 -0800 (PST)
X-Originating-IP: [2.102.85.14]
In-Reply-To: <20130215225624.GB21165@google.com>
X-Gm-Message-State: ALoCoQmnVg/f7sUNi1Ldr0EutGhrKeCZZoJ7sKbymCNjYpyW3YEhR08LkXjO3jJmoHy2GCtH12K+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216363>

Hi Jonathan,

On Fri, Feb 15, 2013 at 10:56 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Paul,
>
> Paul Campbell wrote:
>
>> --- a/contrib/subtree/t/t7900-subtree.sh
>> +++ b/contrib/subtree/t/t7900-subtree.sh
>> @@ -465,4 +465,34 @@ test_expect_success 'verify one file change per commit' '
> [...]
>> +test_expect_success 'change in subtree is pushed okay' '
>> +        cd copy0 && create new_file && git commit -m"Added new_file" &&
>> +        cd .. && git subtree push --prefix=copy0 2>&1 | \
>
> If it possible to restrict the chdirs to subshells, that can make the
> test more resiliant to early failures without breaking later tests.
>
> That is:
>
>         (
>                 cd copy0 &&
>                 create new_file &&
>                 test_tick &&
>                 git commit -m "add new_file"
>         ) &&
>         git subtree push --prefix=copy0 >output 2>&1 &&
>         grep "..." output
>

Adding them in.

>> +                grep "^\s\{3\}[0-9a-f]\{7\}\.\.[0-9a-f]\{7\}\s\s[0-9a-f]\{40\}\s->\ssub1$"
>
> This might not be portable if I understand
> Documentation/CodingGuidelines correctly.
>

And it's ugly. But I believe it fits the "don't use grep -E"
condition. Unless I missed something else.

Is there was a better way to verify that the push operation succeeds
then grepping for a SHA1?

> [...]
>> +        (grep "^copy3 . sub2$" .gitsubtree && die || true) &&
>
>         ! grep "^copy3 . sub2\$" .gitsubtree &&
>
> Hope that helps,
> Jonathan

Thanks. That's a much neater way to do it.

-- 
Paul [W] Campbell
