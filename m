From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: clarify "could not read 'template'" message
Date: Thu, 18 Aug 2011 23:04:09 -0700
Message-ID: <7v4o1e544m.fsf@alter.siamese.dyndns.org>
References: <1313169225059-6681082.post@n2.nabble.com>
 <CAMOZ1BtxNSnncEJ6frEY0STgfS478krkpxXStP401WLPovb2Gw@mail.gmail.com>
 <CAAC=0R66j43CqpaxXskAwHsitvRFwy7DsjguNPm+sPa4YmTWqw@mail.gmail.com>
 <CAMOZ1Bu3AoQb330hkL+8hDTCvKX+amRfPE3PBxDHUZR17N344Q@mail.gmail.com>
 <20110813211852.GA17228@elie.gateway.2wire.net>
 <CAAC=0R5CpJx1QOKYJDs0_ksEdyYG95fSAo3U3eU536YW=M84MA@mail.gmail.com>
 <20110819050714.GA21697@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Fabr=C3=ADcio?= Nascimento 
	<fabricio@tailorbirds.com.br>, Michael Witten <mfwitten@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 08:04:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuICP-0000GP-NY
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 08:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681Ab1HSGEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 02:04:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43333 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293Ab1HSGEO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 02:04:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7715A4D76;
	Fri, 19 Aug 2011 02:04:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WeRxOcsFaOkPO+EZZ0bS1pv6fNU=; b=OiD84o
	LL47jMlKcfoGfIYV0oD7TsRa3df7NhRDSvyQyu1ahZPBCm0uQQX3fQj5G+baZFmq
	6gLIrGLuYNynZlBK2rom/Uj+Nr01RhFvjsaHLVMkzYiHEfC7DCs8TUXZ0Yic31ni
	ZLMI78lCJiq0jCL33MqkvrtI85FaqtgY4cO1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r6BExnEMbbKEVy7JoVf6Fe4SMVW+1ZTb
	Xg8xZJGjud7/fLIwnsF+FUxkgg6Pekm2d/02th4BBeuNivr5XNtMVZ2QR0Vf6Pwu
	ce0fXTrqVFgoIdyqQTlav5Ev/gV0piIHckANLzrxG5Bl5IPNcP95y8xfuR6aDffj
	1ktKcms+7kk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E31B4D75;
	Fri, 19 Aug 2011 02:04:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A77994D74; Fri, 19 Aug 2011
 02:04:10 -0400 (EDT)
In-Reply-To: <20110819050714.GA21697@elie.gateway.2wire.net> (Jonathan
 Nieder's message of "Fri, 19 Aug 2011 00:07:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E81C4BC-CA29-11E0-9199-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179679>

Jonathan Nieder <jrnieder@gmail.com> writes:

> At least the problem could have been easier to debug.  How about this
> patch, to start?

It is a good start, but at this point do we know where the template_file
came from? It does not seem rocket surgery to update git_commit_config()
so that it stores the value taken from configuration file in a separate
variable so that we can tell the difference in order to tweak the message.

Are there only these three kinds of "pathname" variables that can be
configured?

 - Those to be always used (it is an error if missing);
 - Those to be always used (the calling code creat(2)s if missing); and
 - Those to be used only if already exist (otherwise ignored).

If so, a good way forward might be to update git_config_pathname() and
tell it which kind of path we are talking about. For the first and the
third kind, it would (after ~ expansion and other magic) stat the string
and error out for the first kind and return NULL for the third kind. For
the second kind, we do not need to do anything special. We may need to
distinguish between files and dirs, so we might need 6 variations, not
just 3, but that is a minor implementation detail.

This is one of the reasons that I tend to resist applying patches that add
useless configuration variables "just because it seems useful".

>  builtin/commit.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index cb738574..d029ec03 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -703,7 +703,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		hook_arg1 = "squash";
>  	} else if (template_file) {
>  		if (strbuf_read_file(&sb, template_file, 0) < 0)
> -			die_errno(_("could not read '%s'"), template_file);
> +			die_errno(_("could not read commit message template '%s'"),
> +				  template_file);
>  		hook_arg1 = "template";
>  		clean_message_contents = 0;
>  	}
