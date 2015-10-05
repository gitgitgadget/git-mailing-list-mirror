From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 40/43] refs: allow ref backend to be set for clone
Date: Mon, 05 Oct 2015 13:55:43 +0200
Message-ID: <5612653F.5070502@alum.mit.edu>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com> <1443477738-32023-41-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 13:55:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj4Mw-0004ku-5u
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 13:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbbJELzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 07:55:46 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:44959 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751054AbbJELzp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2015 07:55:45 -0400
X-AuditID: 1207440d-f79136d00000402c-f2-5612654194b8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id B2.4C.16428.14562165; Mon,  5 Oct 2015 07:55:45 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96E0C.dip0.t-ipconnect.de [79.201.110.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t95BthE3008680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 5 Oct 2015 07:55:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1443477738-32023-41-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsUixO6iqOuYKhRm8P0dm8X8TScYLbqudDM5
	MHkseH6f3ePzJrkApihum6TEkrLgzPQ8fbsE7oyZE/YwFRzhrmh/H9HA+IKji5GTQ0LARGLt
	lBusELaYxIV769m6GLk4hAQuM0ocPHiFFcI5xySxefN7FpAqXgFtiU17O9i7GDk4WARUJWY8
	UAMJswnoSizqaWYCsUUFgiRWLH/BCFEuKHFy5hOwVhEBB4nLu44yg9jCAp4S1x6uZ4KY38Yo
	0XBqHhtIglPAS2Lp6ulgzcwCehI7rv9ihbDlJba/ncM8gZF/FpK5s5CUzUJStoCReRWjXGJO
	aa5ubmJmTnFqsm5xcmJeXmqRrpFebmaJXmpK6SZGSEDy7mD8v07mEKMAB6MSD++BeMEwIdbE
	suLK3EOMkhxMSqK8N+2EwoT4kvJTKjMSizPii0pzUosPMUpwMCuJ8Fq6AuV4UxIrq1KL8mFS
	0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8GSlAjYJFqempFWmZOSUIaSYOTpDhXFIi
	xal5KalFiaUlGfGgiIwvBsYkSIoHaG8ZSDtvcUFiLlAUovUUo6KUOO/GZKCEAEgiozQPbiws
	zbxiFAf6Upj3AkgVDzBFwXW/AhrMBDS4Xx5scEkiQkqqgXF2Rkj1rxcvjVhb5Ld8W9v7JHCq
	ea2T8r1FAtxvPO9vzzh/cDU334Vmvgr2b2Y8K065Hz6yM9v174Tf89rrf1yfsj/tuuRGy7x5
	st6Wt3y3nnZiEc4MZ9mhIj9vwfUbdxgmTa0/k+QZuORdnrFFNic/q8CNHY1PJr5T 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279056>

On 09/29/2015 12:02 AM, David Turner wrote:
> Add a new option, --refs-backend-type, to allow the ref backend type to
> be set on new clones.
> 
> Submodules must use the same ref backend as the parent repository, so
> we also pass the --refs-backend-type option option when cloning
> submodules.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  Documentation/git-clone.txt |  4 ++++
>  builtin/clone.c             | 27 +++++++++++++++++++++++++--
>  builtin/submodule--helper.c |  5 ++++-
>  cache.h                     |  1 +
>  refs.c                      |  2 ++
>  5 files changed, 36 insertions(+), 3 deletions(-)
> 
> [...]
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 3e14491..d489a87 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> [...]
> @@ -744,6 +762,11 @@ static void write_config(struct string_list *config)
>  					       write_one_config, NULL) < 0)
>  			die("unable to write parameters to config file");
>  	}
> +
> +	if (refs_backend_type &&
> +	    write_one_config("core.refs-backend-type",
> +			     refs_backend_type, NULL) < 0)
> +			die("unable to write backend parameter to config file");
>  }

Our config variable names don't use separated-with-hyphens but rather
wordsruntogether (though in documentation this would be written
core.refsBackendType, because the actual names are case-insensitive).

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
