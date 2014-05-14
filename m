From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep -I: do not bother to read known-binary files
Date: Wed, 14 May 2014 10:52:28 -0700
Message-ID: <xmqqbnv0l02r.fsf@gitster.dls.corp.google.com>
References: <20140514154419.GA4517@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,  Johannes Schindelin <johannes.schindelin@gmx.de>,  msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBCG77UMM3EJRBZW2Z2NQKGQEMC7ENRI@googlegroups.com Wed May 14 19:52:42 2014
Return-path: <msysgit+bncBCG77UMM3EJRBZW2Z2NQKGQEMC7ENRI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f183.google.com ([209.85.220.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBZW2Z2NQKGQEMC7ENRI@googlegroups.com>)
	id 1WkdM8-0003xj-LE
	for gcvm-msysgit@m.gmane.org; Wed, 14 May 2014 19:52:40 +0200
Received: by mail-vc0-f183.google.com with SMTP id lf12sf568071vcb.20
        for <gcvm-msysgit@m.gmane.org>; Wed, 14 May 2014 10:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=TGfWUFG3uuMJh4IHR/n+Zejls9J6oiQCn4Mo9oin56c=;
        b=IPMeVOkRelnTas0QXfRTKYNpkf6ECxdzHyjgiPYVTeDx89X7duj6Rfq/HIfNJ+5xJH
         N7uQSh7RC2oy9H1eqqXGz2vae6Y+8a7IaqNPgwPgUKTfTqMpaUbWUZHvVwqD4u0A1m+b
         nUqbsj0X99eNiM41v92gKItHHnkRtM+EJkv6lt7ALOCJl7AtHRW7AGsvBu3cWlDYlMrQ
         bBOg4kXnrqxWbZ0OcffwoTFFExhOCrGCRmrP/0AozvuRvI8cCunhTFK2xHibLNgBgm24
         HL8Vclxz7FHrOPipxj6skpG3vUQsF2I5ZWKlP9cdvv/jO7s7ym4QQWXy7JpfW4LUhfsU
         W7UQ==
X-Received: by 10.182.158.167 with SMTP id wv7mr33255obb.29.1400089959599;
        Wed, 14 May 2014 10:52:39 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.138.8 with SMTP id qm8ls842905obb.23.gmail; Wed, 14 May
 2014 10:52:38 -0700 (PDT)
X-Received: by 10.182.250.229 with SMTP id zf5mr2484141obc.4.1400089958525;
        Wed, 14 May 2014 10:52:38 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id x7si350493qcd.3.2014.05.14.10.52.38
        for <msysgit@googlegroups.com>;
        Wed, 14 May 2014 10:52:38 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 36BD617528;
	Wed, 14 May 2014 13:52:38 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2A25417526;
	Wed, 14 May 2014 13:52:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 026A217516;
	Wed, 14 May 2014 13:52:30 -0400 (EDT)
In-Reply-To: <20140514154419.GA4517@camelia.ucw.cz> (Stepan Kasal's message of
	"Wed, 14 May 2014 17:44:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8558D30C-DB90-11E3-AA6C-DDB853EDF712-77302942!pb-smtp0.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248929>

Stepan Kasal <kasal@ucw.cz> writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Mon, 8 Nov 2010 16:10:43 +0100
>
> Incidentally, this makes grep -I respect the "binary" attribute (actually,
> the "-text" attribute, but "binary" implies that).
>
> Since the attributes are not thread-safe, we now need to switch off
> threading if -I was passed.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
>
> Hi,
> this patch has been in msysgit for 3.5 years.
> Stepan

I do not think checking 'text' is the right way to do this.  The
attribute controls the eof normalization, and people sometimes want
to keep CRLF terminated files in the repository no matter what the
platform is (an example I heard is a sample protocol exchange over
textual network protocol such as HTTP and SMTP), and the way to do
so is to unset it.  That would still let them look for patterns in
and compare the changes to these paths.

Looking for "Marking files as binary" in gitattributes(5) gives us a
more authoritative alternative, I think.  In short:

 - If 'diff' is Unset, or
 - If 'diff' is Set to X and diff.X.binary is true

then the contents are not suitable for human consumption.  I haven't
thought things through to declare that "grep -I" would want to treat
a PostScript file (which is an example in that section) as a binary
file and refrain from trying to find substrings in it, but my gut
feeling is that we probably should let it look inside such a file,
so replacing 'text' with 'diff' in this patch and doing nothing
about diff.*.binary would be the way to go.  Given that the posted
patch was older than 3.5 years, perhaps it needs updating to adhere
the advice given in ab435611 (docs: explain diff.*.binary option,
2011-01-09).

By the way, I wonder if the patch is about performance, implied by
"do not bother" (to waste time looking inside), though.  Is it an
overall win to avoid looking inside "-diff" files, if that requires
you to use only 1 core and leaving the other 7 idle?

I think "the user tells us it is binary with attribute, and the user
tells us not to look into binary with -I" is a lot better rationale
to do this change , and that would characterise it as a correctness
patch, not a performance patch.

Thanks.


>  builtin/grep.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 43af5b7..8073fbe 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -18,6 +18,7 @@
>  #include "quote.h"
>  #include "dir.h"
>  #include "pathspec.h"
> +#include "attr.h"
>  
>  static char const * const grep_usage[] = {
>  	N_("git grep [options] [-e] <pattern> [<rev>...] [[--] <path>...]"),
> @@ -163,6 +164,22 @@ static void work_done(struct work_item *w)
>  	grep_unlock();
>  }
>  
> +static int skip_binary(struct grep_opt *opt, const char *filename)
> +{
> +	if ((opt->binary & GREP_BINARY_NOMATCH)) {
> +		static struct git_attr *attr_text;
> +		struct git_attr_check check;
> +
> +		if (!attr_text)
> +			attr_text = git_attr("text");
> +		memset(&check, 0, sizeof(check));
> +		check.attr = attr_text;
> +		return !git_check_attr(filename, 1, &check) &&
> +				ATTR_FALSE(check.value);
> +	}
> +	return 0;
> +}
> +
>  static void *run(void *arg)
>  {
>  	int hit = 0;
> @@ -173,6 +190,9 @@ static void *run(void *arg)
>  		if (!w)
>  			break;
>  
> +		if (skip_binary(opt, (const char *)w->source.identifier))
> +			continue;
> +
>  		opt->output_priv = w;
>  		hit |= grep_source(opt, &w->source);
>  		grep_source_clear_data(&w->source);
> @@ -379,6 +399,9 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int
>  			continue;
>  		if (!ce_path_match(ce, pathspec, NULL))
>  			continue;
> +		if (skip_binary(opt, ce->name))
> +			continue;
> +
>  		/*
>  		 * If CE_VALID is on, we assume worktree file and its cache entry
>  		 * are identical, even if worktree file has been modified, so use
> @@ -803,6 +826,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  		string_list_append(&path_list, show_in_pager);
>  		use_threads = 0;
>  	}
> +	if ((opt.binary & GREP_BINARY_NOMATCH))
> +		use_threads = 0;
>  
>  	if (!opt.pattern_list)
>  		die(_("no pattern given."));
> -- 
> 1.9.2.msysgit.0.335.gd2a461f
>
> -- 

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
