From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] gc: config option for running --auto in background
Date: Mon, 10 Feb 2014 20:17:28 +0700
Message-ID: <CACsJy8BBQ3Bh6q6JM8V-QVKfzwp1w99+u4_55jjGbHLV3c62gA@mail.gmail.com>
References: <xmqqd2j2afup.fsf@gitster.dls.corp.google.com> <1391843332-20583-1-git-send-email-pclouds@gmail.com>
 <1391843332-20583-2-git-send-email-pclouds@gmail.com> <CABPQNSb3=i8F+vPEG3RmH+snZVZ-xrPtcVY2Nx9uvyTCLXcy6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, chris <jugg@hotmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 10 14:18:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCqkO-00028K-7k
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 14:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbaBJNR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 08:17:59 -0500
Received: from mail-qc0-f173.google.com ([209.85.216.173]:58624 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206AbaBJNR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 08:17:59 -0500
Received: by mail-qc0-f173.google.com with SMTP id i8so10547602qcq.32
        for <git@vger.kernel.org>; Mon, 10 Feb 2014 05:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gKvcr1yIOuS2qryeHBjZit+DPhf75bOSLORIG9DQO/Y=;
        b=JwCoJ/OwP7dxJGbYHSoCD3fQbB6mWYHEK6SEyjLLQKH1gTRhIBDFs7pcp168jBqEYf
         Hz82xoGL8QjddyDafbNE8iXtSN6ahiby/rqj12xr+eVtu5fpblp2LZMw5ZMkT282dzGv
         G2PK0tdnO1UhnNJJ9rkO3QMvOYZ7VySs20pqdnZdBcrIaBrAM+roLZB6XXUJ3aBzvwaJ
         +tRyERHng0ff3XPBQKpvfoI3Hl3BnB35KC8cHISidi3z1RfhGvQ5lp4/8atibKTC8HOV
         St4hFnXK2OKaMve8OL4OzCyQRCmkKy5Z/mo7P5IPc+KxIA4B0aYX7sIoD3yxcuqcN/CZ
         kvSg==
X-Received: by 10.224.36.129 with SMTP id t1mr44568963qad.8.1392038278601;
 Mon, 10 Feb 2014 05:17:58 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Mon, 10 Feb 2014 05:17:28 -0800 (PST)
In-Reply-To: <CABPQNSb3=i8F+vPEG3RmH+snZVZ-xrPtcVY2Nx9uvyTCLXcy6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241912>

On Mon, Feb 10, 2014 at 6:03 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> `gc --auto` takes time and can block the user temporarily (but not any
>> -               if (!quiet)
>> -                       fprintf(stderr,
>> -                                       _("Auto packing the repository for optimum performance. You may also\n"
>> -                                       "run \"git gc\" manually. See "
>> -                                       "\"git help gc\" for more information.\n"));
>> +               if (!quiet) {
>> +                       if (detach_auto)
>> +                               fprintf(stderr, _("Auto packing the repository in background for optimum performance.\n"));
>> +                       else
>> +                               fprintf(stderr, _("Auto packing the repository for optimum performance.\n"));
>> +                       fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
>> +               }
>> +               if (detach_auto)
>> +                       /*
>> +                        * failure to daemonize is ok, we'll continue
>> +                        * in foreground
>> +                        */
>> +                       daemonize();
>
> While I agree that it should be OK, shouldn't we warn the user?

If --quiet is set, we should not be printing anyway. If not, I thinkg
we could only print "auto packing in background.." when we actually
can do that, else just print the old message. It means an #ifdef
NO_POSIX_GOODIES here again though..
-- 
Duy
