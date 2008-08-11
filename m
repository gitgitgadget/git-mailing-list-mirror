From: "Ken Pratt" <ken@kenpratt.net>
Subject: Re: pack operation is thrashing my server
Date: Mon, 11 Aug 2008 12:13:00 -0700
Message-ID: <a6b6acf60808111213j78028c2ercc1199e080eaeccc@mail.gmail.com>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
	 <20080811030444.GC27195@spearce.org>
	 <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
	 <20080811150150.GC26363@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 21:14:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KScqE-0006TS-7v
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 21:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbYHKTNE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 15:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbYHKTND
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 15:13:03 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:29108 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbYHKTNB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 15:13:01 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2394340rvb.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 12:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=Vg8ap98dDvvmtVjUMclcznaqZzkt88gaO7dadteimgA=;
        b=WDQegwWo5W9bcynXy7cCJaTwp02gz1QvvRMYKOFVI3Bkl/xcbPs7JZ/dQgomRcMsZ8
         /kVUTsHqKV5AgmZGZqjrtXYoszB0BdbbbdGZAGeeRfym7NiDKg3T5+iInGYDJJ6D/uAv
         i9AyRftILgRbuAnlbGlNv+Iu0Ja8KuPSeisPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=SKh8J/GPqK82PxPddA4OiJAWeV2/A67UQwFLRLz72JLWmnBg2bE+6C1kOTlaJ4Hlra
         8BLzHb/yL1onGB5i4aUOosgZ8dguZjvMeIxHm0UEPwqgCMrEPMld109kaNXOFmB6SGzi
         M+Xrm+S9V1V42kSGw8QtSc6uedH7JV0DkAm+Q=
Received: by 10.141.69.1 with SMTP id w1mr3740146rvk.185.1218481980755;
        Mon, 11 Aug 2008 12:13:00 -0700 (PDT)
Received: by 10.141.42.15 with HTTP; Mon, 11 Aug 2008 12:13:00 -0700 (PDT)
In-Reply-To: <20080811150150.GC26363@spearce.org>
Content-Disposition: inline
X-Google-Sender-Auth: 7bf5da9af84fa7a1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91980>

> What is the largest object in that repository? Do you have a
> rough guess?  You said earlier:
>
>> The remote repository is bare, and is 180MB in size (says du), with
>> 1824 objects.
>
> That implies there is at least one really large object in that
> repository.  The average of 101KB per object is not going to be
> a correct figure here as most commits and trees are _very_ tiny.
> It must be a large object.  Those big objects are going to consume
> a lot of memory if they get inflated in memory.

Largest object is ~150MB, and there are a couple 5-10MB objects as well.

> You said earlier this was Git 1.5.6.4.  I recently fixed a bug in
> the code that reads data from packs to prevent it from blowing out
> memory usage, but that bug fix was included in 1.5.6.4.

I tried upgrading to 1.5.6.5 as well, but that didn't help.

> On the up side, packing should only be consuming huge memory like
> this when it needs to move loose objects into a pack file.  I think
> Martin Langhoff suggested packing this on your laptop then using
> rsync over SSH to copy the pack file and .idx file to the server, so
> the server didn't have to spend time figuring out the deltas itself.

Unfortunately, that will only work as a band-aid solution for my
workflow. I think I'll have to limit the file size in the repository
to something that the server can handle.
