From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/18] revert: Don't check lone argument in get_encoding
Date: Wed, 27 Jul 2011 06:32:05 +0200
Message-ID: <20110727043205.GC18470@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 06:32:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlvnN-0005rz-1C
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 06:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389Ab1G0EcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 00:32:19 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:54480 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab1G0EcR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 00:32:17 -0400
Received: by eye22 with SMTP id 22so1561408eye.2
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 21:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kgQfiYYOcZi0BkQS952QvKrc8CNlL0asIzEysy0rBxQ=;
        b=OqSVk1NAznciO/s+CX74GsfiCKulW+WUQV6O/M+96DwiDCwo0i+Q4paRe7t8RzzsPr
         38IrTHPRlErC2mH1sB0HH+pIZJ/VO6z7G3MDB1DTnfDiPDfa3n1VwZZ4TjuOffRAabJC
         T0xEqYkNYDv6uIC11UAd/I2me9IqBR+JypW0k=
Received: by 10.14.3.160 with SMTP id 32mr2721425eeh.41.1311741135085;
        Tue, 26 Jul 2011 21:32:15 -0700 (PDT)
Received: from elie (adsl-165-157-240.teol.net [109.165.157.240])
        by mx.google.com with ESMTPS id b13sm813605een.31.2011.07.26.21.32.12
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 21:32:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311736755-24205-5-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177925>

Ramkumar Ramachandra wrote:

> The get_encoding function has only one callsite, and its caller makes
> sure that a NULL argument isn't passed.  Remove a string marked for
> translation that will never be shown by not unnecessarily
> double-checking the argument.

The above just doesn't parse for me.  Isn't the truth something like:

"The only place get_encoding uses the 'commit' global is when writing
 an error message explaining that its text was NULL.  Since the only
 caller to get_encoding already ensures that the text is not NULL, we
 can remove this check, with two beneficial consequences:

 1) the function doesn't use the "commit" global any more, bringing
    us closer to removing that global altogether;
 2) translators no longer need to localize this error message that
    would never be shown.

 In a sense, after this patch there is an implied assert() replacing
 the "if ... die()" from before, since the function dereferences the
 pointer to commit object text and would segfault immediately if some
 future caller starts passing in NULL."

Please forgive the unclear phrasing; it is getting close to the time
I should sleep.  Hopefully the intent is clear (i.e., please, imagine
that the reader does not already know what is going on and help him).

Sorry to nitpick so.  The patch proper is obviously good.
