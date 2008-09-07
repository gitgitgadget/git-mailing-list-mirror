From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: pack operation is thrashing my server
Date: Sun, 7 Sep 2008 16:33:28 -0400
Message-ID: <9e4733910809071333t57d03257m34fd6a752e40177e@mail.gmail.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
	 <alpine.LFD.1.10.0808151729070.3324@nehalem.linux-foundation.org>
	 <7vk5dorclv.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.1.10.0809061812090.3117@nehalem.linux-foundation.org>
	 <9e4733910809061950g6d9d2cf1g708f8faf0c06108@mail.gmail.com>
	 <alpine.LFD.1.10.0809061957320.3117@nehalem.linux-foundation.org>
	 <9e4733910809062043y661d2d54rcb034d4c70296727@mail.gmail.com>
	 <alpine.LFD.1.10.0809062148110.3117@nehalem.linux-foundation.org>
	 <9e4733910809070658k66e0481fx758e9a365229cf18@mail.gmail.com>
	 <alpine.LFD.1.10.0809071304130.23787@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Sep 07 22:34:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcQxx-0005gR-IS
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 22:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755734AbYIGUda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 16:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755751AbYIGUda
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 16:33:30 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:61434 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725AbYIGUd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 16:33:29 -0400
Received: by wx-out-0506.google.com with SMTP id h27so29662wxd.4
        for <git@vger.kernel.org>; Sun, 07 Sep 2008 13:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8DylKOI8sdufUsM8/JeDBUnbZFpeXLS5FTOh92+NUk4=;
        b=L3y6uApmByLSCxKdVWVSZAKaL5+7+T1r2RjPiTCzPmw7nlwXWZ0e/R6tx3dxLhD1Mb
         XEER6OeeoxtUXGhgIkoWBRVDyUsqWU9eNs0/b16VrHnN4iwuVf1mnSh+hoSzW2A4bYzO
         zada2g6QSgx5FmML9zRRtPAMeDWmP2zTNy7Do=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=iUNTdujOyrKLomm55/IcBsKlZbr22Qq3ajmVlEtEeVSWObN83lUqW/99ejQuGwmqQB
         3PxLrcsxVet1ZEH2LfbCtl5e8EDbWyEP91drBczES+xFPcCjO8+xk82m8+Ds0vGluBHX
         WY/rr0FdUy0rStug1deWPFFJlK9Ht9cthNVwU=
Received: by 10.70.58.2 with SMTP id g2mr18015044wxa.52.1220819608438;
        Sun, 07 Sep 2008 13:33:28 -0700 (PDT)
Received: by 10.70.55.6 with HTTP; Sun, 7 Sep 2008 13:33:28 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0809071304130.23787@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95174>

On 9/7/08, Nicolas Pitre <nico@cam.org> wrote:
> On Sun, 7 Sep 2008, Jon Smirl wrote:
>
>  > On 9/7/08, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>  > >
>  > >
>  > >  On Sat, 6 Sep 2008, Jon Smirl wrote:
>  > >  >
>  > >
>  > > > When I was playing with those giant Mozilla packs speed of zlib wasn't
>  > >  > a big problem. Number one problem was the repack process exceeding 3GB
>  > >  > which forced me to get 64b hardware and 8GB of memory. If you start
>  > >  > swapping in a repack, kill it, it will probably take a month to
>  > >  > finish.
>  > >
>  > >
>  > > .. and you'd make things much much WORSE?
>  >
>  > My observations on the Mozilla packs indicated that the problems were
>  > elsewhere in git, not in the decompression algorithms. Why does a
>  > single 2000 delta chain take 15% of the entire pack time? Something
>  > isn't right when long chains are processed which triggers far more
>  > decompressions than needed.
>
>
> Please have a look at commit eac12e2d4d7f.  This fix improved things for
>  my gcc repack tests.

Do you have any test numbers for something like a 2000 delta chain
before and after?

You can get to Mozilla CVS with rsync.
https://wiki.mozilla.org/How_to_Create_a_CVS_Mirror
I think it was the master Mozilla makefile with the 2000 deltas.
The whole repo is 15GB so you probably just want the Makefile,v

There's no point in working with Mozilla except for testing purposes
since they went with Mercurial and abandoned their history.

-- 
Jon Smirl
jonsmirl@gmail.com
