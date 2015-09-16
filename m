From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 07/67] strbuf: make strbuf_complete_line more generic
Date: Wed, 16 Sep 2015 11:11:15 -0400
Message-ID: <20150916151115.GA547@flurp.local>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915152528.GG29753@sigill.intra.peff.net>
 <CAPig+cT9piy2dGx6jbcQNyzY5kQ1XgaEB_mYNUOYBUCJ5wAc_w@mail.gmail.com>
 <xmqqoah3tap6.fsf@gitster.mtv.corp.google.com>
 <20150916095740.GC13966@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 17:12:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcENK-0007mJ-Sr
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 17:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbbIPPL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 11:11:56 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:32925 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040AbbIPPLq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 11:11:46 -0400
Received: by iofh134 with SMTP id h134so233552121iof.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 08:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=epixvjQyuTVb5AmcVxnlXJGbRfYoyEY2cJRZ2heJsKw=;
        b=1DKXNXGCSn+erv6X2KqGvHirZiRPoNT8DGhBJnIKSQPg6eHUXPZSO1qgxIkog+w+11
         1YbXQANQT12vc/sflaw7WH5ZEhNJ3pof49pqVIS6/trShP7gTI43nzYYINZYaLOSuey6
         KPMitHh7ttBDFyoixdTjgwC8bSuHG/z43hP8tgRNpGoZQ+8ZKlvrvBk3039kCDDMSPeS
         pFdAN7A5HU/LqENTbUE1o9aHQzelJaFXswpq5KDtXbZ4ytxgejNEz1HkELEw6m8gGUVy
         pfmZb0omtLiWOpCrd8w7OIZfroMMfAYohk1qr//5OUtp4VaWGBWcjafLu0EoSywugt3M
         T6Ag==
X-Received: by 10.107.155.146 with SMTP id d140mr50169501ioe.43.1442416305738;
        Wed, 16 Sep 2015 08:11:45 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id x1sm2070563igl.14.2015.09.16.08.11.45
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 08:11:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150916095740.GC13966@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278029>

On Wed, Sep 16, 2015 at 05:57:41AM -0400, Jeff King wrote:
> On Tue, Sep 15, 2015 at 06:27:49PM -0700, Junio C Hamano wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > >> +static inline void strbuf_complete(struct strbuf *sb, char term)
> > >> +{
> > >> +       if (sb->len && sb->buf[sb->len - 1] != term)
> > >> +               strbuf_addch(sb, term);
> > >> +}
> > >
> > > Hmm, so this only adds 'term' if not already present *and* if 'sb' is
> > > not empty, which doesn't seem to match the documentation which says
> > > that it "ensures" termination.
> > [...]
> > So to these two plausible and different set of callers that would be
> > helped by this function, the behaviour Peff gives it would match
> > what the callers want better than your version.
> 
> Right. I think what the function is doing is the right thing (and
> certainly it matches what the callers I'm changing are doing already
> :) ).
> 
> But I agree the docstring is extremely misleading. I've changed it to:
>  
> +/**
> + * "Complete" the contents of `sb` by ensuring that either it ends with the
> + * character `term`, or it is empty.  This can be used, for example,
> + * to ensure that text ends with a newline, but without creating an empty
> + * blank line if there is no content in the first place.
> + */

Sounds better, thanks.
