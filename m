From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] read_directory: avoid invoking exclude machinery on
 tracked files
Date: Sun, 17 Feb 2013 11:39:28 +0700
Message-ID: <CACsJy8C9SGJxwnm1E2N_KyEMg5-MzDt2B+SrX7rygn8X1qq4Wg@mail.gmail.com>
References: <1360937848-4426-1-git-send-email-pclouds@gmail.com>
 <1360999078-27196-1-git-send-email-pclouds@gmail.com> <20130216181110.GA27233@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>, kusmabite@gmail.com,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>, finnag@pvv.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 05:40:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6w3M-0000FE-F1
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 05:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445Ab3BQEkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2013 23:40:01 -0500
Received: from mail-oa0-f52.google.com ([209.85.219.52]:50991 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400Ab3BQEkA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2013 23:40:00 -0500
Received: by mail-oa0-f52.google.com with SMTP id k14so5022183oag.11
        for <git@vger.kernel.org>; Sat, 16 Feb 2013 20:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=JCJ91zktdcJVNza6Tgx/yZfWzdwSlodWUYPo3dPrnUA=;
        b=n40UdxBJNuQ1C0ksq+oUPmg84xdLoGIFK2I3GHpF2IUl9JXz+0rHTcMlHdgJDMquTA
         DvIXR+1vn54GBovqV6e2vr+soIG4mwOuXfUafgmC0YxJwTjToAgeMZ4bqAO923YiJXkJ
         dTYXw60Z6dUuction6eNR8pfa9o63AB8mOT3V7x0RqlOy7Q1Q8odN+Ltt7Zjcj+AlzN9
         +WwOs2N5Qsy5E8JcwIEZiZ+TKvTOvuel+C8Gn5p1TZa5QzYY/HfGj7wZIW2piBkdo/c3
         WfQZcODbipU5QTQSmM8zNvDQ79ajf1/sXlSpKJRppM4YAbGoxbiqmD8dh+R8z1MrgJwG
         gQSA==
X-Received: by 10.60.5.231 with SMTP id v7mr4341442oev.62.1361075998874; Sat,
 16 Feb 2013 20:39:58 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Sat, 16 Feb 2013 20:39:28 -0800 (PST)
In-Reply-To: <20130216181110.GA27233@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216384>

On Sun, Feb 17, 2013 at 1:11 AM, Pete Wyckoff <pw@padd.com> wrote:
> pclouds@gmail.com wrote on Sat, 16 Feb 2013 14:17 +0700:
>> Finally some numbers (best of 20 runs) that shows why it's worth all
>> the hassle:
>>
>> git status   | webkit linux-2.6 libreoffice-core gentoo-x86
>> -------------+----------------------------------------------
>> before       | 1.097s    0.208s           0.399s     0.539s
>> after        | 0.736s    0.159s           0.248s     0.501s
>> nr. patterns |    89       376               19          0
>> nr. tracked  |   182k       40k              63k       101k
>
> Thanks for this work.  I repeated some of the tests across NFS,
> where I'd expect to see bigger differences.

This is about reducing CPU processing time, not I/O time. So no bigger
differences is expected. I/O time can be reduced with inotify, or fam
in nfs case because inotify does not support nfs.

> Best of 20 values reported in "min ...".
>
>     webkit
>     Stock min  9.61 avg 11.61 +/- 1.35 max 14.26
>     Duy   min  6.91 avg  7.67 +/- 0.46 max  8.71
>
>     linux
>     Stock min  2.27 avg  3.16 +/- 0.56 max  4.49
>     Duy   min  2.04 avg  3.12 +/- 0.69 max  4.87
>
>     libreoffice-core
>     Stock min  4.56 avg  5.79 +/- 0.79 max  7.08
>     Duy   min  3.96 avg  5.25 +/- 0.95 max  6.95
>
> Similar 30%-ish speedup on webkit.  And an absolute gain
> of 2.7 seconds is quite nice.
>
>                 -- Pete



-- 
Duy
