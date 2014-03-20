From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] builtin/apply.c: fuzzy_matchlines:trying to fix some
 inefficiencies
Date: Thu, 20 Mar 2014 10:58:57 +0100
Message-ID: <532ABBE1.4090001@alum.mit.edu>
References: <1395279167-20354-1-git-send-email-g3orge.app@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: George Papanikolaou <g3orge.app@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 10:59:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQZkk-0003RM-7t
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 10:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148AbaCTJ7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 05:59:03 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:51059 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751449AbaCTJ7B (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2014 05:59:01 -0400
X-AuditID: 12074413-f79076d000002d17-d8-532abbe47b2f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 97.01.11543.4EBBA235; Thu, 20 Mar 2014 05:59:00 -0400 (EDT)
Received: from [192.168.69.148] (p5B15629D.dip0.t-ipconnect.de [91.21.98.157])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2K9ww4C003491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 20 Mar 2014 05:58:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1395279167-20354-1-git-send-email-g3orge.app@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqPtkt1awQd89WYvGAwfZLLqudDNZ
	NPReYXZg9tg56y67x8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGd8uWBRcFGxYtrMmewNjK8k
	uxg5OSQETCQu3djBAmGLSVy4t56ti5GLQ0jgMqPE7H3PmCGcc0wSWw+AOJwcvALaEk3vjzGC
	2CwCqhKvD15nB7HZBHQlFvU0M4HYogLBEqsvP2CBqBeUODnzCZgtIqAnsXjha7BeZgEtiXUt
	vWwgtrBAlMTCD7/BbCEBF4mOay+A6jk4OAVcJeY/1AcxJQTEJXoagyA6dSTe9T1ghrDlJba/
	ncM8gVFwFpJls5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrrlebmaJXmpK6SZG
	SDgL72DcdVLuEKMAB6MSD2/ALs1gIdbEsuLK3EOMkhxMSqK82ru0goX4kvJTKjMSizPii0pz
	UosPMUpwMCuJ8Fq7A+V4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8
	f3YCNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDoje+GBi/ICkeoL0SIDfxFhck
	5gJFIVpPMepybNi2ppFJiCUvPy9VSpzXCaRIAKQoozQPbgUseb1iFAf6WJhXCqSKB5j44Ca9
	AlrCBLSEfyrYkpJEhJRUA+N0298bfW7H7Bc3vH1lkekk4V23hAJ13z0zX8BwT6TV60eB1q9s
	g+/LrOo2PXNj5ChfEl6qP53t++UOvhz79KwFG9xdy+o7l249sF/8curljUuiC+o3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244528>

Hello and welcome.  See the comments inline.

On 03/20/2014 02:32 AM, George Papanikolaou wrote:
> Hi fellows,
> I'm planning on applying on GSOC 2014...
> 
> I tried my luck with that kinda weird microproject about inefficiencies,
> and I think I've discovered some.
> 
> (also on a totally different mood, there are some warning about empty format
> strings during compilation that could easily be silenced with some #pragma
> calls on "-Wformat-zero-length". Is there a way you're not adding this?)

The main reason is probably that #pragmas are compiler-specific.  It is
undesirable to clutter up the source code with ugly #pragmas that only
benefit people using gcc.

I think that most people who use gcc compile with
-Wno-format-zero-length.  FWIW, the options that I use are

    O = 2
    CFLAGS = -g -O$(O) -Wall -Werror -Wdeclaration-after-statement
-Wno-format-zero-length -Wno-format-security $(EXTRA_CFLAGS)

, which you can put in your config.mak.

> The empty buffers check could happen at the beggining.

s/beggining/beginning/

> Leading whitespace check was unnecessary.
> Some style changes
> 
> Thanks.
> ---

Please pay attention to how patches have to be formatted:

The subject of the email and everything above the "---" line is used as
the commit's log message.  This should only include information that
belongs in the Git project's permanent history, not incidental
information like the fact that you are applying for GSoC.

The commit message *should* include an explanation of *why* you are
making a change, any tradeoffs that might be involved, etc.

The commit message also *must* include a Signed-off-by line.

Other discussion, not intended for the commit message, should be placed
directly *under* the "---" line.

>  builtin/apply.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/builtin/apply.c b/builtin/apply.c
> index b0d0986..df2435f 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -294,20 +294,16 @@ static int fuzzy_matchlines(const char *s1, size_t n1,
>  	const char *last2 = s2 + n2 - 1;
>  	int result = 0;
>  
> +	/* early return if both lines are empty */
> +	if ((s1 > last1) && (s2 > last2))
> +		return 1;
> +

Why is this an improvement?  Do you expect this function to be called
often for empty lines (as opposed, for example, to lines consisting
solely of whitespace characters)?

>  	/* ignore line endings */
>  	while ((*last1 == '\r') || (*last1 == '\n'))
>  		last1--;
>  	while ((*last2 == '\r') || (*last2 == '\n'))
>  		last2--;
>  
> -	/* skip leading whitespace */
> -	while (isspace(*s1) && (s1 <= last1))
> -		s1++;
> -	while (isspace(*s2) && (s2 <= last2))
> -		s2++;
> -	/* early return if both lines are empty */
> -	if ((s1 > last1) && (s2 > last2))
> -		return 1;
>  	while (!result) {
>  		result = *s1++ - *s2++;
>  		/*
> @@ -315,18 +311,15 @@ static int fuzzy_matchlines(const char *s1, size_t n1,
>  		 * both buffers because we don't want "a b" to match
>  		 * "ab"
>  		 */
> -		if (isspace(*s1) && isspace(*s2)) {
> -			while (isspace(*s1) && s1 <= last1)
> -				s1++;
> -			while (isspace(*s2) && s2 <= last2)
> -				s2++;
> -		}
> +		while (isspace(*s1) && s1 <= last1)
> +			s1++;
> +		while (isspace(*s2) && s2 <= last2)
> +			s2++;

The comment just above this change gives a justification for putting an
"if" statement surrounding the "while" statements.  Do you think the
comment's argument is incorrect?  If so, please explain why, and remove
or change the comment.

>  		/*
>  		 * If we reached the end on one side only,
>  		 * lines don't match
>  		 */
> -		if (
> -		    ((s2 > last2) && (s1 <= last1)) ||
> +		if (((s2 > last2) && (s1 <= last1)) ||

This reformatting doesn't have anything to do with the rest of your
patch.  If it were important enough to make this change, then it should
be submitted as a separate patch.  But it is probably not important
enough, and is only code churn, so it should probably be omitted entirely.

>  		    ((s1 > last1) && (s2 <= last2)))
>  			return 0;
>  		if ((s1 > last1) && (s2 > last2))
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
