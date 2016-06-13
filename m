From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf: describe the return value of strbuf_read_file()
Date: Mon, 13 Jun 2016 15:10:09 -0700
Message-ID: <xmqqfusgbv0e.fsf@gitster.mtv.corp.google.com>
References: <20160613202346.6473-1-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, larsxschneider@gmail.com,
	chriscool@tuxfamily.org, christian.couder@gmail.com
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 00:10:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCa41-0003T1-0l
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 00:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423758AbcFMWKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 18:10:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423795AbcFMWKM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 18:10:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A38124B4D;
	Mon, 13 Jun 2016 18:10:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mn9pyWrYn/FmEHNF9he4nFXS+68=; b=xfmS8G
	EKkC9L/hLraB+FtoG4fw3X4W1IhZglIUzZSfbRGBxO4Lv+pWCZVUa6Z93ejfbBSE
	kqrxiLTCwJo3DtkxEHHr1IA0DVm0puC90oPL50ONyBvYI7cEu7tNdfop/xzMAj9Y
	g/3yRhBd/pQQaXvdcz3l37TfVZeuUK/Zf1ZGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y2bQV7FHakQ6+RwqbKfv2/i/9E9/hImA
	yianSgq4/MqAmXJSGOPC8W4OyoctNRT+CndhLDF++WE2jzQYqOL74/Y/rhj1cFCS
	GEvMlbQaCdjEoGZ4bFfgD84+ryNhp4mfq+iUcvmenp01bpbsL3xevStofUWnB2N7
	qfmwbT7PLjk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 81F3C24B4C;
	Mon, 13 Jun 2016 18:10:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0978324B4A;
	Mon, 13 Jun 2016 18:10:10 -0400 (EDT)
In-Reply-To: <20160613202346.6473-1-pranit.bauva@gmail.com> (Pranit Bauva's
	message of "Tue, 14 Jun 2016 01:53:46 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 989A0D52-31B3-11E6-A3A7-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297249>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> It is easy to be misguided on the return value of the function
> strbuf_read_file(). It does follow the pattern of other standard functions
> for reading files but its better to explicitly specify it.

Good thing to do; I wonder if we want to explicitly say -1 or
leave it at "negative values are errors", though (my knee-jerk
reaction being "do not over-specify more than absolute minimum
to write callers correctly").

>
>  strbuf.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/strbuf.h b/strbuf.h
> index 7987405..4b487f7 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -377,6 +377,8 @@ extern ssize_t strbuf_read_once(struct strbuf *, int fd, size_t hint);
>  /**
>   * Read the contents of a file, specified by its path. The third argument
>   * can be used to give a hint about the file size, to avoid reallocs.
> + * Return the number of bytes read or -1 if some error occurred while
> + * opening or reading the file.
>   */
>  extern ssize_t strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
