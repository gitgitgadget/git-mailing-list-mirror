From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] Use faster byte swapping when compiling with MSVC
Date: Tue, 20 Oct 2009 14:44:10 +0200
Message-ID: <40aa078e0910200544i3d8aadc1ud62cf62a6964dd5@mail.gmail.com>
References: <hbi4mt$tjt$1@ger.gmane.org>
	 <loom.20091020T141138-782@post.gmane.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ludvig Strigeus <ludde@spotify.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 14:44:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0E4a-0006jy-5c
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 14:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbZJTMoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 08:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbZJTMoI
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 08:44:08 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:39973 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbZJTMoH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 08:44:07 -0400
Received: by fxm18 with SMTP id 18so6369329fxm.37
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 05:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=VJymPmroP2dGBgPvj2ZFNt9EeF4juxGXLwZ3fXpcLCE=;
        b=HyUidbv6HFb+n/tDsrc+KwL+sSfVsvkj7VHAVo31EMJmzFoaSu/HIT0wcydvASBKar
         Yz0HG/cHNGicSq+ob2dWUwYiYceMe3pVgE7hK0OTDuQRU/vh7SLbhYzADfYJmgjkYK25
         rwpKHz9yvCjMXwGpvVTHmZSlXNj3KUTaQDJ40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=xaJy3CUhzVPC3huO6uRWi1L2pdgHIMKhZxvo4U2p9GqnJ/hYm+Ht7Rwj6rcV0LPifo
         bLYexXxJ3p1UL4bWADi+GtfF5wi/OAtzYGn0zrwWM2X1NK/JyosTdPhnqPwOW8wik5y6
         vBAkvcDlxZSciJFbXga4EEZ59eXVKwljNx7qg=
Received: by 10.204.25.19 with SMTP id x19mr6316941bkb.189.1256042651072; Tue, 
	20 Oct 2009 05:44:11 -0700 (PDT)
In-Reply-To: <loom.20091020T141138-782@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130792>

On Tue, Oct 20, 2009 at 2:20 PM, Ludvig Strigeus <ludde@spotify.com> wrote:
> unsigned long (as used by _byteswap_ulong) is 64 bits on x64, right? Then it
> doesn't make sense to use _byteswap_ulong to swap 32-bit quantities (assuming
> that's what bswap32 does) would it?

No, unsigned long is 32bit on x64 on Windows.

--->8---
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
  printf("sizeof(void *) = %d\n", sizeof(void *));
  printf("sizeof(unsigned long) = %d\n", sizeof(unsigned long));
  return 0;
}
--->8---
sizeof(void *) = 8
sizeof(unsigned long) = 4

-- 
Erik "kusma" Faye-Lund
