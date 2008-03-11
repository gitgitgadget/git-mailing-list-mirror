From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] launch_editor(): allow spaces in the filename
Date: Mon, 10 Mar 2008 17:15:18 -0700
Message-ID: <7v1w6ii0a1.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803102140280.3975@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zeng.Shixin@gmail.com, theevancarroll@gmail.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 01:16:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYsAJ-0003vF-B7
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 01:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbYCKAPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 20:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbYCKAPa
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 20:15:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbYCKAP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 20:15:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1A8B720B8;
	Mon, 10 Mar 2008 20:15:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 58EF620B4; Mon, 10 Mar 2008 20:15:20 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0803102140280.3975@racer.site> (Johannes
 Schindelin's message of "Mon, 10 Mar 2008 21:42:47 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76774>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> For some reason, the construct
>
> 	sh -c "$0 \"$@\"" <editor> <file>
>
> does not pick up quotes in <editor> as expected.  So replace $0 with
> <editor>.
>
> This fixes
>
> 	git config core.editor "c:/Program Files/What/Ever.exe"

Ah, I misread your patch.  The above example needs to be fixed as
discussed, but what the patch does to builtin-tag.c is fine.

> diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
> index c1cec55..5395b74 100755
> --- a/t/t7005-editor.sh
> +++ b/t/t7005-editor.sh
> @@ -89,6 +89,34 @@ do
>  	'
>  done
>  
> +test_expect_success 'editor with a space' '
> +
> +	if echo "echo space > \"\$1\"" > "e space.sh"
> +	then
> +		chmod a+x "e space.sh" &&
> +		GIT_EDITOR="./e\ space.sh" \
> +			git --exec-path=. commit --amend &&

Why do you need --exec-path=. to tell the newly built git to find its
subcommands from t/trash directory, when you give an explicit instruction
to find GIT_EDITOR in "./"?
