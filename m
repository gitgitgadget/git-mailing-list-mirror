From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] sh updates for 2.6.25
Date: Tue, 15 Apr 2008 11:41:52 -0700
Message-ID: <7vr6d7x8nj.fsf@gitster.siamese.dyndns.org>
References: <20080415172333.GA29489@linux-sh.org>
 <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-sh-owner@vger.kernel.org Tue Apr 15 20:45:06 2008
connect(): Connection refused
Return-path: <linux-sh-owner@vger.kernel.org>
Envelope-to: glps-linuxsh-dev@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlq7H-0008Ef-BA
	for glps-linuxsh-dev@gmane.org; Tue, 15 Apr 2008 20:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbYDOSmK (ORCPT <rfc822;glps-linuxsh-dev@m.gmane.org>);
	Tue, 15 Apr 2008 14:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752513AbYDOSmJ
	(ORCPT <rfc822;linux-sh-outgoing>); Tue, 15 Apr 2008 14:42:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64996 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbYDOSmI (ORCPT
	<rfc822;linux-sh@vger.kernel.org>); Tue, 15 Apr 2008 14:42:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6937624C2;
	Tue, 15 Apr 2008 14:42:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9132224C1; Tue, 15 Apr 2008 14:42:01 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org>
 (Linus Torvalds's message of "Tue, 15 Apr 2008 11:01:36 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: linux-sh-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79619>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Junio? Something like this for the merge summary code? (It also turns an 
> empty commit message with just whitespace in the commit message into the 
> SHA1 hex string)

Yeah, your patch makes sense, but it also makes me wonder if we should fix
the code in pretty.c::parse_commit_header() that grabs the "subject" line,
and use format_commit_message() with "%s" format here.  Interested people
then can enhance it to take custom format string.

> 		Linus
>
> ----
>  builtin-fmt-merge-msg.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
> index ebb3f37..7077d52 100644
> --- a/builtin-fmt-merge-msg.c
> +++ b/builtin-fmt-merge-msg.c
> @@ -201,6 +201,15 @@ static void shortlog(const char *name, unsigned char *sha1,
>  			continue;
>  
>  		bol = strstr(commit->buffer, "\n\n");
> +		if (bol) {
> +			unsigned char c;
> +			do {
> +				c = *++bol;
> +			} while (isspace(c));
> +			if (!c)
> +				bol = NULL;
> +		}
> +
>  		if (!bol) {
>  			append_to_list(&subjects, xstrdup(sha1_to_hex(
>  							commit->object.sha1)),
> @@ -208,7 +217,6 @@ static void shortlog(const char *name, unsigned char *sha1,
>  			continue;
>  		}
>  
> -		bol += 2;
>  		eol = strchr(bol, '\n');
>  		if (eol) {
>  			oneline = xmemdupz(bol, eol - bol);
