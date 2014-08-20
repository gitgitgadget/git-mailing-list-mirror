From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] imap-send.c: imap_folder -> imap_server_conf.folder
Date: Wed, 20 Aug 2014 12:16:34 -0700
Message-ID: <xmqqvbpnt1il.fsf@gitster.dls.corp.google.com>
References: <53F3C12F.3020606@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Wed Aug 20 21:16:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKBNJ-0001fB-Pi
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 21:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbaHTTQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 15:16:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58301 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734AbaHTTQo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 15:16:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C978931FA2;
	Wed, 20 Aug 2014 15:16:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RBrfPoMCr4C+bdDnDfcaGvzwCP4=; b=sZEU4e
	//vGdbwgbwcnylaRohMqynrlWkT0wLNiZjPhdpc1+oTjEErtl+ovvG8krfk9yfEh
	P8QrRxD3YDTWFRIXBfDKHzWVh0e+4xx/Zfi7kLw+UE2R15iRkpzEgS6wfLAhwVSs
	Rd0qLIaMMkzgpzhP/Qr9ESWb4UOZyj1zRlEwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mnnkgAo80kCK3+16ByHXOBLtznX5Uju5
	PDVxS3FiehUJIGyOhg48OIDbyDBnlOllUs2da8G/onPrpc7RZU1pOvh70oDofZRL
	wzg8vj5EFXIzGYU8jobNnyBGd+wKeUkAylDCp6ETyVDBQKmY3oacx1wN3U8t9ZOn
	kxZuOtZN5Ts=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BFA7531FA0;
	Wed, 20 Aug 2014 15:16:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2E4C331F94;
	Wed, 20 Aug 2014 15:16:36 -0400 (EDT)
In-Reply-To: <53F3C12F.3020606@raz.or.at> (Bernhard Reiter's message of "Tue,
	19 Aug 2014 23:27:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 80FD9EFE-289E-11E4-9A01-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255581>

Bernhard Reiter <ockham@raz.or.at> writes:

> Rename the imap_folder variable to folder and make it a member
> of struct imap_server_conf.
>
> Signed-off-by: Bernhard Reiter <ockham@raz.or.at>
> ---
> As discussed in
> http://www.mail-archive.com/git@vger.kernel.org/msg57019.html
>
> Bernhard
>
>  imap-send.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index fb01a9c..05a02b5 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -69,6 +69,7 @@ struct imap_server_conf {
>  	char *tunnel;
>  	char *host;
>  	int port;
> +	char *folder;
>  	char *user;
>  	char *pass;
>  	int use_ssl;
> @@ -82,6 +83,7 @@ static struct imap_server_conf server = {
>  	NULL,	/* tunnel */
>  	NULL,	/* host */
>  	0,	/* port */
> +	NULL,	/* folder */
>  	NULL,	/* user */
>  	NULL,	/* pass */
>  	0,   	/* use_ssl */
> @@ -1323,8 +1325,6 @@ static int split_msg(struct strbuf *all_msgs,
> struct strbuf *msg, int *ofs)
>  	return 1;
>  }
>  -static char *imap_folder;
> -
>  static int git_imap_config(const char *key, const char *val, void *cb)
>  {
>  	if (!skip_prefix(key, "imap.", &key))

The patch is corrupt; even though it claims to be text/plain, it
smells like some sort of text/flawed, but it is even worse.  Even
the line counts on @@ lines do not match what is in the patch text.

I wiggled it in so there is no need to resend, but please double
check your outgoing mail toolchain (sending the patch first to
yourself in exactly the same way as you would later send it to the
list and checking what comes out would be one good way to check).

Thanks.

> @@ -1339,7 +1339,7 @@ static int git_imap_config(const char *key, const
> char *val, void *cb)
>  		return config_error_nonbool(key);
>   	if (!strcmp("folder", key)) {
> -		imap_folder = xstrdup(val);
> +		server.folder = xstrdup(val);
>  	} else if (!strcmp("host", key)) {
>  		if (starts_with(val, "imap:"))
>  			val += 5;
> @@ -1387,7 +1387,7 @@ int main(int argc, char **argv)
>  	if (!server.port)
>  		server.port = server.use_ssl ? 993 : 143;
>  -	if (!imap_folder) {
> +	if (!server.folder) {
>  		fprintf(stderr, "no imap store specified\n");
>  		return 1;
>  	}
> @@ -1424,7 +1424,7 @@ int main(int argc, char **argv)
>  	}
>   	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" :
> "");
> -	ctx->name = imap_folder;
> +	ctx->name = server.folder;
>  	while (1) {
>  		unsigned percent = n * 100 / total;
>  -- 2.1.0.3.g63c96dd
