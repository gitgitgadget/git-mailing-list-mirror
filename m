From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 2/3] git-core: Support retrieving passwords with GIT_ASKPASS
Date: Tue, 02 Mar 2010 13:17:22 +0100
Message-ID: <4B8D01D2.9060406@viscovery.net>
References: <1267530657-4848-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 02 13:17:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmR2f-0004B8-Pl
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 13:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818Ab0CBMR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 07:17:28 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:58187 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615Ab0CBMR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 07:17:27 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NmR2R-0002pz-KI; Tue, 02 Mar 2010 13:17:23 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4D5271660F;
	Tue,  2 Mar 2010 13:17:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1267530657-4848-1-git-send-email-lznuaa@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141392>

Frank Li schrieb:
> +	memset(&pass, 0, sizeof(pass));
> +	pass.argv = args;
> +	pass.out = -1;
> +	pass.use_shell = 1;

I thought that the conclusion was to follow how openssh treats
SSH_ASKPASS, and it *does not* treat it as a command with arguments. Do
not set use_shell.

> +	if (start_command(&pass)) {
> +		error("could not run %s\n", askpass);

As I said, this error message is redundant. No big deal, though.

> +		exit(1);
> +	}
> +
> +	strbuf_read(&buffer, pass.out, 20);
> +	close(pass.out);
> +	finish_command(&pass);

You must check for errors here as well. No error message is needed, either.

> +
> +	for (i = 0; i < buffer.len; i++)
> +		if (buffer.buf[i] == '\n' || buffer.buf[i] == '\r') {
> +			buffer.buf[i] = '\0';
> +			buffer.len = i;
> +		}

I think you can shorten this loop to

	strbuf_setlen(&buffer, strcspn(buffer.buf, "\r\n"));

-- Hannes
