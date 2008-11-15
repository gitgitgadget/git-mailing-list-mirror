From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 08/11] gitweb: display HEAD in heads list when detached
Date: Sat, 15 Nov 2008 23:31:15 +0100
Message-ID: <200811152331.17294.jnareb@gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com> <1226616555-24503-8-git-send-email-giuseppe.bilotta@gmail.com> <1226616555-24503-9-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 23:34:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1TiT-0005pe-EM
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 23:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbYKOWbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 17:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbYKOWbX
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 17:31:23 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:46526 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbYKOWbW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 17:31:22 -0500
Received: by nf-out-0910.google.com with SMTP id d3so937621nfc.21
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 14:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ixEqP4p6kCY9rbuQPPnD4EjXaah+wDXrpqtlqWvIcoo=;
        b=TJZpS1O0Osv96E3OV+kTasHMGaJA+NHGVNpAhGQFO/sHSm0cYugywG4PZqPgQ+JXuu
         m5YUFb/qu2rRGhUEOsQdnHxiFmo9BZz3x7ALIkUyZ4Wymqo6NGYTlVT/GcDqx0MBZ95q
         AIhO8ivAP/XYHFteg6H2V9K0DVnR8tvpAE9Kk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VHoYYgf5xC3kvAHysZ2gRDVeGCZuAAvRaz2PDfIfLCTuM2lreogXHRGoCOBSK7dLkf
         Mut6oE1Tx2aU6wLk+QF6E+4L0jK+t/ILbeZSQ8mx6BGqtNKZEoUadQESOTMHe8ZRROoO
         ippynnO2pTPq0bRXu3Mzpsllr3XSOQjFHLM4U=
Received: by 10.210.92.8 with SMTP id p8mr2526271ebb.28.1226788280006;
        Sat, 15 Nov 2008 14:31:20 -0800 (PST)
Received: from ?192.168.1.11? (abwb4.neoplus.adsl.tpnet.pl [83.8.225.4])
        by mx.google.com with ESMTPS id 10sm1477895eyd.6.2008.11.15.14.31.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 Nov 2008 14:31:18 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1226616555-24503-9-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101094>

On Thu, 13 Nov 2008, Giuseppe Bilotta wrote:

First, I think that _at least_ the first two patches dealing with
detached should be squashed.

Second, not this way!


But I think that support for detached HEAD (I am not sure if it should
have to be explicitly turned on using some %feature, or reusing some
existing feature like 'remote_heads') is a very good idea. Especially
for git-instaweb.

> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   21 +++++++++++++++++++++
>  1 files changed, 21 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 09728cb..a168f6f 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2672,6 +2672,27 @@ sub git_get_heads_list {
>  	my @refs = map { "refs/$_" } @class;
>  	my @headslist;
>  
> +	if (grep { $_ eq 'heads' } @class) {

First, IMHO layering violation. Resolving detached HEAD should not be
in my opinion left to git_get_heads_list, which is wrapped around 
git-for-each-ref, which for some reason (contrary for example to
"git ls-remote ." or "git show-ref -h") doesn't show HEAD even if it
is detached. Probably misfeature / a bug in git-for-each-ref. I guess
that we should resolve detached HEAD in caller.

But I am not sure about this decision. Maybe instead of showing
detached HEAD (if it is detached) for 'heads', we should show it if
there is 'HEAD' in @class (well, @refs would have to be corrected,
too)?

> +		my @x = (git_cmd(), 'branch');
> +		my @ret = split("\n", qx(@x));

                                      ^^^^^^^- bit strange

Especially compared to almost everywhere else using open ... "-|"

> +		if (grep { /^\* \(no branch\)$/ } @ret) { ;

                                                          ^
                            WTF? -------------------------|

Second, if we go the route of manually resolving detached HEAD, 
instead of adding [-h|--head] (from git-show-ref) option equivalent
to git-for-each-ref, which would work only for detached HEAD (fixing
kind of a bug), this is *not* the way to do it.

A. It should be done using encapsulation, adding is_HEAD_detached() or
git_is_head_detached() subroutine (squashing the next patch), or
simply using !defined($current_branch), where $current_branch would
be set using git_get_symbolic_ref('HEAD') or something.

B. Using porcelain, especially end-user porcelain such as git-branch,
which can change its output format (because they are porcelain). Use
equivalent plumbing, be if git-symbolic-ref ("git symbolic-ref -q HEAD"
to be more exact) to get current branch name[1], or just simply do
that in Perl: check if it is symlink, or if it starts with "ref: "
if it is regular file (IIRC HEAD, even detached HEAD, cannot get
packed into .git/packed-refs and deleted... at least I think so).

[1] This means that we have better way of detecting (and showing)
which branch is current one than comparing sha1 with resolved HEAD.
($head_hash).

> +			my %ref_item;
> +			@x = (git_cmd(), 'log', '-1', '--pretty=format:%H%n%ct%n%s');
> +			my ($hash, $epoch, $title) = split("\n", qx(@x), 3);

Errr... if we don't fix git-for-each-ref, and go that route, why not
simply use parse_commit subroutine, and extract relevant info from
there, instead of handcrafting git-log (why not git-show?) call?

You get more info than needed, but I think the cost of getting it is
almost the same, and you can reuse existing code.

And if we go --pretty=format:<...> or --pretty=tformat:<...> route for
git-log, git-rev-list or git-show, wouldn't it be possible to generate
the same output format as git-for-each-ref below?

> +
> +			$ref_item{'class'} = 'head';
> +			$ref_item{'name'} = 'HEAD';
> +			$ref_item{'id'} = $hash;
> +			$ref_item{'title'} = $title || '(no commit message)';
> +			if ($ref_item{'epoch'} = $epoch) {
> +				$ref_item{'age'} = age_string(time - $ref_item{'epoch'});

Hmmm...

> +			} else {
> +				$ref_item{'age'} = "unknown";
> +			}
> +			push @headslist, \%ref_item;
> +		}
> +	}
> +
>  	open my $fd, '-|', git_cmd(), 'for-each-ref',
>  		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
>  		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
