From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: cover letter does not respect
 i18n.commitencoding
Date: Tue, 20 Sep 2011 12:24:21 -0700
Message-ID: <7v62kn6mqi.fsf@alter.siamese.dyndns.org>
References: <1316507177-6403-1-git-send-email-zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexey Shumkin <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Tue Sep 20 21:24:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R65vi-0007TR-GB
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 21:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974Ab1ITTYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 15:24:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33452 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806Ab1ITTYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 15:24:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B20259B2;
	Tue, 20 Sep 2011 15:24:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PMPImVhz4oyrnD/0JcPK/JLD6eY=; b=KY0YKp
	5CnOr3du15gVJofAtgL3Z/U5y+mUGBVlkh3pSpiD3+X8hxOzqQfJdYySvhwujqUx
	mibHF9LYws/iYFT/Wj1M8SMv+Jhiin3VgrONbBf/EAhFWPIP9Uc8BKwx7VMINiM7
	e2tcrdcO6N7M3kw/J7mS75sMv5Z6g0+srDmOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=djHmpPJfHg81jxpvG7MdSNGd5tIqdsuK
	tYGL76xxSYZStD98WWNulZJRnkEhqQY/11in280pJezhJ1qWtSTT9Ae25hHo536p
	el//Ip9P8fcuvDwTPce9ZqgKhg6Mj2l5cTxb/3kE+fRloNnDxxklOjjw9XX6mR+M
	yr9HaOUEJFM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 915B759B1;
	Tue, 20 Sep 2011 15:24:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 210E459AF; Tue, 20 Sep 2011
 15:24:23 -0400 (EDT)
In-Reply-To: <1316507177-6403-1-git-send-email-zapped@mail.ru> (Alexey
 Shumkin's message of "Tue, 20 Sep 2011 12:26:17 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 256008D4-E3BE-11E0-AC10-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181780>

Alexey Shumkin <zapped@mail.ru> writes:

> diff --git a/builtin/log.c b/builtin/log.c
> index 5c2af59..6a4050c 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -769,7 +769,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  	struct shortlog log;
>  	struct strbuf sb = STRBUF_INIT;
>  	int i;
> -	const char *encoding = "UTF-8";
> +	const char *encoding =  get_commit_output_encoding();

Hmm, I have a feeling that this should use log output encoding. Am I
mistaken?

The i18n.commitencoding variable is about the internal representation in
the object [*1*] that is to be converted from the encoding of the original
e-mail message which could be different. i18n.logoutputencoding is to
externalize it [*2*].

[Footnotes]

*1* f1f909e (mailinfo: Use i18n.commitencoding, 2005-11-27)
*2* a731ec5 (t3901: test "format-patch | am" pipe with i18n, 2007-01-13)
