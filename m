From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Remove the hard coded length limit on variable names
 in config files
Date: Sun, 30 Sep 2012 06:05:51 +0200
Message-ID: <5067C51F.6020908@alum.mit.edu>
References: <7vpq5yzkf3.fsf@alter.siamese.dyndns.org> <1348913979-27431-1-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 30 06:06:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIAns-0000jz-Kj
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 06:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780Ab2I3EF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 00:05:56 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:48129 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750698Ab2I3EFz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Sep 2012 00:05:55 -0400
X-AuditID: 12074412-b7f216d0000008e3-ec-5067c522e975
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 0D.C7.02275.225C7605; Sun, 30 Sep 2012 00:05:54 -0400 (EDT)
Received: from [192.168.69.140] (p57A251D2.dip.t-dialin.net [87.162.81.210])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8U45q5h014354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 30 Sep 2012 00:05:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <1348913979-27431-1-git-send-email-bdwalton@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqKt0ND3A4NZCbYsPs5tZLLqudDNZ
	NPReYXZg9tg56y67x8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGecnzGRueCdU8WXhomsDYxn
	jboYOTkkBEwkZu55xgphi0lcuLeerYuRi0NI4DKjxIH725kgnDNMEltnf2cCqeIV0JZ42LyY
	GcRmEVCVeLHmBSOIzSagK7GopxmsRlQgRGLG5cnMEPWCEidnPmEBsUUElCXuHvrDDmIzC2hJ
	rGvpZQOxhQWiJZa2HgGrERLIkfh6dg9YnFPAWeLqjm2sEPU6Eu/6HjBD2PIS29/OYZ7AKDAL
	yYpZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXTC83s0QvNaV0EyMkeIV2MK4/
	KXeIUYCDUYmHd+aC9AAh1sSy4srcQ4ySHExKorwy+4BCfEn5KZUZicUZ8UWlOanFhxglOJiV
	RHgzilMDhHhTEiurUovyYVLSHCxK4rw/F6v7CQmkJ5akZqemFqQWwWRlODiUJHjNjgANFSxK
	TU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAfFanwxMFpBUjxAe+VB2nmLCxJzgaIQracY
	jTl2nljwgJFj7V0gKcSSl5+XKiXO6wZSKgBSmlGaB7cIlrZeMYoD/S3Mqw1SxQNMeXDzXgGt
	YgJaVbUqDWRVSSJCSqqBsf+GVlZzwf05trlMJbE8zd7sm/jXqpzgFfh2pSWnS7TAi/dpmLQa
	h+oa32XiTC3Xl4an+q/uU3uy//vbLUV9DSyB13Kv3dj439Pf7ewe1f3xPrUJX28t 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206664>

