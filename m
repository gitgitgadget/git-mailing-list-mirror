From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 40/44] builtin-am: support and auto-detect mercurial patches
Date: Mon, 29 Jun 2015 13:32:56 -0700
Message-ID: <CAGZ79kbnxSD5bm_Bhjy8W2oY+1Mb=is_BcfbT5mGsb44fJE5nQ@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-41-git-send-email-pyokagan@gmail.com>
	<CAGZ79kbO+f2iwTE0dG2zx09SAPR3KTt7T5sw5AFmLuNpo8HG3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 22:33:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9fji-0007ex-BM
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 22:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbbF2Uc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 16:32:58 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:35306 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbbF2Uc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 16:32:56 -0400
Received: by ykdy1 with SMTP id y1so125587958ykd.2
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 13:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0tGVg73BXhtsg3UaQMpzrvay00itl1ebj27oRTwbFuc=;
        b=Ehb+R94Gilrk1YQRfn9obkwsxGckWR+t1QPf3Rwkwq2T7D4GkvonOL50oIP7Kg6Gsw
         B9/QNEUUTyWfnj3upeZyhrcagQbgtBbZL8f7mFGvrPkuv80bz9ArGa6Fy8MHTQUmPVod
         nP+GEzcn6wTIo3T8qFRoHAkO/Tu6ewYXPl15/RyH81or8XIUoq1j77vTTZH0k+/WLsvJ
         RYAc0HQelrh0U6NsApwdyXQcoebJlPkB9F3uDVoqSfos85ppOFhugohYxzUDFQdS+BIj
         Qh3G7UV+0t4HOmLdFE1OPUFbXANzXsoDDSX781FxcfeDAjvDS03R/S6t0lVr6SqYZkCz
         kP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0tGVg73BXhtsg3UaQMpzrvay00itl1ebj27oRTwbFuc=;
        b=bGHxKzVaPRBHqHcBAwdn0uWdLlJTuWDymEXTzu/9e+T/GWkxTlnJ9iX4/2jb5ujpgT
         3JpzgNO8tfW/Jf2HpPnrdZ0aiBjXc2P5YPjAvKWGurFTYqsRzH33GS2HEo7EIFoLdhPP
         WwmeqHwG1Ff1am2VuYQVfpY9TvDoooWK08TMPdxTseENAXnQyrZYpZvX7r0Kl8+1ro3a
         omEEYcuTsfnBmc45uk+YOzBF27vN8JZeoai0YbKSnUGNfPFbwje4yJP4AF2pgoIheYMl
         xaSPgsrxstAoPd8AcLQEGiJll+TesVqw6WzFdVuXrc1CP9afUgqcrRZk1KkECAAHEndy
         k68g==
X-Gm-Message-State: ALoCoQmdYNiQr7QohoyH+MgPheVwCL/nZFsy06hnh9L7Dqi6x2tQAZTtWqPFRcUnsp/0Ajc0NM8b
X-Received: by 10.129.98.198 with SMTP id w189mr12174542ywb.32.1435609976376;
 Mon, 29 Jun 2015 13:32:56 -0700 (PDT)
Received: by 10.37.4.80 with HTTP; Mon, 29 Jun 2015 13:32:56 -0700 (PDT)
In-Reply-To: <CAGZ79kbO+f2iwTE0dG2zx09SAPR3KTt7T5sw5AFmLuNpo8HG3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273016>

On Mon, Jun 29, 2015 at 1:32 PM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, Jun 28, 2015 at 7:06 AM, Paul Tan <pyokagan@gmail.com> wrote:
>> +                       tz = tz / (60 * 60) * 100 + tz % (60 * 60);
>
> What happens if we have a negative input not matching a full hour, say -5400 ?
> (would equate to 0130 in git)
>
> for calculating the minutes we would only need to take % 3600 (which
> you do), but
> then we still need to divide by 60 to convert seconds to minutes?
>

That said, I wonder if we have some helper functions around somewhere as we
need to convert the timezone data at many places.
