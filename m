From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: git commit --only -- $path when $path already has staged content
Date: Mon, 10 Nov 2014 08:18:59 +0100
Message-ID: <546066E3.3060708@atlas-elektronik.com>
References: <545CA118.6040500@atlas-elektronik.com>	<xmqqmw83gd94.fsf@gitster.dls.corp.google.com> <xmqq8ujmg51y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 08:19:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnjFt-0000nL-42
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 08:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbaKJHTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 02:19:13 -0500
Received: from mail96.atlas.de ([194.156.172.86]:16766 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283AbaKJHTM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 02:19:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 4DBCB10138;
	Mon, 10 Nov 2014 08:19:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v-1s30zzRb3O; Mon, 10 Nov 2014 08:19:00 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Mon, 10 Nov 2014 08:19:00 +0100 (CET)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id EF1032716A;
	Mon, 10 Nov 2014 08:18:59 +0100 (CET)
Received: from [10.200.54.122] (10.200.54.122) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server (TLS) id 8.3.327.1; Mon, 10 Nov
 2014 08:19:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <xmqq8ujmg51y.fsf@gitster.dls.corp.google.com>
OpenPGP: id=922127AF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.11.2014 um 20:54 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> In other words, you give paths from the command line to tell the
>> command that you want to record the contents of them in the working
>> tree as a whole to be recorded in the resulting commit.
> 
> ... and --only/--include only makes difference wrt what happens to
> contents from the other paths.
> 
> Perhaps the attached would clarify it better, but there may have to
> be some tutorial material to teach users that fundamentally there
> are two ways to use Git, one to prepare what to be committed in the
> index and run "git commit" without any paths, and the other to
> pretty much ignore the index and run "git commit" with paths (or
> with "-a"), and mixing two are considered to be rare exception.
> 
> You would (1) work with an elaborate sequence to build the next
> commit in the index using "add path" and "add -p", (2) notice a
> change that can go before what you are building (e.g. trivial
> typofix) outside the paths you are touching, and (3) edit that path
> and do "git commit <path>".  That is the only scenario that makes
> some sense to mix the two modes.
> 
> Imagine the change (2) you want to jump over your changes in (1)
> happens to be in a path you are working with the index, e.g. after
> running:
> 
> 	git add -p hello.rb
> 
> and picking only parts of changes you made to hello.rb into the
> index, you found a trivial typo in the same file but in an unrelated
> place (i.e. "git diff hello.rb" at that point would not show the
> typo either in the preimage or the context).  There is no way to
> make the typofix first without disrupting what you did so far, and
> "git commit -o" would not help (you would instead do a "git stash"
> to save away the work in progress, make _only_ the typofix in the
> same file, commit and then unstash, or something).
> 
> So in short, stick to either work with the index or ignore the
> index; do not mix the two workflows and you would not have to worry
> about "-o" or "-i".

 
Thanks for your explanation. Makes perfect sense.

>  Documentation/git-commit.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 0bbc8f5..d6c4af1 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -250,7 +250,7 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
>  
>  -o::
>  --only::
> -	Make a commit only from the paths specified on the
> +	Make a commit only from the working tree contents of the paths specified on the
>  	command line, disregarding any contents that have been
>  	staged so far. This is the default mode of operation of
>  	'git commit' if any paths are given on the command line,

Yep, why not. Makes it a little clearer.


Stefan
-- 
----------------------------------------------------------------
/dev/random says: For every vision there is an equal and opposite revision.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')" 
GPG Key fingerprint = 2DF5 E01B 09C3 7501 BCA9  9666 829B 49C5 9221 27AF
