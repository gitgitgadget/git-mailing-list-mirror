From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git should not use a default user.email config value
Date: Wed, 14 Aug 2013 07:00:58 -0700
Message-ID: <CAPc5daWqzTkMFkecrAjMCmxwZZrgUtB-FVKrjsmfvpgwPgF8AA@mail.gmail.com>
References: <52060EF9.2040504@alum.mit.edu> <7vvc3d1o01.fsf@alter.siamese.dyndns.org>
 <CAH5451nHfOaBzFzkrGvw+TyRj==cVpKF_QdXsTxnn5tTr1c0dw@mail.gmail.com>
 <20130812123921.GA16088@sigill.intra.peff.net> <CAH5451=PK15n4U-3Mb_TLevF3-r+vrpk1PXD15Oo1A2KFc5i_w@mail.gmail.com>
 <20130812154520.GA18215@sigill.intra.peff.net> <CAH5451=WKXUNzovXquFii=EdkeQXJEQ96_CRRebgQW6ow_19VA@mail.gmail.com>
 <20130813114635.GA16506@sigill.intra.peff.net> <7vsiydy2i1.fsf@alter.siamese.dyndns.org>
 <vpqsiycn33b.fsf@anie.imag.fr> <20130814074035.GB5095@sigill.intra.peff.net> <vpq38qcmzw1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Andrew Ardill <andrew.ardill@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 14 16:01:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9bdf-0005cG-8Q
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 16:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313Ab3HNOBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 10:01:22 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:37699 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759590Ab3HNOBW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 10:01:22 -0400
Received: by mail-lb0-f171.google.com with SMTP id t13so6803089lbd.2
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 07:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=z5km1ws1pKs90wg7MJr3mTSHN1reWqKQj2x2L35ejIw=;
        b=lvOw4IWvHPqPy8F2sS81/11KrMZFw+ifgH7wpp8gZgSVlHknuNEVtvi7drkxq5a/BL
         LnlQLInWNLBuEc9ZcIVCgAcFLH1CYlbw0uxm3UcRf+NDMXBm+FOZ7pqr2mQ/iXE5Cj5v
         KvdT/q+0Dd1IiP0l55PunS+zlCDBRBDcaO1kKA3rR5qDoiS9Wawvh5N5pSd/QeJfuFtz
         mmgq9GhpxZdmqFb4bgiZu97Ldj+cx8FomFGSyLK5bfKo8L+lVbAAIChB9uw/MBRSNoIP
         F2WBg+rvXb3HH0yUqgybHPpjXlCblbx29eQIwdjLfy3aWWcsd0fELXaZlLy4LJeXBlLQ
         x02A==
X-Received: by 10.112.181.36 with SMTP id dt4mr1366192lbc.46.1376488879053;
 Wed, 14 Aug 2013 07:01:19 -0700 (PDT)
Received: by 10.112.219.200 with HTTP; Wed, 14 Aug 2013 07:00:58 -0700 (PDT)
In-Reply-To: <vpq38qcmzw1.fsf@anie.imag.fr>
X-Google-Sender-Auth: AURXJypMhrFix23Sda4nyiceb2Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232284>

On Wed, Aug 14, 2013 at 1:37 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > This whole discussion is basically implementing conditional config.
> > [...] The problem is that it would be tricky to do in a
> > backwards-compatible way.
>
> That could be done with "conditional comments" like
>
> # if <some-condition> then
> [core]
>         pager = less
> # endif
>
> That's rather ugly, and the implementation would be even more ugly, but
> backward-compatible.


I highly doubt that you would want to be "backward compatible" in this
case, though.
The section of the configuration you are enclosing the new if/endif
syntax may be
understood only by newer Git (e.g. imagine core.pager is still
bool-only today), and
older Git that do not understand if/endif syntax will happily read
that section and
choke on it, no?
