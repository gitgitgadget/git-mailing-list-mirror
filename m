From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] send-email: squelch warning from Net::SMTP::SSL
Date: Fri, 5 Jul 2013 11:45:57 +0100
Message-ID: <20130705104557.GL9161@serenity.lan>
References: <1373019511-13232-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 12:46:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv3Wo-0007Ts-ML
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 12:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339Ab3GEKqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 06:46:11 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:34520 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757326Ab3GEKqH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 06:46:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id D62152363D;
	Fri,  5 Jul 2013 11:46:06 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qI5Xsibl-dET; Fri,  5 Jul 2013 11:46:06 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 2E14F236C0;
	Fri,  5 Jul 2013 11:45:59 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1373019511-13232-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229648>

On Fri, Jul 05, 2013 at 03:48:31PM +0530, Ramkumar Ramachandra wrote:
> Due to a recent change in the Net::SMTP::SSL module, send-email emits
> the following ugly warning everytime a email is sent via SSL:
> 
> *******************************************************************
>  Using the default of SSL_verify_mode of SSL_VERIFY_NONE for client
>  is deprecated! Please set SSL_verify_mode to SSL_VERIFY_PEER
>  together with SSL_ca_file|SSL_ca_path for verification.
>  If you really don't want to verify the certificate and keep the
>  connection open to Man-In-The-Middle attacks please set
>  SSL_verify_mode explicitly to SSL_VERIFY_NONE in your application.
> *******************************************************************
> 
> Fix this by explicitly specifying SSL_verify_mode => SSL_VERIFY_NONE in
> Net::SMTP::SSL->start_SSL().

I don't think this is really "fix", it's more plastering over the
problem.  As the message from OpenSSL says, specifying this means that
we're explicitly saying that we don't want to check the server
certificate which loses half of the security of SSL.

I'd rather leave this as it is (complete with the big scary error
message) and eventually fix it properly by letting the user specify the
ca_file or ca_path.  Perhaps we can even set a sensible default,
although I expect this needs to be platform-specific.
