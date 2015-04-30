From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] git-compat-util.h: implement a different ARRAY_SIZE
 macro for for safely deriving the size of array
Date: Thu, 30 Apr 2015 13:44:41 -0400
Message-ID: <20150430174440.GC21800@peff.net>
References: <1430397854-28908-1-git-send-email-gitter.spiros@gmail.com>
 <xmqqd22l1pkl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 19:44:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnsW0-0003uH-GD
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 19:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbbD3Roo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 13:44:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:52332 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750878AbbD3Ron (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 13:44:43 -0400
Received: (qmail 8863 invoked by uid 102); 30 Apr 2015 17:44:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Apr 2015 12:44:43 -0500
Received: (qmail 6975 invoked by uid 107); 30 Apr 2015 17:45:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Apr 2015 13:45:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Apr 2015 13:44:41 -0400
Content-Disposition: inline
In-Reply-To: <xmqqd22l1pkl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268081>

On Thu, Apr 30, 2015 at 10:41:30AM -0700, Junio C Hamano wrote:

> Elia Pinto <gitter.spiros@gmail.com> writes:
> 
> > +#if defined(__GNUC__) && (__GNUC__ >= 3)
> > +# if GIT_GNUC_PREREQ(3, 1)
> > + /* &arr[0] degrades to a pointer: a different type from an array */
> > +# define BARF_IF_IS_NOT_AN_ARRAY(arr)						\
> > +	BUILD_ASSERT_OR_ZERO(!__builtin_types_compatible_p(typeof(arr), \
> > +							typeof(&(arr)[0])))
> > +# else
> > +#  define BARF_IF_IS_NOT_AN_ARRAY(arr) 0 
> > +# endif
> [...]
> 
> Hmmmmmmmm.
> 
>     CC ws.o
> ws.c: In function 'parse_whitespace_rule':
> ws.c:46:3: error: unknown type name 'typeof'
>    for (i = 0; i < ARRAY_SIZE(whitespace_rule_names); i++) {
>    ^
> 
> $ gcc --version
> gcc (Ubuntu 4.8.2-19ubuntu1) 4.8.2
> Copyright (C) 2013 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There
> is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
> PURPOSE.

ISTR that you compile with "-std=c89". typeof was added in c99, I think
(and was a GNU extension before that). I wonder if that is fooling the
gcc version-check.

-Peff
