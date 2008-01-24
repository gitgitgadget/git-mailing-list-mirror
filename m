From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: I'm a total push-over..
Date: Thu, 24 Jan 2008 21:45:18 +0300
Message-ID: <37fcd2780801241045o359c19b3h4e2b0c3cf6786aa@mail.gmail.com>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>
	 <4796FBB6.9080609@op5.se> <20080123091558.GP14871@dpotapov.dyndns.org>
	 <4797095F.9020602@op5.se>
	 <e51f66da0801230601n6edd2639lff70415afa9f9026@mail.gmail.com>
	 <4797518A.3040704@op5.se>
	 <e51f66da0801240519u4c8e6ddfrb7af8df34552252a@mail.gmail.com>
	 <4798B633.8040606@op5.se>
	 <37fcd2780801240828vac82e6ds4da5aecde56e8d2f@mail.gmail.com>
	 <alpine.LFD.1.00.0801240839590.2803@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>, "Marko Kreen" <markokr@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 24 19:46:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI75J-0001ob-Ob
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 19:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbYAXSpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 13:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbYAXSpX
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 13:45:23 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:13358 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbYAXSpW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 13:45:22 -0500
Received: by wx-out-0506.google.com with SMTP id h31so231110wxd.4
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 10:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=zGZdzJkpkus5nYWG2tNjg7of833fcoKUojcWyl/0Kro=;
        b=xj1BvfCs51I8iXXSlFA1M9pZHeihNZ0lK1VM7RsMkRqW6BW3SKz+TdTGFjXCrQEjgx0Xgqsm4CUX4hFzDMBcOquklw6vrOsSPSlFfg3MLxR+FpjambC3T/P/k7Jyc3hEFUtlEAi99RSdw0LH9LGgrJ0X55RfH4JFYeaRDhXov/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gKbOITtoDG88tFHNMUo7CFKGAN9RUefuCrUlkThwCcshF6hRjI8BWAhDY2MVNF+WyW84Y2wcft6Q8Rn10Ux/+TZRxCJlo5CTq6Nx4HcU9rxccvdK28qt5XvUv8bWEPw2bK6XOJJqDA6A53Z29/z1xSdVZ1ktAjOKFwTfsNmv448=
Received: by 10.142.49.4 with SMTP id w4mr620704wfw.167.1201200318088;
        Thu, 24 Jan 2008 10:45:18 -0800 (PST)
Received: by 10.143.157.20 with HTTP; Thu, 24 Jan 2008 10:45:18 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801240839590.2803@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71647>

On Thu, Jan 24, 2008 at 09:15:43AM -0800, Linus Torvalds wrote:
>
>
> You can do a perfectly fine 8-bytes-at-a-time hash for almost 100% of all

I suppose 8 bytes for 64-bit platforms and 4 bytes for 32-bits.

>
> 	unsigned int name_hash(const char *name, int size)
> 	{
> 		hash = HASH_INIT;
> 		do {
> 			unsigned char c;
> 			if (size >= sizeof(long)) {
> 				unsigned long val = get_unaligned_long(name);
> 				if (!(val & 0x8080808080808080)) {
> 					/* Make it equivalent in case */
> 					val &= ~0x2020202020202020;
> 					hash = hash_long(hash, val);
> 					name += sizeof(long);
> 					size -= sizeof(long);
> 					continue;
> 				}
> 			}
>
> 			c = *name;
> 			if (!(c & 0x80)) {
> 				hash = hash_long(hash, c & ~0x20);
> 				name++;
> 				size--;
> 				continue;
> 			}

It is better to use 'while' instead of 'if' here, i.e.:

			while (!((c = *name) & 0x80)) {
				hash = hash_long(hash, c & ~0x20);
				name++;
				if (!--size)
					return hash;
			}

>
> 			/* This is the unusual and slowish case */
> 			hash = hash_utf8_char(hash, c, &name, &size);
> 		} while (size);
> 		return hassh;
> 	}


Dmitry
