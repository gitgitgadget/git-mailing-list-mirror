From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: --dissociate option to mark that reference is only temporary
Date: Wed, 15 Oct 2014 14:33:59 -0700
Message-ID: <xmqqoatduiew.fsf@gitster.dls.corp.google.com>
References: <xmqqa94yzap8.fsf@gitster.dls.corp.google.com>
	<543ECE88.7050703@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 23:34:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeWCu-0002QN-4E
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 23:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbaJOVeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 17:34:03 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60157 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750721AbaJOVeB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 17:34:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F83C1588F;
	Wed, 15 Oct 2014 17:34:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=60SB6jMyp8Gyn90UNiXCKj3F5Mc=; b=VOpO9b
	yFlRnSil9FaxDhemTjDqxbkPg9Oh1ZHbk0hZfBBezuCm1y0XznU8mvoO69HTaUxn
	bB1Htx1ltMHmjpo2dRVsFRStCkt8va3qXISQGWzUp5Z1KRCXPX6W7LIZqxnNGaqN
	4sJEOjrgns+OSFHLxvrf+Lncs7iJeBF98/GwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ep8LKirafRQyEIplr3mz4SXcOTP5Mep3
	cnj4YGlrLQ0gjiO43eMeCh8Bh+WIuRTg48AI8qYB32OV0j/QGQ1MMR6c3aaJIPyR
	nX2+CcOhj/Kgg2vYBdWWUGd1Z3+STtVmtKqmKcqmfhfp17vyMcuBF/ub5vG3Rc0V
	o+jbQwgQ5FM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 784B21588E;
	Wed, 15 Oct 2014 17:34:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0087A1588B;
	Wed, 15 Oct 2014 17:34:00 -0400 (EDT)
In-Reply-To: <543ECE88.7050703@kdbg.org> (Johannes Sixt's message of "Wed, 15
	Oct 2014 21:44:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FA6AA562-54B2-11E4-9612-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Unless you have a secret plan, you can do it even shorter with our
> helpers:

Thanks.  No there isn't a secret plan.  It was just me being rusty.

>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 8649090..81efb07 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -743,14 +743,9 @@ static void write_refspec_config(const char *src_ref_prefix,
>  
>  static void dissociate_from_references(void)
>  {
> -	struct child_process cmd;
> -
> -	memset(&cmd, 0, sizeof(cmd));
> -	argv_array_pushl(&cmd.args, "repack", "-a", "-d", NULL);
> -	cmd.git_cmd = 1;
> -	cmd.out = -1;
> -	cmd.no_stdin = 1;
> -	if (run_command(&cmd))
> +	static const char* argv[] = { "repack", "-a", "-d", NULL };
> +
> +	if (run_command_v_opt(argv, RUN_GIT_CMD|RUN_COMMAND_NO_STDIN))
>  		die(_("cannot repack to clean up"));
>  	if (unlink(git_path("objects/info/alternates")) && errno != ENOENT)
>  		die_errno(_("cannot unlink temporary alternates file"));
