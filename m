From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: add correct paddings in time_buf for align
Date: Fri, 18 Apr 2014 10:08:23 -0700
Message-ID: <xmqqd2ged0qg.fsf@gitster.dls.corp.google.com>
References: <43a3735a164c923acc8e6e2681dfbd727cda63de.1397810231.git.worldhello.net@gmail.com>
	<CACsJy8BTBwqFZUU3i3cuv40B6AHw5SRY9DZN2PoKL4XzgEL2eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Brian Gesiak <modocache@gmail.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 19:09:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbCHv-0001vA-Ix
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 19:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754392AbaDRRJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 13:09:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64797 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425AbaDRRI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 13:08:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 570F37940B;
	Fri, 18 Apr 2014 13:08:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W6iXCh95iJNb22aFne3PraAvdOk=; b=EREu6M
	k7AB9JIds5tn4nBT6Mp95gcI2BHXxuChjubixSEjizaPbYOIxOYTYOqm0ohr1a3j
	hFJ2ElRAVKTj7VZIrc5S49v2wM7nUm8ziizP8Zj3ayYa06sholgC1t1Q2UOCd3uT
	i96pxGn4EVpE488NlL2tW0Aimp+Rwr+1Mj1eI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wwrMD6sh3DEood0JTShjQ+QWG1E8IGs6
	iczUJcDOngw+sdmyaTnZ0ZtueIDl8NiwrlxTBBAlb8fJdk8TZp9Uej+wmeAGiZzY
	sHonDBTqteGbRUWCGjakdlJqLyOM2EzBDk26j9uSnw+Mbpt6h932TuRr2e7ppzWF
	hNsw9QoDL50=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C37B7940A;
	Fri, 18 Apr 2014 13:08:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4E4679408;
	Fri, 18 Apr 2014 13:08:25 -0400 (EDT)
In-Reply-To: <CACsJy8BTBwqFZUU3i3cuv40B6AHw5SRY9DZN2PoKL4XzgEL2eA@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 18 Apr 2014 21:42:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0DEAA65C-C71C-11E3-8F0E-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246475>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Apr 18, 2014 at 3:44 PM, Jiang Xin <worldhello.net@gmail.com> wrote:
>> When show blame information with relative time, the UTF-8 characters in
>> `time_str` will break the alignment of columns after the date field.
>> This is because the `time_buf` padding with spaces should have a
>> constant display width, not a fixed strlen size.  So we should call
>> utf8_strwidth() instead of strlen() for calibration.
>>
>> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
>> ---
>>
>> Before applying this patch:
>>
>>         5817da01 builtin-blame.c   (Pierre Habouzit             6 年前                         21) #include "parse-options.h"
>>         ffaf9cc0 builtin-blame.c   (Geoffrey Thomas             5 年前                         22) #include "utf8.h"
>>         3b8a12e8 builtin/blame.c   (Axel Bonnet                 3 年 10 个月之前            23) #include "userdiff.h"
>>         25ed3412 builtin/blame.c   (Bo Yang                     1 年 1 个月之前             24) #include "line-range.h"
>>         58dbfa2e builtin/blame.c   (Eric Sunshine               9 个月之前                   25) #include "line-log.h"
>>         cee7f245 builtin-pickaxe.c (Junio C Hamano              8 年前                         26)
>>
>> After applying this patch:
>>
>>         5817da01 builtin-blame.c   (Pierre Habouzit             6 年前                           21) #include "parse-options.h"
>>         ffaf9cc0 builtin-blame.c   (Geoffrey Thomas             5 年前                           22) #include "utf8.h"
>>         3b8a12e8 builtin/blame.c   (Axel Bonnet                 3 年 10 个月之前                 23) #include "userdiff.h"
>>         25ed3412 builtin/blame.c   (Bo Yang                     1 年 1 个月之前                  24) #include "line-range.h"
>>         58dbfa2e builtin/blame.c   (Eric Sunshine               9 个月之前                       25) #include "line-log.h"
>>         cee7f245 builtin-pickaxe.c (Junio C Hamano              8 年前                           26)
>
>
> The numbers 21..26 still do not look aligned, both in gmail raw
> message view and gmane.

Interesting.  In my GNUS/Emacs on a fixed-column terminal where an
CJK occupies two display columns, they do look aligned, but in my
Chrome showing news.gmane.org/gmane.comp.version-control.git/, they
do look jagged.  When these lines shown in the browser get copied
and pasted to gedit, they still look jagged, but after saving it to
a file and catting it to the same fixed-column terminal, they are
perfectly aligned.

Font issues, I guess?

>> +               /*
>> +                * Add space paddings to time_buf to display a fixed width
>> +                * string, and use time_col for display width calibration.
>> +                */
>> +               time_col = utf8_strwidth(time_str);
>> +               memset(time_buf + time_len, ' ', blame_date_width - time_col);
>> +               *(time_buf + time_len + blame_date_width - time_col) = 0;
>
> And you may want to turn time_buf[128] to strbuf as well while you're at it.

Good eyes.
