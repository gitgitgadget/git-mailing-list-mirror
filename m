From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Disallow '\' in ref names
Date: Fri, 08 May 2009 09:54:57 +0200
Message-ID: <4A03E551.8080904@drmicha.warpmail.net>
References: <1241760757-26068-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, spearce@spearce.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri May 08 09:55:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2KvP-0007JZ-BS
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 09:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104AbZEHHzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 03:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757220AbZEHHzF
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 03:55:05 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:48874 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752422AbZEHHzE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2009 03:55:04 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 0B510342066;
	Fri,  8 May 2009 03:55:05 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 08 May 2009 03:55:05 -0400
X-Sasl-enc: aS8Kl7sUmqKn5g5dpcM/AwmyAIjrOwA5nCaY+R/cENLP 1241769304
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2C67BD5F7;
	Fri,  8 May 2009 03:55:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090506 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <1241760757-26068-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118580>

Robin Rosenberg venit, vidit, dixit 08.05.2009 07:32:
> This is asking for trouble since '\' is a directory separator in
> Windows and thus may produce unpredictable results.
> 
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  Documentation/git-check-ref-format.txt |    2 ++
>  refs.c                                 |    3 ++-
>  2 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
> index c1ce268..4884520 100644
> --- a/Documentation/git-check-ref-format.txt
> +++ b/Documentation/git-check-ref-format.txt
> @@ -38,6 +38,8 @@ imposes the following rules on how references are named:
>  
>  . They cannot contain a sequence `@{`.
>  
> +- They cannot contain a `\\`

Minor nit from the doc watch dog:

+. They cannot contain a `\\`.

> +
>  These rules make it easy for shell script based tools to parse
>  reference names, pathname expansion by the shell when a reference name is used
>  unquoted (by mistake), and also avoids ambiguities in certain
> diff --git a/refs.c b/refs.c
> index e65a3b4..fc33bc6 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -682,12 +682,13 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
>   * - it has ASCII control character, "~", "^", ":" or SP, anywhere, or
>   * - it ends with a "/".
>   * - it ends with ".lock"
> + * - it contains a "\" (backslash)
>   */
>  
>  static inline int bad_ref_char(int ch)
>  {
>  	if (((unsigned) ch) <= ' ' ||
> -	    ch == '~' || ch == '^' || ch == ':')
> +	    ch == '~' || ch == '^' || ch == ':' || ch == '\\')
>  		return 1;
>  	/* 2.13 Pattern Matching Notation */
>  	if (ch == '?' || ch == '[') /* Unsupported */
