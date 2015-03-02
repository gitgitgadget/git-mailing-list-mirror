From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use unsigned char to squash compiler warnings
Date: Mon, 02 Mar 2015 12:29:49 -0800
Message-ID: <xmqqoaob9m82.fsf@gitster.dls.corp.google.com>
References: <1425324151-5480-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 21:30:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSWzK-0007Cy-5t
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 21:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548AbbCBUaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 15:30:46 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60010 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754143AbbCBUap (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 15:30:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A0FE3DD5C;
	Mon,  2 Mar 2015 15:30:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D1B07hqIOU+tPdh6VZF7QTA0v6s=; b=L9fxUp
	V1SRVD9TnXHZL9RIAPMn9Hy7aG+6J7cUGYH0ZZVDrgicuJoPNS84fabqg7nyubFb
	oS9QhEeBnNI2A43qx5Mua7MkrVNmEaCN/o6qMnGcw9HwdLqN2MYlORe98MV2rZIi
	Vq6BNOvlKElk7huS0eqM43JTFJ6RM5tPAP2D8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HlRSUJT4ULAacYYY39uX/6OjO4OdGrec
	5qgbi8K99BGO3C32EfRMmGu+IVrznRnGQB13x+Ld/C05NmqjgZL9DRXL654I1h2E
	EpQR+S1Goen8yG+AT2cAdse2LhTmsuO69WS6kp7lZMauHjJ6omAQ3isFGzrvFnVI
	puRtfyz4BCU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 75EA33DD5B;
	Mon,  2 Mar 2015 15:30:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E89C13DD2B;
	Mon,  2 Mar 2015 15:29:50 -0500 (EST)
In-Reply-To: <1425324151-5480-1-git-send-email-bdwalton@gmail.com> (Ben
	Walton's message of "Mon, 2 Mar 2015 19:22:31 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E09CC99C-C11A-11E4-80B0-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264622>

Ben Walton <bdwalton@gmail.com> writes:

> Sun Studio on Solaris issues warnings about improper initialization
> values being used when defining tolower_trans_tbl in
> ctype.c. tolower_trans_tbl is defined as char[], which studio's
> compiler defaults to signed char[] due to the Solaris ABI. To resolve
> this, instead of supplying -xchar or another option at build time,
> declare tolower_trans_tbl as unsigned char.  Update all appropriate
> references to the new type.
>
> Signed-off-by: Ben Walton <bdwalton@gmail.com>
> ---
>  ctype.c           | 2 +-
>  git-compat-util.h | 2 +-
>  kwset.c           | 8 ++++----
>  kwset.h           | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/ctype.c b/ctype.c
> index 0bfebb4..fc0225c 100644
> --- a/ctype.c
> +++ b/ctype.c
> @@ -30,7 +30,7 @@ const unsigned char sane_ctype[256] = {
>  };
>  
>  /* For case-insensitive kwset */
> -const char tolower_trans_tbl[256] = {
> +const unsigned char tolower_trans_tbl[256] = {
>  	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
>  	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
>  	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,

It is not obvious from the context but later elements in this array
have values above 0x7f.  So you are saying your compiler complains
when you write:

	signed char ch = 0xff;

which sort of makes sense (because you actually are storing -1 not
255 to the variable).  Throughout our codebase (and kwset is a
borrowed code that does not count as "our" codebase ;-) we do use
unsigned when we mean we want 255 and not -1, and this patch fixes
that borrowed code to be in line with the rest.

The conversion looked good from a cursory view; I didn't check it
very carefully though.

Thanks.
