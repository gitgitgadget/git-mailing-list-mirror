From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] Run global hooks from the directory at hooks.dir
Date: Mon, 08 Nov 2010 14:29:27 +0100
Message-ID: <4CD7FB37.4050107@viscovery.net>
References: <1289219520-37435-1-git-send-email-bricollins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, s-beyer@gmx.net
To: Brian Collins <bricollins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 14:29:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFRn2-0007G5-GQ
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 14:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486Ab0KHN3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 08:29:32 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:31532 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab0KHN3c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 08:29:32 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PFRmq-00040C-N2; Mon, 08 Nov 2010 14:29:29 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B23E41660F;
	Mon,  8 Nov 2010 14:29:27 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <1289219520-37435-1-git-send-email-bricollins@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160936>

Am 11/8/2010 13:32, schrieb Brian Collins:
> Run global hooks in the directory specified by the config variable
> hooks.dir before every attempt at running a local hook. If the
> global hook fails, the local hook will not run. If the global hook is
> absent, the local hook runs normally. This is useful because it means
> you can have scripts that run as hooks for multiple repositories, for
> example coding style enforcement for an entire organization, or
> system-wide commit analytics.
> 
> Signed-off-by: Brian Collins <bricollins@gmail.com>
> ---
> 
> The possibility of adding this feature was previously discussed here:
> http://marc.info/?l=git&m=127808782807807&w=2

I'm not in favor of this change, as a number of alternatives were
suggested in the thread you cite (Gmane:
http://thread.gmane.org/gmane.comp.version-control.git/150141).

A few hints, just in case you deploy this code:

> +	if ((global_path == NULL || access(global_path, X_OK) > 0) &&
> +			access(local_path, X_OK) > 0)
> +		return 0;

access(2) returns zero on success, negative on failure.

> +	if (global_path != NULL)
> +		ret = run_hook_file(global_path, index_file, argv) ||
> +			run_hook_file(local_path, index_file, argv);

What is the value of ret if the hook in global_path fails? Is it the exit
code, or is it 1? What should it be?

-- Hannes
