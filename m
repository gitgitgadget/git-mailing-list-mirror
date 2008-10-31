From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb: add 'historyfollow' view that follows renames
Date: Fri, 31 Oct 2008 02:19:52 +0100
Message-ID: <200810310219.55913.jnareb@gmail.com>
References: <054F21930D24A0428E5B4588462C7AED0149B4B8@ednex512.dsto.defence.gov.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: ming.m.lin@intel.com, robert.moore@intel.com, git@vger.kernel.org
To: "Blucher, Guy" <Guy.Blucher@dsto.defence.gov.au>
X-From: git-owner@vger.kernel.org Fri Oct 31 02:21:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvihU-000387-DD
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 02:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbYJaBUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 21:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbYJaBUG
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 21:20:06 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:64467 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbYJaBUE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 21:20:04 -0400
Received: by nf-out-0910.google.com with SMTP id d3so439956nfc.21
        for <git@vger.kernel.org>; Thu, 30 Oct 2008 18:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=P9zPF4z4QML8tSfvATe3YYYxWRG+mDy+7JwBDiQ0cu8=;
        b=FAvjiWY4hA7le2ryw5Wqsep3Np+gy3ECJSYlyXSNdDjsTKet+NnXnin2zDpw6B2RgM
         tNHsTMXUoUCQCEcQ6KmlcEmino1l1LTaG567DRyPuev9bZwpR8ABlRRJ98ayqv/zStia
         eRh9Ws+RVsV32pmMJpYrzTwE4Ks+l25IdAVgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=K++1eyarR0A/qns9EIK+A19OdRP09DPjUNWPeRUfbu07HLTmwkJIhpOWSC6hFj6xuN
         LI+xDPhbP0dMjm8C5b/P/5mIQSrq6HBN0UyRwP7ceWvfS7vMBi+ouwkxS1QIT870F993
         NU2Kxt+yvXapmAC1V9yq6zTV6v41WquDEzSiU=
Received: by 10.210.42.20 with SMTP id p20mr12602587ebp.4.1225416002371;
        Thu, 30 Oct 2008 18:20:02 -0700 (PDT)
Received: from ?192.168.1.11? (abvo7.neoplus.adsl.tpnet.pl [83.8.212.7])
        by mx.google.com with ESMTPS id b30sm2425959ika.3.2008.10.30.18.19.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Oct 2008 18:20:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <054F21930D24A0428E5B4588462C7AED0149B4B8@ednex512.dsto.defence.gov.au>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99543>

I'm sorry for the delay in reviewing this patch...

On Mon, 27 Oct 2008, Huy Blucher wrote:

[Please try do not lose attributions...]

> > > 
> > > What should we add to automatically get all file history?
> 
> > While the 'commitdiff' view would, in default gitweb configuration, 
> > contain information about file renames, currently 'history' view does 
> > not support '--follow' option to git-log.  It wouldn't be too hard to 
> > add it, but it just wasn't done (well, add to this the fact that 
> > --follow works only for simple cases).
> 
> We also ran up against this issue because renaming of files in our
> project is a useful bit of information while browsing file history.
> 
> I hacked gitweb to add a 'historyfollow' viewing option in addition to
> the 'history' option.  Yes, '--follow' is expensive so I didn't just
> make it the default 'history' behaviour.

I would prefer if instead of adding new 'historyfollow' action, which
goes against stated in TODO goal of uniquifying log-like views handling,
the patch added support for '--follow' as extra option to 'history'
view (i.e. a=history;opt=--follow)... on the other hand 'historyfollow'
(or simply 'follow') can be used in pure path_info gitweb URL... Hmm...

> 
> The only problem with doing it was that parse_commits in gitweb.perl
> uses git rev-list which doesn't support the '--follow' option like
> git-log does. A bit of hacking to use 'git log --pretty=raw -z' to make
> the output look close to that from rev-list means only minor
> shoe-horning is required (perhaps it would be better to make rev-list
> understand --follow though?).

Either that, or use --pretty=format:<sth> which mimics current use of
"git-rev-list <opts>" output in parse_commits exactly.

And either move parse_commits to use git-log, change git-rev-parse to
understand '--follow', or make parse_commits use git-log with --follow,
git-rev-list otherwise.

> 
> I wasn't originally prepared to publish the work here because I don't
> really think it's the best solution. But considering it's come up... I
> include a patch inline against gitweb.perl from v1.6.0.3 that implements
> a 'historyfollow' view.

RFC (usually marked [RFC/PATCH]) patches are good because they allow
others to test and comment on your solution: early review, better to
spot bugs etc. earlier.

> 
> Feel free to do with it what you will. It would need some substantial
> tidying up by someone who knows much more about perl than me :) 
> 
> We use it such that anywhere a 'history' link is provided a
> 'historyfollow' link is also provided next to it - This patch doesn't
> implement that bit though.
> 
> Hope it helps.
> 
> Cheers,
> Guy.

It would be nice though if such [RFC/PATCH] followed guidelines from
SubmittingPatches on commit messages...

> 
> ---

Diffstat?

