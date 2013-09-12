From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Thu, 12 Sep 2013 14:31:49 -0700
Message-ID: <20130912213149.GK4326@google.com>
References: <523094F0.9000509@gmail.com>
 <20130911182921.GE4326@google.com>
 <CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
 <20130911214116.GA12235@sigill.intra.peff.net>
 <CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
 <20130912101419.GY2582@serenity.lan>
 <xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
 <20130912182057.GB32069@sigill.intra.peff.net>
 <CAHGBnuPzzokV7YMrx0gAL1VACcmaLwFoaB3n6bX8Y-UDHs7S8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 23:31:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKEUY-0006qW-E6
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 23:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296Ab3ILVby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 17:31:54 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:42208 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421Ab3ILVbx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 17:31:53 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so354904pdj.8
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 14:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mJxf7B/q1n9uRAHlBxowwBCKaJhLHt36UYfse6NZy1U=;
        b=hEefTvDZtN3SiZBGLegHPVPUGkFqXoVNWbiZVPRmKGUd9ruCVGNQKQZ0lZf5r8aanP
         zJs7cJiuRDY3ZXlEvw8TcCHLHsePPdNZqJLlCn7o5crZZYE5mnHPk9lqPIhNQG4qt9TF
         nPViFx0uPXjCk805/owHUM6Qbbhq7ZRFrv/v922Qfdb8MxXZW9sZUE53gbxve+lxpMbN
         zq1sHS8umSVr+PH47UM73wuhLc21qJW5CVBXGgtTngTAEMAKn123BoCwalGThgMv5/KJ
         XXEzgsh9xGXV9ts3b9BWv5hdaj9YSyzj0BNjr1YcAxfvIjtK5jsLZZ2SInJrIaPVFYyY
         tTMw==
X-Received: by 10.68.59.38 with SMTP id w6mr8783749pbq.135.1379021512986;
        Thu, 12 Sep 2013 14:31:52 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id k4sm7032514pbd.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 12 Sep 2013 14:31:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHGBnuPzzokV7YMrx0gAL1VACcmaLwFoaB3n6bX8Y-UDHs7S8A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234700>

Sebastian Schuberth wrote:

> And that's exactly what defining __NO_INLINE__ does. Granted, defining
> __NO_INLINE__ in the scope of string.h will also add a "#define
> strcasecmp _stricmp"; but despite it's name, defining __NO_INLINE__
> does not imply a performance hit due to functions not being inlined
> because it's just the "strncasecmp" wrapper around "_strnicmp" that's
> being inlined, not "_strnicmp" itself.

What I don't understand is why the header doesn't use "static inline"
instead of "extern inline".  The former would seem to be better in
every way for this particular use case.

See also <http://www.greenend.org.uk/rjk/tech/inline.html>, section
"GNU C inline rules".

Thanks,
Jonathan
