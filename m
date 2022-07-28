Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A980C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiG1Q6T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiG1Q6S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:58:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74456556E
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659027486;
        bh=NuKIZBI4LTft+zEMFObiBq+dcXDzZHrPH6cqIuMGmPg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=F81fxJoR+CgbNlFxSHNcggr5DizmNEMwB8g1VqDVdLvch4DIEx7IDCAVO6ztVS9Qe
         MT5BMWlVlmGWIof8WeW66R12XEMNRna/8We5Wwot1g5t40/bwUOZJLHzU6Wrh0CRMp
         6KtLIgvejEgg4wibdkZ3WsCwCqcIh87DZ5jWHEUo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.196.158] ([89.1.214.237]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sDq-1oKyiK1nxC-004yCH; Thu, 28
 Jul 2022 18:58:06 +0200
Date:   Thu, 28 Jul 2022 18:58:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Matheus Tavares <matheus.bernardino@usp.br>
cc:     git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        christian.couder@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v2] t/t0021: convert the rot13-filter.pl script to C
In-Reply-To: <f38f722de7c3323207eda5ea632b5acd3765c285.1658675222.git.matheus.bernardino@usp.br>
Message-ID: <4n20476q-6ssr-osp8-q5o3-p8ns726q4pn3@tzk.qr>
References: <cover.1658518769.git.matheus.bernardino@usp.br> <f38f722de7c3323207eda5ea632b5acd3765c285.1658675222.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/mIiJDC/RjPynXLYD9TvI4+R91GXphuqe1Jj3gx7J/RldgeqVRz
 xDbRp6/qQOYEKLHfGi7KNkuJDNqDNGYR0j1kxObmY0vCY5PeiUVU9UarsSYf9zWe745dyFW
 Rt2+rIODB6NqHVg8UJHpQ93OvDN/yT5KSitTkYGSt9NmBcDrapSo/jEeCU1JurUCpj1oliQ
 a8rOBkQraoMLNkVqRxT2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JqOZ9r+A1KE=:/AQcs2Iev8ovjKP4UwB9lH
 pbi7icSKzTcKWhE7BAXO6SgY6KwaWOnjdxB2V7iKzCKSIfOg8mUPKU7bTCtArVtz5AYE/DgYj
 3uPTvZCeCUxk28WMIesqM+F6rmHIBp81K5+xAwCMO++H0GDtT28raS1zZ54bePF1bD7YR+3vl
 4E2TdxHkIiITyXozz+4xWKMgWhRe6gRxm6AB13t/ZmNI/zX+f1YsvCGKuqAWcwNh/j8R+UVGZ
 8gHwAaZgYuqFdIhVaDpxG2rXL3cpsJpGsDcl2vX3s8+L8l+8AO2e33ait1rkHvJOffx881Qam
 72Tg31TvRxoFTqQ3qVTdlV+sTTgtfz3+0JngxEfc5iXPdi1gUZRNsL1uJCviycwzVn8fUjRpP
 VAUaw6yQva0/b/yoF/SqhMl378X9FQYgqOuIk8iSDsaPIQeOxG9m71aDadFLbbBPjGDMgcBZy
 407boQ63lBJv/5oQjE+SbH/ipvHBdAc2b3K7cQLCaOm3ActZQ7tm3sTAXkcv9jnLdAe2VaCXs
 61oXhu4WtiCwmtQbi4SGmuWZUUwNsfXTS+mUfCknDhkUaT25MOUkO3qbaeVBVCjqPLU34cprZ
 PkklkWKZNdGN288YzjCD0dMiknLime2Hs+zuyO1eEKyda6zd6FC3hZnZF1SSIYK/gliMJ1Dqs
 90KEtgDA+PC5wwsOJK9cs3vqGuAbVr4MIMfcZExmoQBkpPKWH99gKxfZ8mBW9Ygg1Q0qTpVnf
 aAt5l+CnYhlCAexwYtC0CbqBmTb3YR82w9zEY1iVIc+ZEWM6KpBwpmL4PBnMoYAojte6tFBkH
 AYsvoi05KZetSkYix2E5vmmNReEtEL5ANfx4yjWHWjQeziWCYWh5oSt7qXJbczHu5EzX2X6KQ
 N7W2vP9AmD0v7SAqzNOrt/uHWCWm+OfZntzEEwasSCNCH25yjgr5q3EdbHPZCyQ7WZHtVsv4S
 Rm+6navZxPvYDXkzGq7tJ0gl1MAlExuCwelo51agoonveMY5MTsm/NCH//n5P5mruFnaFd3j9
 L1zmAVpkyHAxkBt23VRz3+fHJv35eeFBBnK6LkDBWI79ojccunv6+JiVx16rBHRJQeis7u10N
 Jz/UcYZPfRsCfSn32tXYcdQcbIMI8ok4GSbV5+kBOXIv0Fxvj3q0DT6tg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Sun, 24 Jul 2022, Matheus Tavares wrote:

