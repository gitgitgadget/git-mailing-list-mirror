From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Fri, 20 Jul 2012 11:49:07 +0200
Message-ID: <50092993.6010203@alum.mit.edu>
References: <20120719213225.GA20311@sigill.intra.peff.net> <20120719213311.GA20385@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Alexey Muranov <alexey.muranov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 20 11:56:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ss9wc-0005EE-1d
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 11:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337Ab2GTJ4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 05:56:18 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:46910 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751490Ab2GTJ4N (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jul 2012 05:56:13 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Jul 2012 05:56:13 EDT
X-AuditID: 12074414-b7f846d0000008b8-e9-500929977aac
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 1E.86.02232.79929005; Fri, 20 Jul 2012 05:49:11 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q6K9n9WT028491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 20 Jul 2012 05:49:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <20120719213311.GA20385@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsUixO6iqDtdkzPA4NozCYuFff3MFl1Xupks
	GnqvMFv8aOlhdmDx2DnrLrvHs949jB4XLyl7fN4kF8ASxW2TlFhSFpyZnqdvl8CdseneAbaC
	a1oVPe17mBoY9yl2MXJySAiYSFx79ZEZwhaTuHBvPVsXIxeHkMBlRokHKx5AOceZJPZs6wer
	4hXQlti0bjETiM0ioCox93wrmM0moCuxqKcZzBYVCJFY820KI0S9oMTJmU9YQGwRAVmJ74c3
	gsWZBfIl1q2EsIUFLCS2zX/NCmILCWRKbH+6hg3E5hSwlvi5/y5UvZlE19YuKFteYvvbOcwT
	GAVmIVkxC0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpWujlZpbopaaUbmKEBLTI
	DsYjJ+UOMQpwMCrx8E5O4ggQYk0sK67MPcQoycGkJMr7Vp0zQIgvKT+lMiOxOCO+qDQntfgQ
	owQHs5IIb4UYUI43JbGyKrUoHyYlzcGiJM77bbG6n5BAemJJanZqakFqEUxWhoNDSYL3oQZQ
	o2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoVuOLgdEKkuIB2nsOpJ23uCAxFygK
	0XqK0ZLj2sNbtxg5nnwBkatu3LvFKMSSl5+XKiXOex6kQQCkIaM0D24dLK29YhQH+l6Y9zZI
	FQ8wJcJNfQW0kAloIXcxG8jCkkSElFQDY5AY+yXdthXRjH+C+Yzs32cHrpzjq7/R5Vev8qtp
	B8ueTMjwSZgY82n/4/NSj/vYNVVFJnO9NBfLr38ueD7ZkjMjQthZ7Oqk6bMz0tSe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201764>

On 07/19/2012 11:33 PM, Jeff King wrote:
> [...]
> This cannot be done by simply leaving the reflog files in
> place. The ref namespace does not allow D/F conflicts, so a
> ref "foo" would block the creation of another ref "foo/bar",
> and vice versa. This limitation is acceptable for two refs
> to exist simultaneously, but should not have an impact if
> one of the refs is deleted.

This is a great feature.

> This patch moves reflog entries into a special "graveyard"
> namespace, and appends a tilde (~) character, which is
> not allowed in a valid ref name. This means that the deleted
> reflogs of these refs:
>
>     refs/heads/a
>     refs/heads/a/b
>     refs/heads/a/b/c
>
> will be stored in:
>
>     logs/graveyard/refs/heads/a~
>     logs/graveyard/refs/heads/a/b~
>     logs/graveyard/refs/heads/a/b/c~
>
> Putting them in the graveyard namespace ensures they will
> not conflict with live refs, and the tilde prevents D/F
> conflicts within the graveyard namespace.

I agree with Junio that long-term, it would be nice to allow references 
"foo" and "foo/bar" to exist simultaneously.  To get there, we would 
have to redesign the mapping between reference names and the filenames 
used for the references and for the reflogs.

The easiest thing would be to mark files and directories differently; 
something like

     $GIT_DIR/{,logs/}refs/heads/a/b/c~

or

     $GIT_DIR/{,logs/}refs/heads~/a~/b~/c

i.e., munging either directory or file names to strings that are illegal 
in refnames such that it is unambiguous from the name whether a path is 
a file or directory.

And *if* we did that, then we wouldn't need a separate "graveyard" 
namespace, would we?  The reflogs for dead references could live among 
those for living references.

Therefore, I think it would be good if we would choose a convention now 
for dead reflogs that is compatible with this hoped-for future.

The first convention, "logs/refs/heads/a/b/c~" is not usable because a 
reflog for a dead reference with this name would conflict with a reflog 
for a live reference "heads/a" or "heads/a/b" that uses the current 
filename convention.

But the second convention, "logs/refs/heads~/a~/b~/c, cannot conflict 
with current reflog files.  And it would be a step towards allowing 
"foo" and "foo/bar" at the same time.  What do you think about using a 
convention like this instead of the one that you proposed?


Another minor concern is the choice of trailing tilde in the file or 
directory names.  Given that emacs creates backup files by appending a 
tilde to the filename, (1) it would be easy to inadvertently create such 
files, which git might try to interpret as reflogs and (2) there might 
be tools that innately "know" to skip such files in their processing. 
ack-grep, a replacement for grep, is an example that springs to mind.  I 
know that I have written backup scripts that ignore files matching "*~", 
and a garbage-removal script that removes files matching "*~".  Probably 
it is less precarious to name directories rather than files with 
trailing tildes, but either one could be a surprise for sysadmins.

Other possibilities (according to git-check-ref-format(1)):

     refs/.heads/.a/.b/c
     refs/heads./a./b./c (problematic on some Windows filesystems?)
     refs/heads../a../b../c
     refs/heads~dir/a~dir/b~dir/c (or some other suffix)
     refs/heads..a..b..c (not recommended because it flattens directory 
hierarchy)

> The implementation is fairly straightforward, but it's worth
> noting a few things:
>
>    1. Updates to "logs/graveyard/refs/heads/foo~" happen
>       under the ref-lock for "refs/heads/foo". So deletion
>       still takes a single lock, and anyone touching the
>       reflog directly needs to reverse the transformation to
>       find the correct lockfile.

This should be documented in the code.

>    2. We append entries to the graveyard reflog rather than
>       simply renaming the file into place. This means that
>       if you create and delete a branch repeatedly, the
>       graveyard will contain the concatenation of all
>       iterations.

Good.

>    3. We do not resurrect dead entries when a new ref is
>       created with the same name. However, it would be
>       possible to build an "undelete" feature on top of this
>       if one was so inclined.

Nice prospect.

> [...]> diff --git a/refs.c b/refs.c
> index da74a2b..553de77 100644
> --- a/refs.c
> +++ b/refs.c
> [...]
> @@ -2552,3 +2553,63 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
>   	free(short_name);
>   	return xstrdup(refname);
>   }
> +
> +char *refname_to_graveyard_reflog(const char *ref)
> +{
> +	return git_path("logs/graveyard/%s~", ref);
> +}
> +
> +char *graveyard_reflog_to_refname(const char *log)
> +{
> +	static struct strbuf buf = STRBUF_INIT;
> +
> +	if (!prefixcmp(log, "graveyard/"))
> +		log += 10;
> +
> +	strbuf_reset(&buf);
> +	strbuf_addstr(&buf, log);
> +	if (buf.len > 0 && buf.buf[buf.len-1] == '~')
> +		strbuf_setlen(&buf, buf.len - 1);
> +
> +	return buf.buf;
> +}

Given the names of these two functions, I was surprised that they aren't 
inverses of each other.

Function comments would be nice, too, especially for the latter.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
