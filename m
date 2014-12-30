From: Alex Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH v3] send-email: Improve format of smtp initialization error message
Date: Tue, 30 Dec 2014 16:59:04 +0600
Message-ID: <87iogt4d53.fsf@gmail.com>
References: <1419875601-20836-1-git-send-email-kuleshovmail@gmail.com> <xmqqppb2z3w9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>, git@vger.kernel.org,
	Thomas Gummerer <t.gummerer@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 11:59:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5uWB-0006Jv-At
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 11:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631AbaL3K7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 05:59:11 -0500
Received: from mail-la0-f45.google.com ([209.85.215.45]:44615 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbaL3K7J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 05:59:09 -0500
Received: by mail-la0-f45.google.com with SMTP id gq15so12585390lab.18
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 02:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version:content-type;
        bh=N1pwenJWimOyM8WtIyScGuHmJzWhFbAnEos+b4PjVkk=;
        b=t+T/BSsOn6a+0umu+Rx54Xh6ph6Wuqu3qhYKylUXPPrm7lPQolTfrciiyz5BWR5rO3
         RHZfEsLixKg/YEmek5u3KdL59mmT6IaC088G7Cyq4wAKqjNBZ7mrDIxqSJeYXffw89RA
         WuS5jt8WNjNBIIanprl+WZkZOS2KQ9PpX7ta5OjvvifVZ/Ajgb7xKs+m1/BkZxFw+jhT
         S4GUg3hF78jHyMliOevmpZ1GDNq+4ocuVKmNbbbv2QpFA+s9hUadmNkA8OVVk2QPZ3yj
         kEPYf7Z8+Tq5GECsnyRx1OGe7KEC24RqlKpSFqAgmfB8Mz84UZVak8VNiWbEH9ktV8V6
         LeGw==
X-Received: by 10.152.29.6 with SMTP id f6mr62003585lah.32.1419937148325;
        Tue, 30 Dec 2014 02:59:08 -0800 (PST)
Received: from alex-desktop ([178.91.245.142])
        by mx.google.com with ESMTPSA id ap3sm10572626lbc.48.2014.12.30.02.59.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Dec 2014 02:59:07 -0800 (PST)
In-reply-to: <xmqqppb2z3w9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261922>

What's about output like this:

Unable to initialize SMTP properly. Check config and use --smtp-debug.

VALUES:
	server=smtp.gmail.com
	encryption=
	hello=localhost.localdomain
	port=587

Junio C Hamano <gitster@pobox.com> @ 2014-12-30 00:50 QYZT:

> Alexander Kuleshov <kuleshovmail@gmail.com> writes:
>
>> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
>> ---
>>  git-send-email.perl | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 82c6fea..60dcd8d 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -1275,10 +1275,10 @@ X-Mailer: git-send-email $gitversion
>>
>>  		if (!$smtp) {
>>  			die "Unable to initialize SMTP properly. Check config and use --smtp-debug. ",
>> -			    "VALUES: server=$smtp_server ",
>> -			    "encryption=$smtp_encryption ",
>> -			    "hello=$smtp_domain",
>> -			    defined $smtp_server_port ? " port=$smtp_server_port" : "";
>> +			    "\nVALUES: \n\tserver=$smtp_server ",
>> +			    "\n\tencryption=$smtp_encryption ",
>> +			    "\n\thello=$smtp_domain",
>> +			    defined $smtp_server_port ? " \n\tport=$smtp_server_port" : "";
>
> It may be a good convention to have LF at the beginning of a new
> string (i.e. we terminate the old line only when we have something
> more to say), but that is true only when we want to end the sentence
> without the final newline.  I wonder if that is true in this case;
> do we want perl to say "at line # in file X" at the end?
>
> In any case, you have two output lines that ends with a trailing SP
> just before LF, which is probably not what you wanted.
>
> If we want to see all lines end with LF, it may be far easier to
> read this way:
>
> 	die "msg\n",
>             "\tvar1=val1\n",
>             "\tvar2=val2\n",
>             defined $var3 ? "\tvar3=val3\n" : "";
>
> I dunno.

--
Best regards.
0xAX