> This script is currently used by three test files: t0021-conversion.sh,
> t2080-parallel-checkout-basics.sh, and
> t2082-parallel-checkout-attributes.sh. To avoid the need for the PERL
> dependency at these tests, let's convert the script to a C test-tool
> command.

Great!

>  - Squashed the two patches together.

I see why this might have been suggested, but it definitely made it more
challenging for me to review. You see, it is easy to just fly over a patch
that simply removes the `PERL` prereq, but it is much harder to jump back
and forth over all of these removals when the `.c` version of the filter
is added before them and the `.pl` version is removed after them. So I
find that it was bad advice, but I do not fault you for following it (we
all want reviews to just be over already and therefore sometimes pander to
the reviewers, no matter how much or little sense their feedback makes).

It just would have been easier for me to review if the chaff was separated
from the wheat, so to say.

To illustrate my point: it was a bit of a challenge to find the adjustment
of the "smudge write error at" needle in all of that cruft. It would have
made my life as a reviewer substantially easier had the patch
series been organized this way (which I assume you had before the feedback
you received demanded to squash everything in one hot pile):

	1/3 adjust the needle for the error message
	2/3 implement the rot13-filter in C
	3/3 use the test-tool in the tests and remove the PERL prereq, and
	    remove rot13-filter.pl

> [...]
> diff --git a/pkt-line.c b/pkt-line.c
> index 8e43c2def4..4425bdae36 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -309,9 +309,10 @@ int write_packetized_from_fd_no_flush(int fd_in, in=
t fd_out)
>  	return err;
>  }
>
> -int write_packetized_from_buf_no_flush(const char *src_in, size_t len, =
int fd_out)
> +int write_packetized_from_buf_no_flush_count(const char *src_in, size_t=
 len,
> +					     int fd_out, int *count_ptr)
>  {
> -	int err =3D 0;
> +	int err =3D 0, count =3D 0;
>  	size_t bytes_written =3D 0;
>  	size_t bytes_to_write;
>
> @@ -324,10 +325,18 @@ int write_packetized_from_buf_no_flush(const char =
*src_in, size_t len, int fd_ou
>  			break;
>  		err =3D packet_write_gently(fd_out, src_in + bytes_written, bytes_to_=
write);
>  		bytes_written +=3D bytes_to_write;
> +		count++;
>  	}
> +	if (count_ptr)
> +		*count_ptr =3D count;

This is not just a counter, but a packet counter, right? In any case, it
would probably make more sense to increment the value directly:

		if (count_ptr)
			(*count_ptr)++;

More on that below, where you use it.

>  	return err;
>  }
>
> +int write_packetized_from_buf_no_flush(const char *src_in, size_t len, =
int fd_out)
> +{
> +	return write_packetized_from_buf_no_flush_count(src_in, len, fd_out, N=
ULL);
> +}

Have you considered making this a `static inline` in `pkt-line.h`?

