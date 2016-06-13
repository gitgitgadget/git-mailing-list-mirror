From: Stefan Beller <sbeller@google.com>
Subject: Re: Re attr API further revamp
Date: Mon, 13 Jun 2016 14:31:18 -0700
Message-ID: <CAGZ79kYy4ic1nYgPEHLCfoUZYkzPw3bBq+8kTyRi13nNwQHGFw@mail.gmail.com>
References: <xmqqtwgwbygg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 23:34:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCZS8-0002fx-Ue
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 23:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423347AbcFMVbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 17:31:21 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:36512 "EHLO
	mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422758AbcFMVbU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 17:31:20 -0400
Received: by mail-qt0-f178.google.com with SMTP id 37so38736313qtc.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 14:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zbWVgWwrlKWRMj7cVASyfDraEmD/jdTLy1TVlm00xpk=;
        b=MWOWRPoYVVb1v0DNVpcLWy2DzyJswu9GhWHC9Grzz79tDVKSZ9p0AH6V/ig+wkGg5j
         azGCe6RVV/ZRPFuQ6TAecxMJKgF08de17G5D9sm+zmnjgXjel2J1Xpeuov9ZiW1z17Wv
         KVknB6VvnluEH+6DBe35/DXz/ZC27Ra9h4FBTXRhG34hneJjxw7N7OlqKDDXP57AfIcT
         piy7QFnW18ejlFH0PQ1Lttpnj2DO/e6NhyZswqszUMTE6sv8Kk5NuMVNP2UUScWqG6Kh
         wkOWa4KmIcsWD1+1USVq+6ZoeUkXXhVkXjkARgh7s6ZzjcGvT9g9gmj/KcY2agERChfe
         O5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zbWVgWwrlKWRMj7cVASyfDraEmD/jdTLy1TVlm00xpk=;
        b=MJsPG7ktzYWKLZQaUGQrnUm/BbjUupyQL/kb436XBMu0N5dN9NmM+2n7kkYxu53ywr
         +ABuM4iGgGFtZ+EktIWPVZW1gHCW4Wves6r7bNa6uP3CdW/eBcwdR/6W6C2uwHDvCL4J
         TjWYpgNZH4GHl9Z0Ru5qlTj3ClMVSoSI37zWw5j2L+evJYWEEwiVhRYUAau4bdvnnHko
         mR22xlhjS8fPC2MPafSBrkCDyv+KW85T0m8YsHkxjYRExa6byoEkHbSX7jZZFXPwxhSA
         nO1EDx0LbOHm4E4BW1FTQ4Y95P3mdx6qyYfvaNrcgA/uP/bS0Ioi6Ott3HCBXYEG6tI5
         fIrw==
X-Gm-Message-State: ALyK8tJxpGoGTaHSfYD3zTsroTOkYKmKNXvgP8Mqb0g2i3yn4qMrEMudE1sGz77MR+3vzD3ZlzA49uWdVpjl3LAa
X-Received: by 10.237.51.98 with SMTP id u89mr2564239qtd.71.1465853479432;
 Mon, 13 Jun 2016 14:31:19 -0700 (PDT)
Received: by 10.237.42.226 with HTTP; Mon, 13 Jun 2016 14:31:18 -0700 (PDT)
In-Reply-To: <xmqqtwgwbygg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297246>

On Mon, Jun 13, 2016 at 1:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I hate to be doing this, but we need yet another revamp to the attr
> API that affects all the callers.

So you don't mean origin/jc/attr-more by this?
(Given that we have jc/attr and jc/attr-more, the third thing could go
with jc/even-more-attr. Though I do not propose that)

