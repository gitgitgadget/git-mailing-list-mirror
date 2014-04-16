From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 1/2] sequencer.c: check for lock failure and bail early
 in fast_forward_to
Date: Thu, 17 Apr 2014 00:03:03 +0200
Message-ID: <534EFE17.7060105@alum.mit.edu>
References: <1397674613-4922-1-git-send-email-sahlberg@google.com> <1397674613-4922-2-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 00:03:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaXvF-0006X9-MA
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 00:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780AbaDPWDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 18:03:08 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:55490 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756724AbaDPWDH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Apr 2014 18:03:07 -0400
X-AuditID: 1207440f-f79326d000003c9f-e2-534efe192890
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 10.AF.15519.91EFE435; Wed, 16 Apr 2014 18:03:05 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9722C.dip0.t-ipconnect.de [79.201.114.44])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3GM33aJ004201
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 16 Apr 2014 18:03:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1397674613-4922-2-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1JX85xdssOmXgkXXlW4mi38TahyY
	PBZsKvX4vEkugCmK2yYpsaQsODM9T98ugTvj5NbTjAUvhCpWHHnL2MDYwt/FyMkhIWAi8etP
	GyuELSZx4d56NhBbSOAyo8TM3aZdjFxA9nkmiSXXXjGBJHgFtCUmPpvBCGKzCKhKzDs5GyzO
	JqArsainGcjm4BAVCJL4c1YRolxQ4uTMJywgtoiAncT6WwuZQWxhgWSJxt0HWCB2VUocnHSF
	HcTmFHCW2P6ymR1kjISAuERPYxBImFlAR+Jd3wNmCFteYvvbOcwTGAVmIdkwC0nZLCRlCxiZ
	VzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmujlZpbopaaUbmKEBCj/Dsau9TKHGAU4GJV4eDl/
	+wULsSaWFVfmHmKU5GBSEuXt+AkU4kvKT6nMSCzOiC8qzUktPsQowcGsJMKbeRYox5uSWFmV
	WpQPk5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh4FCS4M3/C9QoWJSanlqRlplTgpBm4uAE
	Gc4lJVKcmpeSWpRYWpIRD4rS+GJgnIKkeID2hoO08xYXJOYCRSFaTzHqclxoWNHCJMSSl5+X
	KiXOm/0HqEgApCijNA9uBSwdvWIUB/pYmDcTZBQPMJXBTXoFtIQJaMmhcF+QJSWJCCmpBsa4
	9QvWt7ra+++ykHZbuN6yctPskgLO72xGO1M5Zlwr0y576rEtrOagxgfukxfucHxbcSn9wbP9
	a33rNizbGZnZ4yv9oIWl1LT/7WGWclXznpIn72uK1ttUm6l6GK+dM+XcGla/Cayv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246387>

On 04/16/2014 08:56 PM, Ronnie Sahlberg wrote:
> Change fast_forward_to() to check if locking the ref failed, print a nice
> error message and bail out early.
> The old code did not check if ref_lock was NULL and relied on the fact
> that the write_ref_sha1() would safely detect this condition and set the

s/the write_ref_sha1()/write_ref_sha1()/

> return variable ret to indicate an error.
> While that is safe, it makes the code harder to read for two reasons:
> * Inconsistency.  Almost all other places we do check the lock for NULL
>   explicitely, so the naive reader is confused "why don't we check here".

s/explicitely/explicitly/
s/here"/here?"/

> * And relying on write_ref_sha1() to detect and return an error for when
>   a previous lock_any_ref_for_update() feels obfuscated.

s/feels/failed feels/ maybe?

> 
> This change should not change any functionality or logic
> aside from adding an extra error message when this condition is triggered.
> (write_ref_sha1() returns an error silently for this condition)

You need a period inside the parentheses.

> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  sequencer.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sequencer.c b/sequencer.c
> index bde5f04..0a80c58 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -281,8 +281,12 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
>  		exit(1); /* the callee should have complained already */
>  	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
>  					   0, NULL);
> +	if (!ref_lock)
> +		return error(_("Failed to lock HEAD during fast_forward_to"));

This error message can be emitted to the user in the normal course of
things (i.e., it is not a bug).  So the message should make sense to the
user.  Is "fast_forward_to" a user-facing term that the user will
understand?  I suspect that you took it from the name of the function,
which is *not* meaningful to a user.

But unfortunately I'm not familiar enough with the sequencer to be able
to suggest a better error message.

> +
>  	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
>  	ret = write_ref_sha1(ref_lock, to, sb.buf);
> +
>  	strbuf_release(&sb);
>  	return ret;
>  }
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
