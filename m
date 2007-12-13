From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Teach git-gui to split hunks
Date: Thu, 13 Dec 2007 10:41:32 +0100
Message-ID: <4760FE4C.9010806@viscovery.net>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com>	<31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com>	<e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com>	<402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com>	<31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com>	<20071212041002.GN14735@spearce.org>	<31e9dd080712112113u44b30c62ja012951fba958c5d@mail.gmail.com>	<20071212052329.GR14735@spearce.org>	<31e9dd080712120702k36a959cfh3e2a5c5fb076d922@mail.gmail.com>	<Pine.LNX.4.64.0712121814260.27959@racer.site>	<31e9dd080712121050i45981ed5u845b71f0e73aa8e2@mail.gmail.com>	<Pine.LNX.4.64.0712121931050.27959@racer.site> <7vhcin3rv4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jason Sewall <jasonsewall@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, David <davvid@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 10:42:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2kZs-0007tO-Mn
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 10:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354AbXLMJli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 04:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753809AbXLMJli
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 04:41:38 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:18473 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364AbXLMJlh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 04:41:37 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J2kZl-0005or-Al; Thu, 13 Dec 2007 10:41:53 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 569E569F; Thu, 13 Dec 2007 10:41:33 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vhcin3rv4.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68138>

Junio C Hamano schrieb:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> For this to work, apply has to be called with --unidiff-zero, since
>> the new hunks can start or stop with a "-" or "+" line.
> 
> You do not have to do "unidiff zero".  Suppose you have this hunk you
> need to split.
> 
> diff --git a/read-cache.c b/read-cache.c
> index 7db5588..4d12073 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -12,8 +12,8 @@
>  /* Index extensions.
>   *
>   * The first letter should be 'A'..'Z' for extensions that are not
> - * necessary for a correct operation (i.e. optimization data).
> - * When new extensions are added that _needs_ to be understood in
> + * necessary for a correct operation (that is, optimization data).
> + * When new extensions are added that needs to be understood in
>   * order to correctly interpret the index file, pick character that
>   * is outside the range, to cause the reader to abort.
>   */
...
> That is, , if you want to do finer grained hunk splitting than what "git
> add -p" lets you do, you do _not_ let user specify "I want to split the
> hunk into two, before this point and after this point".  Instead, let
> the user pick zero or more '-' line and zero or more '+' line, and
> adjust the context around it.  An unpicked '-' line becomes the common
> context, and an unpicked '+' line disappears.  After that, you recount
> the diff.  That way, you do not have to do any "unidiff zero" cop-out.

In this case I would expect two adjacent hunks: one that covers the selected
changes, another one with the remaining changes, but each against the original:

@@ -12,7 +12,7 @@
 /* Index extensions.
  *
  * The first letter should be 'A'..'Z' for extensions that are not
- * necessary for a correct operation (i.e. optimization data).
+ * necessary for a correct operation (that is, optimization data).
  * When new extensions are added that _needs_ to be understood in
  * order to correctly interpret the index file, pick character that
  * is outside the range, to cause the reader to abort.
@@ -13,7 +13,7 @@
  *
  * The first letter should be 'A'..'Z' for extensions that are not
  * necessary for a correct operation (i.e. optimization data).
- * When new extensions are added that _needs_ to be understood in
+ * When new extensions are added that needs to be understood in
  * order to correctly interpret the index file, pick character that
  * is outside the range, to cause the reader to abort.
  */

Then I can stage either one. After that operation, git-gui refreshes the
patch display. This is now the time where the hunk that was not staged
should be updated to reflect the correct diff against the staged hunk.

-- Hannes