> [...]
> diff --git a/t/helper/test-rot13-filter.c b/t/helper/test-rot13-filter.c
> new file mode 100644
> index 0000000000..536111f272
> --- /dev/null
> +++ b/t/helper/test-rot13-filter.c
> @@ -0,0 +1,393 @@
> +/*
> + * Example implementation for the Git filter protocol version 2
> + * See Documentation/gitattributes.txt, section "Filter Protocol"
> + *
> + * Usage: test-tool rot13-filter [--always-delay] <log path> <capabilit=
ies>
> + *
> + * Log path defines a debug log file that the script writes to. The
> + * subsequent arguments define a list of supported protocol capabilitie=
s
> + * ("clean", "smudge", etc).
> + *
> + * When --always-delay is given all pathnames with the "can-delay" flag
> + * that don't appear on the list bellow are delayed with a count of 1
> + * (see more below).
> + *
> + * This implementation supports special test cases:
> + * (1) If data with the pathname "clean-write-fail.r" is processed with
> + *     a "clean" operation then the write operation will die.
> + * (2) If data with the pathname "smudge-write-fail.r" is processed wit=
h
> + *     a "smudge" operation then the write operation will die.
> + * (3) If data with the pathname "error.r" is processed with any
> + *     operation then the filter signals that it cannot or does not wan=
t
> + *     to process the file.
> + * (4) If data with the pathname "abort.r" is processed with any
> + *     operation then the filter signals that it cannot or does not wan=
t
> + *     to process the file and any file after that is processed with th=
e
> + *     same command.
> + * (5) If data with a pathname that is a key in the delay hash is
> + *     requested (e.g. "test-delay10.a") then the filter responds with
> + *     a "delay" status and sets the "requested" field in the delay has=
h.
> + *     The filter will signal the availability of this object after
> + *     "count" (field in delay hash) "list_available_blobs" commands.
> + * (6) If data with the pathname "missing-delay.a" is processed that th=
e
> + *     filter will drop the path from the "list_available_blobs" respon=
se.
> + * (7) If data with the pathname "invalid-delay.a" is processed that th=
e
> + *     filter will add the path "unfiltered" which was not delayed befo=
re
> + *     to the "list_available_blobs" response.
> + */
> +
> +#include "test-tool.h"
> +#include "pkt-line.h"
> +#include "string-list.h"
> +#include "strmap.h"
> +
> +static FILE *logfile;
> +static int always_delay;
> +static struct strmap delay =3D STRMAP_INIT;
> +static struct string_list requested_caps =3D STRING_LIST_INIT_NODUP;
> +
> +static int has_capability(const char *cap)
> +{
> +	return unsorted_string_list_has_string(&requested_caps, cap);
> +}
> +
> +static char *rot13(char *str)
> +{
> +	char *c;
> +	for (c =3D str; *c; c++) {
> +		if (*c >=3D 'a' && *c <=3D 'z')
> +			*c =3D 'a' + (*c - 'a' + 13) % 26;
> +		else if (*c >=3D 'A' && *c <=3D 'Z')
> +			*c =3D 'A' + (*c - 'A' + 13) % 26;

That's quite verbose, but it _is_ correct (if a bit harder than necessary
to validate, I admit that I had to look up whether `%`'s precedence is hig=
her
than `+` in https://en.cppreference.com/w/c/language/operator_precedence).

A conciser way (also easier to reason about):

	for (c =3D str; *c; c++)
		if (isalpha(*c))
			*c +=3D tolower(*c) < 'n' ? 13 : -13;

For fun, you could also look at
https://hea-www.harvard.edu/~fine/Tech/rot13.html whether you want to use
yet another approach.

> +	}
> +	return str;
> +}
> +
> +static char *skip_key_dup(const char *buf, size_t size, const char *key=
)
> +{
> +	struct strbuf keybuf =3D STRBUF_INIT;
> +	strbuf_addf(&keybuf, "%s=3D", key);
> +	if (!skip_prefix_mem(buf, size, keybuf.buf, &buf, &size) || !size)
> +		die("bad %s: '%s'", key, xstrndup(buf, size));
> +	strbuf_release(&keybuf);
> +	return xstrndup(buf, size);

This does what we want it to do, but it looks as if it was code translated
from a language that does not care one bit about allocations to a language
that cares a lot.

For example, instead of allocating a `strbuf` just to append `=3D` to the
key, in idiomatic C this code would read like this:

static char *get_value(char *buf, size_t size, const char *key)
{
	const char *orig_buf =3D buf;
	int orig_size =3D (int)size;

	if (!skip_prefix_mem(buf, size, key, &buf, &size) ||
	    !skip_prefix_mem(buf, size, "=3D", &buf, &size) ||
	    !size)
		die("expected key '%s', got '%.*s'",
		    key, orig_size, orig_buf);

	return xstrndup(buf, size);
}

I was tempted, even, to suggest returning a `const char *` after
NUL-terminating the line (via `buf[size] =3D '\0';`) instead of
`xstrndup()`ing it, but `packet_read_line()` reads into the singleton
`packet_buffer` and we use e.g. the `command` that is returned from this
function after reading the next packet, so the command would most likely
be overwritten.

> +}
> +
> +/*
> + * Read a text packet, expecting that it is in the form "key=3Dvalue" f=
or
> + * the given key. An EOF does not trigger any error and is reported
> + * back to the caller with NULL. Die if the "key" part of "key=3Dvalue"=
 does
> + * not match the given key, or the value part is empty.
> + */
> +static char *packet_key_val_read(const char *key)
> +{
> +	int size;
> +	char *buf;
> +	if (packet_read_line_gently(0, &size, &buf) < 0)
> +		return NULL;
> +	return skip_key_dup(buf, size, key);
> +}
> +
> +static void packet_read_capabilities(struct string_list *caps)
> +{
> +	while (1) {

In Git's source code, I think we prefer `for (;;)`. But not by much:

$ git grep 'while (1)' \*.c | wc
    128     508    3745

$ git grep 'for (;;)' \*.c | wc
    156     614    4389

> +		int size;
> +		char *buf =3D packet_read_line(0, &size);
> +		if (!buf)
> +			break;
> +		string_list_append_nodup(caps,
> +					 skip_key_dup(buf, size, "capability"));

It is tempting to use unsorted string lists for everything because Perl
makes that relatively easy.

However, in this instance I would strongly recommend using something more
akin to Perl's "hash" data structure, in this instance a `strset`.

> +	}
> +}
> +
> +/* Read remote capabilities and check them against capabilities we requ=
ire */
> +static void packet_read_and_check_capabilities(struct string_list *remo=
te_caps,
> +					       struct string_list *required_caps)
> +{
> +	struct string_list_item *item;
> +	packet_read_capabilities(remote_caps);
> +	for_each_string_list_item(item, required_caps) {
> +		if (!unsorted_string_list_has_string(remote_caps, item->string)) {
> +			die("required '%s' capability not available from remote",
> +			    item->string);
> +		}
> +	}
> +}