> 
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -478,6 +478,7 @@ my %actions = (
>         "forks" => \&git_forks,
>         "heads" => \&git_heads,
>         "history" => \&git_history,
> +       "historyfollow" => \&git_history_follow,
>         "log" => \&git_log,
>         "rss" => \&git_rss,
>         "atom" => \&git_atom,
> @@ -2311,25 +2312,39 @@ sub parse_commit {
>  }
>  
>  sub parse_commits {
> -       my ($commit_id, $maxcount, $skip, $filename, @args) = @_;
> +       my ($commit_id, $maxcount, $skip, $mode, $filename, @args) = @_;

Can't you simply pass '--follow' or 'follow' in @args instead of
changing the signature of parse_commits?

>         my @cos;
>  
>         $maxcount ||= 1;
>         $skip ||= 0;
>  
>         local $/ = "\0";
> +        # The '--max-count' argument is not available when doing a
> +        # '--follow' to 'git log'
> +        my $count_arg = ("--max-count=" . $maxcount) ;
> +        if (defined $mode && $mode eq "--follow") {
> +            $count_arg = "--follow" ;
> +        }

I don't understand. Do you mean that

  $ git log --max-count=<n> --follow <rev> -- <path>

doesn't work as expected? Hmmm... true, it doesn't work. 
Then it is certainly a _BUG_ in git!

>  
> -       open my $fd, "-|", git_cmd(), "rev-list",
> -               "--header",
> +
> +       open my $fd, "-|", git_cmd(), "log",
> +               "-z",
> +               "--pretty=raw",
>                 @args,
> -               ("--max-count=" . $maxcount),
> +                ($count_arg ? ($count_arg ) : ()),

Whitespace damage (here visible).

>                 ("--skip=" . $skip),
>                 @extra_options,
>                 $commit_id,
>                 "--",
>                 ($filename ? ($filename) : ())
> -               or die_error(500, "Open git-rev-list failed");
> +               or die_error(500, "Open git-log failed");
>         while (my $line = <$fd>) {
> +               # Need to put a delimiter on the end of output
> +                # 'git-log -z' doesn't put one before EOF like rev-list
> does
> +                $line = ($line . '\0');

Doesn't it work if you don't add the above line?

> +                # Need to strip the word commit from the start so it
> +                # looks like rev-list output
> +                $line =~ s/^commit // ;
>                 my %co = parse_commit_text($line);

Perhaps we should update parse_commit_text instead... or add an option
like parse_commit_text($line, -format=>'log'), or something like that.

>                 push @cos, \%co;
>         }
> @@ -5363,6 +5378,13 @@ sub git_commitdiff_plain {
>  }
>  
>  sub git_history {
> +        my $mode = shift || '';
> +        my $history_call = "history";
> +
> +       if ($mode eq "--follow") {
> +           $history_call .= "historyfollow" ;
> +       }
> +

I don't quite like this solution...

If '--follow' was passed through @extra_options ('opt') parameter, then
it should be re-used in links thanks to href(..., -replay=>1).

>         if (!defined $hash_base) {
>                 $hash_base = git_get_head_hash($project);
>         }
> @@ -5377,7 +5399,7 @@ sub git_history {
>         my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
>  
>         my @commitlist = parse_commits($hash_base, 101, (100 * $page),
> -                                      $file_name, "--full-history")
> +                                      $mode, $file_name,
> "--full-history")

Word wrapped (not only here).

>             or die_error(404, "No such file or directory on given
> branch");
>  
>         if (!defined $hash && defined $file_name) {
> @@ -5398,7 +5420,7 @@ sub git_history {
>         my $paging_nav = '';
>         if ($page > 0) {
>                 $paging_nav .=
> -                       $cgi->a({-href => href(action=>"history",
> hash=>$hash, hash_base=>$hash_base,
> +                       $cgi->a({-href => href(action=>"$history_call",
> hash=>$hash, hash_base=>$hash_base,
>                                                file_name=>$file_name)},
>                                 "first");

I would add opts=>[@extra_options] instead of changing action=>"history"
to action=>$history_call (the quotes around variable are not needed).

>                 $paging_nav .= " &sdot; " .
> @@ -5429,6 +5451,11 @@ sub git_history {
>         git_footer_html();
>  }
>  
> +sub git_history_follow {
> +       git_history('--follow');
> +}
> +
> +
>  sub git_search {
>         gitweb_check_feature('search') or die_error(403, "Search is
> disabled");
>         if (!defined $searchtext) {
> @@ -5469,7 +5496,7 @@ sub git_search {
>                         $greptype = "--committer=";
>                 }
>                 $greptype .= $searchtext;
> -               my @commitlist = parse_commits($hash, 101, (100 *
> $page), undef,
> +               my @commitlist = parse_commits($hash, 101, (100 *
> $page), undef, undef,
>                                                $greptype,
> '--regexp-ignore-case',
>                                                $search_use_regexp ?
> '--extended-regexp' : '--fixed-strings');
>  
> @@ -5737,7 +5764,7 @@ sub git_feed {
>  
>         # log/feed of current (HEAD) branch, log of given branch,
> history of file/directory
>         my $head = $hash || 'HEAD';
> -       my @commitlist = parse_commits($head, 150, 0, $file_name);
> +       my @commitlist = parse_commits($head, 150, 0, undef,
> $file_name);
>  
>         my %latest_commit;
>         my %latest_date;
> ---

What I would like to see is the link in the bottom of action bar
(navbar) or just below it, which would list 'follow' as one of possible
'history' view formats (just like '--no-merges' or '--first-parent'
should be).

-- 
Jakub Narebski
Poland
