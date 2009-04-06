From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH 2/2] pack-objects: report actual number of threads to be 
	used
Date: Sun, 5 Apr 2009 21:09:29 -0500
Message-ID: <449c10960904051909v5ec5d7danc10d13d9a1d613f0@mail.gmail.com>
References: <1238864396-8964-1-git-send-email-dpmcgee@gmail.com>
	 <1238864396-8964-2-git-send-email-dpmcgee@gmail.com>
	 <20090404180601.GA14888@coredump.intra.peff.net>
	 <449c10960904041120j38086192s25070912b0371c09@mail.gmail.com>
	 <20090404232505.GA26906@coredump.intra.peff.net>
	 <alpine.LFD.2.00.0904042001540.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 04:11:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqeIm-0008Ig-6M
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 04:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704AbZDFCJe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 22:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753550AbZDFCJd
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 22:09:33 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:45710 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398AbZDFCJc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 22:09:32 -0400
Received: by ewy9 with SMTP id 9so1718342ewy.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 19:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A88DkDqnkzlWXrDjjmNXHxAs26aVrTs7GVw/SyQU3hU=;
        b=avbQRSO2XLg9szvyRWJQOa0z8V40E9Wsc+6wNosmzEvEOCGgwwVZVUYwnmjf9NONCm
         WCpErPSSQk0AQqAuOdwNTNR91Ih0yQi01tPVh2Ud4hSFSvDmmPNSiKHQJR4CdYqO/LYI
         pZfN/JtRn9Hp6Z4AgjxkSdDxzzgybFwglei4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fQZvtDrrmkaICCD82IRf+gn6PtP7v791CoSc7m81Kc28Lqj32aEZizVHmvGmELzA+Z
         WFMehKcQdvIgzbux2R71gXpaY+79xdd2aOocBtZ0O1zLlDESh6u8s2WZCgTy+lHiuW+v
         9JZOx2Cg0AQGgZLVU6XalC9N+Qlv9RvC+oids=
Received: by 10.216.72.209 with SMTP id t59mr1048162wed.27.1238983769525; Sun, 
	05 Apr 2009 19:09:29 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0904042001540.6741@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115750>

On Sat, Apr 4, 2009 at 7:11 PM, Nicolas Pitre <nico@cam.org> wrote:
> On Sat, 4 Apr 2009, Jeff King wrote:
>
>> On Sat, Apr 04, 2009 at 01:20:18PM -0500, Dan McGee wrote:
>>
>> > > That makes sense to me, though I wonder if it may confuse and fr=
ustrate
>> > > users who are expecting their awesome quad-core machine to be us=
ing 4
>> > > threads when it only uses 2. Is it worth printing both values, o=
r some
>> > > indicator that we could have been using more?
>> >
>> > I thought of this, but decided it wasn't really worth it. The defa=
ult
>> > window size of 10 makes it a very rare case that you will use fewe=
r
>> > than 4 threads. With the default, each thread needs a minimum of 2=
0
>> > objects, so even a 100-object repository would spawn the 4 threads=
=2E
>>
>> Good point. Though by that logic, isn't your patch also not worth it
>> (i.e., it is unlikely not to fill the threads, so the output will be=
 the
>> same with or without it)?
>>
>> I still think yours is an improvement, though, however slight.
>
> I don't think this is worth it at all.
>
> This display is there mainly to confirm expected number of available
> threads. =C2=A0The number of actually active threads is an implementa=
tion
> detail. =C2=A0Sure if the number of objects is too low, or if the win=
dow size
> is too large, then the number of active threads will be lower. =C2=A0=
But in
> practice it is also possible that with some patological object set yo=
u
> end up with 2 threads out of 4 completing very quickly and the other =
2
> threads still busy with big objects and total remaining work set too
> small to split it further amongst idle threads, meaning that you'll e=
nd
> up with only 2 busy CPUs even though the display said 4 threads
> initially even with this patch.
>
> In other words I don't think this patch is a good idea as we don't
> update the display with remaining active threads along the way.

Why do we show this misleading at best piece of information at all
then? I'd rather completely remove it than show lies to the user. It
sounds like it is only there for debugging purposes.

If we choose to keep it, I propose either accepting my patch so we are
not mislead, or dropping the thread count completely from the output
and saying only something like "Using multi-threaded delta
compression."

-Dan
