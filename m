From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] remote-helpers: add support for an export command
Date: Wed, 31 Mar 2010 21:54:34 -0700
Message-ID: <7v634bsrg5.fsf@alter.siamese.dyndns.org>
References: <1269881309-19690-1-git-send-email-srabbelier@gmail.com>
 <1269881309-19690-6-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git List" <git@vger.kernel.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 06:55:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxCQi-0004yo-Qt
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 06:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636Ab0DAEyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 00:54:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58782 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483Ab0DAEyu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 00:54:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FDCAA7112;
	Thu,  1 Apr 2010 00:54:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Kbjy7/HZDSR1svuqKvPYyUoCcJA=; b=dNN/hYIkEQynjo/5miJEUuG
	yK8dGVqUwAr0Yi7cta+IzWomzxduc7I4K7V7Au/I6ShG+pJL1LOzKX+B9HoxiSLf
	j/a0BMEcL3C1cXAlHxOCtyxJDwnIt4aHYoz3MmR33U4zJHQH6m9W7UI8DSxY/6uH
	xjH2w0HMOSkb0WRXKNlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=pA45rLuCzsYWj5rRV+HAFXjqfRHGyZ66kKLPGxas3vFDiA5UB
	07NCmUeFNIAtWM76218E1LEtLcTDRZ3mggV53Ikzo9YBAfriPJKUxedH27zv4mcK
	dhjaaYIiTYXGRLpwKkzdT4HPOG3M6WsjNeUi/dEpTcw6keReCAx0ZFFuUM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A89EA7111;
	Thu,  1 Apr 2010 00:54:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D507A710B; Thu,  1 Apr
 2010 00:54:35 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AFABB78E-3D4A-11DF-9ED7-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143708>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> ---
>
> 	This complements the 'import' capability, making it possible
> 	to use remote-helpers with only fast-import/fast-exports
> 	streams.

I've queued this in 'pu' only to say "I've seen it", but I suspect that
this has to wait until after 1.7.1.  I've been trying to shoot for 6-8
week cycle as originally envisioned, and if things go as planned, post
1.7.1 cycle opens around mid April.

> +	for(ref = remote_refs; ref; ref = ref->next) {
> +		char* private;
> +		unsigned char sha1[20];
> +
> +
> +		if(data->refspecs)
> +			private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
> +
> +		if(private && !get_sha1(private, sha1))
> +		{
> +			strbuf_addf(&buf, "^%s", private);
> +			string_list_append(strbuf_detach(&buf, NULL), &revlist_args);
> +		}
> +
> +		string_list_append(ref->name, &revlist_args);
> +
> +	}

What's happening here?  Style violations aside, it appears that "private"
is accessed uninitialized when data->refspecs is NULL.
