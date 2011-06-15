From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] archive: provide builtin .tar.gz filter
Date: Wed, 15 Jun 2011 16:57:49 -0700
Message-ID: <7v7h8mir5u.fsf@alter.siamese.dyndns.org>
References: <20110615223030.GA16110@sigill.intra.peff.net>
 <20110615223501.GG16807@sigill.intra.peff.net>
 <7vboxyir8y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 01:57:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWzy9-0002H8-Md
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 01:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469Ab1FOX5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 19:57:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39951 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332Ab1FOX5w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 19:57:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0BA3D6590;
	Wed, 15 Jun 2011 20:00:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vd1X9TrHcNp0/Vm/ZrLJYtl7x14=; b=VKyk1i
	kJJ4JUy4PwRX33yFMkmX+T5wPj0xpAiP9nVYw3qpUFpY97Xknds3NJ/WPziexJFW
	HGt/uj3rR+gOxGGequ4lYx6GpgXJeHxKuBl2X89hp4DRBWB4CWERHlvP7teYNf02
	dQly67/NFqpLhDydZ/Z3lzKEzNPYEUpU2X08E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nWpTqKXFeTDv/DkSsG7icR+1UBp/pDZF
	S3pAYSNULa7JJChAZyJax8UYtxocscWbAZNewvlSPf2tkvdKhzTrAB3xI68ntNlZ
	UHzhXKkihnS2zfGWCvcYklnb74sJjPGxjYDSeEOfw6C/O+yqxs+rs9xSx957cZW5
	9ZeYIrt99/I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E4F92658F;
	Wed, 15 Jun 2011 20:00:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E6A1C658E; Wed, 15 Jun 2011
 20:00:00 -0400 (EDT)
In-Reply-To: <7vboxyir8y.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 15 Jun 2011 16:55:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 949CC53E-97AB-11E0-8419-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175874>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> +test_expect_success 'git archive --format=tgz' '
>> +	git archive --format=tgz HEAD >j.tgz
>> +'
>> +
>> +test_expect_success 'infer tgz from .tgz filename' '
>> +	git archive --output=j1.tgz HEAD &&
>> +	test_cmp j.tgz j1.tgz
>> +'
>
> I suspect this would get intermittent failures for the same reason as
> 0c8c385 (gitweb: supply '-n' to gzip for identical output, 2011-04-26)

To be squashed into 7/7, I guess...

 archive-tar-filter.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/archive-tar-filter.c b/archive-tar-filter.c
index de8719a..d6e4e32 100644
--- a/archive-tar-filter.c
+++ b/archive-tar-filter.c
@@ -131,7 +131,7 @@ static void load_builtin_filters(void)
 	struct tar_filter *tf;
 
 	tf = tar_filter_new("tgz", strlen("tgz"));
-	tf->command = xstrdup("gzip");
+	tf->command = xstrdup("gzip -n");
 	string_list_append(&tf->extensions, "tgz");
 	string_list_append(&tf->extensions, "tar.gz");
 	tf->use_compression = 1;
