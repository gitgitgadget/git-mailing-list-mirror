From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] git-compat-util: st_add4: work around gcc 4.2.x
 compiler crash
Date: Mon, 21 Mar 2016 01:38:37 -0400
Message-ID: <CAPig+cR2rBJ4Tn9h7d4pp_Uxrfgc-BgHMLOhxKhWtYbm2wnARA@mail.gmail.com>
References: <1458534958-6956-1-git-send-email-sunshine@sunshineco.com>
	<1458534958-6956-2-git-send-email-sunshine@sunshineco.com>
	<CAP8UFD0Kp55bpwdNrXY3KhpDiHVDReWKpuNJz7_Q537DXeUXHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Renato Botelho <garga@freebsd.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 06:51:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahsk1-0006Xb-Ps
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 06:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbcCUFij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 01:38:39 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33388 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbcCUFii (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 01:38:38 -0400
Received: by mail-vk0-f68.google.com with SMTP id q138so9951906vkb.0
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 22:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=bDdVvGD0/NxjMqtoDwUsxcNXAMcMAKE9OrLC+Yhk4hA=;
        b=UZEpFqvsrhTQldHCr8A0RjVMgkyiXrNtEFZQdUhCfcy15YY7J91lFCMC5ItDhG1nb/
         AMEFUOQvdmVyukGrUAgETDax0gFZA9GzGe7jjQ4rgZNC/ItVcH+Hl6LaQ8J33jxVa4Iy
         NEKhnBfqWhtaRO/0gvk/JbaJA4cjxEDPPWCgX3SOJuuAjdQACBInnQJoTjk8eV5TikRj
         C5hZDfez9CIevRmlCYKFv3sUj2lAu9kY7/iTS8p22pFyh5sKk4nAdbK0DUBPX7zDu57Z
         oHSlkjJsDXmfTNWDt18cmOgSjQKehMgx+GrOd8QT71Qbb5Tg+l5A2GZp+41rqys1vimS
         pKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=bDdVvGD0/NxjMqtoDwUsxcNXAMcMAKE9OrLC+Yhk4hA=;
        b=VpH4F6f6RtfvyvlcYhYWlk1khnsExey8WOerhYaJHUZKtU8PKuz+nd6GXdgYYTzUop
         QM0H9aSb0kqkzPh6OU0nMVgxz3QcotxKAi0b4AoKr21LoVmfnX8+Ts5bH6ZVFpVh3eUP
         pRnV0OvSk+QcjK7vos8BfZa8qbf/w9K4QhTAUUvRdFQFFm8PjuNo7/V3PeCFy+fFfLji
         2TsceNMHPI/sv1gIsKhnO/t9XXbatpsxKe6nVXAvI0awdB5WDb2evAYscs/10ZkMFw2q
         CXwXNjzjlapta79I2MNzUM5DQeLKN3TFBX6zBUPRYEFINoJfIbfPT+5rq6lMjMrka9s9
         m67Q==
X-Gm-Message-State: AD7BkJLPTfpQUisD2+mPfXJHlFrWx8ZSar/VzqkgZcre3nnxuZwn4Hx5tM9YMLfgmDENzoa8xqwSVkplN6mNvg==
X-Received: by 10.31.150.76 with SMTP id y73mr30256754vkd.84.1458538717858;
 Sun, 20 Mar 2016 22:38:37 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Sun, 20 Mar 2016 22:38:37 -0700 (PDT)
In-Reply-To: <CAP8UFD0Kp55bpwdNrXY3KhpDiHVDReWKpuNJz7_Q537DXeUXHA@mail.gmail.com>
X-Google-Sender-Auth: yomiB3QGqZyBuMGL8Jyz5teHcU8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289402>

On Mon, Mar 21, 2016 at 12:56 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Mon, Mar 21, 2016 at 5:35 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index c07e0c1..4743954 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -715,8 +715,8 @@ static inline size_t st_add(size_t a, size_t b)
>>                     (uintmax_t)a, (uintmax_t)b);
>>         return a + b;
>>  }
>> -#define st_add3(a,b,c)   st_add((a),st_add((b),(c)))
>> -#define st_add4(a,b,c,d) st_add((a),st_add3((b),(c),(d)))
>> +#define st_add3(a,b,c)   st_add(st_add((a),(b)),(c))
>> +#define st_add4(a,b,c,d) st_add(st_add3((a),(b),(c)),(d))
>
> Nit: maybe a comment around those lines would make sure that people do
> not inadvertently change them back later.

Maybe, maybe not. I'm hesitant for the following reason.

Unless we determine the exact compiler bug and patch which fixed it,
we don't really have a good handle on what triggers this crash.
Consequently, even with a comment saying "don't change the code in
such and such a way", if someone ever does need to modify st_add4() in
some fashion, it's entirely possible that the modification will
trigger the crash again, even if the current evaluation order is kept
or only modified slightly. We just don't know.

So, such a comment doesn't strike me as having a lot of value, and
whatever value it does have wanes as this old compiler (gcc 4.2.1) and
these old platforms (Mac OS X 10.6 and FreeBSD 9.x) become less and
less relevant over time.
