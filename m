From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rm: do not set a variable twice without intermediate reading.
Date: Tue, 23 Jul 2013 11:32:43 -0700
Message-ID: <7v4nbl86us.fsf@alter.siamese.dyndns.org>
References: <1374571162-22881-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 20:33:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1hOH-0005rS-V9
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 20:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933733Ab3GWScu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 14:32:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33703 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933577Ab3GWSct (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 14:32:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A45CB33E7F;
	Tue, 23 Jul 2013 18:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=78IRufYFzR8I5xDjWWIoHmveqVU=; b=k5JtpK
	yz0Kb3I+8oMq4OYwkNdeeC6FPcCEL4HKi/PzmANAymICaFLIqmLmdG35Mp4tCrLo
	NyL18+RPrxFGdJW/c0QawYTiUx9c3D4uWe7fjt9UON3TNoqN/juk9Z0oT6hJb0Cv
	yWE73EJJ6d8NJNxskyOHPvFqL5mviRJuhtaow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QgPNEjQpEwQsEUGHERv1A8q8fzcYT4Mi
	E4g82aEMft7dlw6LRBLA99ue3dmSXv45Ug1Du8EnG+noJFj5vcFEe6v9CMs+ainP
	OUEek6XGl/s4hJDS6QsMsRkEzY80Z4wW1IHkgVIL6bo7K8m5Bb5dS15WRJ2mtI0X
	EroNVAX4gts=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4ABB233E7D;
	Tue, 23 Jul 2013 18:32:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C7F633E78;
	Tue, 23 Jul 2013 18:32:46 +0000 (UTC)
In-Reply-To: <1374571162-22881-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Tue, 23 Jul 2013 11:19:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4531183C-F3C6-11E2-8C53-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231049>

Stefan Beller <stefanbeller@googlemail.com> writes:

> Just the next line assigns a non-null value to seen.
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---
>  builtin/rm.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 5b63d3f..df85f98 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -316,7 +316,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>  	parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD, prefix, argv);
>  	refresh_index(&the_index, REFRESH_QUIET, &pathspec, NULL, NULL);
>  
> -	seen = NULL;
>  	seen = xcalloc(pathspec.nr, 1);
>  
>  	for (i = 0; i < active_nr; i++) {

Interesting. This is ancient and dates back to 7612a1ef (git-rm:
honor -n flag., 2006-06-08).
