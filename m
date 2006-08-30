From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Mozilla .git tree
Date: Tue, 29 Aug 2006 23:27:08 -0400
Message-ID: <9e4733910608292027v46eb5db4y3e2c4cbeed8d5f92@mail.gmail.com>
References: <20060829165811.GB21729@spearce.org>
	 <20060829175819.GE21729@spearce.org>
	 <9e4733910608291155g782953bbv5df1b74878f4fcf1@mail.gmail.com>
	 <20060829190548.GK21729@spearce.org>
	 <9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com>
	 <20060829232007.GC22935@spearce.org>
	 <9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com>
	 <20060830015122.GE22935@spearce.org>
	 <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
	 <20060830031029.GA23967@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 30 05:27:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIGjS-00050I-Fi
	for gcvg-git@gmane.org; Wed, 30 Aug 2006 05:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWH3D1L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 23:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWH3D1L
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 23:27:11 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:64620 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751332AbWH3D1J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Aug 2006 23:27:09 -0400
Received: by nz-out-0102.google.com with SMTP id n1so27509nzf
        for <git@vger.kernel.org>; Tue, 29 Aug 2006 20:27:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cNRr99aRbzUkoaftIFhkbsFnXs/i6fF7hl/dbw533iWNETe97/DrI6e1amVA06NRKoaxHjiJRwzYOe6mmTyIeRZWfrv76jTJ5HQ+ZKV52a0XX18Wm/w7wxKqLWBZibiURWIp5cjVyhnsknc/Fbb8eNAPVp7jECwCZOvvkOEiaNg=
Received: by 10.65.114.11 with SMTP id r11mr94243qbm;
        Tue, 29 Aug 2006 20:27:08 -0700 (PDT)
Received: by 10.65.133.17 with HTTP; Tue, 29 Aug 2006 20:27:08 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20060830031029.GA23967@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26222>

On 8/29/06, Shawn Pearce <spearce@spearce.org> wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
> > sha1s are effectively 20 byte pointer addresses into the pack. With 2M
> > objects you can easily get away with 4 byte address and a mapping
> > table. Another idea would be to replace the 20 byte sha1 in tree
> > objects with 32b file offsets - requiring that anything the tree
> > refers to has to already be in the pack before the tree entry can be
> > written.
>
> I've thought of that, but when you transfer a "thin" pack over the
> wire the base object may not even be in the pack.  Thus you can't
> use an offset to reference it.  Otherwise there's probably little
> reason why the base couldn't be referenced by its 4 byte offset
> rather than its full 20 byte object ID.  Added up over all deltas
> in the mozilla pack it saves a whopping 23 MiB.

Every time an object goes on the wire these 'pack internal'
optimizations need to be undone. If you are sending the whole pack
everything can be sent as is.

These intense compression schemes are meant for archival level data.
Everybody should end up with a copy of the entire archive and that
will be the end of those objects moving on the wire.

> From what I was able to gather I don't think Clucene stores the
> documents themselves as the tokenized compressed data.  Or if it
> does you lose everything between the tokens.  There's a number of
> things we want to preserve in the original "document" like whitespace
> that would be likely stripped when constructing tokens.

I can't remember if the Clucene code includes the ability to compress
using the dictionary. I had thought that the code was in there but
maybe not. Things that aren't in the dictionary use an escape code and
are copied intact. I have the Lucene book on my desk, I'll flip
through it and see what it says.

Might be worthwhile to poke around on the net and see if you can come
up with an existing dictionary based compressor. There has got to be
one out there, this is a 30 year old concept.

> But it shouldn't be that difficult to produce a rough estimate of
> what that storage size would be.


-- 
Jon Smirl
jonsmirl@gmail.com