On 09/29/2012 12:19 PM, Ben Walton wrote:
> Previously while reading the variable names in config files, there was
> a 256 character limit with at most 128 of those characters being used
> by the section header portion of the variable name.  This limitation
> was only enforced while reading the config files.  It was possible to
> write a config file that was not subsequently readable.
> 
> Instead of enforcing this limitation for both reading and writing,
> remove it entirely by changing the var member of the config_file
> struct to a strbuf instead of a fixed length buffer.  Update all of
> the parsing functions in config.c to use the strbuf instead of the
> static buffer.  Send the buf member of the strbuf to external callback
> functions to preserve the external api.
> 
> Signed-off-by: Ben Walton <bdwalton@gmail.com>
> ---
> Hi Junio,
> 
> (Sorry that this patch took so long to submit.  I've been busy moving.)

The patch doesn't apply to the current master; it appears to have been
built against master 883a2a3504 (2012-02-23) or older.  It will have to
be rebased to the current master.

Nevertheless I will add a few comments below.

Overall, I like your approach of using strbuf here, as it is simpler to
use and less error-prone.  It is also nice to get rid of an arbitrary
length limit, especially since it was not consistently enforced.

> I think this should remove the length limitations enforced while reading
> configuration file variable names.
> 
> Thanks
> -Ben
> 
>  config.c |   50 +++++++++++++++++++++++---------------------------
>  1 file changed, 23 insertions(+), 27 deletions(-)
> 
> diff --git a/config.c b/config.c
> index 40f9c6d..ee860a7 100644
> --- a/config.c
> +++ b/config.c
> @@ -10,8 +10,6 @@
>  #include "strbuf.h"
>  #include "quote.h"
>  
> -#define MAXNAME (256)
> -
>  typedef struct config_file {
>  	struct config_file *prev;
>  	FILE *f;
> @@ -19,7 +17,7 @@ typedef struct config_file {
>  	int linenr;
>  	int eof;
>  	struct strbuf value;
> -	char var[MAXNAME];
> +	struct strbuf var;
>  } config_file;
>  
>  static config_file *cf;
> @@ -191,7 +189,7 @@ static inline int iskeychar(int c)
>  	return isalnum(c) || c == '-';
>  }
>  
> -static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
> +static int get_value(config_fn_t fn, void *data, struct strbuf *name)
>  {
>  	int c;
>  	char *value;
> @@ -203,11 +201,9 @@ static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
>  			break;
>  		if (!iskeychar(c))
>  			break;
> -		name[len++] = tolower(c);
> -		if (len >= MAXNAME)
> -			return -1;
> +		strbuf_addch(name, tolower(c));
>  	}
> -	name[len] = 0;
> +
>  	while (c == ' ' || c == '\t')
>  		c = get_next_char();
>  
> @@ -219,10 +215,10 @@ static int get_value(config_fn_t fn, void *data, char *name, unsigned int len)
>  		if (!value)
>  			return -1;
>  	}
> -	return fn(name, value, data);
> +	return fn(name->buf, value, data);
>  }
>  
> -static int get_extended_base_var(char *name, int baselen, int c)
> +static int get_extended_base_var(struct strbuf *name, int c)
>  {
>  	do {
>  		if (c == '\n')
> @@ -233,7 +229,7 @@ static int get_extended_base_var(char *name, int baselen, int c)
>  	/* We require the format to be '[base "extension"]' */
>  	if (c != '"')
>  		return -1;
> -	name[baselen++] = '.';
> +	strbuf_addch(name, '.');
>  
>  	for (;;) {
>  		int c = get_next_char();
> @@ -246,34 +242,30 @@ static int get_extended_base_var(char *name, int baselen, int c)
>  			if (c == '\n')
>  				return -1;
>  		}
> -		name[baselen++] = c;
> -		if (baselen > MAXNAME / 2)
> -			return -1;
> +		strbuf_addch(name, c);
>  	}
>  
>  	/* Final ']' */
>  	if (get_next_char() != ']')
>  		return -1;
> -	return baselen;
> +	return name->len;
>  }
>  
> -static int get_base_var(char *name)
> +static int get_base_var(struct strbuf *name)
>  {
> -	int baselen = 0;
> +	strbuf_reset(name);
>  
>  	for (;;) {
>  		int c = get_next_char();
>  		if (cf->eof)
>  			return -1;
>  		if (c == ']')
> -			return baselen;
> +			return name->len;
>  		if (isspace(c))
> -			return get_extended_base_var(name, baselen, c);
> +			return get_extended_base_var(name, c);
>  		if (!iskeychar(c) && c != '.')
>  			return -1;
> -		if (baselen > MAXNAME / 2)
> -			return -1;
> -		name[baselen++] = tolower(c);
> +		strbuf_addch(name, tolower(c));
>  	}
>  }
>  
> @@ -281,7 +273,7 @@ static int git_parse_file(config_fn_t fn, void *data)
>  {
>  	int comment = 0;
>  	int baselen = 0;
> -	char *var = cf->var;
> +	struct strbuf *var = &cf->var;
>  
>  	/* U+FEFF Byte Order Mark in UTF8 */
>  	static const unsigned char *utf8_bom = (unsigned char *) "\xef\xbb\xbf";
> @@ -320,14 +312,16 @@ static int git_parse_file(config_fn_t fn, void *data)
>  			baselen = get_base_var(var);
>  			if (baselen <= 0)
>  				break;
> -			var[baselen++] = '.';
> -			var[baselen] = 0;
> +			strbuf_addch(var, '.');
>  			continue;
>  		}
>  		if (!isalpha(c))
>  			break;
> -		var[baselen] = tolower(c);
> -		if (get_value(fn, data, var, baselen+1) < 0)
> +		/* Truncate the var name back to the section header prior to
> +		   grabbing the suffix part of the name and the value */
> +		strbuf_setlen(var, baselen+1);
> +		strbuf_addch(var, tolower(c));
> +		if (get_value(fn, data, var) < 0)
>  			break;
>  	}
>  	die("bad config file line %d in %s", cf->linenr, cf->name);

The preferred format for multiline comments in the git project is

    /*
     * Truncate the var name back to the section header prior to
     * grabbing the suffix part of the name and the value.
     */

It took me a while to figure out what you were doing here.  Let me
explain why.

In the old code, get_base_var() read the string into var and returned
var's length (or -1 on error).  The fact that the length of var was
first "reset" to zero is somewhat implicit in the fact that no length
parameter is being passed to get_base_var().

But in the new version, get_base_var() is passed a strbuf.  Often,
operations with strbufs append to the strbuf, and this is what I first
assumed.  It took me a while to realize that get_base_var() calls
strbuf_reset() before getting to work.  Moreover, get_base_var() still
returns the length of what it found, which is redundant with a strbuf
and therefore unexpected.  So when the return value of get_base_var() is
stored into baselen, it is not really obvious that it is the string's
length.

Therefore, I suggest

* Call strbuf_reset() directly in get_parse_file() rather than in
get_base_var()

* Change get_base_var() to return 0 on success (rather than the length
of the string) and -1 on error (including length==0, which is also an
error in this context).

* Change how get_parse_file() initializes baselen to

        if (get_base_var(var) < 0)
                break;
        strbuf_addch(var, '.');
        baselen = var->len;

Note that baselen now includes the trailing dot.  Then later, you don't
need the "+1":

        /*
         * Truncate the var name back to (section header plus '.')
         * prior to grabbing the suffix part of the name and the value
         */
        strbuf_setlen(var, baselen);
        strbuf_addch(var, tolower(c));
        if (get_value(fn, data, var) < 0)
        [...]

> @@ -842,12 +836,14 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
>  		top.linenr = 1;
>  		top.eof = 0;
>  		strbuf_init(&top.value, 1024);
> +		strbuf_init(&top.var, 1024);
>  		cf = &top;
>  
>  		ret = git_parse_file(fn, data);
>  
>  		/* pop config-file parsing state stack */
>  		strbuf_release(&top.value);
> +		strbuf_release(&top.var);
>  		cf = top.prev;
>  
>  		fclose(f);
> 

Finally, I realize that the MAXNAME constant was not exported and I
can't find the old length limits documented anywhere, but I nevertheless
worry a little bit that one of the users of the config API has a
built-in assumption that names can never be longer than 256 characters
(for example, a config_fn_t function might try to store the name into a
fixed-length buffer).  Hopefully such code would never have been written
or accepted, but...?  If you have thought about this or audited the
callers, please mention that in your commit message.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
