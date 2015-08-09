From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] send-email: provide whitelist of SMTP AUTH mechanisms
Date: Sun, 9 Aug 2015 13:19:58 -0400
Message-ID: <CAPig+cRenkDWeQWR_QFvy_mrH=n5=hz6kaB3PMd_LLbPWN3U1g@mail.gmail.com>
References: <1438533769-17460-1-git-send-email-viktorin@rehivetech.com>
	<CAPig+cQwFxVtO1C_RAumGP6_et21ggORB4jhpcUtBYNznNH1qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Jan Viktorin <viktorin@rehivetech.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 19:20:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOUGh-0008Np-W8
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 19:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933120AbbHIRUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 13:20:00 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35561 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933108AbbHIRT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 13:19:59 -0400
Received: by ykdz80 with SMTP id z80so12011628ykd.2
        for <git@vger.kernel.org>; Sun, 09 Aug 2015 10:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=GiOSUFgttRDHNtYVnG46ZzlPfjxa/AZu6fstmhMrqkY=;
        b=ZmtISx0Ay8PN5HGHux/RMgc9cGgcJpBp9hv06XxdAp8Syw1jzQyUs26dAbArZhM3qG
         nZFVOhXizXrbiy/FIdKHpn7taZIGaaUTsQFexH1vWnNdseF1iHxhzdhITb8x6LhHQQAc
         rMb9LX0THq7UCBpRpYmqYTDHAssCMqRpzZg78VSawEh2hY0AL2iURswPFE8vr2tzZuVa
         oqJwp/oPMB5POo0yECYiCjMJD2ipqVfGbWWB85XsuxQ55uY92u+gW2wgrMe0z4Sqml1z
         FiVVKYQvpMz8gIAVcRGVC8KN7/wSKacxlednexk6SorzFYN8fgvEHuhMtK7XUzJboLbC
         Rbwg==
X-Received: by 10.170.81.133 with SMTP id x127mr17483972ykx.13.1439140798687;
 Sun, 09 Aug 2015 10:19:58 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sun, 9 Aug 2015 10:19:58 -0700 (PDT)
In-Reply-To: <CAPig+cQwFxVtO1C_RAumGP6_et21ggORB4jhpcUtBYNznNH1qA@mail.gmail.com>
X-Google-Sender-Auth: oh6Mnz8gWlufHmtiXCxuQZj6QpI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275553>

On Sun, Aug 2, 2015 at 2:57 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Aug 2, 2015 at 12:42 PM, Jan Viktorin <viktorin@rehivetech.com> wrote:
>> @@ -1136,6 +1141,10 @@ sub smtp_auth_maybe {
>>                 Authen::SASL->import(qw(Perl));
>>         };
>>
>> +       if($smtp_auth !~ /^(\b[A-Z0-9-_]{1,20}\s*)*$/) {
>> +               die "invalid smtp auth: '${smtp_auth}'";
>> +       }
>
> Style: space after 'if'

By the way, I notice that Authen::SASL::Perl implementation itself
normalizes the incoming mechanism to uppercase, if necessary:

    $mechanism =~ s/^\s*\b(.*)\b\s*$/$1/g;
    $mechanism =~ s/-/_/g;
    $mechanism =  uc $mechanism;

Since it doesn't require uppercase, it's not clear how much benefit
there is to adding a strict regex check to git-send-email.
