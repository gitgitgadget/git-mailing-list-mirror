From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Does content provenance matter?
Date: Tue, 8 May 2012 10:03:28 +1000
Message-ID: <CAH5451nq=W6qNsMExobipFXhb4tV+WmLu08QwfhzWd2+mJnbYA@mail.gmail.com>
References: <CAJsNXT=26u-PPNe9_LFoC1tAKpWJRWfBNNKzQB5Ya3X0n4K_eg@mail.gmail.com>
 <1336432417.36394.YahooMailClassic@web121504.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: PJ Weisberg <pj@irregularexpressions.net>, git@vger.kernel.org
To: Kelly Dean <kellydeanch@yahoo.com>
X-From: git-owner@vger.kernel.org Tue May 08 02:04:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRXuF-00054U-Be
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 02:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757926Ab2EHADv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 20:03:51 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:54437 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757648Ab2EHADu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 20:03:50 -0400
Received: by werb10 with SMTP id b10so1574891wer.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 17:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=TtKRc8wT4Y/0eXSfHbByD/gVoSA4zHLhifMENdxj7S0=;
        b=kcOTe7cqzHl6auBrjh4bZxpr2t0Y6akMz9nTUHAGMFLvQIYHwUVw9mU6afFNuOsEMd
         BrC4Td4XdTosyVSFiPKFlbrjCiVTLKjgPpqPvZVXA3mhMsZsJyeBUllm0IUhK42JZlQh
         JQc8cOBW+izvJplP47aLoXxJZz/psR8YTyjOEfceBIfYXTrhJeluKrBWamPR6HiwL+q0
         dQqjqJxLGkwTO5LIjHHx27nxJYU+yIVv/pJsezdNS7bYKVJtiA6HvT6SqI5vvIXqAGgh
         ASsV5bDhVkQytiqjQfN7emtFf41Z4SdSGkdYHCBVK2kaYVx1b/Tt6n7xpXEG15pvA856
         ufsw==
Received: by 10.180.99.72 with SMTP id eo8mr38748684wib.10.1336435429293; Mon,
 07 May 2012 17:03:49 -0700 (PDT)
Received: by 10.223.86.80 with HTTP; Mon, 7 May 2012 17:03:28 -0700 (PDT)
In-Reply-To: <1336432417.36394.YahooMailClassic@web121504.mail.ne1.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197328>

On 8 May 2012 09:13, Kelly Dean <kellydeanch@yahoo.com> wrote:
>
> --- On Mon, 5/7/12, PJ Weisberg <pj@irregularexpressions.net> wrote:
> > But there could be any number of unrelated commits newer than "Bar"
> > but older than "Revert Bar" on other branches. =C2=A0Even if you co=
uld
> > trust the timestamps to be accurate (you can't), you still can't
> > determine a commit's parent unambiguously.
> Therefore, provenance does matter, and it must be explicitly recorded
> because it can't necessarily be correctly and fully deduced from cont=
ent
> alone. And git does record inter-commit provenance.
> However, git doesn't record intra-commit provenance, as I mentioned i=
n my
> original message. My question is: why this discrepancy? Either proven=
ance
> matters, or it doesn't; why record it in one case but not the other?

I don't think it is firmly decided that provenance is not important in
the intra-commit scope, rather that as you stated such information is
not available to us.

My understanding is that git makes a best guess effort to track the
flow of content through the repository. If the content is moved, by
deleting in one place and adding in another it is easy to see that in
git, however if content is merely added, and that same content occurs
in multiple places in the repository, there is no sane way of knowing
where that content came from.
Even if the content that was added only occurred in one other place,
you would need to check every single file for every single hunk added
every single commit in order to be able to determine just where this
content came from. Why stop there though? It's possible we are copying
the content from some other branch we don't have checked out at the
moment, so every time we commit, let's search the entire repositories
history for an occurrence of each hunk we are adding. This way is
madness.

With regards to file renames, all that has been shown so far is that
provenance matters for commit renames. Nothing about the similarities
between the commit parent and rename situations you mention leads me
to concluded that because provenance is important to one it is
important to the other.

Indeed, one of the arguments against provenance being important in the
file rename case is that generally we can determine this information
from the existing information, as opposed to the general commit parent
case. There are additional arguments, such as simply recording file
name changes doesn't capture many situations we would like to know
about, for example when a single file is split into two files.
Tracking the content of those files, and hence being able to deduce
where their content came from, solves this and the general rename
situation. Trying to guess which file was 'renamed' and which is 'new'
when a file is actually split into two new files would lead to
misleading and incomplete information in the end.

So just because provenance matters in some situations doesn't mean it
matters in all (at least in the way we have been applying 'matters'),
furthermore there are additional reasons why the existing
content-tracking system is beneficial. Extra layers of rename encoding
or the 'heritage of data chunks' would be extra work with little added
benefit (though there are a few corner cases, from memory, where
automatic rename detection fails and so /some/ benefit would be seen).

Regards,

Andrew Ardill
