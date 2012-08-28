From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 03/16] Add svndump_init_fd to allow reading dumps from
 arbitrary FDs
Date: Tue, 28 Aug 2012 10:02:35 -0700
Message-ID: <7vipc23neh.fsf@alter.siamese.dyndns.org>
References: <1346143790-23491-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346143790-23491-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 28 20:02:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6Q7u-0003bZ-AE
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 20:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327Ab2H1SCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 14:02:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40613 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694Ab2H1SCt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 14:02:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 103349206;
	Tue, 28 Aug 2012 14:02:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=MAXbzIpFxkTUg1dAPu95BlzcsSI=; b=kCwjSc6/BXGO4yFB6thH
	la0/cF5vTnibz/LTGBeH6SdXgzygJLGMFOhvtURGdgnWzqQhALcLbOpOvf+inLGG
	29arVfUh+jdRpv0b6ouRyQeMVFKaiROGHZeVAB+b2yK2cdC1X7xNBEzy7aKTp8HP
	7maVO4FPQMDhmuW6j6P6OLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=iNUnY/102yxwnSwmPP542NayJPhG6raA/38YbmNWr74xTz
	ho3gyna62kpOwpQaM/DvgvfGIh3h4q+UNz4+/l2vt1gCTpiNMBC8wUIrmBCWQU2a
	V7oql27zlXTMnL3xi05430cZ4A6PvZVHtFlWd3qd659v9j1bEpF1eyDl3EbhA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F11D69205;
	Tue, 28 Aug 2012 14:02:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 504B39203; Tue, 28 Aug 2012
 14:02:48 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 938C876C-F13A-11E1-AA5A-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204437>

Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

> The existing function only allows reading from a filename or from
> stdin. Allow passing of a FD and an additional FD for the back report
> pipe. This allows us to retrieve the name of the pipe in the caller.
>
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  vcs-svn/svndump.c |   22 ++++++++++++++++++----
>  vcs-svn/svndump.h |    1 +
>  2 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
> index 2b168ae..d81a078 100644
> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -468,11 +468,9 @@ void svndump_read(const char *url)
>  		end_revision();
>  }
>  
> -int svndump_init(const char *filename)
> +static void init(int report_fd)
>  {
> -	if (buffer_init(&input, filename))
> -		return error("cannot open %s: %s", filename, strerror(errno));
> -	fast_export_init(REPORT_FILENO);
> +	fast_export_init(report_fd);
>  	strbuf_init(&dump_ctx.uuid, 4096);
>  	strbuf_init(&dump_ctx.url, 4096);
>  	strbuf_init(&rev_ctx.log, 4096);
> @@ -482,6 +480,22 @@ int svndump_init(const char *filename)
>  	reset_dump_ctx(NULL);
>  	reset_rev_ctx(0);
>  	reset_node_ctx(NULL);
> +	return;
> +}
> +
> +int svndump_init(const char *filename)
> +{
> +	if (buffer_init(&input, filename))
> +		return error("cannot open %s: %s", filename ? filename : "NULL", strerror(errno));
> +	init(REPORT_FILENO);
> +	return 0;
> +}
> +
> +int svndump_init_fd(int in_fd, int back_fd)
> +{
> +	if(buffer_fdinit(&input, xdup(in_fd)))

Style:

	if (buffer_fdinit(&input, xdup(in_fd))

> +		return error("cannot open fd %d: %s", in_fd, strerror(errno));
> +	init(xdup(back_fd));
>  	return 0;
>  }
>  
> diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
> index df9ceb0..acb5b47 100644
> --- a/vcs-svn/svndump.h
> +++ b/vcs-svn/svndump.h
> @@ -2,6 +2,7 @@
>  #define SVNDUMP_H_
>  
>  int svndump_init(const char *filename);
> +int svndump_init_fd(int in_fd, int back_fd);
>  void svndump_read(const char *url);
>  void svndump_deinit(void);
>  void svndump_reset(void);
