From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 0/7] Fix some problems with reflog expiration
Date: Wed, 4 Mar 2015 16:18:29 -0800
Message-ID: <CAGZ79kY85u5fxM=sKFoRWj2OK6wzGXOieXTKn9z+YO6P8vS+EA@mail.gmail.com>
References: <1425382997-24984-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 05 01:18:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTJUo-0002wF-UM
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 01:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbbCEASa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 19:18:30 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:44564 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbbCEAS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 19:18:29 -0500
Received: by igdh15 with SMTP id h15so41594148igd.3
        for <git@vger.kernel.org>; Wed, 04 Mar 2015 16:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=imerfRxgfwrLj32N9yi/HTy3p1BKuw6Y35xVFMGKpc4=;
        b=IsAII0NpO4W3Xo4zl/I1hK9uiuxrkvPYkCMlifvP0E30Oy/4JFo0io/HudalIoTaDt
         Jzrom5Yl9UJZLgjDTJlUJ7P1b5NkXHD+UHgIn3KbJwoK/0QMeNVjpEoQK7bf7k4WcVmD
         SKRj/6qUy8vtjIrMS7ly6L229qTt5bU7wrn76ZNHXod7v4SOgAjmPaB1mfIwr99C8vVd
         Q4YLcjhs7qVlhmhei9dX8oLEwf/4WbRacQbUDkT7en7ZxFjwEH6rtl+3ah5rOCyPD9mQ
         /9zY6pvFDDXTwKrqg5qjjIpirfQ2l8LQ7hsz+xvZEo4TDtMQBrcxfMv4oyp/44u5q986
         56tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=imerfRxgfwrLj32N9yi/HTy3p1BKuw6Y35xVFMGKpc4=;
        b=JG5T5LxJWh0nDPLSXmObgnIPntyVg9sABDdiqZQNXPeHHALMC4AZHsXdYYqmMOOZ5o
         9DW+Zb1fqFA5pWGMsf1/KtkSEqsQzT3/L5bAaols3VV2JE0GuVWdTZ4oVNAZkKBDdkWO
         /TZK9Ai4GJLNgndYf1p0GNHQg1o2jW/cZymXvYhIBKEtLCMh0t/eVoMFV0YoVgRQpQsA
         by9Jng4979hrXAjC+T+Zbqa78L6t4SN2f9dISpnw9abwBgkiMyI6aztNsssoAdlrmGhW
         zhrVXLOPFnpDdC5zWaH6VSxqf6plgU2xl+r65hVWbek32NmjaIhtkULIutRvteWcdMFb
         GpCA==
X-Gm-Message-State: ALoCoQkT18dNsVgz4zFoBO3WEPQwwxQFbbpGPOI301S0ElKgy+su8P8br0bSrk3X0GeVCW0KCF3y
X-Received: by 10.50.107.36 with SMTP id gz4mr16528704igb.25.1425514709084;
 Wed, 04 Mar 2015 16:18:29 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Wed, 4 Mar 2015 16:18:29 -0800 (PST)
In-Reply-To: <1425382997-24984-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264797>

On Tue, Mar 3, 2015 at 3:43 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> This is v3 of the patch series. Thanks to Junio for his comments
> about v2 [1]; I think this version addresses all of his points.
>
> Changes since v2:
>
> * Introduce a temporary in "struct ref_lock: delete the force_write
>   member" to make a complicated boolean expression easier to
>   understand.
>
> * Split the documentation of options for "reflog expire" and "reflog
>   delete", and make another couple tweaks to the "reflog"
>   documentation.
>
> * Add a NEEDSWORK comment suggesting that the "reflog" command should
>   use parse_options() to process its command line.
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/264586

The whole series is
Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks for adjusting the commit from me to fit in better into the series.
Thanks,
Stefan

>
> Michael Haggerty (6):
>   write_ref_sha1(): remove check for lock == NULL
>   write_ref_sha1(): Move write elision test to callers
>   lock_ref_sha1_basic(): do not set force_write for missing references
>   reflog: improve and update documentation
>   reflog_expire(): ignore --updateref for symbolic references
>   reflog_expire(): never update a reference to null_sha1
>
> Stefan Beller (1):
>   struct ref_lock: delete the force_write member
>
>  Documentation/git-reflog.txt | 144 ++++++++++++++++++++++++++-----------------
>  builtin/reflog.c             |   9 +--
>  refs.c                       |  65 ++++++++++---------
>  3 files changed, 126 insertions(+), 92 deletions(-)
>
> --
> 2.1.4
>
