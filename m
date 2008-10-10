From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] fix pread()'s short read in index-pack
Date: Fri, 10 Oct 2008 08:52:40 +0200
Message-ID: <81b0412b0810092352n2a9cb5d2m6a0550354af0b397@mail.gmail.com>
References: <20081009195518.GA1497@blimp.localhost>
	 <alpine.LFD.2.00.0810092140500.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 10 08:53:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoBsn-00079x-6t
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 08:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbYJJGwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 02:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbYJJGwm
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 02:52:42 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:62949 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033AbYJJGwl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 02:52:41 -0400
Received: by yx-out-2324.google.com with SMTP id 8so132387yxm.1
        for <git@vger.kernel.org>; Thu, 09 Oct 2008 23:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VJWxSPabF+K1ijV+FVk4Ohmveat/4lpTpGJdZZJlAfY=;
        b=tGaxu1SBuo/777Dkv6oOpd5QfYDaWa8LbjCvqy4ago2RgYFD3LMDotT5bC2okxj3Xc
         Ie9eNwpHHhVL8iwdNKnzJU0Oo1SzSU2JJR35i2hDoY+EX1sK3NrMuBZ2VGoohNiujtQY
         eayK/BAJCw4vikVbF3d7hZKCTRB25COlUZvYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fLYVstC6qJV/GrtLGpKqhV/C5fQZPHYTNhFZwsxDbib+CZDU8mcr8f1F61mTeai3Li
         t5q7Bn0cG42KCi5PBy1hSPTLmhQAyhffoL6tWWKUdGzpoUVeDcHhD689PXqaEbbtqCbE
         yPUICvkaSaRUTohCqOuBoI0gCs02WbQC4+BhU=
Received: by 10.100.5.13 with SMTP id 13mr1576671ane.154.1223621560302;
        Thu, 09 Oct 2008 23:52:40 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Thu, 9 Oct 2008 23:52:40 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0810092140500.26244@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97911>

2008/10/10 Nicolas Pitre <nico@cam.org>:
>
> Since v1.6.0.2~13^2~ the completion of a thin pack uses sha1write() for
> its ability to compute a SHA1 on the written data.  This also provides
> data buffering which, along with commit 92392b4a45, will confuse pread()
> whenever an appended object is 1) freed due to memory pressure because
> of the depth-first delta processing, and 2) needed again because it has
> many delta children, and 3) its data is still buffered by sha1write().

So I seem to have had luck not doing gc in either of source or target repos
(I usually repack, than fetch. Especially this one repo, it's very active).

BTW, I run into complications trying to test the fix on Shawn's
master: conflicts,
and my trivial resolution wasn't good enough.

Aside from that, I confirm the case fixed.
