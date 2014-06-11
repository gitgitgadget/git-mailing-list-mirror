From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 01/19] add strbuf_set operations
Date: Wed, 11 Jun 2014 14:05:35 +0200
Message-ID: <5398460F.3040900@alum.mit.edu>
References: <cover.1402348696.git.jmmahler@gmail.com> <6fe33498512fc2ca1678517e51dc2e94a4260ff4.1402348696.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 14:05:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuhHl-0006aa-HO
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 14:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbaFKMFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 08:05:41 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:52554 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750817AbaFKMFk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2014 08:05:40 -0400
X-AuditID: 12074414-f79f86d000000b9f-37-539846135821
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 6C.EC.02975.31648935; Wed, 11 Jun 2014 08:05:39 -0400 (EDT)
Received: from [172.16.46.14] ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5BC5bQd010536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 11 Jun 2014 08:05:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <6fe33498512fc2ca1678517e51dc2e94a4260ff4.1402348696.git.jmmahler@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsUixO6iqCvsNiPYYPcdI4uuK91MFm8e5Vqc
	edPI6MDssXPWXXaPxQ+8PD5vkgtgjuK2SUosKQvOTM/Tt0vgzjjx8zdrQY98xf7XC9kbGH+L
	dzFyckgImEhM3X6DFcIWk7hwbz1bFyMXh5DAZUaJeQ+/sUA4G5gkfly5D1bFK6AtsWTxO6AE
	BweLgKrE9aVOIGE2AV2JRT3NTCC2qECQxOzP89ghygUlTs58wgJiiwhEScy7cxmslVlAXKL/
	H1hYWMBc4sDyz2DThQSaGCXOH5UDsTkFIiV2H33JDlIuAVTe0xgEEmYW0JF41/eAGcKWl9j+
	dg7zBEbBWUiWzUJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuhZ6uZkleqkppZsY
	IcEssoPxyEm5Q4wCHIxKPLwKO6YHC7EmlhVX5h5ilORgUhLlbXCcESzEl5SfUpmRWJwRX1Sa
	k1p8iFGCg1lJhFfXBCjHm5JYWZValA+TkuZgURLn/bZY3U9IID2xJDU7NbUgtQgmK8PBoSTB
	K+sK1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPit74YmD8gqR4gPaKgLTzFhck
	5gJFIVpPMRpznLpzrI2J40PvmTYmIZa8/LxUKXHedmegUgGQ0ozSPLhFsDT2ilEc6G9h3hcu
	QFU8wBQIN+8V0ComoFWvPaeDrCpJREhJNTCuc1yuEaR7bnEyU70Ts28V/5esf+yT9E6oBdUt
	8DD8ev31gn0znvwyLNETf1S8lmWX/B1PjRszlnqbvnKMyT+w7PDP3yfm3l9wUado 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251364>

On 06/10/2014 12:19 AM, Jeremiah Mahler wrote:
> Currently, the data in a strbuf is modified using add operations.  To
> set the buffer to some data a reset must be performed before an add.
> 
>   strbuf_reset(buf);
>   strbuf_add(buf, cb.buf.buf, cb.buf.len);
> 
> And this is a common sequence of operations with 70 occurrences found in
> the current source code.  This includes all the different variations
> (add, addf, addstr, addbuf, addch).
> 
>   FILES=`find ./ -name '*.c'`
>   CNT=$(pcregrep -M "strbuf_reset.*\n.*strbuf_add" $FILES | wc -l)
>   CNT=$(echo "$CNT / 2" | bc)
>   echo $CNT
>   70
> 
> These patches add strbuf_set operations which allow this common sequence
> to be performed in one line instead of two.
> 
>   strbuf_set(buf, cb.buf.buf, cb.buf.len);
> 
> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
> ---
>  Documentation/technical/api-strbuf.txt | 18 ++++++++++++++++++
>  strbuf.c                               | 21 +++++++++++++++++++++
>  strbuf.h                               | 14 ++++++++++++++
>  3 files changed, 53 insertions(+)
> 
> diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
> index 077a709..b7e23da 100644
> --- a/Documentation/technical/api-strbuf.txt
> +++ b/Documentation/technical/api-strbuf.txt
> @@ -149,6 +149,24 @@ Functions
>  	than zero if the first buffer is found, respectively, to be less than,
>  	to match, or be greater than the second buffer.
>  
> +* Setting the buffer
> +
> +`strbuf_set`::
> +
> +	Replace the buffer content with data of a given length.
> +
> +`strbuf_setstr`::
> +
> +	Replace the buffer content with data from a NUL-terminated string.
> +
> +`strbuf_setf`::
> +
> +	Replace the buffer content with a formatted string.
> +
> +`strbuf_setbuf`::
> +
> +	Replace the buffer content with data from another buffer.
> +
>  * Adding data to the buffer
>  
>  NOTE: All of the functions in this section will grow the buffer as necessary.
> diff --git a/strbuf.c b/strbuf.c
> index ac62982..9d64b00 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -189,6 +189,27 @@ void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
>  	strbuf_setlen(sb, sb->len + dlen - len);
>  }
>  
> +void strbuf_set(struct strbuf *sb, const void *data, size_t len)
> +{
> +	strbuf_reset(sb);
> +	strbuf_add(sb, data, len);
> +}
> +

I never know how much intelligence to attribute to modern compilers, but
it seems like even after optimization this function will be doing more
work than necessary:

    strbuf_reset(sb)
    -> strbuf_setlen(sb, 0)
       -> sb->len = 0
       -> sb->buf[len] = '\0'
    -> strbuf_add(sb, data, len)
       -> strbuf_grow(sb, len)
          -> ...lots of stuff...
       -> memcpy(sb->buf + sb->len, data, len)
       -> strbuf_setlen(sb, sb->len + len)
          -> sb->len = len
          -> sb->buf[len] = '\0'

If there were a function like strbuf_grow_to(sb, len):

void strbuf_grow_to(struct strbuf *sb, size_t len)
{
	int new_buf = !sb->alloc;
	if (unsigned_add_overflows(len, 1))
		die("you want to use way too much memory");
	if (new_buf)
		sb->buf = NULL;
	ALLOC_GROW(sb->buf, len + 1, sb->alloc);
	if (new_buf)
		sb->buf[0] = '\0';
}

(strbuf_grow() could call it:

static inline void strbuf_grow(struct strbuf *sb, size_t extra)
{
	if (unsigned_add_overflows(sb->len, extra))
		die("you want to use way too much memory");
	strbuf_grow_to(sb, sb->len + extra);
}

), then your function could be minimized to

void strbuf_set(struct strbuf *sb, const void *data, size_t len)
{
	strbuf_grow_to(sb, len);
	memcpy(sb->buf, data, len);
	strbuf_setlen(sb, len);
}

I think strbuf_grow_to() would be useful in other situations too.

This is just an idea; I'm not saying that you have to make this change.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
