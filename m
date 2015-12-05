From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/16] init: allow alternate backends to be set for new repos
Date: Fri, 04 Dec 2015 16:07:08 -0800
Message-ID: <xmqq7fktpxlf.fsf@gitster.mtv.corp.google.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	<1449102921-7707-14-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 01:07:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a50Nj-00071d-Cf
	for gcvg-git-2@plane.gmane.org; Sat, 05 Dec 2015 01:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755128AbbLEAHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 19:07:12 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53534 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754286AbbLEAHK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 19:07:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 043EA31A6B;
	Fri,  4 Dec 2015 19:07:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=f0g08vxNA5bHnh7X9jVKkecu/8c=; b=olPtgf
	C9EdnUCV/U4Whf+CH4KppejGVM6b5ZULR3IToanAhsTSwNNEUZzidSx6x/ot5u0/
	4gMHXiVe9GVe+b3mTAGydq2ze8zKJEJEPzRdrKQp9cJWai8R3c+vsek51xgQfl/h
	G+9sPRUnXOeY4BLIrvJ5gWqZDnLkXvwdfFWrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eiWW2HmE0BxThy1MXV92+4LjnyZcRdAb
	1s+zpE0Sl/0sAb0qqFHKUNIaQoC6hC/aEtf3VFfAann7WZYoDPEavZ7EBVsdYUsz
	u6vMeemlsEfdARpTbeVabfXNzC5yTanRPfuQzD7nYo8oqRSvGtqrATHrNEoZggC7
	lgHWeVFVAcA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DEAF531A6A;
	Fri,  4 Dec 2015 19:07:09 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 50A2D31A69;
	Fri,  4 Dec 2015 19:07:09 -0500 (EST)
In-Reply-To: <1449102921-7707-14-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 2 Dec 2015 19:35:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2084672E-9AE4-11E5-84BE-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282021>

David Turner <dturner@twopensource.com> writes:

> diff --git a/setup.c b/setup.c
> index d343725..de6b8ac 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "dir.h"
> +#include "refs.h"
>  #include "string-list.h"
>  
>  static int inside_git_dir = -1;
> @@ -263,6 +264,15 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
>  	return ret;
>  }
>  
> +int refdb_config(const char *var, const char *value, void *ptr)
> +{
> +       struct refdb_config_data *cdata = ptr;
> +
> +       if (!strcmp(var, "core.refsbackendtype"))
> +	       cdata->refs_backend_type = xstrdup((char *)value);
> +       return 0;
> +}
> +

These lines seem to be indented with SPs not HTs.

>  /*
>   * Test if it looks like we're at a git directory.
>   * We want to see:
