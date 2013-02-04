From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Verify Content-Type from smart HTTP servers
Date: Mon, 4 Feb 2013 15:49:35 -0800
Message-ID: <CAJo=hJtZ64ER4X+axtFZJ5ArnEg3h_nCVEBdd8KmE0nUpskzBA@mail.gmail.com>
References: <7v38xhf1i3.fsf@alter.siamese.dyndns.org> <20130201085248.GA30644@sigill.intra.peff.net>
 <7vip6bc3e1.fsf@alter.siamese.dyndns.org> <20130201185827.GA22919@sigill.intra.peff.net>
 <7va9rk5z02.fsf@alter.siamese.dyndns.org> <20130204083824.GB30835@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 05 00:50:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Vnn-0008Ab-N5
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 00:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215Ab3BDXt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 18:49:57 -0500
Received: from mail-ia0-f172.google.com ([209.85.210.172]:61407 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356Ab3BDXt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 18:49:56 -0500
Received: by mail-ia0-f172.google.com with SMTP id u8so8825987iag.3
        for <git@vger.kernel.org>; Mon, 04 Feb 2013 15:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fTRhgmmZX/WbjyFeEBPdyzyHz1RjvkkOgSBDFlU8inY=;
        b=eiFsk6blPg41lA/0NQVF2MM6FaPkDabzo8TESNLG5MMDYcMC2gV6JkQyMJ5IHiQMbu
         DvRZl+BZunAYkQrvTQmWTtm4XgF4mVHCTCKgv3bhWbKtXUFBB7iSkKn1BlTUVkeR9zSI
         u5kI3ZsAwz50PozuEkfJqrFoLm3E83Q7YIDNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:x-gm-message-state;
        bh=fTRhgmmZX/WbjyFeEBPdyzyHz1RjvkkOgSBDFlU8inY=;
        b=IMpDlk/u0pJslka9lx/YLGdQEOxkMtKEbJRNnM+57t25Z/UBvhhcSdr9R2V+TYDosD
         5H70nYNe0iruKU8IuP8692PhxwhGlNZXhiYBxdXVPI2fbM7NX67x0fRSWatDc/Zl5vN8
         zFIVVBX1ncCJ0UQkMgtHH0G0bQtcrENmAEtauoecP0jngFcchiiMEUy3bT+9Jh0Wifkd
         ScpfaGaPZN6F6DHvExJag40r+boJZKpY9cbeL/eIl0o1O9+CQ7wI1x1HmqnyyyabFRUZ
         bSFWgaRpQBQmwhP2YgUvmdk2B6wJgZ9+TTaQdlaJEilyh9m+1BD8b5I01XtkwTaZbNcK
         2EXA==
X-Received: by 10.50.163.35 with SMTP id yf3mr9764175igb.60.1360021796087;
 Mon, 04 Feb 2013 15:49:56 -0800 (PST)
Received: by 10.64.170.100 with HTTP; Mon, 4 Feb 2013 15:49:35 -0800 (PST)
In-Reply-To: <20130204083824.GB30835@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQlb5WBtMC2n8xlrrmtVKpMGNvhrT9Z5UQgMe19gWTrIM9nskRUJbbiv7IjXFNlkL/qndqGS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215435>

On Mon, Feb 4, 2013 at 12:38 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Feb 03, 2013 at 11:17:33PM -0800, Junio C Hamano wrote:
>
> > Does this look good to both of you (relative to Shawn's patch)?
> >
> >  remote-curl.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/remote-curl.c b/remote-curl.c
> > index e6f3b63..933c69a 100644
> > --- a/remote-curl.c
> > +++ b/remote-curl.c
> > @@ -134,14 +134,14 @@ static struct discovery* discover_refs(const char *service)
> >       last->buf_alloc = strbuf_detach(&buffer, &last->len);
> >       last->buf = last->buf_alloc;
> >
> > -     if (maybe_smart && 5 <= last->len && last->buf[4] == '#') {
> > +     strbuf_addf(&exp, "application/x-%s-advertisement", service);
> > +     if (maybe_smart &&
> > +         (5 <= last->len && last->buf[4] == '#') &&
> > +         !strbuf_cmp(&exp, &type)) {
> >               /*
> >                * smart HTTP response; validate that the service
> >                * pkt-line matches our request.
> >                */
> > -             strbuf_addf(&exp, "application/x-%s-advertisement", service);
> > -             if (strbuf_cmp(&exp, &type))
> > -                     die("invalid content-type %s", type.buf);
> >               if (packet_get_line(&buffer, &last->buf, &last->len) <= 0)
> >                       die("%s has invalid packet header", refs_url);
> >               if (buffer.len && buffer.buf[buffer.len - 1] == '\n')
>
> Yeah, I think that's fine. Thanks.

Looks fine to me too, but I think the test won't work now. :-)
