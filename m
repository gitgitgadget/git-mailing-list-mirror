Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3378DC433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F79C2087E
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RPiITUUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgJLUP4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:15:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:46855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgJLUP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 16:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602533740;
        bh=ERYzZdJnVt0kBDjVK3NTKPPboI8WCIeguNfqA2d5mR4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RPiITUUmXvy5eAvwrHChgZmO2j0oEACPREHvVjmMlqGncjHVK6bVAez0JLajvBZs+
         4qNEzB6mTqRCz6GJcVV0W5mUYdHGTOBzmfiM41pGxsAFrg1KwCC3TxlXfnxw15MUSR
         jKz4bj2fNI9JYycdJpngTSsViDf1tsYJKeT8kLTE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.212.188]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNt0M-1kqJBT3XSa-00OGoM; Mon, 12
 Oct 2020 22:15:39 +0200
Date:   Mon, 12 Oct 2020 22:15:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Sean McAllister <smcallis@google.com>
cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        masayasuzuki@google.com
Subject: Re: [PATCH 3/3] http: automatically retry some requests
In-Reply-To: <20201012184806.166251-3-smcallis@google.com>
Message-ID: <nycvar.QRO.7.76.6.2010122126280.50@tvgsbejvaqbjf.bet>
References: <20201012184806.166251-1-smcallis@google.com> <20201012184806.166251-3-smcallis@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:L8D64BYXtm6MQ9m8hGHWbHNtcjXbVLFiwB71AsgVLpj5wKNXkWm
 9SnYwoYNlxHGfIsFuu/wRuGw01nEY4rFuiSKQ0Ikf3d200Fm/kRNYh0lpFBbUuZUF50fxjR
 uDnoF09i1ZsKI5HR2kvzlhLC1QY+0Wrc6sB3CJrPKnRhL70IPGfuM4dpjYtmac3gjfxYBnM
 zJ2GHLM0Upp3MwH4qFDYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IeA5OKdQ7Xw=:rgsaAgfbytW8PAiwx7nrab
 EXRNRHM5JBxPVmEOrx23KMsxw8dFQftcN+ICid7Eya9188Ef+6IVMYHvWA2UtWBKbf05tavAx
 aVthKjU6QpT9UfSPdCf1q/l8Yk4aNSUSz8ysxsdMwJKzGVEjkxUzrfRjNyEZUejc5IZtuMJ8L
 SKKCR9mZNAvImw4oVhZ38bFid0DEMeEAcEgwX057fzODXBYgnYKOuk4HHxCgWVZN5aiex36fr
 AZDwT/42BTIjuLb0PtbmWi8nGqxp5skQbPoSAAWHpIvNpqayatTp5bxYe0bTTWWMoQei3stZl
 BhO6fglBj70dOovAqhY5U7dwwaGXQH9RGItAM87pFTQVw3Asd3C1Z8XCV2wTaWSqgDMKZOVRB
 lotqjzwdT7sSFlSFBxvEeEzgTeDOksnJHuuJ71xG+KNd+jr+D8+Lnvhw9u5KlC6B59fEn5Ck7
 /j3uqQplWbE7izwyI9g9BIMq984HphIlz2/m84WqxdwdbNRwoQeokAUF6ZtDU4O+26rWXRYsJ
 /iDDMiQtPgl1VYXkHu+OAe5k7jLZe5qO+qdi4rT55qeLGymLNjFjrub23RJ7Z+BdE9dp1LK7A
 gEtR6U6TZBuN18VzmjXk8dVRpRqADSuJdO1sP/Ge+c+/MLsTQo6t6dWLxO0lFxFguw4YcFx2p
 ffwYOI16CVVVG9QrFEOhxOJ1BI5WSztQv1F58sxxprc+ZkRGXSoZBO0rtSxMPRF/RRETAw9nU
 gTrYO7znU3XeWGUC/Etbuwtz0XTV1Hc/N+6T4yhyeKn6IkkSb8/OErvcLN5YznE/nUydN1l86
 vNfTs3Zmy2ALE7yD9QVEOia4mkDBU0T8AB4Al5det9Q0NFyDqAvf8o0MOQUE8c/9BImyC1UVb
 9SCbFjks2p/WPKjrAhebvddHBMu/guTBnrqXCDO8qXIaNqXv7OQJTGevm18WieHhmOgaUJRKK
 q8/NKahbD9SkmIMrfKbt/R8OhXa4MURK+MqtIwMZPkM7AF18TR7T7ZtSWRo4KfORkXS8ie3Ba
 PA5cXGCfQ3g7cpbfoxkbgopflQ2Zb+UKK94TjEcUKnTE4L+INn9L68r+8FeyM4UrVgi+sjAcX
 EJGMhSmxRxi90m7dBMpPexZqYaJ9bXtwtGg5oGwF5h1SDzoq8PAFHphGC1A/HdfiYM8R4+Ipi
 UXosGYnYr//UsumRQSzRMqpBtZ/SYEQpDNkfNfGpf9HpruCCrzhlRHyy1N3LqDiZgzFKahw8Z
 fdJhvrL3vqRCHjlK9xAEPQ42woUqi+W50nWer4w==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sean,

