From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 04/12] Avoid calling signal(SIGPIPE, ..) for MinGW builds.
Date: Wed, 02 Jul 2008 02:22:01 -0700
Message-ID: <7vod5gbpza.fsf@gitster.siamese.dyndns.org>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de>
 <1214987532-23640-1-git-send-email-prohaska@zib.de>
 <1214987532-23640-2-git-send-email-prohaska@zib.de>
 <1214987532-23640-3-git-send-email-prohaska@zib.de>
 <1214987532-23640-4-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	msysgit@googlegroups.com,
	Marius Storm-Olsen <mstormo_git@storm-olsen.com>
To: prohaska@zib.de
X-From: git-owner@vger.kernel.org Wed Jul 02 11:23:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDyYZ-0001nF-C5
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 11:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbYGBJWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 05:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752943AbYGBJWW
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 05:22:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58253 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbYGBJWW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 05:22:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 97FEB28A2B;
	Wed,  2 Jul 2008 05:22:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D076528A2A; Wed,  2 Jul 2008 05:22:09 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5E193974-4818-11DD-B889-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87125>

Steffen Prohaska <prohaska@zib.de> writes:

> From: Marius Storm-Olsen <mstormo_git@storm-olsen.com>
>
> SIGPIPE isn't supported in MinGW.

Shouldn't #ifdef be on SIGPIPE not on __MINGW32__?

> @@ -100,9 +100,11 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>  		i++;
>  	}
>  
> +#ifndef __MINGW32__
>  	/* sometimes the program was terminated because this signal
>  	 * was received in the process of writing the gpg input: */
>  	signal(SIGPIPE, SIG_IGN);
> +#endif	
