From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: sprintf security holes?
Date: Fri, 16 Sep 2005 12:11:16 -0400
Message-ID: <118833cc05091609111fd4d2d8@mail.gmail.com>
References: <86zmqd5aey.fsf@blue.stonehenge.com>
Reply-To: mwelinder@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 18:14:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGIo7-00060q-ER
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 18:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161171AbVIPQLR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 12:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161172AbVIPQLR
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 12:11:17 -0400
Received: from qproxy.gmail.com ([72.14.204.192]:13991 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161171AbVIPQLR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 12:11:17 -0400
Received: by qproxy.gmail.com with SMTP id k13so66332qbf
        for <git@vger.kernel.org>; Fri, 16 Sep 2005 09:11:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CLjSnK3NWyw2VPQKUHobl3CG7Q0HOPVKEJKnDWjhntKLFzXsHwEYHyNYz9ypw99ZCiy4hCXFwNSONsnZf5+W6N8lRSOa8Bsr7oHYuPY1hSE3H2DhkLllitpf6pAL2WyrRcMYqMjlXRTa1i9JpDYNAHYCdTgfBdbYsezvjF8dxfE=
Received: by 10.65.148.12 with SMTP id a12mr15108qbo;
        Fri, 16 Sep 2005 09:11:16 -0700 (PDT)
Received: by 10.65.107.8 with HTTP; Fri, 16 Sep 2005 09:11:16 -0700 (PDT)
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86zmqd5aey.fsf@blue.stonehenge.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8690>

> Since sprintf() can lead to buffer overflows from unprotected user
> data, and you want to use git in server situtations, wouldn't it be
> prudent to eliminate those in some near-ish timeframe?

I assume you mean make them into snprintf calls.

I don't think that really buys you anything, i.e., there would still be far
too many places where character pointers are derefenced and
assigned to.  You would probably have to create a small (and thus
auditable) generic strings library and do all string creation within
that.  That is certainly feasible, but evidently not Linus style.

There really is nothing wrong with sprintf that couldn't be said to be
wrong with snprintf, strcpy, strncpy, *p++ = 0, etc.  If you don't have
the right amount of memory allocated, you lose.  (Yes, that goes for
the "n" versions too, although in many cases you could syntactically
check that a "sizeof" was used.  Then you just get to worry whether
random truncation introduced other security problems.)

Morten
