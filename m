From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH 1/2] submodule: implement `module_list` as a builtin helper
Date: Mon, 3 Aug 2015 14:30:42 -0700
Message-ID: <CAGZ79kY=39j4H=62=VZRm4VOcqzgOAU6tDpJVsqdeqnPtB8hQQ@mail.gmail.com>
References: <1438384147-3275-1-git-send-email-sbeller@google.com>
	<1438384147-3275-2-git-send-email-sbeller@google.com>
	<xmqqmvybakjl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 23:30:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMNJo-0005ET-6j
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 23:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbbHCVao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 17:30:44 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:36523 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144AbbHCVan (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 17:30:43 -0400
Received: by ykeo23 with SMTP id o23so25110807yke.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 14:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jCTeZQ8+8CReoaixL+w3n7biZ+mmV/93b8/f4UbRjfQ=;
        b=RVO3acHFV2rN0AWBgH99Bh8tF+L0C34ouXkGxlJacx4hjg8F89EIfqEm72B9c9bvfw
         TsOHQJw9/bdgx+uhPTDA79I4xG3NJb5B6LWlAqu96mvPGVZ/0vpdaxaYQ3RbHtZ4kVJA
         5mBGiNPq+j63cdc7JwBUd0XOgJgHQYpcEvYWoc6L1RswZdkoTq/VShGhvZCwsnse593i
         1nz+MMIFZ2zQWU/eqXRbJb3JPWJWU5fowbLg6xpxp04WDwR4A9KbPrycOs2sCzBP3TX+
         l6/NX06pPCB+7tP51EmEiBvM3dLYzJulaWDiI2M7Pm3BSFeNr19EqT7P8NYg8gHOO4Jl
         afYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jCTeZQ8+8CReoaixL+w3n7biZ+mmV/93b8/f4UbRjfQ=;
        b=Sef8r8ADV5ZEPsViMPxEAUQfoflURygdxiWpv9x2lRzT3i/b3LClVC0Ie1mhd7vcLg
         5LjxGCjhYtu4eLDxrgROtu8sbcX1eDs4w08aD9nm97mtesbgKy4mfWYmIW1kiL5uOFYI
         BI59iXCNXeztx1myZGtNaxxjAfwcAmYfEBF49+6TBdJaMErVpxRR9yV7O36kR3Tjp9G8
         yLzp/ikCqf7m8V6AznFPHWAw6lmtviaFgV5GtzAJ1r7tJaQh4iU4SG1+306G3Nak/Lf0
         EBZPN8Hhkd1bolUVSm14h0LpA1+4nQCKVVUZnrS2ORNgvJP8Gmf3mmSJYb/OH9jw7Aqf
         aWvQ==
X-Gm-Message-State: ALoCoQnI0eEbRPh9UkjDKN1fkWMfYBRPerwBHQL7l6UJCvHKhBgizkulUaWmEiwo1BtCFklOApox
X-Received: by 10.129.101.135 with SMTP id z129mr130644ywb.81.1438637442765;
 Mon, 03 Aug 2015 14:30:42 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Mon, 3 Aug 2015 14:30:42 -0700 (PDT)
In-Reply-To: <xmqqmvybakjl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275210>

On Fri, Jul 31, 2015 at 6:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +static const char * const git_submodule_helper_usage[] = {
>> +     N_("git submodule--helper --module_list [<path>...]"),
>
> Yuck.  Please do not force --multi_word_opt upon us, which is simply
> too ugly to live around here.  --module-list is perhaps OK,

I agree there. The way you word it here, it sounds as if the mixture
of dashes and underscores are a problem.

> but
> because submodule--helper would not have an default action, I'd
> prefer to make these just "command words", i.e.
>
>     $ git submodule--helper module_list

Why would you use an underscore in here as opposed to a dash?
     $ git submodule--helper module-list

I went with --module-list for now as I see no reason real to make it
a command word for now as it is not user facing but just a helper.
I have a patch from my previous attempt to rewrite "git submodule"
as a whole to accept both command words as well as double dashed
selected modes.

>
>> +int module_list(int argc, const char **argv, const char *prefix)
>> +{
>> +     int i;
>> +     static struct pathspec pathspec;
>> +     const struct cache_entry **ce_entries = NULL;
>> +     int alloc = 0, used = 0;
>> +     char *ps_matched = NULL;
>> +     char *max_prefix;
>> +     int max_prefix_len;
>> +     struct string_list already_printed = STRING_LIST_INIT_NODUP;
>> +
>> +     parse_pathspec(&pathspec, 0,
>> +                    PATHSPEC_PREFER_FULL,
>> +                    prefix, argv);
>> +
>> +     /* Find common prefix for all pathspec's */
>> +     max_prefix = common_prefix(&pathspec);
>> +     max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
>> +
>> +     if (pathspec.nr)
>> +             ps_matched = xcalloc(1, pathspec.nr);
>
> Up to this point it interprets its input, and ...
>
>> +     if (read_cache() < 0)
>> +             die("index file corrupt");
>> +
>> +     for (i = 0; i < active_nr; i++) {
>> +             const struct cache_entry *ce = active_cache[i];
>> +
>> +             if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce),
>> +                                 max_prefix_len, ps_matched,
>> +                                 S_ISGITLINK(ce->ce_mode) | S_ISDIR(ce->ce_mode)))
>> +                     continue;
>> +
>> +             if (S_ISGITLINK(ce->ce_mode)) {
>> +                     ALLOC_GROW(ce_entries, used + 1, alloc);
>> +                     ce_entries[used++] = ce;
>> +             }
>> +     }
>> +
>> +     if (ps_matched && report_path_error(ps_matched, &pathspec, prefix)) {
>> +             printf("#unmatched\n");
>> +             return 1;
>> +     }
>
> ... does the computation, with diagnosis.
>
> And then it does the I/O with formatting.
>
>> +
>> +     for (i = 0; i < used; i++) {
>> +             const struct cache_entry *ce = ce_entries[i];
> ...
>> +     return 0;
>> +}
>
> When you have the implementation of "foreach-parallel" to move the
> most expensive part of "submodule update" of a tree with 500
> submodules, you would want to receive more or less the same "args"
> as this thing takes and pass the ce_entries[] list to the "spawn and
> run the user script in them in parallel" engine.

That's true, I thought about splitting it up later when I actually need it.
[That seems easier to write, but not easier to review :( ]
I did split up the function just now.

>
> So I think it makes more sense to split this function into two (or
> three).  One that reads from (argc, argv) and allocates and fills
> ce_entries[] can become a helper that you can reuse later.
>
> 'int module_list()' (shouldn't it be static?), can make a call to
> that helper at the begining of it, and the remainder of the function
> would do the textual I/O.
