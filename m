From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2.1] commit: add --ignore-submodules[=<when>] parameter
Date: Fri, 18 Apr 2014 14:28:09 +0200
Message-ID: <53511A59.6000402@web.de>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de>	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>	<53374E49.9000702@gmail.com>	<533874F9.3090802@web.de>	<5338AC36.6000109@gmail.com>	<5338B1B0.3050703@gmail.com>	<5339BAE4.8020306@web.de> <CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com> <5339F122.60801@gmail.com> <5339FBB4.1010101@gmail.com> <533B2036.3050506@web.de> <533B36AA.3090600@gmail.com> <533C5CBD.4050601@web.de> <533C6B57.3080901@gmail.com> <534180BC.308@web.de> <53431CB8.2050600@gmail.com> <53443F5C.7050400@web.de> <5349CF3E.7010606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Ronald Weiss <weiss.ronald@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 14:30:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wb7vf-0007sT-O9
	for gcvg-git-2@plane.gmane.org; Fri, 18 Apr 2014 14:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbaDRM35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 08:29:57 -0400
Received: from mout.web.de ([212.227.15.4]:64562 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857AbaDRM2U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 08:28:20 -0400
Received: from [192.168.178.41] ([79.193.66.64]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0M09hY-1WwE9W1aPs-00uIAn; Fri, 18 Apr 2014 14:28:10
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <5349CF3E.7010606@gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:E91x2wjRDdIfkub6GSBVdA6jadW0b2xlQN2o1qyP88klAjxyCiA
 SlDbpR1QdDeBmCayiAusHBErNmRWLqOsfZOHPLjbVvxKxtLqtaaivQZaEVdsAS8wiihaDLs
 vOknrKBgyF+V+rjDL949HBDIIQF7yvKSFym10nZbqdZm1KGoL5lmlwJLPHl9Bq+mXmF6ekc
 Fx7wrjNz5xtzaoKbv1PCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246467>

Am 13.04.2014 01:41, schrieb Ronald Weiss:
> On 8. 4. 2014 20:26, Jens Lehmann wrote:
>> Am 07.04.2014 23:46, schrieb Ronald Weiss:
>>> Then, on top of that, I'll prepare patches for add to honor ignore
>>> from .gitmodules, and -f implying --ignore-submodules. That might need
>>> more discussion, let's see.
>>
>> Makes sense.
> 
> I thought more about that, and also played with the code a bit.
> 
> First, I was confused when I wrote that git add doesn't honor
> submodules' ignore setting only from .gitmodules, but it does from
> .git/config. It doesn't, from neither. Sorry for the confusion. However,
> that doesn't change anything on the fact that it would be nice if add
> would honor the ignore setting, from both places.

Ok, thanks for digging deeper here.

> Second, there are some differences between adding standard ignored
> files, and ignored submodules:
> 
> 1) Already tracked files are never ignored, regardless of .gitignore.
>  However, tracked submodules should be ignored by "add -u", if told so
>  by their ignore setting.
> 
> 2) So .gitignore seems to only do something when adding new files to
>  the repo. However, when adding new submodules, they are probably never
>  ignored (setting the ignore setting for non existent submodule seems
>  like non-sense, although possible).

What about "diff.ignoreSubmodules=all"?

> 3) Ignored files can be ignored less explicitely (in global gitignore,
>  or using a wildcard, or by ignoring parent folder). So it makes sense
>  to warn the user if he tries to explicitely add an ignored file, as he
>  might not be aware that the file is ignored. Submodules, however, can
>  only be ignored explicitely. And when user explicitely specifies the
>  submodule in an add command, he most probably really wants to add it,
>  so I don't see the point in warning him and requiring the -f option.

But we do have "diff.ignoreSubmodules=all", so I do not agree with
your conclusion.

> So, I think that the use cases are completely different, for submodules
> and ignored files. So trying to make add behave the same for both, might
> not be that good idea.
> 
> I would propose - let's make add honor the ignore setting by just
> parsing if from config like the other commands do, and pass it to
> underlying diff invocations. And at the same the, let's override it for
> submodules explicitely specified on the command line, to never ignore
> such submodules, without requiring the -f option. That seems to be
> pretty easy, see below.

What about doing that only when '-f' is given? Would that do what we
want?

> diff --git a/builtin/add.c b/builtin/add.c
> index 85f2110..f19e6c8 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -284,6 +284,10 @@ static int add_config(const char *var, const char *value, void *cb)
>  		ignore_add_errors = git_config_bool(var, value);
>  		return 0;
>  	}
> +
> +	if (starts_with(var, "submodule."))
> +		return parse_submodule_config_option(var, value);
> +
>  	return git_default_config(var, value, cb);
>  }
>  
> @@ -320,6 +324,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  	char *seen = NULL;
>  
>  	git_config(add_config, NULL);
> +	gitmodules_config();

Wrong order, gitmodules_config() must be called before git_config()
to make the .gitmodules settings overridable by the users config.

>  	argc = parse_options(argc, argv, prefix, builtin_add_options,
>  			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
> @@ -425,6 +430,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  			       PATHSPEC_EXCLUDE);
>  
>  		for (i = 0; i < pathspec.nr; i++) {
> +			int cachepos;
>  			const char *path = pathspec.items[i].match;
>  			if (pathspec.items[i].magic & PATHSPEC_EXCLUDE)
>  				continue;
> @@ -440,6 +446,18 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  					die(_("pathspec '%s' did not match any files"),
>  					    pathspec.items[i].original);
>  			}
> +
> +			/* disable ignore setting for any submodules specified explicitly in the pathspec */
> +			if (path[0] &&
> +				(cachepos = cache_name_pos(path, pathspec.items[i].len)) >= 0 &&
> +				S_ISGITLINK(active_cache[cachepos]->ce_mode)) {
> +				char *optname;
> +				int optnamelen = pathspec.items[i].len + 17;
> +				optname = xcalloc(optnamelen + 1, 1);
> +				snprintf(optname, optnamelen + 1, "submodule.%s.ignore", path);
> +				parse_submodule_config_option(optname, "none");

We should use "dirty" instead of "none" here. Modifications inside
the submodule cannot be added without committing them there first
and using "none" might incur an extra preformance penalty for
looking through the submodule directories for such changes.

> +				free(optname);
> +			}
>  		}
>  		free(seen);
>  	}
> --  
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
