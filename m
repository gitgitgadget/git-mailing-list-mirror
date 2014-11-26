From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] t1402: check to delete broken refs
Date: Wed, 26 Nov 2014 06:05:00 +0100
Message-ID: <54755F7C.3010803@web.de>
References: <1416956166-20341-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>, mhagger@alum.mit.edu,
	gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 06:06:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtUnx-0000of-6K
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 06:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbaKZFGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 00:06:12 -0500
Received: from mout.web.de ([212.227.17.12]:54072 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbaKZFGL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 00:06:11 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lp71s-1YNJEn0abE-00et6a; Wed, 26 Nov 2014 06:06:05
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <1416956166-20341-1-git-send-email-sbeller@google.com>
X-Provags-ID: V03:K0:opXIW+IFV6oi0NMIIGD09Plf410XBdfzXqlLEksIkfa+0lVVIkM
 a6e9+gFRtojo04HYWFAUsxZ3t28qBeYF6wh/OOGvE57BCKGkj3fCAdKlYd6jFn9BAIdL3e5
 Ere31qOPZHNlJ53plEHtfYJLopJBRC1gdouG6d75ScLor4IGk0nLd9yuKfHMQiKukYbEhTV
 S/2q6CRcivxAclghrXIaQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260272>

On 11/25/2014 11:56 PM, Stefan Beller wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   
>   This was also part of the ongoing series from Ronnie.
>   But I think the patch in this form is rather independant,
>   documenting the current state of "git branch -d", so it's
>   fine to have it in now.
>
>   t/t1402-check-ref-format.sh | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
> index e5dc62e..08af156 100755
> --- a/t/t1402-check-ref-format.sh
> +++ b/t/t1402-check-ref-format.sh
> @@ -197,4 +197,12 @@ invalid_ref_normalized 'heads///foo.lock'
>   invalid_ref_normalized 'foo.lock/bar'
>   invalid_ref_normalized 'foo.lock///bar'
>   
> +test_expect_failure 'git branch -d can delete ref with broken sha1' '
> +	echo "pointing nowhere" > .git/refs/heads/brokensha1 &&
> +	test_when_finished "rm -f .git/refs/heads/brokensha1" &&
> +	git branch -d brokensha1 &&
> +	git branch >output &&
> +	! grep -e "brokensha1" output
> +'
Do we need grep -e here ?
It does not give us anything in the pattern we are using.

   -e PATTERN, --regexp=PATTERN
               Use  PATTERN  as  the pattern.  This can be used to 
specify multiple search patterns, or to protect a pattern beginning
               with a hyphen (-).  (-e is specified by POSIX.)

(And we do not need the "" either, there is no space in brokensha1)
We can simply use:
! grep brokensha1 output





> +
>   test_done
