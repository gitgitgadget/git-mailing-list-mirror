From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/4] cat-file: add --batch-disk-sizes option
Date: Mon, 8 Jul 2013 19:07:01 +0530
Message-ID: <CALkWK0k0xiNFaFmqL2t4ba2g+HSrQ8kU+W_HvnSMcMYY8VgJyg@mail.gmail.com>
References: <20130707100133.GA18717@sigill.intra.peff.net> <20130707100949.GC19143@sigill.intra.peff.net>
 <7vtxk645vp.fsf@alter.siamese.dyndns.org> <CACsJy8A8ZO3DL8Vr=S1G-3yiJz3WaZ-7jV_eA+v6rPAWrd9NAw@mail.gmail.com>
 <CALkWK0ktNK49zBM4tD8fpNN3VMan7DegfWRtDcOEgTyEbSK9Uw@mail.gmail.com> <CACsJy8Dffc2WgtDyUS2g2gmDWG_rTxs389fHcj0ztm6pdJddjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 15:37:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwBdS-0007vR-8x
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 15:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951Ab3GHNhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 09:37:42 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:52902 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442Ab3GHNhl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 09:37:41 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so9940870iec.36
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 06:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7DYGTiVGYUCTC8AD0JcLp1eZD6PkOAmYc6L8Jv7bf8U=;
        b=JsYwsRu+GC8Y2eRWwucyAWi5c7vmAdJFKRIchDO3Eg7pnlMZKxbES0Qtfq6XOkO91T
         fi08NDTMxlVgGdjdH1SUnxcU+4KVHG0XW3KXWC6lZNixE6Po8wneKeqyRKZUOo4fSxt7
         rLOaObZSH2Ao6l0m/dXtqo8ffHiqzFtRBlGT3PHoiwvSqlT+ednkq4Qz8lFYhvIZpVsl
         YcQGiJzQqSKrFTYKPZEIO+6HcWKA9yXGjitThRlvQu+BTZvBrYi6wWSDPR0L6++0unZN
         HIcArSOBSdu6ejtJzPcGZs+WriF8jA4mtrgy3Q95oSbXR8FWS0zXX0ST39FfEXR7QgoZ
         XeQQ==
X-Received: by 10.43.88.3 with SMTP id ay3mr7096326icc.61.1373290661328; Mon,
 08 Jul 2013 06:37:41 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Mon, 8 Jul 2013 06:37:01 -0700 (PDT)
In-Reply-To: <CACsJy8Dffc2WgtDyUS2g2gmDWG_rTxs389fHcj0ztm6pdJddjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229853>

Duy Nguyen wrote:
> The short/long naming is the least I worry about. We could add long
> names to pretty specifiers. The thing about the last attempt is, you
> add some extra things on top elsewhere, but format_commit_item code
> may need to be aware of those changes, which are not obvious when
> sombody just focuses on format_commit_item. Having all specifiers in
> one place would be better (hence no hooks, no callbacks) because we
> get a full picture. And yes we need to deal with specifers that make
> no sense in certain context.

Yeah, it would certainly be nice to have all the format-specifiers
that one unified parser acts on, but isn't this just a matter of
refactoring?  Shouldn't we be starting with cheap callbacks, get
things working, and guard against regressions in the refactoring phase
first?  How else do you propose to start out?

> There's also syntax sharing. I don't think each command should have
> its own syntax. f-e-r already has %(objectsize). If we plan to have a
> common syntax, perhaps %(disk-size) should be %(objectsize:disk) or
> something.

Ofcourse.  I didn't notice %(objectsize); %(objectsize[:disk]) is a
fine suggestion.

> Adding formatting to cat-file --batch from scratch could be
> another big chunk of code (that also comes with bugs, usually) and may
> or may not be compatible with the common syntax because of some
> oversight.

Oh, I'm proposing that Peff implements just %H and
%(objectsize[:disk]) for _now_, because that's what he wants.  It
should be a tiny 20-line parser that's easy to swap out.

> --batch-cols=... or --batch-disk-size would be simpler, but
> we might never be able to remove that code.

Agreed.  The approach paints us into a design-corner, and must
therefore be avoided.
