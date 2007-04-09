From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 5/8] get-repack --max-pack-size: write_object() takes 'limit' arg
Date: Mon, 9 Apr 2007 11:51:55 -0700
Message-ID: <56b7f5510704091151l70cc74b1la82e0c5a67d6885f@mail.gmail.com>
References: <46197994.70009@gmail.com>
	 <alpine.LFD.0.98.0704082034060.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 01:57:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HayyE-00005T-EL
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 20:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbXDISv7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 14:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbXDISv6
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 14:51:58 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:28540 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203AbXDISv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 14:51:57 -0400
Received: by wr-out-0506.google.com with SMTP id 71so952480wri
        for <git@vger.kernel.org>; Mon, 09 Apr 2007 11:51:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GZQ4Z/FhDfnpfrh5p2OlF459202pIY2KBLrKjrNsV7dl3oBiE6QvjMyex96ibK1LfYVnqsYt9o7a9VwURfrZJA8BRqqCQI5aJilKHNjb29zz5ea5vYp+IgfooXwPNate1IxwkrOHv/RyB8r0BG4O0lf/MlkgOjaT/ks4Wgmj6kA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g1o74ZT4WTmhm2ziOHw92FlkvuW6n/XcsBKpiQLXwobSI/k9z9zHlY/dNQgCJ6mUYlh1/pV47lOhunqIuqBRjLmdNKoW99yOMKZfNChY86munBCivKxX4/+LNu9ZNUO78zDeJ+tfR7foR4bYNSpj78P04PmKM9xYTsFiw1GXSII=
Received: by 10.114.151.13 with SMTP id y13mr2459209wad.1176144715784;
        Mon, 09 Apr 2007 11:51:55 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Mon, 9 Apr 2007 11:51:55 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0704082034060.28181@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44086>

On 4/8/07, Nicolas Pitre <nico@cam.org> wrote:
> > @@ -448,6 +480,12 @@ static off_t write_object(struct sha1file *f,
> >                       header[pos] = ofs & 127;
> >                       while (ofs >>= 7)
> >                               header[--pos] = 128 | (--ofs & 127);
> > +                     if ( limit && hdrlen + sizeof(header) - pos + datalen + 20 >= limit ) {
> > +                             free(out);
> > +                             free(buf);
> > +                             return 0;
> > +                     }
> > +                     sha1write(f, header, hdrlen);
> >                       sha1write(f, header + pos, sizeof(header) - pos);
>
> The above looks rather buggy to me.

OK, can you be more specific?

So far from my re-inspection I don't see any error in the snippet above.
Two lines before it, however, we have the line
        off_t ofs = entry->offset - entry->delta->offset;
and this only works if entry->offset is set in write_one() *before*
calling write_object().  I will make that change.

Thanks!
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
