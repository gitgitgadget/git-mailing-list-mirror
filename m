From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Limit the size of the data block passed to SHA1_Update()
Date: Sat, 31 Oct 2015 21:32:17 -0400
Message-ID: <CAPig+cRRjCDhdT-DvGtZqns1mMxygnxi=ZnRKzg+H_do7oRpqQ@mail.gmail.com>
References: <CA+izobsBmYHHepYka795K2VnVLYBmN2tFqEyzSweMoS9gvuRVw@mail.gmail.com>
	<1446243122-21464-1-git-send-email-apahlevan@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: Atousa Pahlevan Duprat <atousa.p@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 02:32:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZshVt-0003K3-Ou
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 02:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbbKABcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 21:32:19 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:35302 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbbKABcS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 21:32:18 -0400
Received: by vkfw189 with SMTP id w189so67617086vkf.2
        for <git@vger.kernel.org>; Sat, 31 Oct 2015 18:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2rUYgz/8M98yTDIdkPGAd96HNNXex/SfDbS+EG97Uhc=;
        b=w4ZHWq5JBXmc2Z8DCLBYIsD9S9zdsYzGM4D1bmkvrC4nvbfVv03AkxQ7r3QjqUimvu
         MY6a0X1dI2peD6PKDRSbB1DePa2nvL8dzLNQRb2q+J7lMrDK+o5a40s0mIjZ7EAFFsHA
         FQhXmHZpL600Tgs2U9hk60kQEql6L2QG6QU5ums+7V2JUAFdsknyYWge0kvK6qykGbbk
         SaHoCOBZK4KuxxnH6G9jCcATCwmBuHy0incLQIXlq2Cv1OuwKZuSC9lt0u5JZw04llrC
         pyf9ilfXORuwJvHhl4ucV1SLZ06pB8SFkEOpGhW71t51Qg9hwLfyB2eD/Yy9bv908w6V
         jf9g==
X-Received: by 10.31.131.141 with SMTP id f135mr10629044vkd.37.1446341537824;
 Sat, 31 Oct 2015 18:32:17 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Sat, 31 Oct 2015 18:32:17 -0700 (PDT)
In-Reply-To: <1446243122-21464-1-git-send-email-apahlevan@ieee.org>
X-Google-Sender-Auth: 7GjkWRJ-eWioEqLapmIjjvUdPHw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280604>

On Fri, Oct 30, 2015 at 6:12 PM, Atousa Pahlevan Duprat
<atousa.p@gmail.com> wrote:
> Some implementations of SHA_Updates have inherent limits
> on the max chunk size. SHA1_MAX_BLOCK_SIZE can be defined
> to set the max chunk size supported, if required.  This is
> enabled for OSX CommonCrypto library and set to 1GiB.
> ---
> diff --git a/compat/apple-common-crypto.h b/compat/apple-common-crypto.h
> index c8b9b0e..83668fd 100644
> --- a/compat/apple-common-crypto.h
> +++ b/compat/apple-common-crypto.h
> @@ -16,6 +16,10 @@
>  #undef TYPE_BOOL
>  #endif
>
> +#ifndef SHA1_MAX_BLOCK_SIZE
> +#error "Using Apple Common Crypto library requires setting SHA1_MAX_BLOCK_SIZE"
> +#endif

You can drop the quotes around the argument to #error.
