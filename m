From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-filter-branch.txt: mention absolute path for scripts in --tree-filter
Date: Mon, 15 Mar 2010 13:32:05 +0200
Organization: Private
Message-ID: <87k4td95xm.fsf@jondo.cante.net>
References: <87vdcy7zyu.fsf@jondo.cante.net> <4B9DFE36.3010707@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 12:32:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr8X4-0006l7-9b
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 12:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177Ab0COLcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 07:32:21 -0400
Received: from lo.gmane.org ([80.91.229.12]:48404 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753142Ab0COLcU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 07:32:20 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nr8Wv-0006i7-3g
	for git@vger.kernel.org; Mon, 15 Mar 2010 12:32:17 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 12:32:17 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 12:32:17 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:0e3ONW82K8qoU3nL/0QQ4uRFzrw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142204>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Jari Aalto schrieb:
>
>> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
>> ---
>>  Documentation/git-filter-branch.txt |    3 +++
>>  1 files changed, 3 insertions(+), 0 deletions(-)
>> 
>> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
>> index 020028c..01bd0ad 100644
>> --- a/Documentation/git-filter-branch.txt
>> +++ b/Documentation/git-filter-branch.txt
>> @@ -91,6 +91,9 @@ OPTIONS
>>  	is then used as-is (new files are auto-added, disappeared files
>>  	are auto-removed - neither .gitignore files nor any other ignore
>>  	rules *HAVE ANY EFFECT*!).
>> ++
>> +In case the <command> is a shell script, provide an absolute path.
>> +An example: --tree-filter 'sh /path/to/filter.sh'
>
> Your choice of words is ambiguous: The --tree-filter is not the name of a
> shell script, but rather the shell script itself; the example you gave is
> just a shell script that happens to run only a shell on a file whose name
> must be specified as an absolute path.

Full context was:

    --tree-filter <command>::
            This is the filter for rewriting the tree and its contents.
            The argument is evaluated in shell with the working
            directory set to the root of the checked out tree.  The new tree
            is then used as-is (new files are auto-added, disappeared files
            are auto-removed - neither .gitignore files nor any other ignore
            rules *HAVE ANY EFFECT*!).
    +
    In case the <command> is a shell script, provide an absolute path.
    An example: --tree-filter 'sh /path/to/filter.sh'


>
> But doesn't the recommendation to use absolute paths apply not only to
> --tree-filters, but
>
> - to all filters;
>
> - to all references to external files that the filters make.

I don't know.

> I'm saying "recommendation" because git-filter-branch does not switch
> directory ad lib., so theoretically, it would be possible to use relative
> paths, even though the base of the relative paths would be non-obvious
> because it is from inside a temporary directory named ".git-rewrite/t"
> that is allocated next to .git.

The problem was that I was trying to use a sell script for athe
manipulation:

    cd <gir repo>
    git filter-branch  --tree-filter "sh ../filter.sh" HEAD

Which didn't. It needed absolute path:

    cd <gir repo>
    git filter-branch  --tree-filter "sh $(pwd)/filter.sh" HEAD

And that didn't work quit either. Script was run, but paths weren't no
longer relative to the "working dir" I was cd'd to:

    rm  file \
        dir/file \
        dir/file \
        ..

So, someone please explain how the paths should be expressed in shell
script and we'll improve the docs.

Jari
