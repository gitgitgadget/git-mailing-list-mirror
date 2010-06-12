From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] Add memory pool library
Date: Sat, 12 Jun 2010 01:42:51 -0500
Message-ID: <20100612064250.GB2549@burratino>
References: <1276175389-6185-1-git-send-email-artagnon@gmail.com>
 <1276175389-6185-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 08:43:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONKRS-0000J6-19
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 08:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716Ab0FLGnA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jun 2010 02:43:00 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63384 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678Ab0FLGm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 02:42:59 -0400
Received: by iwn9 with SMTP id 9so1210403iwn.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 23:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZWC5Ezb0cG4HtOvKJvJYT0rAcIhMO7ZTpYu3Nf4hmro=;
        b=QwXViZ/OfNqK72PUoujaxMPoRTRD05wNndXxlo/F6uJCfZ63uAyOY0H8/yNXH8/QLH
         CwGsvmiuRzhsYB4/iRqFdBQ7rDtsCQLZ+0KmP/aB8PSqFT1wLOik/xr/3NDwmNVjBDPc
         mwJZFXIBsFYvvfeisbxNMIYEatmpsSmLWX5T0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=D/OFDAMwxfYRJKuoNP8sZoQ7IqzaXx8i2gTFCkSTrknyf26BKhW0IcevKi6f+YBZnX
         b856eulOAT88fyXEk69PaYXO6wIyhu8rx4pebgqGTpU63xeKHcPsOmRxsaysvFegRDEB
         NKVWK00rtmritqBy6/1pybabYXDhGKrD/4Fg8=
Received: by 10.231.184.1 with SMTP id ci1mr2907310ibb.39.1276324978421;
        Fri, 11 Jun 2010 23:42:58 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f1sm9027334ibg.9.2010.06.11.23.42.57
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 11 Jun 2010 23:42:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1276175389-6185-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148993>

Ramkumar Ramachandra wrote:

> +#define obj_pool_gen(pre, obj_t, initial_capacity) \
> +static struct { \
> +	uint32_t committed; \
> +	uint32_t size; \
> +	uint32_t capacity; \
> +	obj_t *base; \
> +	FILE *file; \
> +} pre##_pool =3D { 0, 0, 0, NULL, NULL}; \
> +static void pre##_init(void) \
> +{ \
[...]

This defines a family of functions and not all pools use them all.
One workaround is to annotate them, like this:

 #ifdef __GNUC__
 #define MAYBE_UNUSED __attribute__((__unused__))
 #else
 #define MAYBE_UNUSED
 #endif

 #define obj_pool_gen(pre, obj_t, initial_capacity) \
 ... \
 static MAYBE_UNUSED void pre##_init(void) \
 { \
 ...

Could that work here?

The =E2=80=9Cunused=E2=80=9D attribute was added in gcc 2.7.

Jonathan
