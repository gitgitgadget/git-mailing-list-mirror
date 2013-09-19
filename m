From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Thu, 19 Sep 2013 15:47:37 +0200
Message-ID: <523B0079.6000404@gmail.com>
References: <523094F0.9000509@gmail.com> <20130911182921.GE4326@google.com> <CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com> <20130911214116.GA12235@sigill.intra.peff.net> <CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com> <20130912101419.GY2582@serenity.lan> <xmqq61u6qcez.fsf@gitster.dls.corp.google.com> <20130912182057.GB32069@sigill.intra.peff.net> <CAHGBnuPzzokV7YMrx0gAL1VACcmaLwFoaB3n6bX8Y-UDHs7S8A@mail.gmail.com> <20130912213149.GK4326@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 19 15:48:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMeaL-00010B-VN
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 15:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123Ab3ISNry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 09:47:54 -0400
Received: from mail-ee0-f48.google.com ([74.125.83.48]:56480 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab3ISNrx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 09:47:53 -0400
Received: by mail-ee0-f48.google.com with SMTP id l10so4189611eei.35
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 06:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=hWmUTM+cxcJ0Z31kNzpsDNbW93CiRDl8pbc2j7QWUIU=;
        b=Gf6LSFIC+uKOxI46G8k2fdjL9bBtE1DwTbnEH9xPtt4ePy6kEycVHO9mG5ZzNmCb8j
         AdkdZL26nQ1cKqH03eoc+Ot61i/gmIol8KbHDQufnW33s6agsNovpgha//6JmIgBrGSM
         FXR7BpKfj2aI3ESU3n7CdBdosQOXpcSgu5XyHLOHG9cvqWA2efSldnQ6zidzFRuP8m4w
         XO4TQcHeB4e7K3ySwWFAKipkSGygzN5RavbzldZDipIUA0aurGcJ2gUW/GVRNc5+KsxQ
         mky9t0gRE+sP9sZeDPfvt4MV0fCN30Aqhvhmj/HRh5Xp33nwTo9ebOZM+2EdynWuJpW/
         a9vQ==
X-Received: by 10.14.98.8 with SMTP id u8mr2320873eef.59.1379598472459;
        Thu, 19 Sep 2013 06:47:52 -0700 (PDT)
Received: from [192.168.188.20] (p4FC97B80.dip0.t-ipconnect.de. [79.201.123.128])
        by mx.google.com with ESMTPSA id a1sm11489664eem.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 19 Sep 2013 06:47:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20130912213149.GK4326@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235017>

On 12.09.2013 23:31, Jonathan Nieder wrote:

>> And that's exactly what defining __NO_INLINE__ does. Granted, defining
>> __NO_INLINE__ in the scope of string.h will also add a "#define
>> strcasecmp _stricmp"; but despite it's name, defining __NO_INLINE__
>> does not imply a performance hit due to functions not being inlined
>> because it's just the "strncasecmp" wrapper around "_strnicmp" that's
>> being inlined, not "_strnicmp" itself.
>
> What I don't understand is why the header doesn't use "static inline"
> instead of "extern inline".  The former would seem to be better in
> every way for this particular use case.
>
> See also <http://www.greenend.org.uk/rjk/tech/inline.html>, section
> "GNU C inline rules".

I've suggested this at [1] now to see if such a patch is likely to be 
accepted.

[1] http://article.gmane.org/gmane.comp.gnu.mingw.user/42993

-- 
Sebastian Schuberth
