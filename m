From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v20 24/48] tag.c: use ref transactions when doing updates
Date: Tue, 08 Jul 2014 14:33:01 +0200
Message-ID: <53BBE4FD.20605@alum.mit.edu>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com> <1403275409-28173-25-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 14:33:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4Ua6-00036n-4R
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 14:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbaGHMdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 08:33:05 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:50175 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754399AbaGHMdE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2014 08:33:04 -0400
X-AuditID: 12074413-f79ed6d000002501-90-53bbe4ff0c6c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id E1.2D.09473.FF4EBB35; Tue,  8 Jul 2014 08:33:03 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97EC0.dip0.t-ipconnect.de [79.201.126.192])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s68CX1Tr030552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Jul 2014 08:33:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403275409-28173-25-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42IRYndR1P3/ZHewwbwdEhZdV7qZLP5NqHFg
	8liwqdTj8ya5AKYobpukxJKy4Mz0PH27BO6M613NTAVNQhWfnoQ1MM7m62Lk5JAQMJGY0P6c
	CcIWk7hwbz1bFyMXh5DAZUaJq3197BDOeSaJH79Xs4JU8QpoSrStuccOYrMIqEo07ZrOCGKz
	CehKLOppBpskKhAkMfvzPHaIekGJkzOfsIDYIgJ2EutvLWQGsYUFfCV6r7WB1QgJ1Ei8+zoP
	bD6ngKvEnzOHgOo5gC4Sl+hpDAIJMwvoSLzre8AMYctLbH87h3kCo8AsJBtmISmbhaRsASPz
	Kka5xJzSXN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQEBXewbjrpNwhRgEORiUe3hUH
	dwULsSaWFVfmHmKU5GBSEuUVvL87WIgvKT+lMiOxOCO+qDQntfgQowQHs5II75dTQDnelMTK
	qtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgTvhcdAjYJFqempFWmZOSUIaSYO
	TpDhXFIixal5KalFiaUlGfGgOI0vBkYqSIoHaO88kHbe4oLEXKAoROspRkUpcd7Nj4ASAiCJ
	jNI8uLGwxPOKURzoS2HeDSDtPMCkBdf9CmgwE9Dgz+93gAwuSURISTUwcvivmHp2rcBTvt3C
	bzeXH/+l1ruSRTnm2z3rnjVZZf5uR23klmQer/uTl/ng/OHzFp2OMy5ntu+9MEGrXKpq/4+4
	hd/Lq/sY25Y7+t1+EMMosnLPbh1206id52Z89WF/bXJt3uxJ98qUMifKyqqv4OVZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253017>

On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
> Change tag.c to use ref transactions for all ref updates.
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/tag.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/tag.c b/builtin/tag.c
> index c6e8a71..c9bfc9a 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -548,7 +548,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	struct strbuf ref = STRBUF_INIT;
>  	unsigned char object[20], prev[20];
>  	const char *object_ref, *tag;
> -	struct ref_lock *lock;
>  	struct create_tag_options opt;
>  	char *cleanup_arg = NULL;
>  	int annotate = 0, force = 0, lines = -1;
> @@ -556,6 +555,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	const char *msgfile = NULL, *keyid = NULL;
>  	struct msg_arg msg = { 0, STRBUF_INIT };
>  	struct commit_list *with_commit = NULL;
> +	struct ref_transaction *transaction;
> +	struct strbuf err = STRBUF_INIT;
>  	struct option options[] = {
>  		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
>  		{ OPTION_INTEGER, 'n', NULL, &lines, N_("n"),
> @@ -701,11 +702,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	if (annotate)
>  		create_tag(object, tag, &buf, &opt, prev, object);
>  
> -	lock = lock_any_ref_for_update(ref.buf, prev, 0, NULL);
> -	if (!lock)
> -		die(_("%s: cannot lock the ref"), ref.buf);
> -	if (write_ref_sha1(lock, object, NULL) < 0)
> -		die(_("%s: cannot update the ref"), ref.buf);
> +	transaction = ref_transaction_begin(&err);
> +	if (!transaction ||
> +	    ref_transaction_update(transaction, ref.buf, object, prev,
> +				   0, !is_null_sha1(prev), &err) ||

Similar to the error in sequencer.c a few patches later (explained in
more detail in my comment on that patch), here you only do a check if
!is_null_sha1(prev), whereas the old code always did the check.  I think
you want

    ref_transaction_update(transaction, ref.buf, object, prev,
                           0, 1, &err) ||

Please check whether you have made the same mistake in other patches.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
