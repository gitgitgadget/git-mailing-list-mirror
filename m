From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 09/21] strbuf: give strbuf_getline() to the "most text friendly" variant
Date: Fri, 15 Jan 2016 10:02:09 -0800
Message-ID: <xmqqoacmiuvy.fsf@gitster.mtv.corp.google.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
	<1452815916-6447-1-git-send-email-gitster@pobox.com>
	<1452815916-6447-10-git-send-email-gitster@pobox.com>
	<CAPig+cSAO-bJTvkOO-h=R-FKE90pfiJAaW-n-9Gi-omEr7aMCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 19:02:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK8hW-0007Jf-In
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 19:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbcAOSCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 13:02:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52710 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751985AbcAOSCL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 13:02:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 061D039BD8;
	Fri, 15 Jan 2016 13:02:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pCMdkKmKv9dU/ifrgzIrRRBPp7Q=; b=Qv1isM
	lnAyNXb4tH/+cL/ph8yTzoK6/fIygI9CMy2DCJR6Dz2QxGmKzLJqNL8LBgKAgO/6
	vu4fMQkAy/2mZUcymU5EMGXsArqsAGvV2YE5IUBGcPA8xVrqfwiMeJmYmLW5IROD
	3D1so2nrKrhqubdlIp1a/gsZ+jRWQopRSUy8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GTTjf3x/w8DmgIOsXGGvVHu4SC+1/xoA
	qmjgEovMFRkTsbFzrC23a5sMOAVs9T9qlC2+pPVt7QyzoE76YX2Bw4daHpCi5paf
	AzAviZfHxShwgG4rqdPDRTpUaNwmHuE1dGfiXqVhw39pQaigF6rEGG0MToLVNTw2
	ifeFbWM0syA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EF3A739BD7;
	Fri, 15 Jan 2016 13:02:10 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 70D5339BD2;
	Fri, 15 Jan 2016 13:02:10 -0500 (EST)
In-Reply-To: <CAPig+cSAO-bJTvkOO-h=R-FKE90pfiJAaW-n-9Gi-omEr7aMCQ@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 14 Jan 2016 20:46:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 191F827C-BBB2-11E5-8C0C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284193>

Eric Sunshine <sunshine@sunshineco.com> writes:

>>  /**
>>   * Read a line from a FILE *, overwriting the existing contents
>> - * of the strbuf. The second argument specifies the line
>> - * terminator character, typically `'\n'`.
>> + * of the strbuf.  There are three public functions with this
>> + * function signature, with different line termination convention.
>
> s/public// perhaps?
>
> Also, is it worth worrying that the comment may become outdated due to
> the mentioned "three"? Perhaps s/three/several/? Or:
>
>     The family of strbuf_getline*() functions share the same
>     signature, but have different line termination conventions.

I like this one the best, and that is not because I foresee "three"
to be changing (strbuf_getdelim() could become public again, but it
has a different signature), but because it is concise and to the
point.

>>   * Reading stops after the terminator or at EOF.  The terminator
>>   * is removed from the buffer before returning.  Returns 0 unless
>>   * there was nothing left before EOF, in which case it returns `EOF`.
>>   */
>> -extern int strbuf_getline(struct strbuf *, FILE *, int);
>> -
>>
>>  typedef int (*strbuf_getline_fn)(struct strbuf *, FILE *);
>>
>> +/* Uses LF as the line terminator */
>>  extern int strbuf_getline_lf(struct strbuf *sb, FILE *fp);
>> +
>> +/* Uses NUL as the line terminator */
>>  extern int strbuf_getline_nul(struct strbuf *sb, FILE *fp);
>
> This documentation could have been included in patch 3/21.

Perhaps.  I'll see what the best tweak would be.

Thanks.
