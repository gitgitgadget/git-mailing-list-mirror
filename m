From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH v2] Custom compression levels for objects and packs
Date: Tue, 8 May 2007 17:29:20 -0700
Message-ID: <56b7f5510705081729t34a585c6y9ca9e2f9963d24a2@mail.gmail.com>
References: <4640FBDE.1000609@gmail.com>
	 <7vk5vi27ko.fsf@assigned-by-dhcp.cox.net>
	 <alpine.LFD.0.99.0705082010230.24220@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 09 02:29:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hla3e-0007mV-7W
	for gcvg-git@gmane.org; Wed, 09 May 2007 02:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935146AbXEIA3W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 20:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935143AbXEIA3W
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 20:29:22 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:60449 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935135AbXEIA3V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 20:29:21 -0400
Received: by nz-out-0506.google.com with SMTP id o1so18866nzf
        for <git@vger.kernel.org>; Tue, 08 May 2007 17:29:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WbIzlVVfOi0Du6JvUZ/Ib0NcIwk/mgZ6oPZilpglf+UdGFe4YWY4BsaIUcf1XPcaua/uEk/oa3T2Vq392R44EZ8p54RPHARTyBXhbjYBKY3XZG8yYI3S8oVwOOkGXOkXNGLhFUT3Q79dXuX7az5UC6jiRiIOQZBh+QNpA0pAHNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b6BlZ19i4oYwDQo3CTADOWCCc6mtrW0i1XunxHnAfYj/LaKzeTessHUY4gfJxffOCa7awcNtC0UDVPsfAm0BIIc0eR7RH/Ox5se8U4GyoG2H6K3k53uJj5EbGWbs4PRSt5NArETQAxR+L26Zofe0S4ItywNrqtNB5kM7GlrAvW8=
Received: by 10.114.89.1 with SMTP id m1mr2359227wab.1178670560182;
        Tue, 08 May 2007 17:29:20 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Tue, 8 May 2007 17:29:20 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.99.0705082010230.24220@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46645>

On 5/8/07, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 8 May 2007, Junio C Hamano wrote:
> > Dana How <danahow@gmail.com> writes:
> > > +   /* differing core & pack compression when loose object -> must recompress */
> > > +   if (!entry->in_pack && pack_compression_level != zlib_compression_level)
> > > +           to_reuse = 0;
> > > +   else
> > I am not sure if that is worth it, as you do not know if the
> > loose object you are looking at were compressed with the current
> > settings.
> I was about to make the same comment.
I was bitten by *not* doing this.  Please see the more verbose
reply to Junio's comment.

> > Could we somehow remove _seen?  Perhaps by initializing the
> > _level to -1?
>
> -1 is a valid value for compression.  Actually it is equivalent to
> Z_DEFAULT_COMPRESSION.
>
> If we want the fallback logic to work, at some point we must remember if
> the current value is the default or if it is the result of an explicit
> config option.
I can leave as-is, or use a magic value like -99 and
depend on it not colliding with values in zlib.h.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
