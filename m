From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] bisect: save heap memory. allocate only the required
 amount
Date: Tue, 26 Aug 2014 08:43:44 -0400
Message-ID: <20140826124344.GF29180@peff.net>
References: <1408889844-5407-1-git-send-email-arjun024@gmail.com>
 <53FA0054.5060808@gmail.com>
 <CAPc5daWheSH8E-PycSUq2Coqp19t_+_6TuBEOKhK4QwsEtzkkA@mail.gmail.com>
 <20140825130732.GD17288@peff.net>
 <xmqq8umcl0al.fsf@gitster.dls.corp.google.com>
 <20140826110303.GA25736@peff.net>
 <53FC7621.7090102@ramsay1.demon.co.uk>
 <20140826121359.GA29180@peff.net>
 <53FC7F98.5070204@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Aug 26 14:43:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMG6J-0008L2-7V
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 14:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757736AbaHZMnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 08:43:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:59174 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754553AbaHZMnq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 08:43:46 -0400
Received: (qmail 17013 invoked by uid 102); 26 Aug 2014 12:43:46 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 07:43:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 08:43:44 -0400
Content-Disposition: inline
In-Reply-To: <53FC7F98.5070204@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255898>

On Tue, Aug 26, 2014 at 01:37:44PM +0100, Ramsay Jones wrote:

> > On my 64-bit system using gcc, sizeof() returns 16; it has to pad the
> > whole thing to 64-bit alignment in case I put two of them in an array.
> > But offsetof(name) is 12, since the array of char does not need the same
> > alignment; it can go right after the type and make use of the padding
> > bits.
> 
> Hmm, interesting. I must re-read the standard. I was convinced that the
> standard *requires* any alignment padding to come *before* the name field.
> (how would you put a, non-trivial, variable data structure into an array?)

I think you don't. How would you compute a[1] if a[0] has a variable
size?

You can put a flex-array structure into an array, but then each element
has the flex member as zero-size (and you should not access it, of
course).

-Peff