This is a pretty literal translation from Perl to C, and a couple of years
ago, I would have done the same.

However, these days I would recommend against it. In this instance, we are
really only interested in three capabilities: clean, smudge and delay. It
is much, much simpler to read in the capabilities and then manually verify
that the three required ones were included:

static void read_capabilities(struct strset *remote_caps)
{
	char *cap
	while ((cap =3D packet_key_val_read("capability")))
		strset_add(remote_caps, cap);

	if (!strset_contains(remote_caps, "clean"))
		die("required 'clean' capability not available from remote");
	if (!strset_contains(remote_caps, "smudge"))
		die("required 'smudge' capability not available from remote");
	if (!strset_contains(remote_caps, "delay"))
		die("required 'delay' capability not available from remote");
}

> +
> +/*
> + * Check our capabilities we want to advertise against the remote ones
> + * and then advertise our capabilities
> + */
> +static void packet_check_and_write_capabilities(struct string_list *rem=
ote_caps,
> +						struct string_list *our_caps)

The list of "our caps" comes from the command-line. In C, this means we
get a `const char **argv` and an `int argc`. So:

static void check_and_write_capabilities(struct strset *remote_caps,
					 const char **caps, int caps_count)
{
	int i;

	for (i =3D 0; i < caps_count; i++) {
		if (!strset_contains(remote_caps, caps[i]))
			die("our capability '%s' is not available from remote",
			    caps[i]);

		packet_write_fmt(1, "capability=3D%s\n", caps[i]);
	}
	packet_flush(1);
}

