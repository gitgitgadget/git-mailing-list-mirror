From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Honor git-reset -q by silencing progress updates.
Date: Sat, 31 May 2008 15:43:59 -0700
Message-ID: <7vej7idrgw.fsf@gitster.siamese.dyndns.org>
References: <32206B67-D97A-459E-BA48-D3B343D775F3@37signals.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jamis Buck <jamis@37signals.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 00:45:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Zow-0004HH-Sc
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 00:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742AbYEaWoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 18:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754681AbYEaWoO
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 18:44:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36899 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906AbYEaWoN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 18:44:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 95BD334CD;
	Sat, 31 May 2008 18:44:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DD53A34CC; Sat, 31 May 2008 18:44:06 -0400 (EDT)
In-Reply-To: <32206B67-D97A-459E-BA48-D3B343D775F3@37signals.com> (Jamis
 Buck's message of "Sat, 31 May 2008 15:41:54 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 15DC3C42-2F63-11DD-A27A-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83413>

Jamis Buck <jamis@37signals.com> writes:

> --Apple-Mail-10--112802933
> Content-Type: text/plain;
> 	charset=US-ASCII;
> 	format=flowed;
> 	delsp=yes
> Content-Transfer-Encoding: 7bit

Please do not do unnecessary S/MIME nor format=flawed.  It makes reviewing
and application of the patches inconvenient.

>
> When running git-reset in a non-interactive setting, the -q switch
> works for everything except the progress updates. This patch attempts
> to extend the application of -q to suppress that, too.
> ---
> builtin-reset.c |    9 +++++----
> 1 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/builtin-reset.c b/builtin-reset.c
> index e32ddd9..3810f6d 100644
> --- a/builtin-reset.c
> +++ b/builtin-reset.c
> @@ -49,13 +49,14 @@ static inline int is_merge(void)
> 	return !access(git_path("MERGE_HEAD"), F_OK);
> }
>
> -static int reset_index_file(const unsigned char *sha1, int  
> is_hard_reset)
> +static int reset_index_file(const unsigned char *sha1, int  
> is_hard_reset, int quiet)
> {
