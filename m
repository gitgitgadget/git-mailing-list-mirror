From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: add _cb suffix to callback functions
Date: Tue, 27 Aug 2013 07:54:08 -0700
Message-ID: <xmqqmwo3falr.fsf@gitster.dls.corp.google.com>
References: <1377591136-10680-1-git-send-email-ncopa@alpinelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Natanael Copa <ncopa@alpinelinux.org>
X-From: git-owner@vger.kernel.org Tue Aug 27 16:54:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEKeu-0000yV-1P
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 16:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704Ab3H0OyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 10:54:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51556 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753190Ab3H0OyL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 10:54:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAE823CB35;
	Tue, 27 Aug 2013 14:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=44XM9mtYY22aqQi6zwQWPx1IdIw=; b=aBQclb
	pjhNF/T01l5r6Rmd+P9QHPoGDE+RejwZ2HzEX5h41ywRehl8rlt2OHpeMIBRd5Me
	fyNJI0R4WO+jMeSPvdsTZtQIMaUkoaqFY/4o+yPL+kpbxSLwukbIGGdyiTu/NdSv
	TDt8zev8o/eQsGVcUC5S7hZMbHwE1JVZcZbVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SICcd4Mq3LE8xSEGiquyn+yPJ3hU0Myp
	JfljOWvc7VNkO5Y0kdHXL25UKnM0E1yaYANbAOOIHtpomuQAypbqWNOsrqdSRS7V
	yEtWGGvC88xIhiICipMuB/nKnvflB6w9giDGyo6v0rcW4uMNkoXC38ySCipzjh54
	IGagz1DrJeY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A16F73CB34;
	Tue, 27 Aug 2013 14:54:10 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 073A03CB33;
	Tue, 27 Aug 2013 14:54:09 +0000 (UTC)
In-Reply-To: <1377591136-10680-1-git-send-email-ncopa@alpinelinux.org>
	(Natanael Copa's message of "Tue, 27 Aug 2013 08:12:16 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 87A920F6-0F28-11E3-AD73-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233095>

Natanael Copa <ncopa@alpinelinux.org> writes:

> Commit 4d8dd1494e9f3af2e9738edaca40ada096f7bf10 introduced a build
> regression on uClibc which defines fgetc as macro. To work around that
> we add a _cb suffix to the callback functions.
>
> Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
> ---

Thanks; I think Peff already fixed this yesterday.

Just for future reference, a looong commit object name like this

> Commit 4d8dd1494e9f3af2e9738edaca40ada096f7bf10 introduced a build

is not very friendly to human readers in a log message; it does not
help tickle their memory.

    4d8dd149 (config: make parsing stack struct independent from
    actual data source, 2013-07-12) introduced...

may be a way to phrase it in a more useful way.

>  config.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/config.c b/config.c
> index e13a7b6..aa80078 100644
> --- a/config.c
> +++ b/config.c
> @@ -27,9 +27,9 @@ struct config_source {
>  	struct strbuf value;
>  	struct strbuf var;
>  
> -	int (*fgetc)(struct config_source *c);
> -	int (*ungetc)(int c, struct config_source *conf);
> -	long (*ftell)(struct config_source *c);
> +	int (*fgetc_cb)(struct config_source *c);
> +	int (*ungetc_cb)(int c, struct config_source *conf);
> +	long (*ftell_cb)(struct config_source *c);
>  };
>  
>  static struct config_source *cf;
> @@ -217,13 +217,13 @@ int git_config_from_parameters(config_fn_t fn, void *data)
>  
>  static int get_next_char(void)
>  {
> -	int c = cf->fgetc(cf);
> +	int c = cf->fgetc_cb(cf);
>  
>  	if (c == '\r') {
>  		/* DOS like systems */
> -		c = cf->fgetc(cf);
> +		c = cf->fgetc_cb(cf);
>  		if (c != '\n') {
> -			cf->ungetc(c, cf);
> +			cf->ungetc_cb(c, cf);
>  			c = '\r';
>  		}
>  	}
> @@ -992,9 +992,9 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
>  		top.u.file = f;
>  		top.name = filename;
>  		top.die_on_error = 1;
> -		top.fgetc = config_file_fgetc;
> -		top.ungetc = config_file_ungetc;
> -		top.ftell = config_file_ftell;
> +		top.fgetc_cb = config_file_fgetc;
> +		top.ungetc_cb = config_file_ungetc;
> +		top.ftell_cb = config_file_ftell;
>  
>  		ret = do_config_from(&top, fn, data);
>  
> @@ -1013,9 +1013,9 @@ int git_config_from_buf(config_fn_t fn, const char *name, const char *buf,
>  	top.u.buf.pos = 0;
>  	top.name = name;
>  	top.die_on_error = 0;
> -	top.fgetc = config_buf_fgetc;
> -	top.ungetc = config_buf_ungetc;
> -	top.ftell = config_buf_ftell;
> +	top.fgetc_cb = config_buf_fgetc;
> +	top.ungetc_cb = config_buf_ungetc;
> +	top.ftell_cb = config_buf_ftell;
>  
>  	return do_config_from(&top, fn, data);
>  }
> @@ -1196,7 +1196,7 @@ static int store_aux(const char *key, const char *value, void *cb)
>  				return 1;
>  			}
>  
> -			store.offset[store.seen] = cf->ftell(cf);
> +			store.offset[store.seen] = cf->ftell_cb(cf);
>  			store.seen++;
>  		}
>  		break;
> @@ -1223,19 +1223,19 @@ static int store_aux(const char *key, const char *value, void *cb)
>  		 * Do not increment matches: this is no match, but we
>  		 * just made sure we are in the desired section.
>  		 */
> -		store.offset[store.seen] = cf->ftell(cf);
> +		store.offset[store.seen] = cf->ftell_cb(cf);
>  		/* fallthru */
>  	case SECTION_END_SEEN:
>  	case START:
>  		if (matches(key, value)) {
> -			store.offset[store.seen] = cf->ftell(cf);
> +			store.offset[store.seen] = cf->ftell_cb(cf);
>  			store.state = KEY_SEEN;
>  			store.seen++;
>  		} else {
>  			if (strrchr(key, '.') - key == store.baselen &&
>  			      !strncmp(key, store.key, store.baselen)) {
>  					store.state = SECTION_SEEN;
> -					store.offset[store.seen] = cf->ftell(cf);
> +					store.offset[store.seen] = cf->ftell_cb(cf);
>  			}
>  		}
>  	}
