From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 07/12] Fixed text file auto-detection: treat EOF
 character 032 at the end of file as printable
Date: Wed, 02 Jul 2008 02:16:18 -0700
Message-ID: <7vabh0d4t9.fsf@gitster.siamese.dyndns.org>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de>
 <1214987532-23640-1-git-send-email-prohaska@zib.de>
 <1214987532-23640-2-git-send-email-prohaska@zib.de>
 <1214987532-23640-3-git-send-email-prohaska@zib.de>
 <1214987532-23640-4-git-send-email-prohaska@zib.de>
 <1214987532-23640-5-git-send-email-prohaska@zib.de>
 <1214987532-23640-6-git-send-email-prohaska@zib.de>
 <1214987532-23640-7-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	msysgit@googlegroups.com, Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
To: prohaska@zib.de
X-From: git-owner@vger.kernel.org Wed Jul 02 11:17:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDyT9-00087g-LK
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 11:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbYGBJQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 05:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbYGBJQi
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 05:16:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbYGBJQh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 05:16:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 37E1A289C7;
	Wed,  2 Jul 2008 05:16:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DA697289C6; Wed,  2 Jul 2008 05:16:29 -0400 (EDT)
In-Reply-To: <1214987532-23640-7-git-send-email-prohaska@zib.de> (Steffen
 Prohaska's message of "Wed, 2 Jul 2008 10:32:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 91FEFAD6-4817-11DD-856A-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87122>

Steffen Prohaska <prohaska@zib.de> writes:

> From: Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
>
> Signed-off-by: Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---
>  convert.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/convert.c b/convert.c
> index 1c66844..f24ac25 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -61,6 +61,10 @@ static void gather_stats(const char *buf, unsigned long size, struct text_stat *
>  		else
>  			stats->printable++;
>  	}
> +
> +	// If file ends with EOF then don't count this EOF as non-printable
> +	if ( size >= 1 && buf[size-1] == '\032' )
> +		stats->nonprintable--;

Style.

I debated for 5 seconds with myself if this should be inside #ifdef, but
doing this everywhere would give us reproducibility --- otherwise the
resulting project won't be cross platform, so I think the intention of
this change is good.
