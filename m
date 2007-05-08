From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] remove unnecessary loop
Date: Tue, 8 May 2007 11:08:35 +0200
Message-ID: <81b0412b0705080208x3713cbc1y3c870383b586c877@mail.gmail.com>
References: <463FEC07.8080605@gmail.com> <4640015F.1080407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Liu Yubao" <yubao.liu@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 11:08:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlLga-0002GB-Cu
	for gcvg-git@gmane.org; Tue, 08 May 2007 11:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbXEHJIj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 05:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966235AbXEHJIj
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 05:08:39 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:31027 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965148AbXEHJIi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 05:08:38 -0400
Received: by an-out-0708.google.com with SMTP id d18so215403and
        for <git@vger.kernel.org>; Tue, 08 May 2007 02:08:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Iy2lVo8c0CVRTqJV96t/g2i2LCduuTWvzv6QvIH38iRrqk48jORxvEaz4MODDyK7W08ABdTJi5iVjiDs7ws//BQQ6vCTFYl5bwyU/AJrmip2fAYGe5rX3aSE41NyPXQfOcSinnMsw4M24byNX/xWMaOT+t69y7bCVE7NyVNtvpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g33ZdetPpZgo78zZFrjlawxp5jYWEjRt3rnJE6uiibE9NIGXqX1jir74stKKjZy6LlNaggZO+dkgIQZ4XFn0uEYWTDdPsRCQTJd9ma6aGab8OLhtXvZFK6pt4sK/Su6UNTE2J5kM1sKKw55Jn6HeZUXH0Izg1BtOT1agy3XmEtM=
Received: by 10.101.68.18 with SMTP id v18mr3014338ank.1178615315571;
        Tue, 08 May 2007 02:08:35 -0700 (PDT)
Received: by 10.100.202.10 with HTTP; Tue, 8 May 2007 02:08:35 -0700 (PDT)
In-Reply-To: <4640015F.1080407@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46555>

On 5/8/07, Liu Yubao <yubao.liu@gmail.com> wrote:
> +#ifdef __CYGWIN__
> +               /*
> +                * On cygwin, lstat("hello", &st) returns 0 when
> +                * "hello.exe" exists, so test with open() again.
> +                */
> +               if (lstat(match, &st) && -1 != (fd = open(match, O_RDONLY))) {

This does not "test again" if lstat returns 0. If lstat returns 0
(file stat info
obtained) the open is not even called. Besides, cygwin lies not only about
.exe but also about .lnk files.

P.S. Somehow I have the feeling that even if it is a stupidity in cygwin
they will not fix it (nor will they admit it is a bug).
