From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fix obscure perl message when encryption=tls and smtp
	cannot connect.
Date: Fri, 25 Sep 2009 14:34:40 -0700
Message-ID: <20090925213440.GX14660@spearce.org>
References: <1253914213-22274-1-git-send-email-iler.ml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: iler.ml@gmail.com
X-From: git-owner@vger.kernel.org Fri Sep 25 23:34:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrIRD-0006O3-Cl
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 23:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbZIYVeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 17:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbZIYVeg
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 17:34:36 -0400
Received: from george.spearce.org ([209.20.77.23]:33895 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbZIYVeg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 17:34:36 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3CC6E38151; Fri, 25 Sep 2009 21:34:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1253914213-22274-1-git-send-email-iler.ml@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129120>

iler.ml@gmail.com wrote:
> When encryption=tls and smtp cannot connect, git-send-email prints following perl error:
> 
> Can't call method "command" on an undefined value at /usr/local/libexec/git-core/git-send-email line 927.
> 
> (ithis is when smtp host orport is misspelled, or network is down, and encryption is tls).
> We expect some familiar "Cannot connect to SERVER:PORT" message.
> Fix it to print normal "smtp can't connect" diagnostics.

Thanks, looks reasonable.  Signed-off-by line, per the Developer's
Certificate of Origin in Documentation/SubmittingPatches ?
 
> --- /usr/local/libexec/git-core/git-send-email.000	2009-09-26 00:10:01.000000000 +0300
> +++ /usr/local/libexec/git-core/git-send-email	2009-09-26 00:11:39.000000000 +0300
> @@ -922,7 +922,7 @@
>  			$smtp ||= Net::SMTP->new((defined $smtp_server_port)
>  						 ? "$smtp_server:$smtp_server_port"
>  						 : $smtp_server);
> -			if ($smtp_encryption eq 'tls') {
> +			if ($smtp_encryption eq 'tls' && $smtp) {
>  				require Net::SMTP::SSL;
>  				$smtp->command('STARTTLS');
>  				$smtp->response();

-- 
Shawn.
