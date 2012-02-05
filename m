From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] blame duplicates trailing ">" in mailmapped emails
Date: Sun, 05 Feb 2012 13:38:19 -0800
Message-ID: <7vipjlezas.fsf@alter.siamese.dyndns.org>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
 <20120202084859.GC3823@burratino> <7v8vklvxwh.fsf@alter.siamese.dyndns.org>
 <CAMP44s1gWNG+jJ6M7OnLS-1VA5YPa07LJfnrvdbsQb0MOJB7PA@mail.gmail.com>
 <7vhaz8vkhd.fsf@alter.siamese.dyndns.org>
 <CAMP44s0Fq_BGwcmDM5E1kWNiyoJw6e6Hr=8XaNF6tmQAcdnUmw@mail.gmail.com>
 <7vehuboe5g.fsf@alter.siamese.dyndns.org>
 <CAMP44s2QdJ4+qgg4fF5-DOWHx3Btd0pTivTT9s_E=qqxg16YLQ@mail.gmail.com>
 <20120204182611.GA31091@sigill.intra.peff.net>
 <7v39aphw85.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 05 22:38:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru9n1-0004D0-JN
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 22:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912Ab2BEViX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 16:38:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47225 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876Ab2BEViW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 16:38:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05A935C55;
	Sun,  5 Feb 2012 16:38:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=r/t0EMM71ehPwOji5sBKD6h/FGA=; b=dqXpjPVAS9KV0tp2KyRh
	1amhg4NRF2P4hiYA2P4VodC563M07nKC5afJapKN331KtK3Cb62DydZqhvHsbEG8
	48IMRZf4QnpXnu4y1jYq1ie054a++1gfoJpoTWNDtQ64Hshto8sgwpeQF2e7dPJw
	YC0l/fvkJJygVGQUtozK2VE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Mf3tpV5Hc27GcJC1tFst2gdbG/bRP90ITQTTc3gGQIfiS+
	s3bSJNKWB0cGowocjwX8uZFDQjJSh+T0DNfHQCmj08tgLKLMB3BHSjk7ccQdcTKu
	GpGLrQswcKTuAgMGVz7FL0d4vjIwburPAVvdBvSSSxwRo2WB9fhSDqd4297vo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0B015C4B;
	Sun,  5 Feb 2012 16:38:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72CD75C4A; Sun,  5 Feb 2012
 16:38:21 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B99A5910-5041-11E1-984E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189969>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
> ...
>> but it feels like the fix should go into map_user.
>
> Thanks.
>
> The map_user() API takes an email address that is terminated by either NUL
> or '>' to allow the caller to learn the corresponding up-to-date email
> address that is NUL terminated, while indicating with its return value
> that if the caller even needs to replace what it already has.  But the
> function does not properly terminate email when it only touched the name
> part. And I think that is the real bug.

And the gist of the patch to fix the bug would look like this two liner.
In the real fix, "p" should be renamed to "end_of_email" or something
descriptive like that.

I only made sure that this fixes the original case of the email address of
Shawn reported by Felipe, but other than that like everything else I send
here with "... would look like this", not tested beyond "it compiles".

But conceptually it looks correct (famous last words ;-).

Felipe, does it pass your test cases?


 mailmap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 8c3196c..ce805fa 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -236,6 +236,8 @@ int map_user(struct string_list *map,
 		}
 		if (maxlen_email && mi->email)
 			strlcpy(email, mi->email, maxlen_email);
+		else
+			*p = '\0';
 		if (maxlen_name && mi->name)
 			strlcpy(name, mi->name, maxlen_name);
 		debug_mm("map_user:  to '%s' <%s>\n", name, mi->email ? mi->email : "");
