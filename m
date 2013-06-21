From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] lib-httpd/apache.conf: check version only after mod_version loads
Date: Fri, 21 Jun 2013 13:59:56 -0700
Message-ID: <7vmwqjkwmr.fsf@alter.siamese.dyndns.org>
References: <C44E969B-A5AE-44EF-BFCA-CAEF69516BEB@gernhardtsoftware.com>
	<20130621043052.GA5318@sigill.intra.peff.net>
	<20130621044236.GA5798@sigill.intra.peff.net>
	<26902D6D-D105-4943-BC67-461CEF82D888@gernhardtsoftware.com>
	<20130621044953.GA5962@sigill.intra.peff.net>
	<D0852D0F-3282-41DF-8A5A-4BEF1B39ED66@gernhardtsoftware.com>
	<20130621180334.GA4499@sigill.intra.peff.net>
	<1B9251F9-C1AF-41F7-8BF8-D36DDB27EF09@gernhardtsoftware.com>
	<20130621181250.GA5290@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 21 23:00:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq8RL-0006LE-FJ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 23:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945960Ab3FUVAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 17:00:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48959 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945933Ab3FUU76 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 16:59:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 459752AD43;
	Fri, 21 Jun 2013 20:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pV0xKVAwxLFadfSZgFNOXMtLkQo=; b=ePb6mQ
	aj5drmgMdC3/ny7EU05vReYJDtBFFpTeWs+oJfX4L+eEvXkDtN+JpL/2LtVrOIk+
	RvoJwZmeLqHbhghMARhjE7HGbqDswKBfZVbNNcr7/YIS5x+n6eEZ23YIduema6+5
	8T2G5bpVE/aDTLadZ5733EQVkhGOZaPJqWPBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qHH+wzUycsyfZpNC8+zsC4y/mpLNco46
	2dCh0sNWcdQeL6nRar2k6waVc7LScksNcySNHc4r92EBmmUyrmwbu0hlXCqr9TPE
	Q3L7F2Jf35CiGKjuzalmJX37m1OT+YILMlUas29Ta4plDd1G1JsUvQ7f7H7YdkL8
	/9RdyKqQkIc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39BE12AD42;
	Fri, 21 Jun 2013 20:59:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9234C2AD41;
	Fri, 21 Jun 2013 20:59:57 +0000 (UTC)
In-Reply-To: <20130621181250.GA5290@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 21 Jun 2013 14:12:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 87C1A0EC-DAB5-11E2-83EF-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228658>

Jeff King <peff@peff.net> writes:

> Cool. I think the patch should look like the one below, then.
>
> Just to double-check that I have explained the issue correctly, can you
> share the output of "apache2 -l"? Mine has:
>
>   $ apache2 -l
>   Compiled in modules:
>     core.c
>     mod_log_config.c
>     mod_logio.c
>     mod_version.c
>     prefork.c
>     http_core.c
>     mod_so.c
>
> which explains why it works here. I'm assuming you will not have
> mod_version.c compiled in.
>
> -- >8 --
> Subject: lib-httpd/apache.conf: check version only after mod_version loads
>
> Commit 0442743 introduced an <IfVersion> directive near the
> top of the apache config file. However, at that point we
> have not yet checked for and loaded the mod_version module.
> This means that the directive will behave oddly if
> mod_version is dynamically loaded, failing to match when it
> should.
>
> We can fix this by moving the whole block below the
> LoadModule directive for mod_version.
>
> Reported-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/lib-httpd/apache.conf | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index 56ae548..dd17e3a 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -1,7 +1,4 @@ ServerName dummy
>  ServerName dummy
> -<IfVersion < 2.4>
> -LockFile accept.lock
> -</IfVersion>
>  PidFile httpd.pid
>  DocumentRoot www
>  LogFormat "%h %l %u %t \"%r\" %>s %b" common
> @@ -26,6 +23,10 @@ ErrorLog error.log
>  	LoadModule version_module modules/mod_version.so
>  </IfModule>
>  
> +<IfVersion < 2.4>
> +LockFile accept.lock
> +</IfVersion>
> +

Once you see it in the patch form, it is very clear what this change
does and why it is necessary in the context ;-)

Thanks, both of you, for digging this down to the root cause; you
guys have done before it graduates to 'master', which I especially
appreciate.

Will queue.
