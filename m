From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 0/3] Begin replacing OpenSSL with CommonCrypto
Date: Tue, 21 May 2013 12:36:16 -0700
Message-ID: <20130521193616.GU3657@google.com>
References: <1368959016-23146-1-git-send-email-sunshine@sunshineco.com>
 <7vfvxhs1pz.fsf@alter.siamese.dyndns.org>
 <519BC8B0.5050100@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	David Aguilar <davvid@gmail.com>
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue May 21 21:36:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UesME-0001GJ-VY
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 21:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755778Ab3EUTgW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 May 2013 15:36:22 -0400
Received: from mail-da0-f52.google.com ([209.85.210.52]:63715 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054Ab3EUTgV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 15:36:21 -0400
Received: by mail-da0-f52.google.com with SMTP id o9so631205dan.39
        for <git@vger.kernel.org>; Tue, 21 May 2013 12:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=h2VE9XmBM0IW/xWJP3yHwqZkTS4kJrm8pEXDs0ujU5g=;
        b=DJkS90tYv7AvT/TEB6sAKgQNrBMsIDBtqHMJMYRnfMoi7er9JrG3tzMh3bg3iOCsTU
         4mium8ldI0DevRfre1ufeShVRMnPC+BUDSrpY88I71a6vnSBvqG7EPHHoCxQztiUN/N6
         4/DngV82vdAgpmPp9YxfpqMQFLFlqlLg9ypofZArQs5dUOn8ppcv2W/gtWB7VNUG38ui
         4BmRRWvWlQ2DAROuq5ZQGG70jsMTHbXdhVdIxtGMebbj2AWyZMzmbQfxObYJUfGRUnsQ
         pxAOtQM/ToSf2z9GgQhTxhGqyXKWwBAyz3tnbFyLNLApGM8OQnewiPBxvN/kP7GfAhMi
         PAYA==
X-Received: by 10.68.49.130 with SMTP id u2mr4232349pbn.124.1369164981122;
        Tue, 21 May 2013 12:36:21 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id vm10sm4542210pab.5.2013.05.21.12.36.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 May 2013 12:36:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <519BC8B0.5050100@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225068>

Torsten B=C3=B6gershausen wrote:

> One minor nit, or 2:
> imap-send.c: In function =E2=80=98cram=E2=80=99:
> imap-send.c:913: warning: statement with no effect
>
> This fixes it:
>
> diff --git a/imap-send.c b/imap-send.c
> index 8ea180f..11577c9 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -35,7 +35,7 @@ typedef void *SSL;
> #define HMAC_Init(hmac, key, len, algo) CCHmacInit(hmac, algo, key, l=
en)
> #define HMAC_Update CCHmacUpdate
> #define HMAC_Final(hmac, hash, ptr) CCHmacFinal(hmac, hash)
> -#define HMAC_CTX_cleanup
> +#define HMAC_CTX_cleanup(c)
> #define EVP_md5() kCCHmacAlgMD5
> #else
> #include <openssl/evp.h>

Good catch.  Thanks.

> (And I think there are more minor nits:
> #define HMAC_Final(hmac, hash, ptr) CCHmacFinal(hmac, hash)
> could be written as
> #define HMAC_Final(hmac, hash, ptr) CCHmacFinal((hmac), (hash))
> (Use paranthese around each parameter)
> Similar change for HMAC_Init()

Not needed --- the comma operator has lower precedence than any other,
and any expression containing commas would have to already be
surrounded by parentheses to be an argument to this function-like
macro.

Jonathan
