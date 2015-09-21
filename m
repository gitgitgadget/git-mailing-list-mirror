From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 66/67] use strbuf_complete to conditionally append slash
Date: Mon, 21 Sep 2015 11:17:05 -0400
Message-ID: <20150921151704.GB25286@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915161619.GN29753@sigill.intra.peff.net>
 <CAPig+cS=SQxPVGg9XGmo-SqZ71dkZ9uWrtM4AQ8kMN1e2KUKcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 17:17:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze2q9-0007Jj-7f
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 17:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756811AbbIUPRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 11:17:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:33956 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752476AbbIUPRH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 11:17:07 -0400
Received: (qmail 15778 invoked by uid 102); 21 Sep 2015 15:17:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Sep 2015 10:17:06 -0500
Received: (qmail 27774 invoked by uid 107); 21 Sep 2015 15:17:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Sep 2015 11:17:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Sep 2015 11:17:05 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cS=SQxPVGg9XGmo-SqZ71dkZ9uWrtM4AQ8kMN1e2KUKcQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278305>

On Sun, Sep 20, 2015 at 09:50:28PM -0400, Eric Sunshine wrote:

> > diff --git a/builtin/clean.c b/builtin/clean.c
> > index df53def..d7acb94 100644
> > --- a/builtin/clean.c
> > +++ b/builtin/clean.c
> > @@ -159,8 +159,7 @@ static int is_git_repository(struct strbuf *path)
> >         int gitfile_error;
> >         size_t orig_path_len = path->len;
> >         assert(orig_path_len != 0);
> > -       if (path->buf[orig_path_len - 1] != '/')
> > -               strbuf_addch(path, '/');
> > +       strbuf_complete(path, '/');
> 
> Does the above assert() still have value following this change? I
> recall, when reviewing this code, specifically asking[1,2] for an
> assert() or some other check to show that accessing buf[orig_path_len
> - 1] was safe. Since this patch removes the code in question, the
> assert() may no longer have meaning.
> 
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/266839/focus=266892
> [2]: http://thread.gmane.org/gmane.comp.version-control.git/266839/focus=266974

I didn't dig that far, as I was mostly aiming for an obvious
no-behavior-change transition to the new helper, and dropping the assert
means we will behave differently overall for an empty path.

I agree from the messages you quote that it is probably fine, but I
wonder if it should be in a separate patch.

-Peff
