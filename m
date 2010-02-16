From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] Refactoring: remove duplicated code from
 builtin-checkout.c and merge-recursive.c
Date: Tue, 16 Feb 2010 11:41:57 -0800
Message-ID: <7vd405m0hm.fsf@alter.siamese.dyndns.org>
References: <1266276411-5796-1-git-send-email-michael.lukashov@gmail.com>
 <1266276411-5796-5-git-send-email-michael.lukashov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 20:42:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhTJV-00066f-Uw
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 20:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933258Ab0BPTmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 14:42:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933091Ab0BPTmD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 14:42:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 357279ADF1;
	Tue, 16 Feb 2010 14:42:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LXK75s09N52tYZjCXnZueplSD/g=; b=nmDwt9
	7SBggHthIgWHxydSb4vqVdEcmP4uL/e5jzXI2V5fCQz4yT5WSz4Ji1rq3xtXTsef
	ra/GsmgAvYo1pDsMeKi2ZmaWSvc+lJfmrMB2cWIHKuKbUVKuKJGr4sne7au115ii
	WTEZJ3P0x/2ek3Qazj/fxTc86oyI59qQ0ekug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WA34JYp8n1+d/gOfkIcR/G4ufcet9Mxi
	ERDj1djiafNttZ6TiTACoyHJLeglxXRTdzF5+LI8mSwvobK/V8/DYMCbCBATeDOC
	KmyWwTpneDt8L7RGVdVGoDPHANRXbYFLrxJZ2seu1hwFjfCWuyW6zD1vaA0uJEPK
	lA1OpA/+Xvg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 14AF19ADEC;
	Tue, 16 Feb 2010 14:42:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7329F9ADEA; Tue, 16 Feb
 2010 14:41:58 -0500 (EST)
In-Reply-To: <1266276411-5796-5-git-send-email-michael.lukashov@gmail.com>
 (Michael Lukashov's message of "Mon\, 15 Feb 2010 23\:26\:50 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 59EEE0AC-1B33-11DF-998C-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140149>

Michael Lukashov <michael.lukashov@gmail.com> writes:

> diff --git a/merge-recursive.c b/merge-recursive.c
> index cb53b01..5999ae2 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -599,7 +599,7 @@ struct merge_file_info
>  		 merge:1;
>  };
>  
> -static void fill_mm(const unsigned char *sha1, mmfile_t *mm)
> +void fill_mm(const unsigned char *sha1, mmfile_t *mm)
>  {
>  	unsigned long size;
>  	enum object_type type;

Isn't a much better home for this function next to read_mmfile() in
xdiff-interface.c?

Perhaps it would make sense to morph it into something like this

	int read_mmblob(mmfile_t *ptr, const unsigned char *sha1);

for consistency.