>
> In the original design, a codepath that wants to check attributes
> repeatedly for many paths (e.g. "convert" that wants to see what
> crlf, ident, filter, eol and text attributes are set to for paths
> that it is asked to munge the blob contents for) used to allocate
>
>         static struct git_attr_check {
>                 struct git_attr *attr;
>                 const char *value;
>         } ccheck[NUM_ATTRS];
>
> and populated the array when the first time the codepath was
> entered, e.g.
>
>         if (!ccheck[0].attr) {
>                 for (i = 0; i < NUM_ATTRS; i++)
>                         ccheck[i].attr = git_attr(...);
>         }
>
> and then make a call to the API to ask for these attributes in
> ccheck[] for a path, i.e.
>
>         git_attr_check(path, NUM_ATTRS, ccheck);
>
> The API function will fill in the ccheck[].value fields and the
> caller will read from there how each attribute is set for the path.
>
> This was updated with recent jc/attr topic so that attr_check
> structure can be enriched to keep _more_ state, such as the
> pre-parsed representation of all the contents of the relevant
> .gitattributes files, which currently is held in a program-side
> singleton instance called attr_stack, partly in preparation for
> Stefan's sb/pathspec-label topic that is expected to place a lot
> heavier load to the attribute subsystem.

I do not quite expect that. Some numbers:
(I am looking at https://android.googlesource.com/platform/manifest)
* There are currently different 56 groups in that manifest
* with an average of 1.5 groups for each entry that has at least one group,
* or 0.88 groups per entry (which is one resulting file/submodule after the
  conversion)

For reference:

* git.git makes use of 1 attr (whitespace), in 2 value configurations
* that is applied to each file.

So comparing one entry to the 1.5 or 0.88 above doesn't seem to
be that bad. That is what needs to be done on a per-file basis?

What is different is the number of different attrs in use by about
2 orders of magnitude, which needs to be collected upfront and stored
in a smart way?

>
> A caller of the API after that update would do more like
>
>         static struct git_attr_check *ccheck;
>
>         if (!ccheck)
>                 ccheck = git_attr_check_initl(...);
>         git_attr_check(path, ccheck);
>         for (i = 0; i < NUM_ATTRS; i++)
>                 if (ccheck->check[i].value == ATTR_UNSET)
>                         ... do the Unset thing ...

This is origin/jc/attr-more ?

>
> This however is not thread-safe for obvious two reasons.
>
>  * Two threads can simultanously enter this section of the code and
>    end up initializing ccheck twice;
>
>  * Even though ccheck[].attr are constant for the purpose of this
>    codepath (i.e. all threads passing through are interested in
>    checking the same set of attributes), ccheck[].value fields
>    cannot be shared across simultaneous threads like the above
>    snippet does.
>
> So it appears that the final API visible from the callers needs to
> be updated further, perhaps something like:
>
>
>         static struct git_attr_check *ccheck;
>         const char *values[NUM_ATTRS];
>
>         git_attr_check_initl(&ccheck, "crlf", "ident", ..., NULL);
>         git_attr_check(path, ccheck, values);

and later on each thread will do a

        git_attr_thread_byebye(&ccheck) ?

to free its thread local stuff or rather is the calling site responsible for
freeing up all of it after all threads are done?
(This is probably too much of a detail question now?)

>
> where git_attr_check_initl() would do the "if ccheck is NULL then
> initialize it to an instance" atomically in threading environment,
> and git_attr_check() returns its finding to values[] array the
> calling thread exclusively owns, while sharing the input ccheck
> and the list of attributes the call inquires among threads.
>
> Also unlike the earlier plan, attr_stack aka "where in the directory
> hierarchy are we asking attributes for?" will not be stored directly
> in git_attr_check structure.  It is likely that a thread-local
> structure will be introduced hidden behind this API (i.e. the
> callers do not have to be aware of it), and attr_stack will be
> registered in this thread-local structure keyed by &ccheck, so that
> <thread, callsite> pair can have attr_stack instance of its own.
>
> This is because a single attr_stack per ccheck will not work as an
> optimization mechanism when multi-threaded.  Two threads may be
> running the same convert() function, and they may be interested in
> the same set of attributes (e.g. "crlf", "ident", etc.) but they
> will be working on different parts of the tree, so having attr_stack
> per <thread, callsite> would make more sense.
>
> All of which will be quite a lot of work, though, so do not expect
> that it will appear by the end of this week ;-)
>
> Thanks.
>

Thanks for the heads up,
Stefan
