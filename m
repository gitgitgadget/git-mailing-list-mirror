From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-pack: unify error messages for unsupported capabilities
Date: Thu, 02 Apr 2015 11:02:01 -0700
Message-ID: <xmqqtwwyjtnq.fsf@gitster.dls.corp.google.com>
References: <1427995728-8162-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, matthias.ruester@gmail.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 20:02:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdjRX-0004FP-4x
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 20:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbbDBSCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 14:02:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63160 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752626AbbDBSCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 14:02:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 53F1C444C2;
	Thu,  2 Apr 2015 14:02:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m4si1aS5n6qi/Cj55xVkuy7cYZ0=; b=DpmU+l
	ANSR+TUt6h3xulv8d7FNx7t5e7kAi/gFWFhSwLPhEyWzXXn3b08FXCpF6f9tkXoq
	UvTUywX5tG9HQuYq6QMVzvDY0L9NTO5UpIPeUiM/O1FXggS1kS3w+OJXiQ0iqDX4
	v9R1pC0vbBjKjHwpSFWpRaGMFDAFO5QMY9tYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xStM1qdXWBwPZN3EPWWHynPBE4c/dTGG
	NlI0alf18a0io3vVAJr78kd8EocOgX4t4ildu4ppfGOoyPED0rXnyJ7WSfLFcvvB
	WUHorVOMww2VrjH3WbBp5viQVPFjGjGHhrycMBZoLOS22BSoAGDDooLNk4/FTBrK
	EZnqz4nj3ws=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D7B7444C1;
	Thu,  2 Apr 2015 14:02:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A44E0444BF;
	Thu,  2 Apr 2015 14:02:02 -0400 (EDT)
In-Reply-To: <1427995728-8162-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Thu, 2 Apr 2015 19:28:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5D832C4E-D962-11E4-98EF-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266652>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> If --signed is not supported, the error message names the remote
> "receiving end". If --atomic is not supported, the error message
> names the remote "server". Unify the naming to "receiving end"
> as we're in the context of "push".
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---

Sounds very sensible.  Let's do this before -rc1, so that i18n has
time to adjust.

>  send-pack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/send-pack.c b/send-pack.c
> index 9d2b0c5..189bdde 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -356,21 +356,21 @@ int send_pack(struct send_pack_args *args,
>  			die(_("the receiving end does not support --signed push"));
>  		push_cert_nonce = xmemdupz(push_cert_nonce, len);
>  	}
>  
>  	if (!remote_refs) {
>  		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
>  			"Perhaps you should specify a branch such as 'master'.\n");
>  		return 0;
>  	}
>  	if (args->atomic && !atomic_supported)
> -		die(_("server does not support --atomic push"));
> +		die(_("the receiving end does not support --atomic push"));
>  
>  	use_atomic = atomic_supported && args->atomic;
>  
>  	if (status_report)
>  		strbuf_addstr(&cap_buf, " report-status");
>  	if (use_sideband)
>  		strbuf_addstr(&cap_buf, " side-band-64k");
>  	if (quiet_supported && (args->quiet || !args->progress))
>  		strbuf_addstr(&cap_buf, " quiet");
>  	if (use_atomic)
