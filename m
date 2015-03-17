From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4/GSoC/MICRO] revision: forbid combining --graph and --no-walk
Date: Tue, 17 Mar 2015 19:24:40 -0400
Message-ID: <CAPig+cRUqwcunX8mGKbsyBZPeTrz92jqvBJtDKfXvVzHvbun2g@mail.gmail.com>
References: <1425632110-31863-1-git-send-email-dongcan.jiang@gmail.com>
	<c6c08cdbbc0060c6d834c86d13a142cde290dc5c.1426039099.git.dongcan.jiang@gmail.com>
	<xmqq4mpjmcvv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dongcan Jiang <dongcan.jiang@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 00:24:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY0qs-00015e-8P
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 00:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbbCQXYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 19:24:42 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:34104 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbbCQXYl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 19:24:41 -0400
Received: by ykfc206 with SMTP id c206so10062570ykf.1
        for <git@vger.kernel.org>; Tue, 17 Mar 2015 16:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=I/j4rK6DELzG2I9aBGxxKvKaj+t7Lw9Y3hRxTHDxQEU=;
        b=xLRdwQoiioVpzgza0FKj2CtRTpN+KDJqXt1e9LMntTDxAkS+exluf3Q0JTw4O1sa4h
         0kD5Ro/QBCehkSDh3Om8tYo3EESOtm8JpMpAcpKm2mKE2cNJVyPeyqME9VE2TB7E+kBH
         Gn5w76p38tjlmOjsIOhoNURnyXnR1hFdJe7ccYPNRZPq9i/ELFiJRxp+74X4OVz6SCIf
         kVzHS1WGr4MWsjyHKNuKQbNf6F3trWBNW3ZgtcVrSchKpstjWRYEQIzHOhHDwfEfDMlg
         jF7cRbUnjLub7HOhN81EtjWp5txpSNecW5lu0/F1gcjRqvGcX+53AwiMfkrI19KZ8V98
         u42A==
X-Received: by 10.170.163.67 with SMTP id f64mr48760484ykd.74.1426634680427;
 Tue, 17 Mar 2015 16:24:40 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Tue, 17 Mar 2015 16:24:40 -0700 (PDT)
In-Reply-To: <xmqq4mpjmcvv.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: nS5YPdhyq29uaV9pbCPKRCruvcs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265677>

On Tue, Mar 17, 2015 at 7:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dongcan Jiang <dongcan.jiang@gmail.com> writes:
>> diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
>> index b68afef..a989e8f 100755
>> --- a/t/t4052-stat-output.sh
>> +++ b/t/t4052-stat-output.sh
>> @@ -99,7 +99,7 @@ do
>>               test_cmp "$expect" actual
>>       '
>>
>> -     test "$cmd" != diff || continue
>> +     test "$cmd" != diff -a "$cmd" != show || continue
>
> I think we avoid -a and -o used with test (don't we have a write-up
> on this somewhere?).

The very last item in the shell script section of CodingGuidelines discusses it.

> Write it like this
>
>         test "$cmd" != diff &&
>         test "$cmd" != show || continue
>
> or perhaps like this
>
>         case "$cmd" in diff|show) continue ;; esac
