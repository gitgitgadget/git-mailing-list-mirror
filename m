From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add: add --chmod=+x / --chmod=-x options
Date: Wed, 25 May 2016 09:46:17 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605250923120.4449@virtualbox>
References: <20160525020609.GA20123@zoidberg>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Edward Thomson <ethomson@edwardthomson.com>
X-From: git-owner@vger.kernel.org Wed May 25 09:52:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5TcS-00005U-0N
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 09:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbcEYHwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 03:52:40 -0400
Received: from mout.gmx.net ([212.227.15.19]:54579 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963AbcEYHwj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 03:52:39 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lgql4-1brU6125Re-00oFNY; Wed, 25 May 2016 09:52:35
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160525020609.GA20123@zoidberg>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:y0MTGRM+5ApK5acieh6KssIK2EmS1X8E+qpqZ97Duvab1v75d0K
 hk9hT8xTyGQ9KLa6Vh9kjgZBUJZjzs+ZiyzNOHJGVSNz6hZpM5M+RA5AnKOt7gi7Ald5k/s
 CH0Wf1JCE6BxuxTceRemCVatIQO4xskJB0a5eK7FL2c9urNxmf1g0WqveyBZah8cEE/nA3p
 0X87GBl+tWGWXwt3Bl3+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3JpcM2bGbIQ=:Zo7QLYNFJEgwpjhAf3kRN/
 Vo2ZPY4OT6gHfst5B30qSFggqfs8Rm/1MfEsr+yOKw9FpzsZI3HNsf7GCnnCaPANxg0geGyrK
 +m0Qlm+1Y+DtCtHXlq5YfqsuCiHlO8noGsqYVo7DDROBL76u7vu0Lwx4XjWrJoAIqdObJ/uc8
 GdpxfcY3+i2TUPNmCi54L1W4PZsKdvFsomxr0OMQhOoGwq4cB8ogY2WZ98TkD5XUnNTJTmjc9
 7ytAjUGTLbQpyImcuLzxo8hYUsGXLTmKbVho28KoYtI4F10AEg0cvc5NZ6OkWd6tjuj/2meog
 xUR7XXmGWOG7874hdxERp/M0IvVGQGoB9g1bOWK/kw0kTTOiUnVIMXK8KAz09lU0kDBSq32EQ
 dVRQRuD0Pznyv9ba6be1S8EBiQjUFLub/y+ns3R+Ai5FUWFQFR5p66JWCKah+sbUQjY641XlQ
 MfBMZxfPwRX+ImY/WXuXMN267N6XyGo5qcaQHW3Fw+Jww6kaK/uR1IT7dVDMJtt+8js/3BNel
 Lqit29d6myEa4f4Nw24w4otoiO5eVsvvKVyZh71eTws+1ppFt6E4aJlmi02taPH7/K0pxmxG7
 4C7Gm8IPSSOrkWl9+FkaMRpBxALGK4n3PYjsrj9T1F60ljQyUJ25ruDwO/RGnW+9+SYCBrwIF
 OBml6aGhU9UEO+27RBthh8bu3s94CkI54YnkZrGRGkETWyJ0hwkHW6wFOqv44Pc/qP+2b1iUk
 3zphr2/ioGgANRIBIU/g4MZroS6HIPqr4hsbcny5ByHwJN0Mxf8o6agBiv6ROa8QnW5oIozz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295569>

Hi Ed,

On Tue, 24 May 2016, Edward Thomson wrote:

> Users on deficient filesystems that lack an execute bit may still
> wish to add files to the repository with the appropriate execute
> bit set (or not).  Although this can be done in two steps
> (`git add foo && git update-index --chmod=+x foo`), providing the
> `--chmod=+x` option to the add command allows users to set a file
> executable in a single command that they're already familiar with.
> 
> Signed-off-by: Edward Thomson <ethomson@edwardthomson.com>

I like it! Some comments below:

> diff --git a/builtin/add.c b/builtin/add.c
> index 145f06e..2a9abf7 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -238,6 +238,8 @@ static int ignore_add_errors, intent_to_add, ignore_missing;
>  static int addremove = ADDREMOVE_DEFAULT;
>  static int addremove_explicit = -1; /* unspecified */
>  
> +static char should_chmod = 0;
> +
>  static int ignore_removal_cb(const struct option *opt, const char *arg, int unset)
>  {
>  	/* if we are told to ignore, we are not adding removals */
> @@ -245,6 +247,15 @@ static int ignore_removal_cb(const struct option *opt, const char *arg, int unse
>  	return 0;
>  }
>  
> +static int chmod_cb(const struct option *opt, const char *arg, int unset)
> +{
> +	char *flip = opt->value;
> +	if ((arg[0] != '-' && arg[0] != '+') || arg[1] != 'x' || arg[2])
> +		return error("option 'chmod' expects \"+x\" or \"-x\"");
> +	*flip = arg[0];
> +	return 0;
> +}
> +
>  static struct option builtin_add_options[] = {
>  	OPT__DRY_RUN(&show_only, N_("dry run")),
>  	OPT__VERBOSE(&verbose, N_("be verbose")),
> @@ -263,6 +274,9 @@ static struct option builtin_add_options[] = {
>  	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
>  	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
>  	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
> +	{ OPTION_CALLBACK, 0, "chmod", &should_chmod, N_("(+/-)x"),
> +	  N_("override the executable bit of the listed files"),
> +	  PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP, chmod_cb},

I wonder, however, whether it would be "cleaner" to simply make this an
OPT_STRING and perform the validation after the option parsing. Something
like:

	const char *chmod_string = NULL;
	...
	OPT_STRING( 0 , "chmod", &chmod_string, N_("( +x | -x )"),
		N_("override the executable bit of the listed files")),
	...
	flags = ...
	if (chmod_string) {
		if (!strcmp("+x", chmod_string))
			flags |= ADD_CACHE_FORCE_EXECUTABLE;
		else if (!strcmp("-x", chmod_string))
			flags |= ADD_CACHE_FORCE_NOTEXECUTABLE;
		else
			die(_("invalid --chmod value: %s"), chmod_string);
	}

> diff --git a/cache.h b/cache.h
> index 6049f86..da03cd9 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -581,6 +581,8 @@ extern int remove_file_from_index(struct index_state *, const char *path);
>  #define ADD_CACHE_IGNORE_ERRORS	4
>  #define ADD_CACHE_IGNORE_REMOVAL 8
>  #define ADD_CACHE_INTENT 16
> +#define ADD_CACHE_FORCE_EXECUTABLE 32
> +#define ADD_CACHE_FORCE_NOTEXECUTABLE 64

Hmm. This change uses up 2 out of 31 available bits. I wonder whether a
better idea would be to extend struct update_callback_data to include a
`force_mode` field, pass a parameter of the same name to
add_files_to_cache() and then handle that in the update_callback().
Something like this:

                case DIFF_STATUS_MODIFIED:
-               case DIFF_STATUS_TYPE_CHANGED:
+               case DIFF_STATUS_TYPE_CHANGED: {
+			struct stat st;
+			if (lstat(path, &st))
+				die_errno("unable to stat '%s'", path);
+			if (S_ISREG(&st.st_mode) && data->force_mode)
+				st.st_mode = data->force_mode;
-                       if (add_file_to_index(&the_index, path, data->flags)) {
+                       if (add_to_index(&the_index, path, &st, data->flags)) {
                                if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
                                        die(_("updating files failed"));
                                data->add_errors++;
                        }
                        break;
+		}

This would not only contain the changes in builtin/add.c, it would also
force the mode change when core.filemode = true and core.symlinks = true
(which your version would handle in a surprising way, I believe).

> 2.6.4 (Apple Git-63)

Time to upgrade? ;-)

Ciao,
Dscho
