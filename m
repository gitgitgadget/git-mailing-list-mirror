From: Christian Holtje <docwhat@gmail.com>
Subject: Re: pread() over NFS (again) [1.5.5.4]
Date: Thu, 26 Jun 2008 17:36:08 -0400
Message-ID: <20AEFB67-2BE7-470F-B0EA-BDAC4B6DE576@gmail.com>
References: <6F25C1B4-85DE-4559-9471-BCD453FEB174@gmail.com> <20080626204606.GX11793@spearce.org> <7vskuzq5ix.fsf@gitster.siamese.dyndns.org> <20080626210556.GZ11793@spearce.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 26 23:37:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBz9S-0001Wj-JG
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 23:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbYFZVgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 17:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbYFZVgN
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 17:36:13 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:37877 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbYFZVgL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 17:36:11 -0400
Received: by yw-out-2324.google.com with SMTP id 9so63783ywe.1
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 14:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=I6pbfegZrQaLBM7jUkDznVPb2kbfDzkCG6QcKza24HE=;
        b=PifX0sje+70YhsrLVSCEesH9DrLc5emxl5ifGSNU56p6ty2ldj5q31Ij2oP2h/z8zX
         E0oFfcpiOSaxGZZHzQ4af8MOXnnBy+fKWCDRGIkAdKx+h78dGDDwGY1FuD6tRssdnUoV
         /E4vYha8ZNG3Hq0heaY5OxHkNo+u45upALI9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=VnGUyO59ojay1YA8/OJtD6phiK6VOs5Ue/suQvmg5w/D60wtjVR+KmQ4X2TFNAzXHB
         +IwC3Nbpb6FWKBeB2IHD8eSH2ZkPk4ls1h4otEYQgCSIKPnR+zek5a2UYX/EgSLlUxsk
         7tKeb5xCrVwNzj/2UxFmu5WEhW11jOlqvaUJc=
Received: by 10.151.143.3 with SMTP id v3mr790981ybn.244.1214516170749;
        Thu, 26 Jun 2008 14:36:10 -0700 (PDT)
Received: from ?192.168.0.161? ( [206.210.75.84])
        by mx.google.com with ESMTPS id y67sm1369147pyg.33.2008.06.26.14.36.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Jun 2008 14:36:10 -0700 (PDT)
In-Reply-To: <20080626210556.GZ11793@spearce.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86490>

On Jun 26, 2008, at 5:05 PM, Shawn O. Pearce wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>>> Christian Holtje <docwhat@gmail.com> wrote:
>>>> I have read all the threads on git having trouble with pread()  
>>>> and I
>>>> didn't see anything to help.
>>> ...
>>>>  Receiving objects: 100% (253/253), 5.27 MiB | 9136 KiB/s, done.
>>>>  fatal: cannot pread pack file: No such file or directory
>>>>  fatal: index-pack failed
>>>>
>>>> The end of the strace looks like so:
>>>> pread(3, "", 205, 1373)                 = 0
>>>> write(2, "fatal: cannot pread pack file: N"..., 57) = 57
>>>
>>> Hmmph.  So pread for a length of 205 can return 0 on NFS?  Is this
>>> a transient error?  If so, perhaps a patch like this might help:
> ...
>>> The file shouldn't be short unless someone truncated it, or there
>>> is a bug in index-pack.  Neither is very likely, but I don't think
>>> we would want to retry pread'ing the same block forever.
>>
>> I don't think we would want to retry even once.  Return value of 0  
>> from
>> pread is defined to be an EOF, isn't it?
>
> Indeed, it is defined to be EOF, but EOF here makes no sense.
>
> We have a file position we saw once before as the start of a delta.
> We wrote it down to disk.  We want to go back and open it up, as
> we have the base decompressed and in memory and need to compute
> the SHA-1 of the object that resides at this offset.
>
> And *wham* we get an EOF.  Where there should be data.  Where we
> know there is data.
>
> I'm open to the idea that index-pack has a bug, but I doubt it.
> We shovel hundreds of megabytes through that on a daily basis
> across all of the git users, and nobody ever sees it crash out
> with an EOF in the middle of an object it knows to be present.
> Except poor Christian on NFS.
>
> Actually, I think the last time someone reported something like this
> in Git it turned out to be an NFS kernel bug.  I didn't quote it
> in my reply to him, but I think he did say this was a linux client,
> linux server.

I did see the threads that talked about NFS, but I couldn't find any  
matching messages in the linux kernel mailing list.  If someone can  
give me a pointer to where this picked up on other mailing lists (say,  
via a URL) then I'll take that back to IT as a reason to upgrade.

Would it be a bug in the client or server?  I'd assume client...

The other NFS/pread() email thread was also a client of linux 2.6.9....

Ciao!
