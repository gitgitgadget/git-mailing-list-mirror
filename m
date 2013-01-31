From: Jeff King <peff@peff.net>
Subject: Re: Segmentation fault with latest git (070c57df)
Date: Thu, 31 Jan 2013 02:35:43 -0500
Message-ID: <20130131073543.GA5342@sigill.intra.peff.net>
References: <28799936.346521359596121253.JavaMail.weblogic@epmltmp3>
 <20130131064921.GB24660@sigill.intra.peff.net>
 <CALWbr2y8veWYRwEGrbGq-PhxZjXbBF5HMgQXrRr=1JzGQ9Y-tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jongman Heo <jongman.heo@samsung.com>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 08:36:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0ogq-0000kD-78
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 08:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820Ab3AaHfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 02:35:47 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54471 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754239Ab3AaHfq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 02:35:46 -0500
Received: (qmail 4168 invoked by uid 107); 31 Jan 2013 07:37:09 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Jan 2013 02:37:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jan 2013 02:35:43 -0500
Content-Disposition: inline
In-Reply-To: <CALWbr2y8veWYRwEGrbGq-PhxZjXbBF5HMgQXrRr=1JzGQ9Y-tQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215104>

On Thu, Jan 31, 2013 at 08:02:06AM +0100, Antoine Pelisse wrote:

> In "clean.c" we have a "string_list" created on the stack with
> "STRING_LIST_INIT_NODUP" (there are probably others, I stopped at the
> first occurrence).
> But, "STRING_LIST_INIT_NODUP" doesn't init the "list->cmp" pointer
> which can thus be random.

I don't think that is the problem. Extra struct members that are not
mentioned by an initializer will get set to 0 or NULL.

A code path that tried to initialize each member individually would run
into problems, but I could not find any such code path (all of them
either use an initializer, are static, or memset the struct to
all-zeroes).

-Peff
