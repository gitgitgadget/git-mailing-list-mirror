From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9] ls-files: Add eol diagnostics
Date: Mon, 04 Jan 2016 13:16:08 -0800
Message-ID: <xmqq37udnizr.fsf@gitster.mtv.corp.google.com>
References: <56845C0A.1060404@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 04 22:16:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGCUE-0000Pa-MN
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 22:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbcADVQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 16:16:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57561 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751523AbcADVQL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 16:16:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 15E8C368C3;
	Mon,  4 Jan 2016 16:16:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1LZDuih/S2aSJpWl9NU9dilq/zQ=; b=lfVwQm
	svFuQjni3tn1MiISmdOavs+BciYuIsTdFHaoCjpOEfp4gISnheA7yAkAh3ri7dhb
	WLg8MgaxG7Y97/Igr7fom2TAqEZECXeg23WogN6/v8r9LEcZapdmfzbHKmd3tC3p
	q4wXKCSlAn8+nUJp/78EiHKG9bvztyojgnids=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DyZYfxZWybByG94HBdcsQZz0LTShlpwB
	kLl/U72+rovWVWIkKGTuRVVYd6pFxt3scv1N4if6WMDmfLFrE25W15PwHtp2jZZJ
	gj+dY/od0H83q3koCIyshEk5Un54x4FaEWU5id3tK/BPc5ym9DKGV3GH/2J4MBAm
	WV2Cse1XNSs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0A773368C2;
	Mon,  4 Jan 2016 16:16:10 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 785F3368C1;
	Mon,  4 Jan 2016 16:16:09 -0500 (EST)
In-Reply-To: <56845C0A.1060404@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Wed, 30 Dec 2015 23:34:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5FFB97C2-B328-11E5-960C-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283324>

This one is severely whitespace damaged.

It is _possible_ for me to fix these up manually, but because there
is no guarantee that I caught them all (i.e. the end result may
contain some leading whitespaces you did not intend them to be
there, if the whitespace corruption did not break the syntax of the
diff), I'd rather not to do that.

> +	Show line endings (<eolinfo>) and the text/eol attributes (<texteolattr>) of
> files.
> +	<eolinfo> is the file content identification used by Git when

wrapped

>  diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index b6a7cb0..73b2ba6 100644

indented funnily

>  @@ -170,6 +187,7 @@ static void show_ce_entry(const char *tag, const struct
> cache_entry *ce)

wrapped

>  		       find_unique_abbrev(ce->sha1,abbrev),
>  		       ce_stage(ce));
>  	}
> +	write_eolinfo(ce, ce->name);
>  	write_name(ce->name);
>  	if (debug_mode) {
>  		const struct stat_data *sd = &ce->ce_stat_data;
> @@ -433,6 +451,7 @@ int cmd_ls_files(int argc, const char **argv, const char
> *cmd_prefix)

wrapped

> +		git ls-files --eol $src* | sed -e 's!attr/[=a-z-]*!!g' -e 's/  */ /g' | sort
>>actual &&

wrapped.  For shell scripts, change the line immediately after '|',
reglardless of the length of the line; that would automatically
avoid unnecessarily overlong lines.

>  checkout_files    native  true  "crlf"    CRLF  CRLF  CRLF         CRLF_mix_CR
>  CRLF_nul
>  +# Should be the last test case: remove some files from the worktree
> +# This test assumes that "rm" can remove staged files

indented funnily.
