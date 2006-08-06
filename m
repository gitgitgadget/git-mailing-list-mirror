From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: GPF in index-pack
Date: Sat, 5 Aug 2006 22:58:21 -0400
Message-ID: <9e4733910608051958h6144add7td46de70dd8b45a5e@mail.gmail.com>
References: <9e4733910608051805j1192d910hf55393f1dbe1e472@mail.gmail.com>
	 <9e4733910608051944v5af7e552wd6909b9773dd516e@mail.gmail.com>
	 <20060806024858.GC20565@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 06 04:58:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9YqQ-0007Ef-VE
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 04:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWHFC6X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 22:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWHFC6X
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 22:58:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:1971 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751498AbWHFC6X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 22:58:23 -0400
Received: by nf-out-0910.google.com with SMTP id p46so62316nfa
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 19:58:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lx7OFs6rsrZ4cqAGlS+OqC8boQTFW9mf0CXofOTrtjhYl84sQ9g2BnLVovMpBVZ0lQDrxnHxD3lpWc1izJooi96Y+E1Jv3/jMZs79vjTSgmPKQnvrHesFI9QZc+e9vxR5HV5RN1B9CpPdrlEyiCACn+6eYKMsvg/8sD+/r9ZCdE=
Received: by 10.78.118.19 with SMTP id q19mr2020519huc;
        Sat, 05 Aug 2006 19:58:21 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Sat, 5 Aug 2006 19:58:21 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20060806024858.GC20565@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24955>

On 8/5/06, Shawn Pearce <spearce@spearce.org> wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
> > Process size is 2.6GB when the seg fault happen. That's a lot of
> > memory to build a pack index over 1M objects.
> >
> > I'm running a 3:1 process address space split. I wonder why it didn't
> > grow all the way to 3GB. I still have RAM and swap available.
>
> Was the pack you are trying to index built with that fast-import.c
> I sent last night?  Its possible its doing something weird that
> pack-index can't handle, such as insert a duplicate object into
> the same pack...

built with fast-import.

> How big is the pack file?  I'd expect pack-index to be using
> something around 24 MB of memory (24 bytes/entry) but maybe its
> hanging onto a lot of data (memory leak?) as it decompresses the
> entries to compute the checksums.

It is 934MB in size with 985,000 entries.

Why does resolve_delta in index-pack.c need to be recursive? Is there
a better way to code that routine? If it mmaps the file that uses 1GB
address space, why does it need another 1.5GB to build an index?

I had a prior 400MB pack file built with fast-import that I was able
to index ok.

-- 
Jon Smirl
jonsmirl@gmail.com
