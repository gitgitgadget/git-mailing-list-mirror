From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/3] rebase-i: slight internal improvements
Date: Fri, 20 Jun 2008 09:16:43 +0200
Message-ID: <485B595B.80608@viscovery.net>
References: <1213929935-15093-1-git-send-email-s-beyer@gmx.net> <1213929935-15093-2-git-send-email-s-beyer@gmx.net> <1213929935-15093-3-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jun 20 09:17:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9asR-0003fd-6y
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 09:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbYFTHQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 03:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbYFTHQq
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 03:16:46 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:33888 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbYFTHQq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 03:16:46 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K9arT-0000dT-RR; Fri, 20 Jun 2008 09:16:44 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7FC644FB; Fri, 20 Jun 2008 09:16:43 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1213929935-15093-3-git-send-email-s-beyer@gmx.net>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85599>

Stephan Beyer schrieb:
> Add commit_message function to get the commit message
> from a commit and other slight internal improvements.

If by "other slight improvements" you mean ...

>  mark_action_done () {
> -	sed -e 1q < "$TODO" >> "$DONE"
> -	sed -e 1d < "$TODO" >> "$TODO".new
> -	mv -f "$TODO".new "$TODO"
> -	count=$(grep -c '^[^#]' < "$DONE")
> -	total=$(($count+$(grep -c '^[^#]' < "$TODO")))
> +	sed -e 1q "$TODO" >>"$DONE"
> +	sed -e 1d "$TODO" >>"$TODO.new"
> +	mv -f "$TODO.new" "$TODO"
> +	count="$(grep -c '^[^#]' "$DONE")"
> +	total="$(expr "$count" + "$(grep -c '^[^#]' "$TODO")")"

... this ...

>  has_action () {
> -	grep '^[^#]' "$1" >/dev/null
> +	grep -q '^[^#]' "$1"

... and this, etc, then they are not improvements. They make the script
less portable: There are 'grep's that don't have -q, others write the file
name in front of the count, and I _think_ I have encountered 'sed's that
don't take a file name as argument.

This patch is just code churn for which you give no convincing reason in
the commit message why it is good.

-- Hannes
