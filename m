From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git-imap-send: use libcurl for implementation
Date: Tue, 19 Aug 2014 10:51:13 -0700
Message-ID: <xmqq1tscwepa.fsf@gitster.dls.corp.google.com>
References: <53ED2E46.5020403@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Tue Aug 19 19:51:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJnZF-0005Zr-IK
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 19:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbaHSRvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 13:51:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60249 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625AbaHSRvY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 13:51:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BE5FF2F217;
	Tue, 19 Aug 2014 13:51:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3flLukLluj5kXP9oegYbLTi9yZU=; b=Vtmzoj
	ZpQEqL7Nsa3rFJrlYV06GCzs6l7YgqTEs9I5wLCntMG+dqEEB2bhq3m8U98dYP0t
	giZjrPECiSRpIO0ShvZoJClgQb/hr7p3FXDZ5mMCS8b6SBMYVf7EUXpYaTABdV/c
	ahRAertcEByc+d5tFb7b3kTvlTPYtGuSk1GMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C8VBXamD0d9niGuiieTfqHGqvTQmvBXw
	UMv4Kcp8h+jO2+hX/1fB3/Kb9NS8l8qrIWyO/wx4BcMAPhb2n3WCFtTHgDopHe9N
	mkS204JygNXXrcQhHmeRDaajDaEcZ7GWBXeDWFjOmWKZS16DlvW+5qbR5HvWWzQL
	2yCmLkS7xQ0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B47302F216;
	Tue, 19 Aug 2014 13:51:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6DDCE2F20D;
	Tue, 19 Aug 2014 13:51:15 -0400 (EDT)
