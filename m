From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] builtin-apply: prevent non-explicit permission
 changes
Date: Thu, 01 Jan 2009 05:00:27 -0800
Message-ID: <7vfxk3npuc.fsf@gitster.siamese.dyndns.org>
References: <20081230235357.GA12747@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Alexander Potashev <aspotashev@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 01 14:02:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LINBV-0002o1-SA
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 14:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756085AbZAANAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 08:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756069AbZAANAf
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 08:00:35 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64738 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756050AbZAANAf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 08:00:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 448258CE8B;
	Thu,  1 Jan 2009 08:00:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7AD668CE86; Thu,
  1 Jan 2009 08:00:29 -0500 (EST)
In-Reply-To: <20081230235357.GA12747@myhost> (Alexander Potashev's message of
 "Wed, 31 Dec 2008 02:53:57 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2C1EE4BA-D804-11DD-BD9B-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104295>

Alexander Potashev <aspotashev@gmail.com> writes:

>  builtin-apply.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-apply.c b/builtin-apply.c
> index 07244b0..071f6d8 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -630,7 +630,7 @@ static int gitdiff_index(const char *line, struct patch *patch)
>  	memcpy(patch->new_sha1_prefix, line, len);
>  	patch->new_sha1_prefix[len] = 0;
>  	if (*ptr == ' ')
> -		patch->new_mode = patch->old_mode = strtoul(ptr+1, NULL, 8);
> +		patch->old_mode = strtoul(ptr+1, NULL, 8);
>  	return 0;
>  }
>  
> @@ -2447,6 +2447,7 @@ static int check_preimage(struct patch *patch, struct cache_entry **ce, struct s
>  	if (st_mode != patch->old_mode)
>  		fprintf(stderr, "warning: %s has type %o, expected %o\n",
>  			old_name, st_mode, patch->old_mode);
> +	patch->new_mode = st_mode;

Can you do this unconditionally, overwriting whatever we read from the
patch header metainfo lines?
