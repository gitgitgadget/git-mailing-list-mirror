From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] dir.c: fix ignore processing within not-ignored directories
Date: Sun, 02 Jun 2013 12:25:44 -0700
Message-ID: <7vk3mcnwlj.fsf@alter.siamese.dyndns.org>
References: <CAGLuM14_MQffwQWrB2YCQXzhkGaxdaYBuY74y7=pfb-hB6LskA@mail.gmail.com>
	<CACsJy8BqCUKhc8vhjhNz0OedBngk7zcSOk70ekRm3EiruHfNxA@mail.gmail.com>
	<CACsJy8DD=LxAKh_fUELJ5Mj0xS_gZE88N_rJFkKGer=YAOqsMg@mail.gmail.com>
	<51A62A96.6040009@gmail.com> <51A665E4.9080307@gmail.com>
	<CACsJy8D4wmhGkEsn8r5OEQv_hX=OFD5W8abnBnYFcFCQZfLOoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Misty De Meo <misty@brew.sh>,
	=?utf-8?Q?=C3=98ys?= =?utf-8?Q?tein?= Walle <oystwa@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 02 21:25:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjDuZ-0002DM-P5
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 21:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755851Ab3FBTZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 15:25:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53365 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755815Ab3FBTZr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 15:25:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F9F4234EE;
	Sun,  2 Jun 2013 19:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6Cx2uJiQlcn5BAOQfnzA5XABdS0=; b=GxqQtw
	2m+4xWmDXmicgP0xkXbEdd6V3IywGGvOfoK2pi49+RGGxrO3S4C8G2MuBaqAXkLK
	T4gLEfNcnEayZZzErsduytCzHGKSrs9sGcHE0rAK871lRIwkIX7YVoDZOVzVYfJn
	HKLKt9HfVFMnS+/XVtr0DYGsA1t8GyLMOcbks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I+zkEwa48iDTpx7Lw/dpe0nLi0N6cZs8
	HmvtsZ+/YOl8AIHsV6sVUMzZ0GpEALu4ME/J6lSzdXAsa8jKXXTxPeFkKwUXcG19
	eRFdNKTT6N7OSWL0ZXjYWEGH7xrnz+6nI0UXzbuFjDGcauyljsi953qSQYu4nYua
	J2bC7rVf8fw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6278B234ED;
	Sun,  2 Jun 2013 19:25:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBB74234EA;
	Sun,  2 Jun 2013 19:25:45 +0000 (UTC)
In-Reply-To: <CACsJy8D4wmhGkEsn8r5OEQv_hX=OFD5W8abnBnYFcFCQZfLOoQ@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 1 Jun 2013 17:44:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 393BB3A4-CBBA-11E2-9398-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226175>

Duy Nguyen <pclouds@gmail.com> writes:

>> +       then
>> +               false
>> +       fi
>> +'
>
> Nit pick, maybe this instead?
>
> test_must_fail grep "^one/a.1" output

Neither.

	! grep "^one/a.1" output

The second bullet point in the "Don't" section of t/README may want
to be updated to clarify that test_must_fail is to test Git, and we
do not mean to catch segfaults by platform tools like grep.
