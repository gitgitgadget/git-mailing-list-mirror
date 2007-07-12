From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: new cgi parameter: option
Date: Thu, 12 Jul 2007 12:11:32 +0200
Message-ID: <200707121211.32813.jnareb@gmail.com>
References: <20070708013543.GD29994@genesis.frugalware.org> <f73hhc$uo1$1@sea.gmane.org> <20070711230038.GN19386@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jul 12 12:05:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8vXw-0004KJ-36
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 12:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757674AbXGLKFL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 06:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756910AbXGLKFL
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 06:05:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:31559 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756071AbXGLKFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 06:05:09 -0400
Received: by ug-out-1314.google.com with SMTP id j3so301093ugf
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 03:05:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iKMl4Bee9SOKbfDJnWoRyBuHYXtkwut6xdUcd94RPO/Lg6WWKvyqQNXk4eu8j2PtxsX/gM3LD1PRNChPdcB9hvw6l+VPAc9pMMwsyvsibovUTJ7ga0YZnR+zuNU5ZZ/k6dPuTYtCdQiVLnE+urXVcNETFEjAOCGrj45WVueCwjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=b10T79U0Ote/V99pyyZgvo+Hp0FI5KTu1eb62mBEz7ex7jd/toR11tU+3A81ZNBzEuq3LgTrJTtoHkEedd8x2LIhdBDBojbL2HUzEmz6w1emoltSOewoJiCLJdWASMHTWjDpBEcv33F/8TeMNXPgH4jODkqgO5vze3BA254m2gQ=
Received: by 10.86.97.7 with SMTP id u7mr356980fgb.1184234708027;
        Thu, 12 Jul 2007 03:05:08 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTP id k29sm38528483fkk.2007.07.12.03.05.04
        (version=SSLv3 cipher=OTHER);
        Thu, 12 Jul 2007 03:05:04 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070711230038.GN19386@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52264>

On Thu, 12 Jul 2007, Miklos Vajna wrote:
> Currently the only supported value is '--no-merges' for the 'rss', 'atom',
> 'log', 'shortlog' and 'history' actions, but it can be easily extended to allow
> other parameters for other actions.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>

Micronit: it is unwritten (as of yet) requirement to word wrap commit
message at 80 columns or less.

> ---
> 
> Na Wed, Jul 11, 2007 at 11:19:41PM +0200, Jakub Narebski <jnareb@gmail.com> pisal(a):
>> Miklos Vajna wrote:
>>
>>> +((defined $filter and $filter == "nomerges") ? ("--no-merges") : ()),
>>
>> Shouldn't it be '$filter eq "nomerges"' instead?
> 
> Yes, that works too (I'm not a perl addict :) )

By the way, there is t9500-gitweb-standalone-no-errors.sh test script to
check if gitweb doesn't give any Perl warnings or errors. Please try to
use it; it should at least find errors about undefined values and such.
But it has the disadvantage of requiring git to be build (compiled),
even if theoretically testing gitweb doesn't require it.

You would see something like

  Argument "nomerges" isn't numeric in numeric eq (==)

when running this test with --debug, I think.

>> Besides, I'd rather have generalized way to provide additional options
>> to git commands, like '--no-merges' for RSS and Atom feeds, log, shortlog
>> and history views, '-C' for commitdiff view, '--remove-empty' for history
>> view for a file, perhaps even '-c' or '--cc' for commitdiff for merges
>> instead of abusing 'hp' argument for that.

Now I'm not so sure about using 'option' for selecting between
combined ('-c') and compressed combined ('--cc') formats for commitdiff
for merges. The '-c' and '--cc' (or '-m') must be used with only one
commit-ish[*1*], so they can take place of the second commit-ish, i.e.
'hp' (hash_parent) parameter. What do the list think about it?

[*1*] At least in gitweb. If I understand correctly, you can use
"git diff --cc tree1 tree2 tree2 ..." to get combined diff of specified
tree-ish; I'm not sure if git-diff-tree support this. And I know that
gitweb does not support this... at least for now. Would this be useful,
I wonder?

>> But that doesn't mean that this patch should be not applied... it doesn't
>> mean it should be applied neither ;-)
> 
> What about this one?

See comments below.


> +my %options = (
> +	"--no-merges" => [('rss', 'atom', 'log', 'shortlog', 'history')],
> +);

First, you don't need inner () parentheses to delimit/create list, as
anonymous array reference constructor [] works like it. So it could be
written simply as

  +my %options = (
  +	"--no-merges" => ['rss', 'atom', 'log', 'shortlog', 'history'],
  +);

Second, instead of quoting each word by hand, we can use handy Perl
quoting operator, qw(), i.e. 'word list' operator, like below. 
See perlop(1), "Quote and Quote-like Operators" subsection

  +my %options = (
  +	"--no-merges" => [ qw(rss atom log shortlog history) ],
  +); 

> +our $option = $cgi->param('option');
> +if (defined $option) {
> +	if (not grep(/^$option$/, keys %options)) {
> +		die_error(undef, "Invalid option parameter");
> +	}
> +	if (not grep(/^$action$/, @{$options{$option}})) {
> +		die_error(undef, "Invalid option parameter for this action");
> +	}
> +}

I'd rather make it possible to pass multiple additional options, for
example both '--remove-empty' (to speed up) and '--no-merges' for the
history view. So I'd use

  +our @options = $cgi->param('option');

instead. This would make option validation bit harder, but I think not that
harder. But it would also make using extra options easier: just @options
instead of (defined $option ? $option : ()).

I'd also use @extra_options, or @act_opts instead of @options as
a variable name to be more descriptive.

I'm also not sure if invalid option parameter for action should return
error, or be simply ignored. This allow to hand-edit URL, changing for
example action from 'commitdiff' to 'commit', not worrying about spurious
parameters.

By the way, gitweb uses shortened names for paramaters. Perhaps 'opt'
or 'op' instead of 'options' here and in href subroutine (below)?

> @@ -534,6 +548,7 @@ sub href(%) {
[...]
> +		option => "option",


> @@ -1770,6 +1785,7 @@ sub parse_commits {
>  		($arg ? ($arg) : ()),
>  		("--max-count=" . $maxcount),
>  		("--skip=" . $skip),
> +		((defined $option) ? ($option) : ()),
>  		$commit_id,
>  		"--",
>  		($filename ? ($filename) : ())

Very clever to put this in parse_commits subroutine...

-- 
Jakub Narebski
Poland
