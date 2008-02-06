From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix parsing numeric color values
Date: Wed, 06 Feb 2008 01:59:26 -0800
Message-ID: <7vzluez9q9.fsf@gitster.siamese.dyndns.org>
References: <47A89E2A.9010905@kergoth.com>
	<20080205203940.1dcff0ce.tihirvon@gmail.com>
	<b6ebd0a50802051045t4949df68u7e405ea618403a31@mail.gmail.com>
	<20080205205856.76a7cd45.tihirvon@gmail.com>
	<20080205211821.e4a15194.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Chris Larson" <clarson@kergoth.com>, git@vger.kernel.org
To: Timo Hirvonen <tihirvon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 11:00:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMh4a-0003sq-Qw
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 11:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760400AbYBFJ7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 04:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760125AbYBFJ7g
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 04:59:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760079AbYBFJ7f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 04:59:35 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3034B18D5;
	Wed,  6 Feb 2008 04:59:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FF1F18D3;
	Wed,  6 Feb 2008 04:59:28 -0500 (EST)
In-Reply-To: <20080205211821.e4a15194.tihirvon@gmail.com> (Timo Hirvonen's
	message of "Tue, 5 Feb 2008 21:18:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72786>

Timo Hirvonen <tihirvon@gmail.com> writes:

> Fix bug reported by Chris Larson <clarson@kergoth.com>.  Numeric color
> only worked if it was at end of line.

Signoff?

It is much easier to read if you said that backwards:

        Numeric color only worked if it was at end of line.
        Noticed by Chris Larson <clarson@kergoth.com>.  

> @@ -17,7 +17,7 @@ static int parse_color(const char *name, int len)
>  			return i - 1;
>  	}
>  	i = strtol(name, &end, 10);
> -	if (*name && !*end && i >= -1 && i <= 255)
> +	if (*name && (!*end || isspace(*end)) && i >= -1 && i <= 255)

Hmph.  Is it the same as (end-name) == len?

Please add a test so that your fix won't be broken by others who
might later touch this code.