On Mon, 12 Oct 2020, Sean McAllister wrote:

> Some HTTP response codes indicate a server state that can support
> retrying the request rather than immediately erroring out.  The server
> can also provide information about how long to wait before retries to
> via the Retry-After header.  So check the server response and retry
> some reasonable number of times before erroring out to better accomodate
> transient errors.
>
> Exiting immediately becomes irksome when pulling large multi-repo code
> bases such as Android or Chromium, as often the entire fetch operation
> has to be restarted from the beginning due to an error in one repo. If
> we can reduce how often that occurs, then it's a big win.

Makes a lot of sense to me.

>
> Signed-off-by: Sean McAllister <smcallis@google.com>
> ---
>  Documentation/config/http.txt |   5 ++
>  http.c                        | 121 +++++++++++++++++++++++++++++++++-
>  http.h                        |  13 +++-
>  remote-curl.c                 |   2 +-
>  t/t5539-fetch-http-shallow.sh |  41 ++++++++----
>  t/t5540-http-push-webdav.sh   |  26 +++++++-
>  t/t5541-http-push-smart.sh    |  15 +++++
>  t/t5550-http-fetch-dumb.sh    |  12 ++++
>  t/t5551-http-fetch-smart.sh   |  14 ++++
>  t/t5601-clone.sh              |   6 +-
>  10 files changed, 237 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/config/http.txt b/Documentation/config/http.t=
xt
> index 3968fbb697..0beec3d370 100644
> --- a/Documentation/config/http.txt
> +++ b/Documentation/config/http.txt
> @@ -260,6 +260,11 @@ http.followRedirects::
>  	the base for the follow-up requests, this is generally
>  	sufficient. The default is `initial`.
>
> +http.retryLimit::
> +	Some HTTP error codes (eg: 429,503) can reasonably be retried if

Please have a space after the comma so that it is not being mistaken for a
6-digit number. Also, aren't they called "status codes"? Not all of them
indicate errors, after all.

> +	they're encountered.  This value configures the number of retry attemp=
ts
> +	before giving up.  The default retry limit is 3.
> +
>  http.<url>.*::
>  	Any of the http.* options above can be applied selectively to some URL=
s.
>  	For a config key to match a URL, each element of the config key is
> diff --git a/http.c b/http.c
> index b3c1669388..e41d7c5575 100644
> --- a/http.c
> +++ b/http.c
> @@ -92,6 +92,9 @@ static const char *http_proxy_ssl_key;
>  static const char *http_proxy_ssl_ca_info;
>  static struct credential proxy_cert_auth =3D CREDENTIAL_INIT;
>  static int proxy_ssl_cert_password_required;
> +static int http_retry_limit =3D 3;
> +static int http_default_delay =3D 2;

