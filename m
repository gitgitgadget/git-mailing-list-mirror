From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 0/5] Use watchman to reduce index refresh time
Date: Tue, 10 Nov 2015 16:04:28 -0500
Organization: Twitter
Message-ID: <1447189468.20147.32.camel@twopensource.com>
References: <1446386146-10438-1-git-send-email-pclouds@gmail.com>
	 <CAHVLzcn3j8eLi9VrNoZjyOZ2UzE7=NYF1bqB9UyKmghUoUw1Zg@mail.gmail.com>
	 <CACsJy8DzSEVJYc85-3vSAZ8wB1pR9TLz0RrKyKFfHth9Tq+xyg@mail.gmail.com>
	 <CACsJy8Dz17gRSHch9e=iB2Kq2t4FbssatW84DF8pHTuFMgEgjQ@mail.gmail.com>
	 <CAP8UFD0rAL62eFdtLo__ta=_Yhq4cdRcqmfYTqw3imNa5Lde-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 22:04:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwG5j-0002lm-Uf
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 22:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbbKJVEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 16:04:32 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33122 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbbKJVEb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 16:04:31 -0500
Received: by qkas77 with SMTP id s77so4548866qka.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2015 13:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=3K4Fvo1ve7pr6SVkWSh53dEx84BX6zGxiNtPLK5gslQ=;
        b=PZwyb1i131Nui5+NVHe8HSnVwRmoirs3YEq9/pal+7SsB7dWGzrO2Eygy0p2Qc6m8C
         nh3a5QiCr+lH2+6MzQHA8zCc76+iK5GpPeedkX1I2n8mihpIFAQu4GWeMSDV16eF6rbu
         /rbw1fLp7m4J077p6/KlXaOdggQhV+xoDYBxUoS8tLO48lr/+3YuU7tOV+nEDaqtzu3y
         vVcpO5r03NJRirHAOAWb6zONsBZ1CWxT19qZoWoq7+8FETxlucdtRdW0Fj/QHqhCiei4
         iDvB/JHWD+LOUy0CZc5Up8MWaEzxW2+F2CsczpdX8tLusbm4CoNoPyyzQBDsKQjgbk0r
         JtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=3K4Fvo1ve7pr6SVkWSh53dEx84BX6zGxiNtPLK5gslQ=;
        b=CUtKl23YxNP65hBlc3+Cn7l0vyBUzVXaa+sHRqr7A0TAq06s6O0+FQkcR5q/37eCg4
         G6LQPtxqBY/VcCoJMTsewccKlMPAD1rUIC48Q6hwG/aHdIKOD3VVy+OgD/sZhNtN9/ZS
         guPZzL2IG2EFwv6PuLptpgeQj13l9J4xDXqztx8+Nf06yAu9VmrHaEwiUG+C3CKOfOJi
         GJ32tMxv4fG3nBQAmB5poxtIORcYsYoqCR9aE7Y68x7DPassnnRXKj0koNMjswa+3oxt
         UlPpRVfsLwxFrANxzkN/W+Z/GCpLeednwDxbgmJXCcvHhG4Aw879BASzH/dvwxev+VKD
         o9kA==
X-Gm-Message-State: ALoCoQmQq1I9HyhYOWjaJQt9O21YBFWyZy7Qi18u2Tx5OxVXwK421OcvBSTTl5/yl94JDBnnOIKf
X-Received: by 10.55.72.66 with SMTP id v63mr7075131qka.105.1447189470665;
        Tue, 10 Nov 2015 13:04:30 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id b22sm2035292qge.23.2015.11.10.13.04.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Nov 2015 13:04:29 -0800 (PST)
In-Reply-To: <CAP8UFD0rAL62eFdtLo__ta=_Yhq4cdRcqmfYTqw3imNa5Lde-A@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281134>

On Mon, 2015-11-09 at 21:06 +0100, Christian Couder wrote:
> Using David's series I get worse results than all of the above but I
> guess it's because his series is based on an ancient git version
> (v2.0.0-rc0).

My more-recent series is on top of 2.4, but (for webkit):
mine: 0m0.206s 
duy's: 0m0.107s

However, I'm getting occasional index-helper segfaults due to
istate->last_update being NULL.  (I'm using Duy's  index-helper branch
from his github + this patchset + a function signature fix due to a
newer version of libwatchman).  I haven't looked into why this is --
maybe accidentally mixing git versions while testing?  

Also, after messing around for a while (on Duy's branch), I ended up in
a state where git status would take ~2.5s every time.  The index helper
was alive but evidently not working right.  Killing and restarting it
worked.  Actually, I think I can repro this more easily: "git rm
Changelog" seems to put the index-helper into this state.