And then we would call it via

	check_and_write_capabilities(remote_caps, argv + 1, argc - 1);

> +
> +struct delay_entry {
> +	int requested, count;
> +	char *output;
> +};

Since you declare this here, it makes most sense to define
`free_delay_hash()` (which should really be named `free_delay_entries()`)
and `add_delay_entry()` here.

> +
> +static void command_loop(void)
> +{
> +	while (1) {
> +		char *command =3D packet_key_val_read("command");
> +		if (!command) {
> +			fprintf(logfile, "STOP\n");
> +			break;
> +		}
> +		fprintf(logfile, "IN: %s", command);

We will also need to `fflush(logfile)` here, to imitate the Perl script's
behavior more precisely.

> +
> +		if (!strcmp(command, "list_available_blobs")) {
> +			struct hashmap_iter iter;
> +			struct strmap_entry *ent;
> +			struct string_list_item *str_item;
> +			struct string_list paths =3D STRING_LIST_INIT_NODUP;
> +
> +			/* flush */
> +			if (packet_read_line(0, NULL))
> +				die("bad list_available_blobs end");
> +
> +			strmap_for_each_entry(&delay, &iter, ent) {
> +				struct delay_entry *delay_entry =3D ent->value;
> +				if (!delay_entry->requested)
> +					continue;
> +				delay_entry->count--;
> +				if (!strcmp(ent->key, "invalid-delay.a")) {
> +					/* Send Git a pathname that was not delayed earlier */
> +					packet_write_fmt(1, "pathname=3Dunfiltered");
> +				}
> +				if (!strcmp(ent->key, "missing-delay.a")) {
> +					/* Do not signal Git that this file is available */
> +				} else if (!delay_entry->count) {
> +					string_list_insert(&paths, ent->key);
> +					packet_write_fmt(1, "pathname=3D%s", ent->key);
> +				}
> +			}
> +
> +			/* Print paths in sorted order. */

The Perl script does not order them specifically. Do we really have to do
that here?

In any case, it is more performant to append the paths in an unsorted way
and then sort them once in the end (that's O(N log(N)) instead of O(N^2)).

> +			for_each_string_list_item(str_item, &paths)
> +				fprintf(logfile, " %s", str_item->string);
> +			string_list_clear(&paths, 0);
> +
> +			packet_flush(1);
> +
> +			fprintf(logfile, " [OK]\n");
> +			packet_write_fmt(1, "status=3Dsuccess");
> +			packet_flush(1);

I know the Perl script uses an else here, but I'd much rather insert a
`continue` at the end of the `list_available_blobs` clause and de-indent
the remainder of the loop body.

> +		} else {
> +			char *buf, *output;
> +			int size;
> +			char *pathname;
> +			struct delay_entry *entry;
> +			struct strbuf input =3D STRBUF_INIT;
> +
> +			pathname =3D packet_key_val_read("pathname");
> +			if (!pathname)
> +				die("unexpected EOF while expecting pathname");
> +			fprintf(logfile, " %s", pathname);

Again, let's `fflush(logfile)` here.

> +
> +			/* Read until flush */
> +			buf =3D packet_read_line(0, &size);
> +			while (buf) {

Let's write this in more idiomatic C:

			while ((buf =3D packet_read_line(0, &size))) {

> +				if (!strcmp(buf, "can-delay=3D1")) {
> +					entry =3D strmap_get(&delay, pathname);
> +					if (entry && !entry->requested) {
> +						entry->requested =3D 1;
> +					} else if (!entry && always_delay) {
> +						entry =3D xcalloc(1, sizeof(*entry));
> +						entry->requested =3D 1;
> +						entry->count =3D 1;
> +						strmap_put(&delay, pathname, entry);

I guess here is our chance to extend the signature of `add_delay_entry()`
to accept a `requested` parameter, and to call that here.

> +					}
> +				} else if (starts_with(buf, "ref=3D") ||
> +					   starts_with(buf, "treeish=3D") ||
> +					   starts_with(buf, "blob=3D")) {
> +					fprintf(logfile, " %s", buf);
> +				} else {
> +					/*
> +					 * In general, filters need to be graceful about
> +					 * new metadata, since it's documented that we
> +					 * can pass any key-value pairs, but for tests,
> +					 * let's be a little stricter.
> +					 */
> +					die("Unknown message '%s'", buf);
> +				}
> +				buf =3D packet_read_line(0, &size);
> +			}
> +
> +
> +			read_packetized_to_strbuf(0, &input, 0);
> +			fprintf(logfile, " %"PRIuMAX" [OK] -- ", (uintmax_t)input.len);

This reads _so much nicer_ than the Perl version!

> +
> +			entry =3D strmap_get(&delay, pathname);
> +			if (entry && entry->output) {
> +				output =3D entry->output;
> +			} else if (!strcmp(pathname, "error.r") || !strcmp(pathname, "abort.=
r")) {
> +				output =3D "";
> +			} else if (!strcmp(command, "clean") && has_capability("clean")) {
> +				output =3D rot13(input.buf);
> +			} else if (!strcmp(command, "smudge") && has_capability("smudge")) {
> +				output =3D rot13(input.buf);
> +			} else {
> +				die("bad command '%s'", command);
> +			}
> +
> +			if (!strcmp(pathname, "error.r")) {
> +				fprintf(logfile, "[ERROR]\n");
> +				packet_write_fmt(1, "status=3Derror");
> +				packet_flush(1);
> +			} else if (!strcmp(pathname, "abort.r")) {
> +				fprintf(logfile, "[ABORT]\n");
> +				packet_write_fmt(1, "status=3Dabort");
> +				packet_flush(1);
> +			} else if (!strcmp(command, "smudge") &&
> +				   (entry =3D strmap_get(&delay, pathname)) &&
> +				   entry->requested =3D=3D 1) {
> +				fprintf(logfile, "[DELAYED]\n");
> +				packet_write_fmt(1, "status=3Ddelayed");
> +				packet_flush(1);
> +				entry->requested =3D 2;
> +				entry->output =3D xstrdup(output);

We need to call `free(entry->output)` before that lest we leak memory, but
only if `output` is not identical anyway:

				if (entry->output !=3D output) {
					free(entry->output);
					entry->output =3D xstrdup(output);
				}


> +			} else {
> +				int i, nr_packets;
> +				size_t output_len;
> +				struct strbuf sb =3D STRBUF_INIT;
> +				packet_write_fmt(1, "status=3Dsuccess");
> +				packet_flush(1);
> +
> +				strbuf_addf(&sb, "%s-write-fail.r", command);
> +				if (!strcmp(pathname, sb.buf)) {

We can easily avoid allocating the string just for comparing it:

				const char *p;

				if (skip_prefix(pathname, command, &p) &&
				    !strcmp(p, "-write-fail.r")) {

> +					fprintf(logfile, "[WRITE FAIL]\n");

					fflush(logfile) ;-)

> +					die("%s write error", command);
> +				}
> +
> +				output_len =3D strlen(output);
> +				fprintf(logfile, "OUT: %"PRIuMAX" ", (uintmax_t)output_len);
> +
> +				if (write_packetized_from_buf_no_flush_count(output,
> +					output_len, 1, &nr_packets))
> +					die("failed to write buffer to stdout");
> +				packet_flush(1);
> +
> +				for (i =3D 0; i < nr_packets; i++)
> +					fprintf(logfile, ".");

That's not quite the same as the Perl script does: it prints a '.'
(without flushing, though) _every_ time it wrote a packet.

If you want to emulate that, you will have to copy/edit that loop (and in
that case, the insanely long-named function
`write_packetized_from_buf_no_flush_count()` is unnecessary, too).

> +				fprintf(logfile, " [OK]\n");
> +
> +				packet_flush(1);
> +				strbuf_release(&sb);
> +			}
> +			free(pathname);
> +			strbuf_release(&input);
> +		}
> +		free(command);
> +	}
> +}
> +
> +static void free_delay_hash(void)
> +{
> +	struct hashmap_iter iter;
> +	struct strmap_entry *ent;
> +
> +	strmap_for_each_entry(&delay, &iter, ent) {
> +		struct delay_entry *delay_entry =3D ent->value;
> +		free(delay_entry->output);
> +		free(delay_entry);
> +	}
> +	strmap_clear(&delay, 0);
> +}
> +
> +static void add_delay_entry(char *pathname, int count)
> +{
> +	struct delay_entry *entry =3D xcalloc(1, sizeof(*entry));
> +	entry->count =3D count;
> +	if (strmap_put(&delay, pathname, entry))
> +		BUG("adding the same path twice to delay hash?");
> +}
> +
> +static void packet_initialize(const char *name, int version)
> +{
> +	struct strbuf sb =3D STRBUF_INIT;
> +	int size;
> +	char *pkt_buf =3D packet_read_line(0, &size);
> +
> +	strbuf_addf(&sb, "%s-client", name);
> +	if (!pkt_buf || strncmp(pkt_buf, sb.buf, size))

We do not need the flexibility of the Perl package, where `name` is a
parameter. We can hard-code `git-filter-client` here. I.e. something like
this:

	if (!pkt_buf || size !=3D 17 ||
	    strncmp(pkt_buf, "git-filter-client", 17))

> +		die("bad initialize: '%s'", xstrndup(pkt_buf, size));
> +
> +	strbuf_reset(&sb);
> +	strbuf_addf(&sb, "version=3D%d", version);

Same here. We do not need to allocate a string just to compare it to the
packet's payload.

> +	pkt_buf =3D packet_read_line(0, &size);
> +	if (!pkt_buf || strncmp(pkt_buf, sb.buf, size))
> +		die("bad version: '%s'", xstrndup(pkt_buf, size));
> +
> +	pkt_buf =3D packet_read_line(0, &size);
> +	if (pkt_buf)
> +		die("bad version end: '%s'", xstrndup(pkt_buf, size));
> +
> +	packet_write_fmt(1, "%s-server", name);
> +	packet_write_fmt(1, "version=3D%d", version);
> +	packet_flush(1);
> +	strbuf_release(&sb);
> +}
> +
> +static char *rot13_usage =3D "test-tool rot13-filter [--always-delay] <=
log path> <capabilities>";
> +
> +int cmd__rot13_filter(int argc, const char **argv)
> +{
> +	int i =3D 1;
> +	struct string_list remote_caps =3D STRING_LIST_INIT_DUP,
> +			   supported_caps =3D STRING_LIST_INIT_NODUP;
> +
> +	string_list_append(&supported_caps, "clean");
> +	string_list_append(&supported_caps, "smudge");
> +	string_list_append(&supported_caps, "delay");
> +
> +	if (argc > 1 && !strcmp(argv[i], "--always-delay")) {
> +		always_delay =3D 1;
> +		i++;
> +	}
> +	if (argc - i < 2)
> +		usage(rot13_usage);
> +
> +	logfile =3D fopen(argv[i++], "a");
> +	if (!logfile)
> +		die_errno("failed to open log file");
> +
> +	for ( ; i < argc; i++)
> +		string_list_append(&requested_caps, argv[i]);
> +
> +	add_delay_entry("test-delay10.a", 1);
> +	add_delay_entry("test-delay11.a", 1);
> +	add_delay_entry("test-delay20.a", 2);
> +	add_delay_entry("test-delay10.b", 1);
> +	add_delay_entry("missing-delay.a", 1);
> +	add_delay_entry("invalid-delay.a", 1);
> +
> +	fprintf(logfile, "START\n");
> +
> +	packet_initialize("git-filter", 2);
> +
> +	packet_read_and_check_capabilities(&remote_caps, &supported_caps);
> +	packet_check_and_write_capabilities(&remote_caps, &requested_caps);
> +	fprintf(logfile, "init handshake complete\n");
> +
> +	string_list_clear(&supported_caps, 0);
> +	string_list_clear(&remote_caps, 0);
> +
> +	command_loop();
> +
> +	fclose(logfile);
> +	string_list_clear(&requested_caps, 0);
> +	free_delay_hash();
> +	return 0;
> +}

Other than that, this looks great!

Thank you,
Dscho

