From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 08/12] fast-import: MinGW does not have getppid().  So do
 not print it.
Date: Wed, 02 Jul 2008 02:20:02 -0700
Message-ID: <7vzlp0bq2l.fsf@gitster.siamese.dyndns.org>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de>
 <1214987532-23640-1-git-send-email-prohaska@zib.de>
 <1214987532-23640-2-git-send-email-prohaska@zib.de>
 <1214987532-23640-3-git-send-email-prohaska@zib.de>
 <1214987532-23640-4-git-send-email-prohaska@zib.de>
 <1214987532-23640-5-git-send-email-prohaska@zib.de>
 <1214987532-23640-6-git-send-email-prohaska@zib.de>
 <1214987532-23640-7-git-send-email-prohaska@zib.de>
 <1214987532-23640-8-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	msysgit@googlegroups.com,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: prohaska@zib.de
X-From: git-owner@vger.kernel.org Wed Jul 02 11:21:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDyWW-0000z0-FZ
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 11:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbYGBJUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 05:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752910AbYGBJUP
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 05:20:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57909 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbYGBJUN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 05:20:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4ABE828A0D;
	Wed,  2 Jul 2008 05:20:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4889928A0C; Wed,  2 Jul 2008 05:20:05 -0400 (EDT)
In-Reply-To: <1214987532-23640-8-git-send-email-prohaska@zib.de> (Steffen
 Prohaska's message of "Wed, 2 Jul 2008 10:32:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 12CE8EE2-4818-11DD-B889-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87123>

Steffen Prohaska <prohaska@zib.de> writes:

> diff --git a/fast-import.c b/fast-import.c
> index e72b286..271b93c 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -391,7 +391,9 @@ static void write_crash_report(const char *err)
>  
>  	fprintf(rpt, "fast-import crash report:\n");
>  	fprintf(rpt, "    fast-import process: %d\n", getpid());
> +#ifndef __MINGW32__
>  	fprintf(rpt, "    parent process     : %d\n", getppid());
> +#endif
>  	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, DATE_LOCAL));
>  	fputc('\n', rpt);
>  
> -- 
> 1.5.6.1.255.g32571

It does not matter too much for this part that writes crash report, but
keeping the file format the same across platforms will make it easier for
tools to read output, so as a general principle, I think this is a
suboptimal solution to the issue.  How about throwing something like this
in MinGW specific header files?

        #define getppid() 0
