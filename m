From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] pack-protocol.txt: Elaborate on pusher identity
Date: Wed, 01 Jul 2015 11:58:41 -0700
Message-ID: <xmqq7fqjaen2.fsf@gitster.dls.corp.google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
	<1435774099-21260-5-git-send-email-dborowitz@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 20:58:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZANDf-0003EX-N5
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 20:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947AbbGAS6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 14:58:47 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34595 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763AbbGAS6q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 14:58:46 -0400
Received: by igcsj18 with SMTP id sj18so142665682igc.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 11:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=054Dzmx22BowrFAes9/053SZj4f+7Gkb5qdgZZuxu24=;
        b=PtPUBou/QKJywFsbCcUJf8raKq+ztW79OIGitOOrxKwmC/v3EIrLXSiqKoTu9WrCm2
         HKMV4e/4bA7armazqV/mC00ttZQYqmDGpxGcQ3h9d1Doy/oXbpdj7UW+faDwOagfE2uV
         Wsp18D/6yJMDp2ekTEhsesQnx8mrCeZsEo3Bybh9LtsQ53DVStchqZJNoNrRKDDVO88h
         hxxUVckOI8eaWlx56A5mOfN3Z6KXdBv9WSEY5/46YKl1cSs7l+gS/X19H5+LelIMNvVF
         QUaj7bgqKyJqsoBLqu7olYITD9KOx45hTAucctO8/YKcnG+J6EcpNYuwKtHt+s2ElXDd
         XS1Q==
X-Received: by 10.107.128.72 with SMTP id b69mr38589413iod.84.1435777125895;
        Wed, 01 Jul 2015 11:58:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:64b9:4225:baa1:c97c])
        by mx.google.com with ESMTPSA id d96sm1991710ioj.37.2015.07.01.11.58.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Jul 2015 11:58:45 -0700 (PDT)
In-Reply-To: <1435774099-21260-5-git-send-email-dborowitz@google.com> (Dave
	Borowitz's message of "Wed, 1 Jul 2015 11:08:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273182>

Dave Borowitz <dborowitz@google.com> writes:

> This is sort of like a standard identity, except that RFC 4880 section
> 4.11 allows any UTF-8 text in the User ID packet. It is trivial to get
> gpg to pass arbitrary text when generating a push cert by setting
> user.signingKey to that arbitrary value (assuming it is an actual user
> ID associated with that key).
>
> Signed-off-by: Dave Borowitz <dborowitz@google.com>
> ---

I think this is a good idea.  I notice that "nonce" used near-by
also lacks the definition, which we would want to document.

Thanks.

>  Documentation/technical/pack-protocol.txt | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
> index 2d8b1a1..de3c72c 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -494,7 +494,7 @@ references.
>  
>    push-cert         = PKT-LINE("push-cert" NUL capability-list LF)
>  		      PKT-LINE("certificate version 0.1" LF)
> -		      PKT-LINE("pusher" SP ident LF)
> +		      PKT-LINE("pusher" SP push-cert-ident LF)
>  		      PKT-LINE("pushee" SP url LF)
>  		      PKT-LINE("nonce" SP nonce LF)
>  		      PKT-LINE(LF)
> @@ -502,6 +502,8 @@ references.
>  		      *PKT-LINE(gpg-signature-lines LF)
>  		      PKT-LINE("push-cert-end" LF)
>  
> +  push-cert-ident   = 1*(UTF8) SP ["-"] 1*(DIGIT) SP ["-"|"+"] 1*(DIGIT)
> +
>    packfile          = "PACK" 28*(OCTET)
>  ----
>  
> @@ -540,8 +542,14 @@ Note that (unlike other portions of the protocol), all LFs in the
>  Currently, the following header fields are defined:
>  
>  `pusher` ident::
> -	Identify the GPG key in "Human Readable Name <email@address>"
> -	format.
> +	Identity of the GPG key. This is similar to the identify found
> +	elsewhere, such as the author/committer field in commit headers,
> +	in that it consists of a name portion, a timestamp, and a
> +	timezone offset. However, unlike normal git identities, the name
> +	field may be any valid OpenPGP User ID, which is any valid UTF-8
> +	string. (By convention this matches the form:
> +	"Human Readable Name (optional comment) <email@address>"
> +	but this is only a convention.)
>  
>  `pushee` url::
>  	The repository URL (anonymized, if the URL contains
