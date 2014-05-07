From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 0/2] add a reflog_exists and delete_reflog abstraction
Date: Wed, 07 May 2014 13:56:52 +0200
Message-ID: <536A1F84.8020902@alum.mit.edu>
References: <1399416353-31817-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 13:57:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi0T5-0004eU-VY
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 13:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755835AbaEGL44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 07:56:56 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:49248 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755316AbaEGL4z (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 May 2014 07:56:55 -0400
X-AuditID: 1207440f-f79326d000003c9f-99-536a1f866be2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 95.02.15519.68F1A635; Wed,  7 May 2014 07:56:54 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96C3A.dip0.t-ipconnect.de [79.201.108.58])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s47Buq9A020599
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 7 May 2014 07:56:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1399416353-31817-1-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1G2Tzwo2WHpewaLrSjeTxb8JNQ5M
	Hgs2lXp83iQXwBTFbZOUWFIWnJmep2+XwJ1xaul6toI3XBWLHjYxNTBu5+hi5OSQEDCR2Hr8
	MTOELSZx4d56NhBbSOAyo8TdS4kQ9jkmiX2bZEBsXgFtiT0rXwDVcHCwCKhK3J/jCRJmE9CV
	WNTTzAQSFhUIkvhzVhGiWlDi5MwnLCC2iICdxPpbC8E2CQv4SqydNocZYrqzRNPrmWA1nAIu
	Eq+OnmIBGSMhIC7R0xgEEmYW0JF41/eAGcKWl9j+dg7zBEaBWUg2zEJSNgtJ2QJG5lWMcok5
	pbm6uYmZOcWpybrFyYl5ealFuiZ6uZkleqkppZsYIcHJv4Oxa73MIUYBDkYlHt4HrzKChVgT
	y4orcw8xSnIwKYnysnJnBQvxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4e3mB8rxpiRWVqUW5cOk
	pDlYlMR51Zeo+wkJpCeWpGanphakFsFkZTg4lCR4+YBRKCRYlJqeWpGWmVOCkGbi4AQZziUl
	Upyal5JalFhakhEPitD4YmCMgqR4gPZygrTzFhck5gJFIVpPMepyXGhY0cIkxJKXn5cqJc4b
	IAdUJABSlFGaB7cClopeMYoDfSzMexekigeYxuAmvQJawgS0hMs4HWRJSSJCSqqBccru3aoH
	J3bzPnjI9Gnme0PJf827tJ7fM25c7cV09Zuc8KGn8g7eZ5fKPjzhGm2bXjDR7t+NybP4Tmpd
	/h7Z/eU021HRqiflnby6xVc7bZyK7vz5slXj/Qd/RrMXT1fJmP94u3EWvzXfN6Uw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248298>

On 05/07/2014 12:45 AM, Ronnie Sahlberg wrote:
> This is a series adds two new functions to try to hide the reflog
> implementation details from the callers in checkout.c and reflog.c.
> It adds new functions to test if a reflog exists and to delete it, thus
> allowing checkout.c to perform this if-test-then-delete operation without
> having to know the internal implementation of reflogs (i.e. that they are files
> that live under .git/logs)
> 
> Additionally we change checkout.c to use ref_exists instead of file_exists
> when checking for ref existence. This fixes a bug when checkout could delete
> a valid reflog file if the branch was a packed ref. The tests have been updated
> to test for this bug.
> 
> 
> Version 2:
>  - Typos and fixes suggested by mhagger.
>  - Break the checkout-deletes reflog bugfix out into a separate patch.
> 
> 
> Ronnie Sahlberg (2):
>   refs.c: add new functions reflog_exists and delete_reflog
>   checkout.c: use ref_exists instead of file_exist
> 
>  builtin/checkout.c |  8 ++------
>  builtin/reflog.c   |  2 +-
>  refs.c             | 21 +++++++++++++++------
>  refs.h             |  6 ++++++
>  t/t1410-reflog.sh  |  8 ++++++++
>  5 files changed, 32 insertions(+), 13 deletions(-)

+1 Looks good to me.  Thanks!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
