From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Do not decode url protocol.
Date: Tue, 22 Jun 2010 13:34:42 +0200
Message-ID: <vpqiq5bb8rx.fsf@bauges.imag.fr>
References: <AANLkTinK99krA-16qUO8nWYbZ7w6o632jLTTW5WyaKOk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Tue Jun 22 13:35:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR1kn-0008WT-Ey
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 13:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130Ab0FVLew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 07:34:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54386 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502Ab0FVLev (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 07:34:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5MBQLld028188
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 22 Jun 2010 13:26:23 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OR1kY-0004Nm-Ps; Tue, 22 Jun 2010 13:34:42 +0200
In-Reply-To: <AANLkTinK99krA-16qUO8nWYbZ7w6o632jLTTW5WyaKOk@mail.gmail.com> (Pascal Obry's message of "Tue\, 22 Jun 2010 11\:25\:50 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 22 Jun 2010 13:26:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5MBQLld028188
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1277810787.10704@hN7LKLmlJ0LCnS+Add4AGg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149477>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Otherwise, the patch sounds good.

Humm, looking a bit closer ...

Pascal Obry <pascal@obry.net> writes:

> @@ -70,9 +70,18 @@ static int url_decode_char(const char *q)
>  static char *url_decode_internal(const char **query, const char *stop_at)
>  {

This function is called from multiple places :


char *url_decode(const char *url)
{
	return url_decode_internal(&url, NULL);
}

char *url_decode_parameter_name(const char **query)
{
	return url_decode_internal(query, "&=");
}

char *url_decode_parameter_value(const char **query)
{
	return url_decode_internal(query, "&");
}

I don't think you want to avoid escaping until the first slash in
url_decode_parameter_name and url_decode_parameter_value. I think you
want to patch url_decode, not url_decode_internal.

> +	/* Skip protocol. */
> +	first_slash = strchr(*query, '/');

Are you sure the URL contains a / at this point? That would be a user
error if it doesn't, but has this been validated (with a clean error
message if needed) earlier in the code?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
