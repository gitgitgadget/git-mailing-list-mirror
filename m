From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 5/8] refs: new public ref function: safe_create_reflog
Date: Wed, 08 Jul 2015 13:49:57 +0200
Message-ID: <559D0E65.6080403@alum.mit.edu>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com> <1436316963-25520-5-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 13:50:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCnre-0000UE-5x
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 13:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758345AbbGHLuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 07:50:05 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:54009 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758270AbbGHLuC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2015 07:50:02 -0400
X-AuditID: 1207440f-f79df6d000007c0f-cc-559d0e67e8f8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 4E.C1.31759.76E0D955; Wed,  8 Jul 2015 07:49:59 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB0310.dip0.t-ipconnect.de [93.219.3.16])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t68BnvXd004993
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 8 Jul 2015 07:49:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1436316963-25520-5-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsUixO6iqJvONzfUYPJlCYv5m04wWnRd6WZy
	YPJY8Pw+u8fnTXIBTFHcNkmJJWXBmel5+nYJ3Bnvzx5kL1giWLHm9h6WBsYTvF2MnBwSAiYS
	q25PY4WwxSQu3FvP1sXIxSEkcJlR4tziLVDOGSaJ6Sfa2ECqeAW0Jc4tvcsMYrMIqEqs6f3P
	BGKzCehKLOppBrI5OEQFgiRev8yFKBeUODnzCQuILSLgIHF511GwVmEBX4k5H56xQsxvZZRY
	duML2BxOAU+JPx83MoLYzAJ6Ejuu/2KFsOUltr+dwzyBkX8WkrmzkJTNQlK2gJF5FaNcYk5p
	rm5uYmZOcWqybnFyYl5eapGuiV5uZoleakrpJkZISPLvYOxaL3OIUYCDUYmH1yNmTqgQa2JZ
	cWXuIUZJDiYlUd64R0AhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrznOeeGCvGmJFZWpRblw6Sk
	OViUxHnVl6j7CQmkJ5akZqemFqQWwWRlODiUJHiVeYEaBYtS01Mr0jJzShDSTBycIMO5pESK
	U/NSUosSS0sy4kExGV8MjEqQFA/Q3tk8IHuLCxJzgaIQracYFaXEedlB5gqAJDJK8+DGwhLN
	K0ZxoC+FeXNAqniASQqu+xXQYCagwct1Z4EMLklESEk1ME4QT/4nGXqXZ7lCrXjwR7GwPzO3
	/WvvqIxwrz3uG85wvtd0cq5uza6Lm6Nn74l88LHMr+3Lt4qV6pXbm50zL1xJtOIUuuKcYHDd
	TTR/kbKXrJnxrnnFnaLvLyZ1qM6++tD5g5CJ+R3xmukVP45vm33kw7TknhXqJ4x+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273673>

On 07/08/2015 02:56 AM, David Turner wrote:
> The safe_create_reflog function creates a reflog, if it does not
> already exist.
> 
> The log_ref_setup function becomes private and gains a force_create
> parameter to force the creation of a reflog even if log_all_ref_updates
> is false or the refname is not one of the special refnames.
> 
> The new parameter also reduces the need to store, modify, and restore
> the log_all_ref_updates global before reflog creation.
> 
> In a moment, we will use this to add reflog creation commands to
> git-reflog.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  builtin/checkout.c | 16 +++++-----------
>  refs.c             | 25 +++++++++++++++++++++----
>  refs.h             |  2 +-
>  3 files changed, 27 insertions(+), 16 deletions(-)
> 
> [...]
> diff --git a/refs.c b/refs.c
> index e694359..01b0af5 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3128,8 +3128,14 @@ static int should_autocreate_reflog(const char *refname)
>  		!strcmp(refname, "HEAD");
>  }
>  
> -/* This function will fill in *err and return -1 on failure */
> -int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err)
> +/*
> + * Create a reflog for a ref.  If force_create = 0, the reflog will
> + * only be created for certain refs (those for which
> + * should_autocreate_reflog returns non-zero.  Otherwise, it will be
> + * created regardless of the ref name.  This function will fill in
> + * *err and return -1 on failure
> + */
> +static int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err, int force_create)
>  {
>  	int logfd, oflags = O_APPEND | O_WRONLY;
>  	char *logfile;

Sorry for being unclear in the last round. I meant that the whole
docstring should be in the imperative voice, like

/*
 * Create a reflog for a ref. If force_create = 0, only create the
 * reflog for certain refs (those for which should_autocreate_reflog
 * returns non-zero). Otherwise, create it regardless of the reference
 * name. Fill in *err and return -1 on failure.
 */

Otherwise, this patch looks good.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
