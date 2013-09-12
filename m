From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Thu, 12 Sep 2013 14:36:33 -0700
Message-ID: <20130912213633.GL4326@google.com>
References: <20130911182921.GE4326@google.com>
 <CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
 <20130911214116.GA12235@sigill.intra.peff.net>
 <CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
 <20130912101419.GY2582@serenity.lan>
 <xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
 <20130912182057.GB32069@sigill.intra.peff.net>
 <xmqqd2odq45y.fsf@gitster.dls.corp.google.com>
 <20130912183849.GI4326@google.com>
 <CAHGBnuPejvs_zTdV52GWVCF35+Bdih2c1zNuBdHJRd_2ShcnKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 23:36:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKEZ8-000358-8p
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 23:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754963Ab3ILVgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 17:36:38 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:53421 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768Ab3ILVgh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 17:36:37 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so357415pdj.32
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 14:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HJyi+RddOFtEgEBKh3773+iNO1lqesH8QCVKbdeWe0k=;
        b=sx0UTlM2f+4U3XoKUOVwYtlsPa9soDfbu+HpO2E5LHYVT76yXO4RVxo76O9czj1uWC
         6Ku+bEp3l7kCyxp5KHjlK4QflvwWmW6VcCGSSkzdANE1sFbzrs7fDdYV3U5y3y09kCHN
         urRo3PMcPJdo42XTAhnm0GBAPFUsRNWqdah3J3SCOjOwAQY77FAHKmOLs+SS44ri3UVa
         ZkXSX3TXAWyi0S+pCOqGnIrjJqXJYKazxI4wSkosGRupAhuzuWUGLOYkuYOIdsZHokIu
         n1JBhc7z03RpMsOtFzqIuJHJ8n55iBPe0QJv6Fy6auCJ9SCV+V/tEju/NA3iwy7ewaC4
         rEwQ==
X-Received: by 10.66.27.175 with SMTP id u15mr11479134pag.146.1379021797347;
        Thu, 12 Sep 2013 14:36:37 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id u7sm7045939pbf.12.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 12 Sep 2013 14:36:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHGBnuPejvs_zTdV52GWVCF35+Bdih2c1zNuBdHJRd_2ShcnKQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234701>

Sebastian Schuberth wrote:

> I'm not too happy with the wording either. As I see it, even on MinGW
> runtime version 4.0 it's not true that "string.h has _only_ inline
> definition of strcasecmp"; there's also "#define strncasecmp
> _strnicmp"

I assume you mean "#define strcasecmp _stricmp", which is guarded by
defined(__NO_INLINE__).  I think what Junio meant is that by default
(i.e., in the !defined(__NO_INLINE__) case) string.h uses
__CRT_INLINE, defined as

	extern inline __attribute__((__gnu_inline__))

to suppress the non-inline function definition.

Jonathan
