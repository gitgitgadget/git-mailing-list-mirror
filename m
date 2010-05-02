From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/5] pretty: add infrastructure to allow format
 aliases
Date: Sat, 01 May 2010 20:13:15 -0700
Message-ID: <7vhbmryp10.fsf@alter.siamese.dyndns.org>
References: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
 <1272656128-2002-5-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, raa.lkml@gmail.com,
	jrnieder@gmail.com
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 02 05:13:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Pcr-0004mW-9B
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 05:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755755Ab0EBDNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 23:13:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43348 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370Ab0EBDN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 23:13:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 15665AFFCE;
	Sat,  1 May 2010 23:13:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=fOWiFef/K5zJzq3DVTRUix8WJok=; b=sTz/iB7X1XNLohMsuXIcAA0
	lBE1Q+cK/zkWgIA/z85KWTpMzoaslwFn9ABYFGH9meE9ELA5lOMOATzofP33OYsm
	z3P8knkuPrqEtt6yZ7XHfzyS1RWAt6MdQUjbjTbNuuvN4ff56XD3INqY0dy2c3iI
	KUMqI1c80Kq7QsWihQVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=CoWwb1lF5xlzqRPwmJInV9z282ObxGke/OxQs5fpvlp2Iuu7t
	iIF49dIVF7FgTj4uf/hgq19A//jgdJBmzF5Qu6iYAvdK8kYfu7bdG5jvwebBGQDh
	74SUFF5qogutxmYaKs+NYNVBdkpXwl40snbisNoZLo16xAHc5eeGjlzkHA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B17A4AFFCC;
	Sat,  1 May 2010 23:13:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA756AFFCB; Sat,  1 May
 2010 23:13:16 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AA6BD5C2-5598-11DF-AC3F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146129>

Will Palmer <wmpalmer@gmail.com> writes:

> -static struct cmt_fmt_map *find_commit_format(const char *sought)
> +static struct cmt_fmt_map *find_commit_format_recursive(const char *sought,
> +							int num_redirections)
>  {
>  	struct cmt_fmt_map *found = NULL;
>  	size_t found_match_len;
>  	int i;
>  
> -	if (!commit_formats)
> -		setup_commit_formats();
> +	if (num_redirections >= commit_formats_len)
> +		return NULL;

Nice trick to avoid a loopy definition chain.

I however wonder if we would want to be more helpful to the users to
diagnose this error by saying something here with error(), instead of just
letting the caller say "invalid --pretty format: %s".
