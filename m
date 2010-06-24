From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] msvc: Fix some compiler warnings
Date: Thu, 24 Jun 2010 09:40:41 -0700
Message-ID: <7v1vbwe646.fsf@alter.siamese.dyndns.org>
References: <4C2264E6.4030209@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Jun 24 18:40:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORpU1-0006pt-BT
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 18:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861Ab0FXQkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 12:40:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54989 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754623Ab0FXQkv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 12:40:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 484D6BE960;
	Thu, 24 Jun 2010 12:40:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lhqkYNNxuE4IV9tUUo5zCaXA6wA=; b=uWXGJi
	f8qTZug4XRUE32JcRksF1ZUTdvsneLTb5yerm5AxSMFBDvJX3n3W2w88ti+mKA3M
	jZCmgFkHw+3lNFh9XwrhcicZ+vXKITQ70oIK97PGTvGZW8DkJt3xueSepTLEbZyX
	yIw9y1Ees2un+7OdLJrkO52U50khDsE+KIGFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LuJ3aGluoaSeXiN5Ce5fFJhDdIaIOtOa
	UrA8aIg0FbrEYfvpIiAZeG6BPe3pOkCGyJb1jDLH2m84tHRDku7n2ksbPd12rPMa
	/Q+E0j8UpFozy21iTM9lIxA/fGLicaZEb+bSn9M7jNOZA+/IRXAqlgKxizmzF38T
	JASVMXEjpIg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 130A0BE95C;
	Thu, 24 Jun 2010 12:40:47 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E885BE95A; Thu, 24 Jun
 2010 12:40:42 -0400 (EDT)
In-Reply-To: <4C2264E6.4030209@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Wed\, 23 Jun 2010 20\:47\:50 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3D662CF2-7FAF-11DF-8166-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149603>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> In particular, using the normal (or production) compiler
> warning level (-W3), msvc complains as follows:
>
> .../sha1.c(244) : warning C4018: '<' : signed/unsigned mismatch
> .../sha1.c(270) : warning C4244: 'function' : conversion from \
>    'unsigned __int64' to 'unsigned long', possible loss of data
> .../sha1.c(271) : warning C4244: 'function' : conversion from \
>    'unsigned __int64' to 'unsigned long', possible loss of data
>
> Note that gcc issues a similar complaint about line 244 when
> compiling with -Wextra.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

I do not think it matters much, but ...

>  block-sha1/sha1.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
> index e102856..c0054a0 100644
> --- a/block-sha1/sha1.c
> +++ b/block-sha1/sha1.c
> @@ -237,13 +237,13 @@ void blk_SHA1_Init(blk_SHA_CTX *ctx)
>  
>  void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
>  {
> -	int lenW = ctx->size & 63;
> +	unsigned int lenW = ctx->size & 63;
>  
>  	ctx->size += len;
>  
>  	/* Read the data into W and process blocks as they get full */
>  	if (lenW) {
> -		int left = 64 - lenW;
> +		unsigned int left = 64 - lenW;
>  		if (len < left)
>  			left = len;
>  		memcpy(lenW + (char *)ctx->W, data, left);

... surprisingly this patch changes the compiler output slightly.

 Disassembly of section .text:
 
 0000000000000000 <blk_SHA1_Init>:
 ...
 		unsigned int left = 64 - lenW;
     11ee:	bb 40 00 00 00       	mov    $0x40,%ebx
     11f3:	44 29 f3             	sub    %r14d,%ebx
 		if (len < left)
-    11f6:	41 89 df             	mov    %ebx,%r15d
+    11f6:	4c 63 fb             	movslq %ebx,%r15
     11f9:	4c 39 fd             	cmp    %r15,%rbp
     11fc:	73 05                	jae    1203 <blk_SHA1_Update+0x53>
 			left = len;
     11fe:	89 eb                	mov    %ebp,%ebx
-    1200:	41 89 ef             	mov    %ebp,%r15d
+    1200:	4c 63 fd             	movslq %ebp,%r15
 		memcpy(lenW + (char *)ctx->W, data, left);
     1203:	49 8d 45 1c          	lea    0x1c(%r13),%rax
-    1207:	44 89 f7             	mov    %r14d,%edi
+    1207:	49 63 fe             	movslq %r14d,%rdi
     120a:	4c 89 fa             	mov    %r15,%rdx
     120d:	4c 89 e6             	mov    %r12,%rsi
     1210:	48 01 c7             	add    %rax,%rdi
     1213:	48 89 04 24          	mov    %rax,(%rsp)
