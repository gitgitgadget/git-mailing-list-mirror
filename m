From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: can we prevent reflog deletion when branch is deleted?
Date: Thu, 14 Nov 2013 21:36:42 +0530
Message-ID: <5284F512.1090303@gmail.com>
References: <CAMK1S_jY1tDCkyOamX8XNW9g8Dzf6yN9znwN6he-EVcOkBM1fQ@mail.gmail.com> <51A963B7.6060002@alum.mit.edu> <20130601050355.GA23408@sigill.intra.peff.net> <CALkWK0kcJH0t4i0BAPmMkNWwNzeJNdmg_wbt3ao-=R31kJ5noA@mail.gmail.com> <20130601090934.GA13904@sigill.intra.peff.net> <CALkWK0mwAc0bFon7B7nw1Nbvcwdf8m2_531qtrN-r28r9F+70Q@mail.gmail.com> <CAMK1S_hPups3SCwxhHRYWBJzpPreNVUfNdx1+_Hjy2_d0MMpaA@mail.gmail.com> <CALkWK0=SqCh-82F4ud+AxuzzEezyMWqMvc6HAPoxOk32vUND7A@mail.gmail.com> <528416EA.1070307@gmail.com> <20131114081456.GC16327@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 14 17:07:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgzSE-0000Sy-1k
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 17:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab3KNQHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 11:07:21 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:60374 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626Ab3KNQGt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 11:06:49 -0500
Received: by mail-pb0-f51.google.com with SMTP id xa7so2231200pbc.10
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 08:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=/XzhzDBOpk2TBlpX4dYSJUKdPtYItXuPrhGv0J4ZcAA=;
        b=vo/48oPRIWjS42978ZTYFn8S66Twtc6I//3R5WHLJ8WgrUlRGJoDO+i2D+X8t7j1fC
         no2fEIwuHkRDS4OOGlvDoXB9e/7iPfPMkHtFuUz2SIzBR5q4kwkOBCJv/nGzj2tCjY7z
         tzwIHX3byvx58lmF0ubm6LI/s+ofIcxM7hK2vpfKEMGj4zdTu4lGRIIhQqKMYKS9hfVy
         lBVinD8OC/SR+cgvIzAhKKHkRMH7u4W/17vfuc+srCaLiavUYZk6mJngKTdBiS0ThD0+
         kMdKxcEkjGtfoaUa0vXYBG1AXUaZmR//M80qq2qznmOConlxiG9TrwSKBZfv4UEacTy0
         X3sA==
X-Received: by 10.68.189.65 with SMTP id gg1mr2059922pbc.135.1384445208585;
        Thu, 14 Nov 2013 08:06:48 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([117.195.164.152])
        by mx.google.com with ESMTPSA id pu5sm5684pac.21.2013.11.14.08.06.45
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 08:06:46 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20131114081456.GC16327@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237855>

On 11/14/2013 01:44 PM, Jeff King wrote:
> On Thu, Nov 14, 2013 at 05:48:50AM +0530, Sitaram Chamarty wrote:
> 
>> Is there *any* way we can preserve a reflog for a deleted branch,
>> perhaps under logs/refs/deleted/<timestamp>/full/ref/name ?
> 
> I had patches to do something like this here:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/201715/focus=201752
> 
> but there were definitely some buggy corners, as much of the code
> assumed you needed to have a ref to have a reflog. I don't even run with
> it locally anymore.
> 
> At GitHub, we log each change to an "audit log" in addition to the
> regular reflog (we also stuff extra data from the environment into the
> reflog message). So even after a branch is deleted, its audit log
> entries remain, though you have to pull out the data by hand (git
> doesn't know about it at all, except as an append-only sink for
> writing). And git doesn't use the audit log for connectivity, either, so
> eventually the objects could be pruned.
> 
>> Just some basic protection -- don't delete the reflog, and instead,
>> rename it to something that preserves the name but in a different
>> namespace.
> 
> That part is easy. Accessing it seamlessly and handling reflog
> expiration are a little harder. Not because they're intractable, but
> just because there are some low-level assumptions in the git code. The
> patch series I mentioned above mostly works. It probably just needs
> somebody to go through and find the corner cases.

The use cases I am talking about are those where someone deleted
something and it was noticed well within Git's the earliest of Git's
expire timeouts.

So, no need to worry about expiry times and connecting it with object
pruning.  Really, just the eqvt of a "cp" or "mv" of one file is all
that most people need.

Gitolite's log is the same.  So no one who uses Gitolite needs this
feature.  But people shouldn't have to install Gitolite or anything else
just to get this either!
