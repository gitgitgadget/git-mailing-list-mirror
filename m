From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] archive-tar: split long paths more carefully
Date: Sat, 5 Jan 2013 15:31:06 -0800
Message-ID: <20130105233106.GA5686@elie.Belkin>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org>
 <50E8AE12.8040102@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jan 06 00:31:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrdDB-0000Ti-EA
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 00:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932Ab3AEXbP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jan 2013 18:31:15 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:40184 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898Ab3AEXbN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jan 2013 18:31:13 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so9920450pad.11
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 15:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=36vXkQnyiZ1VheNaOk/tbxf8PAX6O9he+/hmoVvjKnw=;
        b=UZTYHIFSSvNC0Nl31ApX8sXNrl+vsNmqm8+NIP+bqQxaJoGAHemYNG+P0yijBTCOtx
         xWgLGVryoAwUnD3SLtqW+GI169Kxf3jtlMl0uD65Hi3GBN76/GeabS9fXIabSQPwaqQ/
         FnZnKKuuK/cdMPBxiA0dVmtNbAr5oss6/mBn8GXKXc/hyIREF7ikZOagwpoqPG8PUBTj
         xJSLFEQzRxCQq9Dn5KNNSdpwM6d9bz0Mfgxp9xgnL4fOcAZZRUOg6NoYVRuZzLNx9jo8
         kGDvuuS6VBnk+nOn0ZXAnCqn1KEt+V9fYzmvjheVLuFkZSX0nBmCSmA7MphWkXItxRKN
         5kHQ==
X-Received: by 10.68.254.137 with SMTP id ai9mr172699255pbd.21.1357428673532;
        Sat, 05 Jan 2013 15:31:13 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id rn8sm4978656pbc.65.2013.01.05.15.31.12
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 15:31:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50E8AE12.8040102@lsrfire.ath.cx>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212741>

Ren=C3=A9 Scharfe wrote:

> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -153,6 +153,8 @@ static unsigned int ustar_header_chksum(const str=
uct ustar_header *header)
>  static size_t get_path_prefix(const char *path, size_t pathlen, size=
_t maxlen)
>  {
>  	size_t i =3D pathlen;
> +	if (i > 1 && path[i - 1] =3D=3D '/')
> +		i--;

Beautiful.
