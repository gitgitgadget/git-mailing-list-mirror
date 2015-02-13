From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove duplicate #include
Date: Fri, 13 Feb 2015 13:15:44 -0800
Message-ID: <xmqqegptms1r.fsf@gitster.dls.corp.google.com>
References: <1423838859-15413-1-git-send-email-git-dpa@aegee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: =?iso-2022-jp?B?GyRCJyUnWiddJ3EnXxsoQiAbJEInMSdRJ10nUSdlJ1knYCdTGyhC?= 
	<git-dpa@aegee.org>
X-From: git-owner@vger.kernel.org Fri Feb 13 22:15:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMNaZ-0003D9-Bk
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 22:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967AbbBMVPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 16:15:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753727AbbBMVPq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 16:15:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D41733781A;
	Fri, 13 Feb 2015 16:15:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fesO/tlR5WGM74uRxkM6cnqr+3Y=; b=ixGWq9
	TSVucLHzp3PMaMC3K/3tRcmOZDip5AFSbEA3bJJbiIRSg8QhdhS0UCu90ozKjQw6
	EyhTDvPa7vWDR7Dyt/bk8bJTVmiBb6JJ+evjFIluxtMYKAnroK+szpSpeBeaFIxv
	GqNFw2Ol+mecKvEISJsY6FOdtcQ9l52HLIbAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GrjFqqSheqhnP4MdrsdmoC3Sgk3UXBs9
	v0iZSuEyuboZwEdbYE+Q833j3AlOfG5yBqjc7BDK9lyrYLfhg3bX2D0ABIjUIp9I
	o0fhiDJaQEAbhRUTCiYjhEgCsY62F+AsEsxX7kVIvbGES5ChJZGu/2LdNQIoe7Et
	NbZIX6LcRwo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BEAA537819;
	Fri, 13 Feb 2015 16:15:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3548537817;
	Fri, 13 Feb 2015 16:15:45 -0500 (EST)
In-Reply-To: <1423838859-15413-1-git-send-email-git-dpa@aegee.org>
 (=?iso-2022-jp?B?IhskQiclJ1onXSdxJ18bKEIJGyRCJzEnUSddJ1EnZSdZJ2AnUxsoQiIn?=
 =?iso-2022-jp?B?cw==?= message of "Fri, 13 Feb 2015 14:47:39 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 79428384-B3C5-11E4-A408-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263835>

Дилян Палаузов  <git-dpa@aegee.org> writes:

> deheader (git://gitorious.org/deheader/deheader.git) found out that
> some .c files #include twice one and the same header file.
>
> This patch removes such occurrences and hence speeds up the compilation.

Does it speed up?  By how much?  Any numbers?

I do not see any reason to reject this change.  Removing repeated
inclusions of the same header is a good thing by itself [*1*].

Thanks.

[Footnote]

*1* If things break when repeated inclusions are removed, that would
mean the headers were wrong in the first place.  I do not think
transport.h, string-list.h, quote.h and cache.h have any reason why
they need to be included twice to work correctly, and in fact they
are designed to be no-op when included twice.

> Signed-off-by: Дилян Палаузов <git-dpa@aegee.org>
> ---
>  builtin/fetch.c    | 1 -
>  trailer.c          | 1 -
>  transport-helper.c | 1 -
>  userdiff.c         | 1 -
>  4 files changed, 4 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 7b84d35..75a55e5 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -11,7 +11,6 @@
>  #include "run-command.h"
>  #include "parse-options.h"
>  #include "sigchain.h"
> -#include "transport.h"
>  #include "submodule.h"
>  #include "connected.h"
>  #include "argv-array.h"
> diff --git a/trailer.c b/trailer.c
> index 623adeb..05b3859 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1,7 +1,6 @@
>  #include "cache.h"
>  #include "string-list.h"
>  #include "run-command.h"
> -#include "string-list.h"
>  #include "commit.h"
>  #include "trailer.h"
>  /*
> diff --git a/transport-helper.c b/transport-helper.c
> index 0224687..3652b16 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -5,7 +5,6 @@
>  #include "commit.h"
>  #include "diff.h"
>  #include "revision.h"
> -#include "quote.h"
>  #include "remote.h"
>  #include "string-list.h"
>  #include "thread-utils.h"
> diff --git a/userdiff.c b/userdiff.c
> index fad52d6..2ccbee5 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -1,6 +1,5 @@
>  #include "cache.h"
>  #include "userdiff.h"
> -#include "cache.h"
>  #include "attr.h"
>  
>  static struct userdiff_driver *drivers;
