From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCHv2 1/5] update-ref: test handling large transactions properly
Date: Thu, 22 Jan 2015 11:54:49 +0100
Message-ID: <54C0D6F9.1000808@alum.mit.edu>
References: <1421893929-7447-1-git-send-email-sbeller@google.com> <1421893929-7447-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Stefan Beller <sbeller@google.com>, peff@peff.net,
	git@vger.kernel.org, gitster@pobox.com, loic@dachary.org
X-From: git-owner@vger.kernel.org Thu Jan 22 11:55:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEFPq-0004q1-Us
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 11:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbbAVKzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 05:55:07 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:45164 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750961AbbAVKzE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2015 05:55:04 -0500
X-AuditID: 12074412-f79e46d0000036b4-4e-54c0d6fdf4d3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id D7.1B.14004.DF6D0C45; Thu, 22 Jan 2015 05:54:53 -0500 (EST)
Received: from [192.168.69.130] (p5DDB02C5.dip0.t-ipconnect.de [93.219.2.197])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t0MAsoKE007278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 22 Jan 2015 05:54:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <1421893929-7447-2-git-send-email-sbeller@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsUixO6iqPv32oEQg5Mz2Sy6rnQzWTT0XmG2
	eLXdx+JHSw+zxebN7SwOrB7PtrF6LNhU6vGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn6dsl
	cGf8bZ7KVrCSp+LcrAuMDYwvObsYOTkkBEwkuv42MULYYhIX7q1n62Lk4hASuMwosWbVXBYI
	5xyTxP2TM5i7GDk4eAW0JW49zABpYBFQlXi6/iIbiM0moCuxqKeZCcQWFQiSuNKymRnE5hUQ
	lDg58wkLiC0iUCFxcfMdsHphgQCJCxcWgdlCAuUSXb9vs4PYnAJOEpvmLAM7iFlAT2LH9V+s
	ELa8RPPW2cwTGPlnIRk7C0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmunlZpbo
	paaUbmKEBLHQDsb1J+UOMQpwMCrx8GYUHwgRYk0sK67MPcQoycGkJMqbegUoxJeUn1KZkVic
	EV9UmpNafIhRgoNZSYTX9ARQjjclsbIqtSgfJiXNwaIkzvtzsbqfkEB6YklqdmpqQWoRTFaG
	g0NJgvfDVaBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFBExhcDYxIkxQO0twWk
	nbe4IDEXKArReopRUUqcdxlIQgAkkVGaBzcWlppeMYoDfSnM6wRMVEI8wLQG1/0KaDAT0OCC
	7WCDSxIRUlINjOsNy/oLVSbcjtzQHW25pnb93henZdR23Jj7Z+ns+lBGuZWuitPVapyOT5FU
	kFj8OH/VlFnvPUw+f5wjXBwUt93WsYbpx1b/apvr4U2mP/q6swtOXZ9w3G7XL+ZU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262816>

On 01/22/2015 03:32 AM, Stefan Beller wrote:
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t1400-update-ref.sh | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 7b4707b..47d2fe9 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -973,4 +973,32 @@ test_expect_success 'stdin -z delete refs works with packed and loose refs' '
>  	test_must_fail git rev-parse --verify -q $c
>  '
>  
> +run_with_limited_open_files () {
> +	(ulimit -n 32 && "$@")
> +}

Regarding the choice of "32", I wonder what is the worst-case number of
open file descriptors that are needed *before* counting the ones that
are currently wasted on open loose-reference locks. On Linux it seems to
be only 4 with my setup:

    $ (ulimit -n 3 && git update-ref --stdin </dev/null)
    bash: /dev/null: Too many open files
    $ (ulimit -n 4 && git update-ref --stdin </dev/null)
    $

This number might depend a little bit on details of the repository, like
whether config files import other config files. But as long as the
"background" number of fds required is at least a few less than 32, then
your number should be safe.

Does anybody know of a platform where file descriptors are eaten up
gluttonously by, for example, each shared library that is in use or
something? That's the only think I can think of that could potentially
make your choice of 32 problematic.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
