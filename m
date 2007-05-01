From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 3/8] git-repack --max-pack-size: make close optional in sha1close()
Date: Mon, 30 Apr 2007 22:24:52 -0700
Message-ID: <56b7f5510704302224r637788fela543df5eaad2317d@mail.gmail.com>
References: <463679AE.7020106@gmail.com> <20070501050155.GY5942@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 01 07:25:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hiks4-0000po-38
	for gcvg-git@gmane.org; Tue, 01 May 2007 07:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459AbXEAFZf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 01:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031593AbXEAFZe
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 01:25:34 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:48126 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754411AbXEAFYx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 01:24:53 -0400
Received: by nz-out-0506.google.com with SMTP id o1so2141729nzf
        for <git@vger.kernel.org>; Mon, 30 Apr 2007 22:24:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IFPnQQmcAbdexYFeMQZL0Nl0axJqTwuMA+64W2KIL1KysJgQ/SX2MQoQRoKmVoAJk2JsZzqBgaB3L1gvNg1daGtFhn3l7rEqPOMiOsyj6yK600UR3XKKhHych8Dd6Jby0pOPeESDGR5A1CeafG6JkUCp/sqY/gMW/5UtX5xcQmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i8XKjmJAzu+BEaxekQAWV38rnjF/iB9SNsoxAhv8+xihgxE5H0HsrLHKw7vdmk62wWNMyktFg7bkZ1rEz9auxk6/xM9yBPLlbEuzKRl2IM+POyF2/J2QgN2ccSsKZFWo0OEWreVewOS+88Pj/jVOGJW3+fvwWktQdoLg+yytfig=
Received: by 10.114.168.1 with SMTP id q1mr2272515wae.1177997092631;
        Mon, 30 Apr 2007 22:24:52 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Mon, 30 Apr 2007 22:24:52 -0700 (PDT)
In-Reply-To: <20070501050155.GY5942@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45914>

On 4/30/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Dana How <danahow@gmail.com> wrote:
> > sha1close() flushes, writes checksum, and closes.
> > The 2nd can be suppressed; make the last suppressible as well.
> ...
> > diff --git a/csum-file.c b/csum-file.c
> > --- a/csum-file.c
> > +++ b/csum-file.c
> > @@ -35,7 +35,10 @@ int sha1close(struct sha1file *f, unsigned char *result, int update)
> > +             f->offset = 0;
> >       }
> > +     if (update < 0)
> > +             return 0;       /* only want to flush (no checksum write, no close) */
>
> Huh.  Nobody currently uses that update parameter; all current in-tree
> callers (which better be *all* callers since we don't have a true
> libgit!) seem to always pass a 1 for this argument.  This makes the
> later:
>
>   if (update)
>     sha1flush(f, 20);
>
> always true anytime sha1close is called.  Maybe we should be
> redefining that update argument to be 1 means do all work, 0 means
> return where you return update < 0 above?

Considering I had to look at all the sha1close call sites
to confirm -1 was a safe new value,
I should have reached your conclusion as well.
But I was really trying to focus on additions, not alterations.

I'll either roll this into my next patchset (also in pack-objects),
or include it in any other changes to this patchset if any.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
