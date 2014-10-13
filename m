From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Initialise hash variable to prevent compiler warnings
Date: Mon, 13 Oct 2014 13:12:03 -0700
Message-ID: <xmqq38ar3f1o.fsf@gitster.dls.corp.google.com>
References: <1413211041-28732-1-git-send-email-felipe@paradoxo.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Felipe Franciosi <felipe@paradoxo.org>
X-From: git-owner@vger.kernel.org Mon Oct 13 22:13:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xdlzx-0005NE-Ju
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 22:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbaJMUMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 16:12:08 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751058AbaJMUMG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 16:12:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 07C0616C7E;
	Mon, 13 Oct 2014 16:12:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eO7//if+xjZqo3838OeGpb2Eypw=; b=ZBohRm
	pelyCugWQP5Bg0wLyNuU44iN92YlINqRtxOt3xLGrTyykJAGgZ/ugsUfcgZaXYnz
	yHV7tVgDBBXblsMEp77Ra0gfKJTQNbEB3yjBYYn3ZBN2Ur7592ShIUM52y1hDBUZ
	WHjh5lPm906LcRWMVRJT69HfnDmOdL2uOFFqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=epkWZcT/cxumO77C8new+MgiF4yy11so
	2xa8t+HkrqkHdzGhssqF30PmS8AslkRsrv9kVsMCBthf5YggMi9zwSJ0wGt6T0zl
	CK9iHKhiQ3swZhMZ+oBab6frNWuuXoIJFkcpGxV1/BCTvp5a3AYM1aj3V/gE/nlu
	NWXC/snxdng=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F2F3016C7C;
	Mon, 13 Oct 2014 16:12:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B94116C75;
	Mon, 13 Oct 2014 16:12:04 -0400 (EDT)
In-Reply-To: <1413211041-28732-1-git-send-email-felipe@paradoxo.org> (Felipe
	Franciosi's message of "Mon, 13 Oct 2014 15:37:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 33208CEA-5315-11E4-A730-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Franciosi <felipe@paradoxo.org> writes:

> The 'hash' variable in test-hashmap.c is not initialised properly
> which causes some 'gcc' versions to complain during compilation.

FNV/I/IDIV10/0 covers all the possibilities of (method & 3), I would
have to say that the compiler needs to be fixed.

Or insert "default:" just before "case HASH_METHOD_0:" line?

I dunno.

>
> Signed-off-by: Felipe Franciosi <felipe@paradoxo.org>
> ---
>  test-hashmap.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test-hashmap.c b/test-hashmap.c
> index 07aa7ec..cc2891d 100644
> --- a/test-hashmap.c
> +++ b/test-hashmap.c
> @@ -47,7 +47,7 @@ static struct test_entry *alloc_test_entry(int hash, char *key, int klen,
>  
>  static unsigned int hash(unsigned int method, unsigned int i, const char *key)
>  {
> -	unsigned int hash;
> +	unsigned int hash = 0;
>  	switch (method & 3)
>  	{
>  	case HASH_METHOD_FNV:
