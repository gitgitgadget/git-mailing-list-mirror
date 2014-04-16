From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 2/2] commit.c: check for lock error and return early
Date: Thu, 17 Apr 2014 00:06:24 +0200
Message-ID: <534EFEE0.9000806@alum.mit.edu>
References: <1397674613-4922-1-git-send-email-sahlberg@google.com> <1397674613-4922-3-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 00:06:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaXyS-0004xi-3d
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 00:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756789AbaDPWG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 18:06:28 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:59077 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756599AbaDPWG1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Apr 2014 18:06:27 -0400
X-AuditID: 1207440d-f79d86d0000043db-f0-534efee2f0a7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id CE.FB.17371.2EEFE435; Wed, 16 Apr 2014 18:06:26 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9722C.dip0.t-ipconnect.de [79.201.114.44])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3GM6O6L004359
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 16 Apr 2014 18:06:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1397674613-4922-3-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1H30zy/Y4ModcYuuK91MFv8m1Dgw
	eSzYVOrxeZNcAFMUt01SYklZcGZ6nr5dAnfGgUWvmAq281bMOnmSrYHxJFcXIyeHhICJxP99
	/ewQtpjEhXvr2boYuTiEBC4zSlz+tJ8ZwjnPJLHk0nawKl4BbYk7/5YxgtgsAqoSt7pWgdls
	AroSi3qamboYOThEBYIk/pxVhCgXlDg58wkLiC0iYCex/tZCZhBbWMBb4u7+5cwg5UIClRI3
	X0uDhDkFnCU+XznEAhKWEBCX6GkMAgkzC+hIvOt7wAxhy0tsfzuHeQKjwCwkC2YhKZuFpGwB
	I/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0jvdzMEr3UlNJNjJAA5d3B+H+dzCFGAQ5GJR5e
	jt9+wUKsiWXFlbmHGCU5mJREeTt+AoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8GaeBcrxpiRW
	VqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR48/8CNQoWpaanVqRl5pQgpJk4
	OEGGc0mJFKfmpaQWJZaWZMSDojS+GBinICkeoL3hIO28xQWJuUBRiNZTjLocFxpWtDAJseTl
	56VKifNm/wEqEgApyijNg1sBS0evGMWBPhbmzQQZxQNMZXCTXgEtYQJacijcF2RJSSJCSqqB
	semj56YLRa+7+TImL0/QPMa79CajmCKHnq2gg/w9F6FdradtvE72bxf3vho1y+jWe7V00x1e
	HOcO8saq1N3JK59ubL7tX6tB2Jv3d521ujh9dW+cd7w+19vCeqtap8Hjqxn+cd/V 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246388>

On 04/16/2014 08:56 PM, Ronnie Sahlberg wrote:
> Move the check for the lock failure to happen immediately after
> lock_any_ref_for_update().
> Previously the lock and the check-if-lock-failed was separated by a handful
> of string manipulation statements.

Please flow sentences together into paragraphs for easier reading,
rather than having an extremely ragged right-hand margin.

The rest looks good.

Michael

>
> Moving the check to occur immediately after the failed lock makes the
> code slightly easier to read and makes it follow the pattern of
>  try-to-take-a-lock()
>  if (check-if-lock-failed){
>     error
>  }
> ---
>  builtin/commit.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index d9550c5..c6320f1 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1672,6 +1672,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  					   ? NULL
>  					   : current_head->object.sha1,
>  					   0, NULL);
> +	if (!ref_lock) {
> +		rollback_index_files();
> +		die(_("cannot lock HEAD ref"));
> +	}
>  
>  	nl = strchr(sb.buf, '\n');
>  	if (nl)
> @@ -1681,10 +1685,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
>  	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
>  
> -	if (!ref_lock) {
> -		rollback_index_files();
> -		die(_("cannot lock HEAD ref"));
> -	}
>  	if (write_ref_sha1(ref_lock, sha1, sb.buf) < 0) {
>  		rollback_index_files();
>  		die(_("cannot update HEAD ref"));
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