Should there be a config option for that? Also, it took me some time to
find the code using this variable in order to find out what unit to use:
it is seconds (not microseconds, as I had expected). Maybe this can be
documented in the variable name, or at least in a comment?

> +static int http_max_delay =3D 60;
>
>  static struct {
>  	const char *name;
> @@ -219,6 +222,51 @@ size_t fwrite_null(char *ptr, size_t eltsize, size_=
t nmemb, void *strbuf)
>  	return nmemb;
>  }
>
> +
> +/* return 1 for a retryable HTTP code, 0 otherwise */
> +static int retryable_code(int code)
> +{
> +	switch(code) {
> +	case 429: /* fallthrough */
> +	case 502: /* fallthrough */
> +	case 503: /* fallthrough */
> +	case 504: return 1;
> +	default:  return 0;
> +	}
> +}
> +
> +size_t http_header_value(

In the part of Git's code with which I am familiar, we avoid trying to
break the line after an opening parenthesis, instead preferring to break
after a comma.

Also, shouldn't we make the return type `ssize_t` to allow for a negative
value to indicate an error/missing header?

> +	const struct strbuf headers, const char *header, char **value)
> +{
> +	size_t len =3D 0;
> +	struct strbuf **lines, **line;
> +	char *colon =3D NULL;
> +
> +	lines =3D strbuf_split(&headers, '\n');
> +	for (line =3D lines; *line; line++) {
> +		strbuf_trim(*line);
> +
> +		/* find colon and null it out to 'split' string */
> +		colon =3D strchr((*line)->buf, ':');
> +		if (colon) {
> +			*colon =3D '\0';
> +
> +			if (!strcasecmp(header, (*line)->buf)) {

If all we want is to find the given header, splitting lines seems to be a
bit wasteful to me. We could instead search for the header directly:

	const char *p =3D strcasestr(headers.buf, header), *eol;
	size_t header_len =3D strlen(header);

	while (p) {
		if ((p !=3D headers.buf && p[-1] !=3D '\n') ||
		    p[header_len] !=3D ':') {
			p =3D strcasestr(p + header_len, header);
			continue;
		}

		p +=3D header_len + 1;
		while (isspace(*p) && *p !=3D '\n')
			p++;
		eol =3D strchrnul(p, '\n');
		len =3D  eol - p;
		*value =3D xstrndup(p, len);
		return len;
	}

> +				/* move past colon and skip whitespace */
> +				colon++;
> +				while (*colon && isspace(*colon)) colon++;
> +				*value =3D xstrdup(colon);
> +				len =3D strlen(*value);
> +				goto done;
> +			}
> +		}
> +	}
> +
> +done:
> +	strbuf_list_free(lines);
> +	return len;
> +}
> +
>  static void closedown_active_slot(struct active_request_slot *slot)
>  {
>  	active_requests--;
> @@ -452,6 +500,11 @@ static int http_options(const char *var, const char=
 *value, void *cb)
>  		return 0;
>  	}
>
> +	if (!strcmp("http.retrylimit", var)) {
> +		http_retry_limit =3D git_config_int(var, value);
> +		return 0;
> +	}
> +
>  	/* Fall back on the default ones */
>  	return git_default_config(var, value, cb);
>  }
> @@ -1668,7 +1721,7 @@ static int handle_curl_result(struct slot_results =
*results)
>  }
>
>  int run_one_slot(struct active_request_slot *slot,
> -		 struct slot_results *results)
> +		 struct slot_results *results, int *http_code)
>  {
>  	slot->results =3D results;
>  	if (!start_active_slot(slot)) {
> @@ -1678,6 +1731,8 @@ int run_one_slot(struct active_request_slot *slot,
>  	}
>
>  	run_active_slot(slot);
> +	if (http_code)
> +		*http_code =3D results->http_code;
>  	return handle_curl_result(results);
>  }
>
> @@ -1903,20 +1958,55 @@ static void http_opt_request_remainder(CURL *cur=
l, off_t pos)
>  #define HTTP_REQUEST_STRBUF	0
>  #define HTTP_REQUEST_FILE	1
>
> +/* check for a retry-after header in the given headers string, if found=
, then
> +honor it, otherwise do an exponential backoff up to the max on the curr=
ent delay
> +*/

Multi-line comments should be of this form:

	/*
	 * Check for a retry-after header in the given headers string, if
	 * found, then honor it, otherwise do an exponential backoff up to
	 * the maximum on the current delay.
	 */

> +static int http_retry_after(const struct strbuf headers, int cur_delay)=
 {

For functions, the initial opening curly bracket goes on its own line.

> +	int len, delay;
> +	char *end;
> +	char *value;

Why not declare `char *end, *value;`, just like `len` and `delay` are
declared on the same line?

> +
> +	len =3D http_header_value(headers, "retry-after", &value);
> +	if (len) {
> +		delay =3D strtol(value, &end, 0);
> +		if (*value && *end =3D=3D 0 && delay >=3D 0) {

Better: `*end =3D=3D '\0'`

And why `*value` here? We already called `strtol()` on it.

> +			if (delay > http_max_delay) {
> +				die(Q_(

Let's not end the line in an opening parenthesis. Instead, use C's string
continuation like so:

				die(Q_("server requested retry after %d second,"
				       " which is longer than max allowed\n",
				       "server requested retry after %d "
				       "seconds, which is longer than max "
				       "allowed\n", delay), delay);

> +						"server requested retry after %d second, which is longer than max=
 allowed\n",
> +						"server requested retry after %d seconds, which is longer than ma=
x allowed\n", delay), delay);
> +			}
> +			free(value);

`value` is not actually used after that `strtol()` call above, so let's
release it right then and there.

> +			return delay;
> +		}
> +		free(value);
> +	}

If the header was found, but for some reason had an empty value, we're
leaking `value` here.

> +
> +	cur_delay *=3D 2;
> +	return cur_delay >=3D http_max_delay ? http_max_delay : cur_delay;
> +}
> +
>  static int http_request(const char *url,
>  			void *result, int target,
>  			const struct http_get_options *options)
>  {
>  	struct active_request_slot *slot;
>  	struct slot_results results;
> -	struct curl_slist *headers =3D http_copy_default_headers();
> +	struct curl_slist *headers;
>  	struct strbuf buf =3D STRBUF_INIT;
> +	struct strbuf result_headers =3D STRBUF_INIT;
>  	const char *accept_language;
>  	int ret;
> +	int retry_cnt =3D 0;
> +	int retry_delay =3D http_default_delay;
> +	int http_code;
>
> +retry:
>  	slot =3D get_active_slot();
>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
>
> +	curl_easy_setopt(slot->curl, CURLOPT_HEADERDATA, &result_headers);
> +	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_buffer);
> +
>  	if (result =3D=3D NULL) {
>  		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
>  	} else {
> @@ -1936,6 +2026,7 @@ static int http_request(const char *url,
>
>  	accept_language =3D get_accept_language();
>
> +	headers =3D http_copy_default_headers();
>  	if (accept_language)
>  		headers =3D curl_slist_append(headers, accept_language);
>
> @@ -1961,7 +2052,31 @@ static int http_request(const char *url,
>  	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
>  	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
>
> -	ret =3D run_one_slot(slot, &results);
> +	http_code =3D 0;
> +	ret =3D run_one_slot(slot, &results, &http_code);
> +
> +	if (ret !=3D HTTP_OK) {
> +		if (retryable_code(http_code) && (retry_cnt < http_retry_limit)) {

The parentheses around the second condition should be dropped.

> +			retry_cnt++;
> +			retry_delay =3D http_retry_after(result_headers, retry_delay);
> +			fprintf(stderr,

Should this be a `warning()` instead? I see 5 instances in `http.c` that
use `fprintf(stderr, ...)`, but 12 that use `warning()`, making me believe
that at least some of those 5 instances should call `warning()` instead,
too.

> +			    Q_("got HTTP response %d, retrying after %d second (%d/%d)\n",
> +				   "got HTTP response %d, retrying after %d seconds (%d/%d)\n",
> +					retry_delay),
> +				http_code, retry_delay, retry_cnt, http_retry_limit);
> +			sleep(retry_delay);
> +
> +			// remove header data fields since not all slots will use them

No C++-style comments, please: use /* ... */ instead.

> +			curl_easy_setopt(slot->curl, CURLOPT_HEADERDATA, NULL);
> +			curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, NULL);
> +
> +			goto retry;
> +		}
> +	}
> +
> +	// remove header data fields since not all slots will use them

No C++-style comments, please.

> +	curl_easy_setopt(slot->curl, CURLOPT_HEADERDATA, NULL);
> +	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, NULL);

Shouldn't we just perform this assignment before the `if (ret !=3D HTTP_OK=
)`
condition? I do not see anything inside that block that needs it,
therefore this could be DRY'd up.

>
>  	if (options && options->content_type) {
>  		struct strbuf raw =3D STRBUF_INIT;
> diff --git a/http.h b/http.h
> index 5de792ef3f..60ce03801f 100644
> --- a/http.h
> +++ b/http.h
> @@ -86,6 +86,17 @@ size_t fwrite_null(char *ptr, size_t eltsize, size_t =
nmemb, void *strbuf);
>  curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp);
>  #endif
>
> +/*
> + * Query the value of an HTTP header.
> + *
> + * If the header is found, then a newly allocate string is returned thr=
ough
> + * the value parameter, and the length is returned.
> + *
> + * If not found, returns 0
> + */
> +size_t http_header_value(
> +	const struct strbuf headers, const char *header, char **value);

Do we really need to export this function? It could stay file-local, at
least for now (i.e. be defined `static` inside `http.c`), no?

> +
>  /* Slot lifecycle functions */
>  struct active_request_slot *get_active_slot(void);
>  int start_active_slot(struct active_request_slot *slot);
> @@ -99,7 +110,7 @@ void finish_all_active_slots(void);
>   *
>   */
>  int run_one_slot(struct active_request_slot *slot,
> -		 struct slot_results *results);
> +		 struct slot_results *results, int *http_code);
>
>  #ifdef USE_CURL_MULTI
>  void fill_active_slots(void);
> diff --git a/remote-curl.c b/remote-curl.c
> index 7f44fa30fe..2657c95bcb 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -805,7 +805,7 @@ static int run_slot(struct active_request_slot *slot=
,
>  	if (!results)
>  		results =3D &results_buf;
>
> -	err =3D run_one_slot(slot, results);
> +	err =3D run_one_slot(slot, results, NULL);
>
>  	if (err !=3D HTTP_OK && err !=3D HTTP_REAUTH) {
>  		struct strbuf msg =3D STRBUF_INIT;
> diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow.=
sh
> index 82aa99ae87..e09083e2b3 100755
> --- a/t/t5539-fetch-http-shallow.sh
> +++ b/t/t5539-fetch-http-shallow.sh
> @@ -30,20 +30,39 @@ test_expect_success 'clone http repository' '
>  	git clone --bare --no-local shallow "$HTTPD_DOCUMENT_ROOT_PATH/repo.gi=
t" &&
>  	git clone $HTTPD_URL/smart/repo.git clone &&
>  	(
> -	cd clone &&
> -	git fsck &&
> -	git log --format=3D%s origin/master >actual &&
> -	cat <<EOF >expect &&
> -7
> -6
> -5
> -4
> -3
> -EOF
> -	test_cmp expect actual
> +		cd clone &&
> +		git fsck &&
> +		git log --format=3D%s origin/master >actual &&
> +		cat <<-\EOF >expect &&
> +		7
> +		6
> +		5
> +		4
> +		3
> +		EOF
> +		test_cmp expect actual

This just changes the indentation, right?

I _guess_ this is a good change, but it should live in its own patch.

>  	)
>  '
>
> +test_expect_success 'clone http repository with flaky http' '
> +    rm -rf clone &&

Let's consistently use horizontal tab characters for indentation. (There
are more instances of lines indented by spaces below.)

> +	git clone $HTTPD_URL/error_ntime/`gen_nonce`/3/429/1/smart/repo.git cl=
one 2>err &&

Let's use `$(gen_nonce)`. Also: where is the `gen_nonce` defined? I do not
see the definition in this patch (but it could be 1/3, which for some
reason did not make it to the mailing list:
https://lore.kernel.org/git/20201012184806.166251-1-smcallis@google.com/).

Another suggestion: rather than deleting `clone/`, use a separate
directory to clone into, say, `flaky/`. That will make it easier to debug
when the entire "trash" directory is tar'ed up in a failed CI build, for
example.

> +	(
> +		cd clone &&
> +		git fsck &&
> +		git log --format=3D%s origin/master >actual &&
> +		cat <<-\EOF >expect &&
> +		7
> +		6
> +		5
> +		4
> +		3
> +		EOF
> +		test_cmp expect actual
> +	) &&
> +    test_i18ngrep "got HTTP response 429" err
> +'
> +
>  # This test is tricky. We need large enough "have"s that fetch-pack
>  # will put pkt-flush in between. Then we need a "have" the server
>  # does not have, it'll send "ACK %s ready"
> diff --git a/t/t5540-http-push-webdav.sh b/t/t5540-http-push-webdav.sh
> index 450321fddb..d8234d555c 100755
> --- a/t/t5540-http-push-webdav.sh
> +++ b/t/t5540-http-push-webdav.sh
> @@ -68,12 +68,36 @@ test_expect_success 'push already up-to-date' '
>  	git push
>  '
>
> +test_expect_success 'push to remote repository with packed refs and fla=
key server' '
> +	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
> +	 rm -rf packed-refs &&
> +	 git update-ref refs/heads/master $ORIG_HEAD &&
> +	 git --bare update-server-info) &&
> +    git remote set-url origin $HTTPD_URL/error_ntime/`gen_nonce`/3/502/=
1/dumb/test_repo.git &&
> +	git push &&
> +    git remote set-url origin $HTTPD_URL/dumb/test_repo.git &&
> +	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
> +	 test $HEAD =3D $(git rev-parse --verify HEAD))
> +'
> +
>  test_expect_success 'push to remote repository with unpacked refs' '
>  	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
> -	 rm packed-refs &&
> +	 rm -rf packed-refs &&
> +	 git update-ref refs/heads/master $ORIG_HEAD &&
> +	 git --bare update-server-info) &&
> +	git push &&
> +	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
> +	 test $HEAD =3D $(git rev-parse --verify HEAD))
> +'
> +
> +test_expect_success 'push to remote repository with unpacked refs and f=
lakey server' '
> +	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
> +	 rm -rf packed-refs &&
>  	 git update-ref refs/heads/master $ORIG_HEAD &&
>  	 git --bare update-server-info) &&
> +    git remote set-url origin $HTTPD_URL/error_ntime/`gen_nonce`/3/502/=
1/dumb/test_repo.git &&
>  	git push &&
> +    git remote set-url origin $HTTPD_URL/dumb/test_repo.git &&
>  	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
>  	 test $HEAD =3D $(git rev-parse --verify HEAD))
>  '
> diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
> index 187454f5dd..9b2fc62e11 100755
> --- a/t/t5541-http-push-smart.sh
> +++ b/t/t5541-http-push-smart.sh
> @@ -77,6 +77,21 @@ test_expect_success 'push to remote repository (stand=
ard)' '
>  	 test $HEAD =3D $(git rev-parse --verify HEAD))
>  '
>
> +test_expect_success 'push to remote repository (flakey server)' '
> +	cd "$ROOT_PATH"/test_repo_clone &&
> +	: >path5 &&
> +	git add path5 &&
> +	test_tick &&
> +	git commit -m path5 &&
> +	HEAD=3D$(git rev-parse --verify HEAD) &&
> +	git remote set-url origin $HTTPD_URL/error_ntime/`gen_nonce`/3/502/1/s=
mart/test_repo.git &&
> +	GIT_TRACE_CURL=3Dtrue git push -v -v 2>err &&
> +	git remote set-url origin $HTTPD_URL/smart/test_repo.git &&
> +	grep "POST git-receive-pack ([0-9]* bytes)" err &&
> +	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
> +	test $HEAD =3D $(git rev-parse --verify HEAD))
> +'
> +
>  test_expect_success 'push already up-to-date' '
>  	git push
>  '
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index 483578b2d7..350c47097b 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -176,6 +176,18 @@ test_expect_success 'fetch changes via http' '
>  	test_cmp file clone/file
>  '
>
> +test_expect_success 'fetch changes via flakey http' '
> +	echo content >>file &&
> +	git commit -a -m three &&
> +	git push public &&
> +	(cd clone &&
> +		git remote set-url origin $HTTPD_URL/error_ntime/`gen_nonce`/3/502/1/=
dumb/repo.git &&
> +		git pull 2>../err &&
> +		git remote set-url origin $HTTPD_URL/dumb/repo.git) &&
> +    test_i18ngrep "got HTTP response 502" err &&
> +	test_cmp file clone/file
> +'
> +
>  test_expect_success 'fetch changes via manual http-fetch' '
>  	cp -R clone-tmpl clone2 &&
>
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index e40e9ed52f..85d2a0e8b8 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -45,6 +45,7 @@ test_expect_success 'clone http repository' '
>  	EOF
>  	GIT_TRACE_CURL=3Dtrue GIT_TEST_PROTOCOL_VERSION=3D0 \
>  		git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
> +    cd clone && git config pull.rebase false && cd .. &&

Better: test_config -C clone pull.rebase false

>  	test_cmp file clone/file &&
>  	tr '\''\015'\'' Q <err |
>  	sed -e "
> @@ -103,6 +104,19 @@ test_expect_success 'fetch changes via http' '
>  	test_cmp file clone/file
>  '
>
> +test_expect_success 'fetch changes via flakey http' '
> +	echo content >>file &&
> +	git commit -a -m two &&
> +	git push public &&
> +	(cd clone &&
> +		git remote set-url origin $HTTPD_URL/error_ntime/`gen_nonce`/3/502/1/=
smart/repo.git &&
> +		git pull 2>../err &&
> +		git remote set-url origin $HTTPD_URL/smart/repo.git) &&
> +	test_cmp file clone/file &&
> +    test_i18ngrep "got HTTP response 502" err
> +'
> +
> +
>  test_expect_success 'used upload-pack service' '
>  	cat >exp <<-\EOF &&
>  	GET  /smart/repo.git/info/refs?service=3Dgit-upload-pack HTTP/1.1 200
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 71d4307001..9988e3ff14 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -757,13 +757,17 @@ test_expect_success 'partial clone using HTTP' '
>  '
>
>  test_expect_success 'partial clone using HTTP with redirect' '
> -    _NONCE=3D`gen_nonce` && export _NONCE &&
> +    _NONCE=3D`gen_nonce` &&
>      curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" > /de=
v/null &&
>      curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" > /de=
v/null &&
>      curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" > /de=
v/null &&
>  	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/error_nti=
me/${_NONCE}/3/502/10/smart/server"
>  '
>
> +test_expect_success 'partial clone with retry' '
> +	partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/error_nti=
me/`gen_nonce`/3/429/1/smart/server" 2>err &&
> +    test_i18ngrep "got HTTP response 429" err
> +'

I wonder whether it is really necessary to add _that_ many test cases. The
test suite already takes so long to run that we had cases where
contributors simply did not run it before sending their contributions.

In this instance, I would think that it would be plenty sufficient to have
a single new test case that exercizes the added code path (and verifies
that it can see the message).

Thanks,
Dscho

>
>  # DO NOT add non-httpd-specific tests here, because the last part of th=
is
>  # test script is only executed when httpd is available and enabled.
> --
> 2.28.0.1011.ga647a8990f-goog
>
>
