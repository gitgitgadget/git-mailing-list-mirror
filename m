From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/3] config: add 'type' to config_source struct that identifies config type
Date: Wed, 17 Feb 2016 13:31:09 -0800
Message-ID: <xmqqd1rvhvmq.fsf@gitster.mtv.corp.google.com>
References: <1455699468-45443-1-git-send-email-larsxschneider@gmail.com>
	<1455699468-45443-3-git-send-email-larsxschneider@gmail.com>
	<xmqqa8mzjh7d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, ramsay@ramsayjones.plus.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 17 22:31:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW9gq-0007UG-Jm
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 22:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423914AbcBQVbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 16:31:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51684 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423542AbcBQVbL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 16:31:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E3F0E44A15;
	Wed, 17 Feb 2016 16:31:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MjpXkdLZuWdM1o1jY0Q41maXV+U=; b=bB9ptB
	yTsDqotWjqBZf/16BWQLjjxkzzF1GDFvfMY49HxfHb3VKKwiWBZzkSU/JqzQvQcI
	fzpV/+PFnn+4kRokq5SMW3ffQaEqtoWjtFeenIIz2CdZFjZn1lZDRzn64jXw+WmD
	C6WvqBxF5EDtIEC22Pw+BJHz4A46GKxivYKSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oLcT150xlomvbWuXMsLd3jMe9EnqT6gB
	LfHGXFmF/ZRKb5W3H1r1mjVYYaTRjEMwrL8Whfi/8Y//pcS3+cRsXvpUvcVG8pzY
	Bi0DowvqpRyuKSGg8d8e84Upif6fTCu85n0i/NhxT/M4WzXReXMk4uP2atlK53Gt
	8WNz7+Gdb+A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DC36D44A12;
	Wed, 17 Feb 2016 16:31:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3BA9A44A11;
	Wed, 17 Feb 2016 16:31:10 -0500 (EST)
In-Reply-To: <xmqqa8mzjh7d.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 17 Feb 2016 10:59:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C3165E98-D5BD-11E5-8559-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286555>

Junio C Hamano <gitster@pobox.com> writes:

> larsxschneider@gmail.com writes:
>
>> From: Lars Schneider <larsxschneider@gmail.com>
>>
>> Use the config type to print more detailed error messages that inform
>> the user about the origin of a config error (file, stdin, blob).
>
> "type" is too broad a word in the context of configuration file, and
> does not help readers as a variable or a field name in a structure.
> You are not talking about "this is a binary typed variable", for
> example.
>
> If showing the origin is useful to the user, that origin should be
> called origin, not type, I would think.

You seem to use in 3/3 "origin type", and I think that is a sensible
phrasing.  Renaming 'type' to 'origin' in this patch would not be a
good idea, but renaming it to 'origin_type' would be a great thing
to do.

In the context of configuration parsing, 'origin' would be like
"file called .git/config", "standard input", "command line's 3rd
argument", etc., i.e. for some origin types, it would consist of
<origin_type=file, origin_value=.git/config> pair, while some other
origin type (e.g. "standard input") there is no need for an
"origin_value" that further qualifies the origin.

Thanks.
