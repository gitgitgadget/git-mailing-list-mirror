From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3][GSOC] diff: rename read_directory() to get_directory_list()
Date: Wed, 19 Mar 2014 10:22:48 -0700
Message-ID: <xmqq4n2u5cif.fsf@gitster.dls.corp.google.com>
References: <1395091825-8330-1-git-send-email-sh19910711@gmail.com>
	<xmqqy508a1up.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hiroyuki Sano <sh19910711@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 18:23:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQKCe-00044D-Ok
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 18:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759452AbaCSRWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 13:22:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40840 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759444AbaCSRWv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 13:22:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2C0D744F4;
	Wed, 19 Mar 2014 13:22:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UiNd1OpeGnUK9Pe2eHhsfnF7Xfk=; b=EOXOy+
	42cdG/bG8fPe7vE/u9rBKY+JuvHKEaFjIZS/2v6CwKdh9jMqCZr3PVsV4csMSZ5v
	Xr99AF5IHw1A4FwMME4AsPONEy8yOnRSdMzo0Yss7bDE1dS+fUx5HsEHuEyd7+c5
	R6Tq2LFds2fl0MOOpvSFNR2Fa39GDR+Xuo0mg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P+nh4SOhpxiUMQ4E2B8Rl3aIZ+fcFmJq
	YZP0HOoNWDeS5MasaCjhAl3Gw7LrfG9k56RLndfAu6iRVwUfGQGe6ZzqN8fIxsTz
	OkcF63OV9A1t8PPAUHLYnP6RtUSBXnCzYvqJMYwOB1k0XlNLmQR4j0n60rVYbwUP
	IjCrCBI8xwI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1BE6744F3;
	Wed, 19 Mar 2014 13:22:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42125744F2;
	Wed, 19 Mar 2014 13:22:50 -0400 (EDT)
In-Reply-To: <xmqqy508a1up.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 17 Mar 2014 15:37:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 18CF160A-AF8B-11E3-8CEA-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244464>

Junio C Hamano <gitster@pobox.com> writes:

> Hiroyuki Sano <sh19910711@gmail.com> writes:
>
>> Including "dir.h" in "diff-no-index.c", it causes a compile error, because
>> the same name function read_directory() is declared globally in "dir.h".
>>
>> This change is to avoid conflicts as above.
>>
>> Signed-off-by: Hiroyuki Sano <sh19910711@gmail.com>
>> ---
>>  diff-no-index.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/diff-no-index.c b/diff-no-index.c
>> index 8e10bff..1ed5c9d 100644
>> --- a/diff-no-index.c
>> +++ b/diff-no-index.c
>> @@ -16,7 +16,7 @@
>>  #include "builtin.h"
>>  #include "string-list.h"
>>  
>> -static int read_directory(const char *path, struct string_list *list)
>> +static int get_directory_list(const char *path, struct string_list *list)
>
> Renaming is a good idea but the new name sounds like you are
> grabbing the names of directories, ignoring all the files, no?

I am tempted to suggest, because this is an internal implementation
detail only visible to this narrow corner of the system, calling
this just 

	static int ls(const char *path, struct string_list *result)

;-)
