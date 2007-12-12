From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (amend)] diff: Make numstat machine friendly also for renames (and copies)
Date: Wed, 12 Dec 2007 11:21:23 +0100
Message-ID: <200712121121.24613.jnareb@gmail.com>
References: <200712102332.53114.jnareb@gmail.com> <200712120009.36560.jnareb@gmail.com> <7vabog9wyx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 11:22:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Oiz-0001tj-GS
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 11:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758133AbXLLKVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 05:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758129AbXLLKVe
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 05:21:34 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:50013 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756729AbXLLKVd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 05:21:33 -0500
Received: by nf-out-0910.google.com with SMTP id g13so156063nfb.21
        for <git@vger.kernel.org>; Wed, 12 Dec 2007 02:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=5GTQ/BLEtUQgnC8Wvv3evIIHb+XrZFRRJRpYrfM1Vn0=;
        b=bA/YbnKyRoaT0vVok8TMy5NjBi8a52pjrLFZY7evq8H4KFC/kpdmrNiqBfA1l4EBDXruvVu8X40dcMmV5bZ1NazQ/t8Waobi/86EjJ8hA0odrXr+QMG6KYMOnBRlSgMgybqXRlUqW57KQcnMyOqnt5QMNjX3dUAMeqy+oaPuA0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=m1db3RPS1YrkA5kLjuvCqFmwb+ivo+Q3nc/GybsqbzwEAtAtMyqWE2LiWf6/zIRfzH/NVsDXE+FzfQRYJL8xblW9cL29SjQO0UELDYW7dH1nS/SUxoKJf4VJkgyCwnHqHQ6dZt4oCZFNjAS37rxxuO/boj/mgP1kBBNsp24feOQ=
Received: by 10.86.99.9 with SMTP id w9mr476692fgb.58.1197454891305;
        Wed, 12 Dec 2007 02:21:31 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.249.28])
        by mx.google.com with ESMTPS id d4sm3931217fga.2007.12.12.02.21.27
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Dec 2007 02:21:28 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vabog9wyx.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68031>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > The previous patch is a fix (usability fix) for numstat output in the
> > presence of rename detection, making it truly machine friendly. Moreover
> > it should not break any scripts which parsed numstat output not
> > expecting to deal with renames (for example if repository has
> > diff.renames config option set), and might even fix them.
> >
> > The proposed - and implemented in patch below - change could break some
> > scripts not expecting to deal with new numstat output.
> 
> I do not quite follow.  If a script wanted -M and/or -C output in the
> older "common/{a => b}/common" format, either change would break it
> equally badly, either with or without -z.  And I do not think adding
> status letter is necessary for --numstat; if the caller wants that
> information, it can ask for it explicitly with both options.

I meant it there that if an [older] script parsing numstat output
didn't expect to deal with renames (but had to for example because
of diff.renames set), and expected the numstat output format to be
either

  <add> TAB <del> TAB <filename_q> LF

or (if running with -z option)

  <add> TAB <del> TAB <filename> NUL

After first patch, but before second, those expectations were met, that
I meant by "and might even fix them" (the scripts).

BTW. beside the fact that for renames it was not filename (pathname),
it could be half-quoted; see also below.

> So I do not think there is anything more to solve, than the patch you
> just sent.
> 
> The patch looks good.  Thanks.
> 
> > P.S. The numstat output format for renames should be probably described
> > in documentation, and not only in commit message, but I was not sure
> > where to put it (and even how it should be written).
> 
> I started writing this, and then reviewed the result of squashing your
> two patches.

And because of the above I wanted that you'd rather _not_ squash those
patches, but apply them separately...

> Although everybody complains that most of git is run-once-and-exit, I
> wrote the original diff part fairly conservatively to make it leak-free,
> because of a single command, "diff-tree --stdin", that can be told to
> run millions of diffs inside a single process.
> 
> But the diffstat part is horribly leaky, especially after your patch,
> and it has ugly workarounds such as refusing to show both diffstat and
> shortstat at the same time, not because it does not make much sense
> (admittedly it doesn't), but because show_stats() discards necessary
> information when it is done, making it impossible for shortstat to run.
> 
> So I ended up restructuring the name allocation/free code a bit while at
> it.

...but as you did more surgery on diffstat, it is reasonable to do it
in one commit, not two.

> -- >8 --
> diff --numstat -z: make it machine readable
> 
> The "-z" format is all about machine parsability, but showing renamed
> paths as "common/{a => b}/suffix" makes it impossible.  The scripts would
> never have successfully parsed "--numstat -z -M" in the old format.
> 
> This fixes the output format in a (hopefully minimally) backward
> incompatible way.
> 
>  * The output without -z is not changed.  This has given a good way for
>    humans to view added and deleted lines separately, and showing the
>    path in combined, shorter way would preserve readability.
> 
>  * The output with -z is unchanged for paths that do not involve renames.
>    Existing scripts that do not pass -M/-C are not affected at all.
> 
>  * The output with -z for a renamed path is shown in a format that can
>    easily be distinguished from an unrenamed path.

This changes invariant what we had, that output with and without -z differ
only in [filename] quoting and record separator. Now those two have
different semantic: --numstat without -z is for easier reading, --numstat
with -z is for machine consumption.

But as output with and without -z has to differ (in the form) already
for renames, why not...

[...]
>  include::diff-generate-patch.txt[]
> +
> +
> +other diff formats
> +------------------
> +
> +The `--summary` option describes newly added, deleted, renamed and
> +copied files.  The `--stat` option adds diffstat(1) graph to the
> +output.  These options can be combined with other options, such as
> +`-p`, and are meant for human consumption.
> +
> +When showing a change that involves a rename or a copy, `--stat` output
> +formats the pathnames compactly by combining common prefix and suffix of
> +the pathnames.  For example, a change that moves `arch/i386/Makefile` to
> +`arch/x86/Makefile` while modifying 4 lines will be shown like this:

Perhaps it could be added there word about "table-like format", and about
column widths (total width, filename [column] width).

> +
> +------------------------------------
> +arch/{i386 => x86}/Makefile    |   4 +--

I would add there example of shortened filename there, for example

  +.../SubmittingPatches          |   2 +

Do I understand correctly that code first tries to strip directories,
and only if the filename is too long it does shorten filename?

By the way the combining common prefix and suffix (pprint_rename) doesn't
play well with quoting: when only one of the source and destination names
are quoted it wouldn't of course find any common prefix/suffix.  I think
that if one of filenames has to be quoted, both should be.

And shortening of filenames together with either combining common prefix,
and/or with filename quoting produces output with might be a bit strange
for some. But I don't have idea how (and if) it could be corrected.

> +------------------------------------
> +
> +The `--numstat` option gives the diffstat(1) information but is designed
> +for easier machine consumption.  An entry in `--numstat` output looks
> +like this:
> +
> +----------------------------------------
> +1	2	README
> +3	1	arch/{i386 => x86}/Makefile
> +----------------------------------------

Note that filename is not shortened in --numstat (as it can be in --stat).

> +
> +When `-z` output option is in effect, the output is formatted this way:
> +
> +----------------------------------------
> +1	2	README NUL
> +3	1	NUL arch/i386/Makefile NUL arch/x86/Makefile NUL
> +----------------------------------------

I wanted to say that it would make it harder on "line"-based parsers...
but I have realized that it would not, as one can simply read next two
"lines" (records) for pre-image and post-image filename if 0-length
filename is detected.

[...]
> +static void fill_print_name(struct diffstat_file *file)

Nice idea to separate this into function.

-- 
Jakub Narebski
Poland