In-Reply-To: <53ED2E46.5020403@raz.or.at> (Bernhard Reiter's message of "Thu,
	14 Aug 2014 23:46:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6A60D3A8-27C9-11E4-9380-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255505>

Bernhard Reiter <ockham@raz.or.at> writes:

> Use libcurl's high-level API functions to implement git-imap-send
> instead of the previous low-level OpenSSL-based functions.
>
> Since version 7.30.0, libcurl's API has been able to communicate with
> IMAP servers. Using those high-level functions instead of the current
> ones would reduce imap-send.c by some 1200 lines of code. For now,
> the old ones are wrapped in #ifdefs, and the new functions are enabled
> by make if curl's version is >= 7.35.0, from which version on curl's
> CURLOPT_LOGIN_OPTIONS (enabling IMAP authentication) parameter has been
> available.
>
> As I don't have access to that many IMAP servers, I haven't been able to
> test the new code with a wide variety of parameter combinations. I did
> test both secure and insecure (imaps:// and imap://) connections and
> values of "PLAIN" and "LOGIN" for the authMethod.
>
> Signed-off-by: Bernhard Reiter <ockham@raz.or.at>
> ---

I think people have missed this one, partly because it was hidden as
an attachment.

>  Documentation/git-imap-send.txt |   3 +-
>  INSTALL                         |  15 +++---
>  Makefile                        |  16 +++++-
>  git.spec.in                     |   5 +-
>  imap-send.c                     | 109
> +++++++++++++++++++++++++++++++++++++---
>  5 files changed, 132 insertions(+), 16 deletions(-)

I smell a line-wrapped patch but it probably is at my receiving end,
forcing the attachment into a flattened form inside my MUA.

Nice to see git.spec.in updated; I like it when I see that the
author paid attention to details.

> diff --git a/imap-send.c b/imap-send.c
> index fb01a9c..a45570d 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -22,6 +22,10 @@
>   *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>   */
>  
> +#ifdef USE_CURL_FOR_IMAP_SEND
> +#define NO_OPENSSL
> +#endif
> +

This looks strange and stands out like a sore thumb.  Do any of our
other sources do this kind of macro tweaking inside C source before
including git-compat-util.h (or its equivalent like cache.h)?

I think what you are trying to do is to change the meaning of
NO_OPENSSL, which merely means "we do not have OpenSSL library and
do not want to link with it", locally to "we may or may not have and
use OpenSSL library elsewhere in Git, but in the code below we do
not want to use the code written to work on top of OpenSSL and
instead use libcurl".  Because of that, you define NO_OPENSSL before
including any of our headers to cause us not to include the headers,
and typedef away SSL, for example.

>  #include "cache.h"
>  #include "credential.h"
>  #include "exec_cmd.h"
> @@ -29,6 +33,9 @@
>  #ifdef NO_OPENSSL
>  typedef void *SSL;
>  #endif
> +#ifdef USE_CURL_FOR_IMAP_SEND
> +#include "http.h"
> +#endif

But does it have to be that way?  For one thing, doing it this way,
the user has to make a compilation-time choice, but if you separate
these compilation time macro into two, one for "can we even link
with and use OpenSSL?" (which is what NO_OPENSSL is about) and
another for "do we want an ability to talk to imap via libcurl?",
wouldn't it make it possible for you to switch between them at
runtime (e.g. you might want to go over the direct connection when
tunneling, while letting libcurl do the heavy lifting in
non-tunneled operation)?

> @@ -44,9 +51,7 @@ __attribute__((format (printf, 1, 2)))
>  static void imap_info(const char *, ...);
>  __attribute__((format (printf, 1, 2)))
>  static void imap_warn(const char *, ...);
> -
>  static char *next_arg(char **);
> -
>  __attribute__((format (printf, 3, 4)))
>  static int nfsnprintf(char *buf, int blen, const char *fmt, ...);
>  
> @@ -69,6 +74,7 @@ struct imap_server_conf {
>  	char *tunnel;
>  	char *host;
>  	int port;
> +	char *folder;
>  	char *user;
>  	char *pass;
>  	int use_ssl;
> @@ -82,6 +88,7 @@ static struct imap_server_conf server = {
>  	NULL,	/* tunnel */
>  	NULL,	/* host */
>  	0,	/* port */
> +	NULL,	/* folder */
>  	NULL,	/* user */
>  	NULL,	/* pass */
>  	0,   	/* use_ssl */
> @@ -1323,7 +1330,54 @@ static int split_msg(struct strbuf *all_msgs, struct strbuf *msg, int *ofs)
>  	return 1;
>  }
>  
> -static char *imap_folder;

All of the above seem to have meant well, but these changes are not
about talking with IMAP servers via libcurl.  We'd prefer to see
changes like these as preliminary clean-up before the main change as
separate patch(es).

> @@ -1417,18 +1476,48 @@ int main(int argc, char **argv)
>  	}
>  
>  	/* write it to the imap server */
> +
> +#ifdef USE_CURL_FOR_IMAP_SEND
> +	if (!server.tunnel) {
> +		curl = setup_curl(&server);
> +		curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
> +	} else {
> +#endif
>  	ctx = imap_open_store(&server);
>  	if (!ctx) {
>  		fprintf(stderr, "failed to open store\n");
>  		return 1;
>  	}
> +	ctx->name = server.folder;
> +#ifdef USE_CURL_FOR_IMAP_SEND
> +	}
> +#endif
>  
>  	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
> -	ctx->name = imap_folder;
>  	while (1) {
>  		unsigned percent = n * 100 / total;
>  
>  		fprintf(stderr, "%4u%% (%d/%d) done\r", percent, n, total);
> +#ifdef USE_CURL_FOR_IMAP_SEND
> +		if (!server.tunnel) {
> ...
> +			}
> +		} else {
> +#endif
>  		if (!split_msg(&all_msgs, &msg, &ofs))
>  			break;
>  		if (server.use_html)
> @@ -1436,11 +1525,19 @@ int main(int argc, char **argv)
>  		r = imap_store_msg(ctx, &msg);
>  		if (r != DRV_OK)
>  			break;
> +#ifdef USE_CURL_FOR_IMAP_SEND
> +		}
> +#endif
>  		n++;
>  	}
>  	fprintf(stderr, "\n");
>  
> +#ifdef USE_CURL_FOR_IMAP_SEND
> +	curl_easy_cleanup(curl);
> +	curl_global_cleanup();
> +#else
>  	imap_close_store(ctx);
> +#endif
>  
>  	return 0;
>  }

Ugly.  Can we do this with less #ifdef/#else/#endif in the primary
code path?

If we were to keep these two modes as a choice the users have to
make at the compilation time, that is.

Thanks.
