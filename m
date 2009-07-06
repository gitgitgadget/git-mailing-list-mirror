From: astubbs <antony.stubbs@gmail.com>
Subject: [PATCH 1/1] Re: cvs import and internal plumbing commands
Date: Mon, 6 Jul 2009 05:15:55 -0700 (PDT)
Message-ID: <1246882555704-3212716.post@n2.nabble.com>
References: <B9FEA72A-882C-4CF9-97A3-A353F282ACBB@gmail.com> <A48A81BD-30F4-4363-88F8-F61BCB7ADB0F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 14:16:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNn7D-0002TI-Vl
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 14:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761AbZGFMPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 08:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754345AbZGFMPw
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 08:15:52 -0400
Received: from kuber.nabble.com ([216.139.236.158]:38383 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754229AbZGFMPv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 08:15:51 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1MNn6x-00018L-ND
	for git@vger.kernel.org; Mon, 06 Jul 2009 05:15:55 -0700
In-Reply-To: <A48A81BD-30F4-4363-88F8-F61BCB7ADB0F@gmail.com>
X-Nabble-From: antony.stubbs@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122784>


fyi this is a patch

astubbs wrote:
> 
> OK, I have it running now - didn't know exec takes all command line  
> arguments as a list. So here's the patch. It's not finished importing  
> yet - it will probably take a while, but I'll report back once it's  
> done.
> 
>  From 7394424e9892feb4a1274a7c57a11fd81af5a31a Mon Sep 17 00:00:00 2001
> From: Antony Stubbs <antony.stubbs@gmail.com>
> Date: Sun, 5 Jul 2009 18:09:32 +1200
> Subject: [PATCH] migrate to internal git * commands
> 
> ---
>   git-cvsimport.perl |   64 +++++++++++++++++++++++++ 
> +--------------------------
>   1 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> index e439202..80c9710 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -560,16 +560,16 @@ $orig_git_index = $ENV{GIT_INDEX_FILE} if exists  
> $ENV{GIT_INDEX_FILE};
>   my %index; # holds filenames of one index per branch
> 
>   unless (-d $git_dir) {
> -	system("git-init");
> +	system("git", "init");
>   	die "Cannot init the GIT db at $git_tree: $?\n" if $?;
> -	system("git-read-tree");
> +	system("git", "read-tree");
>   	die "Cannot init an empty tree: $?\n" if $?;
> 
>   	$last_branch = $opt_o;
>   	$orig_branch = "";
>   } else {
> -	open(F, "git-symbolic-ref HEAD |") or
> -		die "Cannot run git-symbolic-ref: $!\n";
> +	open(F, "git symbolic-ref HEAD |") or
> +		die "Cannot run git symbolic-ref: $!\n";
>   	chomp ($last_branch = <F>);
>   	$last_branch = basename($last_branch);
>   	close(F);
> @@ -578,12 +578,12 @@ unless (-d $git_dir) {
>   		$last_branch = "master";
>   	}
>   	$orig_branch = $last_branch;
> -	$tip_at_start = `git-rev-parse --verify HEAD`;
> +	$tip_at_start = `git rev-parse --verify HEAD`;
> 
>   	# Get the last import timestamps
>   	my $fmt = '($ref, $author) = (%(refname), %(author));';
> -	open(H, "git-for-each-ref --perl --format='$fmt' $remote |") or
> -		die "Cannot run git-for-each-ref: $!\n";
> +	open(H, "git for-each-ref --perl --format='$fmt' $remote |") or
> +		die "Cannot run git for-each-ref: $!\n";
>   	while (defined(my $entry = <H>)) {
>   		my ($ref, $author);
>   		eval($entry) || die "cannot eval refs list: $@";
> @@ -638,7 +638,7 @@ unless ($opt_P) {
>   	    print $cvspsfh $_;
>   	}
>   	close CVSPS;
> -	$? == 0 or die "git-cvsimport: fatal: cvsps reported error\n";
> +	$? == 0 or die "git cvsimport: fatal: cvsps reported error\n";
>   	close $cvspsfh;
>   } else {
>   	$cvspsfile = $opt_P;
> @@ -667,27 +667,27 @@ my $state = 0;
>   sub update_index (\@\@) {
>   	my $old = shift;
>   	my $new = shift;
> -	open(my $fh, '|-', qw(git-update-index -z --index-info))
> -		or die "unable to open git-update-index: $!";
> +	open(my $fh, '|-', qw(git update-index -z --index-info))
> +		or die "unable to open git update-index: $!";
>   	print $fh
>   		(map { "0 0000000000000000000000000000000000000000\t$_\0" }
>   			@$old),
>   		(map { '100' . sprintf('%o', $_->[0]) . " $_->[1]\t$_->[2]\0" }
>   			@$new)
> -		or die "unable to write to git-update-index: $!";
> +		or die "unable to write to git update-index: $!";
>   	close $fh
> -		or die "unable to write to git-update-index: $!";
> -	$? and die "git-update-index reported error: $?";
> +		or die "unable to write to git update-index: $!";
> +	$? and die "git update-index reported error: $?";
>   }
> 
>   sub write_tree () {
> -	open(my $fh, '-|', qw(git-write-tree))
> -		or die "unable to open git-write-tree: $!";
> +	open(my $fh, '-|', qw(git write-tree))
> +		or die "unable to open git write-tree: $!";
>   	chomp(my $tree = <$fh>);
>   	is_sha1($tree)
>   		or die "Cannot get tree id ($tree): $!";
>   	close($fh)
> -		or die "Error running git-write-tree: $?\n";
> +		or die "Error running git write-tree: $?\n";
>   	print "Tree ID $tree\n" if $opt_v;
>   	return $tree;
>   }
> @@ -702,7 +702,7 @@ sub commit {
>   	if ($branch eq $opt_o && !$index{branch} &&
>   		!get_headref("$remote/$branch")) {
>   	    # looks like an initial commit
> -	    # use the index primed by git-init
> +	    # use the index primed by git init
>   	    $ENV{GIT_INDEX_FILE} = "$git_dir/index";
>   	    $index{$branch} = "$git_dir/index";
>   	} else {
> @@ -712,9 +712,9 @@ sub commit {
>   		$index{$branch} = tmpnam();
>   		$ENV{GIT_INDEX_FILE} = $index{$branch};
>   		if ($ancestor) {
> -		    system("git-read-tree", "$remote/$ancestor");
> +		    system("git", "read-tree", "$remote/$ancestor");
>   		} else {
> -		    system("git-read-tree", "$remote/$branch");
> +		    system("git", "read-tree", "$remote/$branch");
>   		}
>   		die "read-tree failed: $?\n" if $?;
>   	    }
> @@ -749,7 +749,7 @@ sub commit {
>   	$ENV{GIT_COMMITTER_EMAIL} = $author_email;
>   	$ENV{GIT_COMMITTER_DATE} = $commit_date;
>   	my $pid = open2(my $commit_read, my $commit_write,
> -		'git-commit-tree', $tree, @commit_args);
> +		'git', 'commit-tree', $tree, @commit_args);
> 
>   	# compatibility with git2cvs
>   	substr($logmsg,32767) = "" if length($logmsg) > 32767;
> @@ -762,7 +762,7 @@ sub commit {
>   	}
> 
>   	print($commit_write "$logmsg\n") && close($commit_write)
> -		or die "Error writing to git-commit-tree: $!\n";
> +		or die "Error writing to git commit-tree: $!\n";
> 
>   	print "Committed patch $patchset ($branch $commit_date)\n" if $opt_v;
>   	chomp(my $cid = <$commit_read>);
> @@ -771,9 +771,9 @@ sub commit {
>   	close($commit_read);
> 
>   	waitpid($pid,0);
> -	die "Error running git-commit-tree: $?\n" if $?;
> +	die "Error running git commit-tree: $?\n" if $?;
> 
> -	system('git-update-ref', "$remote/$branch", $cid) == 0
> +	system('git', 'update-ref', "$remote/$branch", $cid) == 0
>   		or die "Cannot write branch $branch for update: $!\n";
> 
>   	if ($tag) {
> @@ -783,7 +783,7 @@ sub commit {
>   		$xtag =~ s/[\/]/$opt_s/g;
>   		$xtag =~ s/\[//g;
> 
> -		system('git-tag', '-f', $xtag, $cid) == 0
> +		system('git', 'tag', '-f', $xtag, $cid) == 0
>   			or die "Cannot create tag $xtag: $!\n";
> 
>   		print "Created tag '$xtag' on '$branch'\n" if $opt_v;
> @@ -920,7 +920,7 @@ while (<CVS>) {
>   			my $pid = open(my $F, '-|');
>   			die $! unless defined $pid;
>   			if (!$pid) {
> -			    exec("git-hash-object", "-w", $tmpname)
> +			    exec("git", "hash-object", "-w", $tmpname)
>   				or die "Cannot create object: $!\n";
>   			}
>   			my $sha = <$F>;
> @@ -964,7 +964,7 @@ unless ($opt_P) {
>   # The heuristic of repacking every 1024 commits can leave a
>   # lot of unpacked data.  If there is more than 1MB worth of
>   # not-packed objects, repack once more.
> -my $line = `git-count-objects`;
> +my $line = `git count-objects`;
>   if ($line =~ /^(\d+) objects, (\d+) kilobytes$/) {
>     my ($n_objects, $kb) = ($1, $2);
>     1024 < $kb
> @@ -989,26 +989,26 @@ if ($orig_branch) {
>   	if ($opt_i) {
>   		exit 0;
>   	}
> -	my $tip_at_end = `git-rev-parse --verify HEAD`;
> +	my $tip_at_end = `git rev-parse --verify HEAD`;
>   	if ($tip_at_start ne $tip_at_end) {
>   		for ($tip_at_start, $tip_at_end) { chomp; }
>   		print "Fetched into the current branch.\n" if $opt_v;
> -		system(qw(git-read-tree -u -m),
> +		system(qw(git read-tree -u -m),
>   		       $tip_at_start, $tip_at_end);
>   		die "Fast-forward update failed: $?\n" if $?;
>   	}
>   	else {
> -		system(qw(git-merge cvsimport HEAD), "$remote/$opt_o");
> +		system(qw(git merge cvsimport HEAD), "$remote/$opt_o");
>   		die "Could not merge $opt_o into the current branch.\n" if $?;
>   	}
>   } else {
>   	$orig_branch = "master";
>   	print "DONE; creating $orig_branch branch\n" if $opt_v;
> -	system("git-update-ref", "refs/heads/master", "$remote/$opt_o")
> +	system("git", "update-ref", "refs/heads/master", "$remote/$opt_o")
>   		unless defined get_headref('refs/heads/master');
> -	system("git-symbolic-ref", "$remote/HEAD", "$remote/$opt_o")
> +	system("git", "symbolic-ref", "$remote/HEAD", "$remote/$opt_o")
>   		if ($opt_r && $opt_o ne 'HEAD');
> -	system('git-update-ref', 'HEAD', "$orig_branch");
> +	system('git', 'update-ref', 'HEAD', "$orig_branch");
>   	unless ($opt_i) {
>   		system('git checkout -f');
>   		die "checkout failed: $?\n" if $?;
> -- 
> 1.6.3.1
> 
> 
> 
> 
> Regards,
> Antony Stubbs
> 
> Talk to me about Wicket, Spring, Maven consulting, small scale  
> outsourcing to Australasia and India and Open Source development!
> 
> Website: http://sharca.com
> Blog: http://stubbisms.wordpress.com
> Linked In: http://www.linkedin.com/in/antonystubbs
> Podcast: http://www.illegalargument.com
> 
> On 5/07/2009, at 2:43 PM, Antony Stubbs wrote:
> 
>> I've got a new install from mac-ports and am having trouble with cvs  
>> import not finding the plumbing commands.
>>
>> It seems that cvsimport still uses all the old style git-hash-object  
>> type commands, instead of the new " git hash-object" command style.  
>> And on my system, I don't have any of the old style commands.
>>
>> I'm working on patching cvsimport to the new style, but would  
>> appreicate anyone pointing out anything I'm missing...
>>
>> If i am indeed correct, then a little help with this would be great  
>> (I'm not a perl programmer):
>>
>> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
>> index e439202..de40933 100755
>> --- a/git-cvsimport.perl
>> +++ b/git-cvsimport.perl
>> @@ -920,7 +920,7 @@ while (<CVS>) {
>>                        my $pid = open(my $F, '-|');
>>                        die $! unless defined $pid;
>>                        if (!$pid) {
>> -                           exec("git-hash-object", "-w", $tmpname)
>> +                           exec("git", "hash-object -w", $tmpname)
>>                                or die "Cannot create object: $!\n";
>>                        }
>>                        my $sha = <$F>;
>>
>> git: 'hash-object -w' is not a git-command. See 'git --help'.
>>
>> Regards,
>> Antony Stubbs
>>
>> Talk to me about Wicket, Spring, Maven consulting, small scale  
>> outsourcing to Australasia and India and Open Source development!
>>
>> Website: http://sharca.com
>> Blog: http://stubbisms.wordpress.com
>> Linked In: http://www.linkedin.com/in/antonystubbs
>> Podcast: http://www.illegalargument.com
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

-- 
View this message in context: http://n2.nabble.com/cvs-import-and-internal-plumbing-commands-tp3207876p3212716.html
Sent from the git mailing list archive at Nabble.com.
