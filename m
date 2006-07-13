From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: [PATCH 2/5] daemon: if one of the standard fds is missing open it to /dev/null
Date: Thu, 13 Jul 2006 11:37:50 -0400
Message-ID: <118833cc0607130837u30c58d53lc785f56d45ef970c@mail.gmail.com>
References: <E1G0zj7-0001c1-8q@moooo.ath.cx> <E1G0znB-0002IO-61@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 17:38:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G13GH-0007XT-O1
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 17:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWGMPhz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 11:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWGMPhz
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 11:37:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:25257 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964783AbWGMPhy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 11:37:54 -0400
Received: by ug-out-1314.google.com with SMTP id m3so339631ugc
        for <git@vger.kernel.org>; Thu, 13 Jul 2006 08:37:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ekpRhIxqKVHSuzH0fHNU2dcii+aqd5kHC5XrT5VvuBn8Br7/nVrDpr0C0P/Fgy8FKWjtVrS1ewPH+RaCLBl6BENXLw8eEISv7YxA1Dno7aoOvhyDvmez6SqgU5XJV98oX6695cA00MRrP6zwmPzoPGbjTzb97yOoZHmw3iTboy0=
Received: by 10.67.100.17 with SMTP id c17mr186378ugm;
        Thu, 13 Jul 2006 08:37:50 -0700 (PDT)
Received: by 10.67.86.4 with HTTP; Thu, 13 Jul 2006 08:37:50 -0700 (PDT)
To: "Matthias Lederhofer" <matled@gmx.net>
In-Reply-To: <E1G0znB-0002IO-61@moooo.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23838>

> +               if (devnull == -1 &&
> +                       (devnull = open("/dev/null", O_RDWR, 0)) == -1)
> +                       die("open /dev/null failed: %s", strerror(errno));
> +               if (dup2(devnull, i) != i)
> +                       die("dup2 failed: %s", strerror(errno));

"die" probably won't work well at this point.

Should git (and most other programs) do something like this in general?
fprintf will happily write to fd=2 regardless of whether that is some critical
file you opened.

Morten
