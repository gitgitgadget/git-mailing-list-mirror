From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Fri, 19 Feb 2010 09:52:00 -0800
Message-ID: <7v635tkta7.fsf@alter.siamese.dyndns.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100213121238.GA2559@progeny.tock> <20100213133951.GA14352@Knoppix>
 <201002131539.54142.trast@student.ethz.ch> <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <20100219082813.GB17952@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 18:52:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiX1d-0000nX-0I
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 18:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276Ab0BSRwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 12:52:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab0BSRwS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 12:52:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E01899B434;
	Fri, 19 Feb 2010 12:52:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=zzNVROXtCxzstIqtRh4Atfmsm0w=; b=bh2aYuKLc78VcBocx5MAF9W
	Qv2trGcarS34zh5grNzbAZ6wdO2WssdZgmx2Jir2s2TxCId2FvRFA5n8+4d+VVQq
	FasMpd+7NYiHjKVKPGaDx+1kWuyAAYZtua3br7fQrlpsyw3W7tyYx/PGeJkOIyQT
	i1BnLZjod7ogQ0EKPt6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=L91T7kOYvMu7iDwj0SG9M1VA2XGqrEy4qppuRyWsi69U+OAks
	OQHoCIbunMU+TF0ytMmFA9cP4QCb42hbt2aaKjg8gR1sW9NQ9/GK2JkCneJ1hXrK
	pEl0/Ulr76ztaXO9zhKd8Puq5lNi3lyQ4SEQn57h1F2tsvzhG7unv74cw4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 693AE9B429;
	Fri, 19 Feb 2010 12:52:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 891F89B417; Fri, 19 Feb
 2010 12:52:02 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 80D3A808-1D7F-11DF-8EB1-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140472>

Dmitry Potapov <dpotapov@gmail.com> writes:

> ... I think it is possible
> to avoid the overhead of being on the safe side in a few common cases.
> Here is a patch. I have not had time to test it, but changes appear to
> trivial.

Yeah, these are obvious "paranoia not needed" cases.

How much "speed-up" are we talking about, though?  Can we quantify?  I
personally think it is not even worth to quantify it but instead simply
say "avoid unnecessary computation" without saying "speed up", though ;-)

Thanks.

> -- >8 --
> From 3e53610a41c4aad458dff13135a73bb4944f456b Mon Sep 17 00:00:00 2001
> From: Dmitry Potapov <dpotapov@gmail.com>
> Date: Fri, 19 Feb 2010 11:00:51 +0300
> Subject: [PATCH] speed up "git add" by avoiding the paranoid mode
>
> While the paranoid mode preserve the git repository from corruption in the
> case when the added file is changed simultaneously with running "git add",
> it has some overhead. However, in a few common cases, it is possible to
> avoid this mode and still be on the safe side:
>
> 1. If mmap() is implemented as reading the whole file in memory.
>
> 2. If the whole file was read in memory as result of applying some filter.
>
> 3. If the added file is small, it is faster to use read() than mmap().
>
> Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
> ---
>  sha1_file.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index d8a7722..4efeb21 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2469,6 +2469,7 @@ static int index_mem(unsigned char *sha1, void *buf, size_t size,
>  		                   write_object ? safe_crlf : 0)) {
>  			buf = strbuf_detach(&nbuf, &size);
>  			re_allocated = 1;
> +			paranoid = 0;
>  		}
>  	}
>  
> @@ -2490,7 +2491,7 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
>  	size_t size = xsize_t(st->st_size);
>  
>  	flag = write_object ? INDEX_MEM_WRITE_OBJECT : 0;
> -	if (!S_ISREG(st->st_mode)) {
> +	if (!S_ISREG(st->st_mode) || size < 262144) {
>  		struct strbuf sbuf = STRBUF_INIT;
>  		if (strbuf_read(&sbuf, fd, 4096) >= 0)
>  			ret = index_mem(sha1, sbuf.buf, sbuf.len,
> @@ -2500,7 +2501,9 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object,
>  		strbuf_release(&sbuf);
>  	} else if (size) {
>  		void *buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
> +#ifndef NO_MMAP
>  		flag |= INDEX_MEM_PARANOID;
> +#endif
>  		ret = index_mem(sha1, buf, size, type, path, flag);
>  		munmap(buf, size);
>  	} else
> -- 
> 1.7.0
>
> -- >8 --
