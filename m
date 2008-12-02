From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: two questions about the format of loose object
Date: Tue, 02 Dec 2008 11:05:16 +0800
Message-ID: <4934A5EC.2090708@gmail.com>
References: <493399B7.5000505@gmail.com> <20081201153211.GH23984@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 02 04:06:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Laz-0003Hu-4k
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 04:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbYLBDFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 22:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbYLBDFX
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 22:05:23 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:53177 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbYLBDFW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 22:05:22 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1759837tic.23
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 19:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=skGJ6Yk+INqvvTm6D2fICs7M+rFSxtypwOn4NrI6eig=;
        b=YUYF2Yk5dowJ9i2lYCRYYggIRO1JavK2Gfy6UXTkAywejEEIGJw2+fyFdrs7wbq4Op
         H3RJ2Qzn3L8I6hUJomUAIb65KAUXLcBZ1ToUszIT+ys46DNHAgOD1P3VUjlITiAFVTji
         4SlE15LYNIG6hl5Wbd051m8VzR7lOrDWOD+5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=gjUR1ne2/vOceBBYitn8PPncA2PV/Cvc2aA2KHrFz5F9qP0Rx9Gn4GYdfIQREG9qZ6
         TrqbsJ2ZMU7MbwaNJmdmuH5o1CJ6jEsywYKWeAJ/v1QDpsA36bmHdDLA4f2uxoCjSqyU
         rC/89BrEQVkSoNkH0McP1F0Bi/gDgfETCKiys=
Received: by 10.110.31.5 with SMTP id e5mr17328087tie.31.1228187120636;
        Mon, 01 Dec 2008 19:05:20 -0800 (PST)
Received: from ?10.64.1.142? ([211.157.41.194])
        by mx.google.com with ESMTPS id d1sm2491972tid.15.2008.12.01.19.05.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 19:05:19 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <20081201153211.GH23984@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102116>

Shawn O. Pearce wrote:
> Liu Yubao <yubao.liu@gmail.com> wrote:
>> In current implementation the loose objects are compressed:
>>
>>      loose object = deflate(typename + <space> + size + '\0' + data)
> ...
>> * Question 1:
>>
>> Why not use the format below for loose object?
>>     loose object = typename + <space> + size + '\0' + deflate(data)
> 
> Historical accident.  We really should have used a format more
> like what you are asking here, because it makes inflation easier.
> The pack file format uses a header structure sort of like this,
> for exactly that reason.  IOW we did learn our mistakes and fix them.
> 
> If you look up the new style loose object code you'll see that it
> has a format like this (sort of), the header is actually the same
> format that is used in the pack files, making it smaller than what
> you propose but also easier to unpack as the code can be reused
> with the pack reading code.
> 
> Unfortunately the new style loose object was phased out; it never
> really took off and it made the code much more complex.  So it was
> pulled in commit 726f852b0ed7e03e88c419a9996c3815911c9db1:
> 

In fact the format I proposed in my patches is uncompressed loose
object, not uncompressed loose object header, that's to say I
proposed format 2 in my question 2, I am just curious why the
loose object header is compressed in question 1.

I did a test to add all files of git-1.6.1-rc1 with git-add, the
time spent decreased by half. Other commands like git diff,
git diff --cached, git diff HEAD~ HEAD should be faster now
although the change may be not noticable for small and medium project.


>  Author: Nicolas Pitre <nico@cam.org>:
>  >  deprecate the new loose object header format
>  >
>  >  Now that we encourage and actively preserve objects in a packed form
>  >  more agressively than we did at the time the new loose object format and
>  >  core.legacyheaders were introduced, that extra loose object format
>  >  doesn't appear to be worth it anymore.
>  >
>  >  Because the packing of loose objects has to go through the delta match
>  >  loop anyway, and since most of them should end up being deltified in
>  >  most cases, there is really little advantage to have this parallel loose
>  >  object format as the CPU savings it might provide is rather lost in the
>  >  noise in the end.
>  >
>  >  This patch gets rid of core.legacyheaders, preserve the legacy format as
>  >  the only writable loose object format and deprecate the other one to
>  >  keep things simpler.
> 

Thank you for dig it out for me!


Best regards,

Liu Yubao
