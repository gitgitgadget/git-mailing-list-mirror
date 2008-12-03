From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: [PATCH 5/5] support writing uncompressed loose object
Date: Wed, 03 Dec 2008 12:22:46 +0800
Message-ID: <49360996.40106@gmail.com>
References: <493399B7.5000505@gmail.com> <7voczws3np.fsf@gitster.siamese.dyndns.org> <4934975E.2010601@gmail.com> <20081202160706.GN23984@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 03 05:24:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7jHk-00024j-7z
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 05:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbYLCEWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 23:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752716AbYLCEWx
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 23:22:53 -0500
Received: from ti-out-0910.google.com ([209.85.142.191]:11035 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbYLCEWx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 23:22:53 -0500
Received: by ti-out-0910.google.com with SMTP id b6so2119178tic.23
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 20:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=8ULRvEFcvcu16eSYQ1VOkzRq9RJ94UotKrO+NF0Y/GM=;
        b=YngrxA0x1ExElE6qg+miDfEDzGG19ALi13ZUC1n/5E4H9yx/9zMfxlW172xGVs+RAT
         iOG4sSdIW+d6gZ8GOEr+aAYp+8Fi+P2QvtmzGzP5Z1AyOULjR2YkSQO84qFZLr83nxR+
         t2VPeP1noN3bFQe47ODD8aKW2fV7im/Yw1hFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=d4WpQLdPhh42sGEMh/dZEQ4VADTocFS13K0sfzTOp7UPhcMhjZktv2y8b952Sa4zAO
         fShF7m/DB5gFYvbAOvpl98BIZL+faCUzUUVXCLcgSQmTeXXTIYoCXwr8gSdiBTd53bAM
         Tfaz1UIs6QfXhxddRabPqfCo9kTA40h9QVN8o=
Received: by 10.110.42.17 with SMTP id p17mr10876311tip.42.1228278170804;
        Tue, 02 Dec 2008 20:22:50 -0800 (PST)
Received: from ?10.64.1.78? ([211.157.41.194])
        by mx.google.com with ESMTPS id 14sm2332308tim.11.2008.12.02.20.22.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Dec 2008 20:22:49 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <20081202160706.GN23984@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102214>

Shawn O. Pearce wrote:
> Liu Yubao <yubao.liu@gmail.com> wrote:
>> Signed-off-by: Liu Yubao <yubao.liu@gmail.com>
> 
> IMHO, this needs more description in the commit message.
> 
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 05a9fa3..053b564 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -2328,7 +2328,7 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
>>  }
>>  
>>  static int write_loose_object(const unsigned char *sha1, char *hdr, int hdrlen,
>> -			      void *buf, unsigned long len, time_t mtime)
>> +			      void *buf, unsigned long len, time_t mtime, int dont_deflate)
> 
> Passing this as an argument is pointless.  It should be a repository
> wide configuration option in core, so you can declare it a static and
> allow git_config to populate it.  Defaulting to 1 (no compression)
> like you do elsewhere in the patch isn't good.
> 
Aha, sorry again, I sent the patch series as separate topics by mistake.

I considered adding a configuration variable, the patch series are sent
just to see whether the idea is worth.

> I'm still against this file format change.  The series itself isn't
> that bad, and the buffer overflow catch in parse_sha1_header()
> may be something worthwhile fixing.  But I'm still not sold that
> introducing a new loose object format is worth it.
> 
> I'd rather use a binary header encoding like the new-style/in-pack
> format rather than the older style text headers.  Its faster to
> parse for one thing.
> 
The key point I suggest is to use *uncompressed* loose object, I didn't
change the format of uncompressed loose object because I don't want
to distract your attention and keep the patches small.

> Your changes in the reading code cause a copy of the buffer we
> mmap()'d.  That sort of ruins your argument that this change is
> worthwhile because concurrent processes on the same host can mmap the
> same buffer and save memory.  We're still copying the buffer anyway.
> I probably should have commented on that in patch 4/5, but I just
> realized it, so I'm saying it here.
> 
Yes, I mentioned it in the cover letter(sigh, sorry!)

I didn't use the mapped buffer directly because other functions required
a null terminated buffer to parse data part of loose object. It can be
fixed but I don't want to make the patches too big.

The two big pros of uncompressed loose object are:

*) avoid compressing and uncompressing loose objects    (I have implemented it)
*) use memory mapped loose object directly              (I havn't implemented it)


Thank you for reviewing my patches, seems the idea to use uncompressed loose
object isn't attractive enough, I will keep the patches locally.


Best regards,

Liu Yubao
