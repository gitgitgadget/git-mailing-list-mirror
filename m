From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3 10/11] http-fetch: Use index-pack rather than
 verify-pack to check packs
Date: Sun, 18 Apr 2010 11:07:16 +0800
Message-ID: <20100418110716.000050e5@unknown>
References: <20100416100307.0000423f@unknown>
	<1271534864-31944-10-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 18 05:07:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3KrB-0005G4-I5
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 05:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756949Ab0DRDHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 23:07:31 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58063 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756776Ab0DRDHa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 23:07:30 -0400
Received: by gwaa18 with SMTP id a18so2047615gwa.19
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 20:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=p7Q6RiAufRVSKo+p9COzt8UPRjkn+h/GTxsNGNOkz/w=;
        b=RjZVz2QqFiDIUaqE4r+zdADotJFUAeNfVDB4NF0WTFaMDzFX/iP7wvKS/M/bho7kLm
         lanstMomNMEXfTXkBcBZT5BMFd5qUoqRyNMyU+PNF3JfEfWCveLKmZwpiiDm7sDsbaNK
         8HeJ7Z0AV6slS1hlpM08SI/cQwihvT8fQmZm4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=wlibEhbuObXn4I+Iwh7D3jXTIxHiV5Ex9ftjWJ2wHl2s4nmuvM7dnhXz0Xd1NGQxLU
         Y8AAIIITNQ/5VzPaddGM5xBWYl4D1Bftf2hpeDtXJMsnSAWdznBmYCNBRh5pq/yQx2xl
         wuKRfIW7soUCkaMaTev2BbzItNp4i8cWZjKbI=
Received: by 10.100.233.2 with SMTP id f2mr8928128anh.43.1271560048903;
        Sat, 17 Apr 2010 20:07:28 -0700 (PDT)
Received: from unknown (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id r21sm30157462anp.17.2010.04.17.20.07.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 20:07:28 -0700 (PDT)
In-Reply-To: <1271534864-31944-10-git-send-email-spearce@spearce.org>
X-Mailer: Claws Mail 3.7.4cvs1 (GTK+ 2.16.0; i586-pc-mingw32msvc)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145206>

Hi,

On Sat, 17 Apr 2010 13:07:43 -0700
"Shawn O. Pearce" <spearce@spearce.org> wrote:

> diff --git a/http.c b/http.c
> index 9f3dfc1..a7352b7 100644
> --- a/http.c
> +++ b/http.c
[snip]
> @@ -998,11 +999,15 @@ void release_http_pack_request(struct http_pack_request *preq)
>  
>  int finish_http_pack_request(struct http_pack_request *preq)
>  {
[snip]
> +	unlink(sha1_pack_index_name(p->sha1));

I think this should be done later, after we have run index-pack
successfully. A good place would be probably after the if() block here:

> +	if (run_command(&ip)) {
> +		unlink(preq->tmpfile);
> +		unlink(tmp_idx);
> +		free(tmp_idx);
>  		return -1;
> -	install_packed_git(p);
> +	}

-- 
Cheers,
Ray Chuan
