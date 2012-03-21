From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [GSoC] Designing a faster index format
Date: Wed, 21 Mar 2012 18:18:39 +0700
Message-ID: <CACsJy8Aga7OYfAL0X+SyHxaF4gzGs+cvqfX+DZNXCua8c9XMig@mail.gmail.com>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
 <CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com>
 <8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com> <CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com>
 <CALgYhfPOJpKbM__iU4KvChWeXWyyhWb2ocR-SLvrQQHNw5F5dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 12:19:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAJZU-0006Wj-Ku
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 12:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756603Ab2CULTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 07:19:12 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:63039 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818Ab2CULTL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 07:19:11 -0400
Received: by wejx9 with SMTP id x9so832457wej.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 04:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QFGoFrpWDaNlJY4u3GcoyURQgc8PXd6dQ6oDwGRefjQ=;
        b=xRSeeS/POIzZ8H5UXFeCwIUqF8bWl0SsaPC3IwnVT07OTa8CyW7xoUASIngCKQiAgy
         6slkslk4pjQS4oXYnoNqdRr742aF9bGon6+XSdhN8Z11cfzNuxMR97e+AJG9yd7n9JD0
         bHXC8jKSWayBJJh74zlklRv2Fhr0JB9AkPt9zU23UNuYPH8x1WLR42gu6cDol58rTV6H
         Cs3jtUUsIUhElIZUoPuw74rbKUKrirOyNyQqWIouF0oJyab8gnW2TCYIKHoobDXFciBc
         vM0s7IP+1a8eeA/1zQhUe8VAuNGSR0l7UbnoHxN5y2/KNBcmM6IMKPEmgGkiS+jIZSZ4
         qbvA==
Received: by 10.216.135.103 with SMTP id t81mr2021203wei.113.1332328749728;
 Wed, 21 Mar 2012 04:19:09 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Wed, 21 Mar 2012 04:18:39 -0700 (PDT)
In-Reply-To: <CALgYhfPOJpKbM__iU4KvChWeXWyyhWb2ocR-SLvrQQHNw5F5dQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193569>

On Wed, Mar 21, 2012 at 6:08 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> > However I got one more question, since I'm not yet really familiar with
>> > the
>> > code and internal structure of git, what exactly does the SHA1 over the
>> > index exactly achieve? Is it only for checking if the index is still
>> > correct
>> > for the next time it is used and has not been changed or is there a more
>> > important function of it?
>>
>> It makes sure the index is not corrupt (by disk faults for example). I
>> don't think it is used for anything else. Cheaper checksum can be used
>> if good enough for the index. See
>> http://thread.gmane.org/gmane.comp.version-control.git/190016 and the
>> following reply.
>
> Ok thanks. I guess that could be another way to speed things up, but for
> really big repositories probably it won't be enough and the reduction of the
> complexity as described in the proposal is the way to go.

Yeah. A good format should not require checksuming the whole index, if
we only need to read/verify a few entries, I think.

> Is the current complexity O(n)?

I think so. Have a look at read-cache.c, read_index_from for reading
and write_index for writing, as a starting point.
-- 
Duy
