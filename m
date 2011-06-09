From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] Git-remote-mediawiki: Add push support
Date: Thu, 09 Jun 2011 10:15:50 -0700
Message-ID: <7vsjrjx6wp.fsf@alter.siamese.dyndns.org>
References: <1307625360-10973-1-git-send-email-jeremie.nikaes@ensimag.imag.fr>
 <1307625360-10973-2-git-send-email-jeremie.nikaes@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Sylvain =?utf-8?Q?Boulm=C3=A9?= <sylvain.boulme@imag.fr>
To: Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 09 19:16:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUiqO-000276-03
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 19:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848Ab1FIRQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 13:16:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49665 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791Ab1FIRQK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 13:16:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CC7C348EC;
	Thu,  9 Jun 2011 13:18:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c/dTWeVn/1PqyrDO4/J1+d5k6/Q=; b=T/2uKF
	8MQeq3PkDVXVay8O80btM7zz0+qCtgTXmxltO2UYGys+SWoE80Dcd9bdAQQOYg+2
	m/jcjRGpdh50SJ20XcSt3hBl6lbupZrn0mlm+F/nQiqV23rRS8wgtzPk8InWebUw
	c/bu0+Ez5af4ByL0Ei2pn1N3HB4xvIcmW9QZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f6DaiC34789xHPwahxcjPO4CGmCU8XgS
	KQGycGghJW9a+b6bG/jJKeJ2he5e2A895QikFPfLdRcI+OWcyxNrGlqv/iBxp44b
	j+pFpBu8/dGa/dtX+DpthvsLK4AeOT+uZLNCbGlOK/b/6QLyuOgCTPLHY4O0PsE3
	mRMo/7D3Gg8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 51F3348E2;
	Thu,  9 Jun 2011 13:18:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1303748DA; Thu,  9 Jun 2011
 13:18:01 -0400 (EDT)
In-Reply-To: <1307625360-10973-2-git-send-email-jeremie.nikaes@ensimag.imag.fr> (Jeremie
 Nikaes's message of "Thu, 9 Jun 2011 15:16:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 739EE1EE-92BC-11E0-9B0E-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175554>

Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr> writes:

> diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
> index 176ff09..dc1aacf 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki
> +++ b/contrib/mw-to-git/git-remote-mediawiki
> @@ -148,6 +148,14 @@ sub get_last_remote_revision {
>  	return $max_rev_num;
>  }
>  
> +sub mediawiki_filter($) {

The only caller calls this function with a plain vanilla single scalar
string, and this is not emulating to replace any Perl built-in. I do not
see why you want to confuse the readers with a prototype here.

> @@ -318,5 +327,87 @@ sub mw_import {
>  }
>  
>  sub mw_push {
> -	print STDERR "Push not yet implemented\n";
> +
> +	sub push_file {

The language lets you to write nested functions, but in this case I do not
think it is buying you anything, other than one level unnecessarily deeper
indentation to make the resulting code harder to read.

> +		#$_[0] contains a string in this format :
> +		#100644 100644 <sha1_of_blob_before_commit> <sha1_of_blob_now> <status>\0<filename.mw>\0
> +		#$_[1] contains the title of the commit message (the only phrase kept in the revision message)
> +		my @blob_info_split = split(/ |\t|\0/, $_[0]);

What if a filename has space or tab in it?  A code that reads from "-z"
output should not be using split().  Something like this (untested)?

  # avoid $_[number] unless in a trivial few-liner function. they
  # are unreadable.
  my ($raw_diff, $message) = @_;
  my ($old_mode, $new_mode, $old_sha1, $new_sha1, $status, $path) =
  ($raw_diff =~ /^:([0-7]+) ([0-7]+) ([0-9a-f]{40}) ([0-9a-f]{40}) (\S+)\0(.*?)\0$/) 

> +		if (substr($complete_file_name,-3) eq ".mw"){
> +			my $title = substr($complete_file_name,0,-3);
> +			$title =~ s/$slash_replacement/\//g;

It is probably more customary to write this like so:
	
	if (($title = $complete_file_name) =~ s/\.mw$//) {
		...

> +	} elsif ($HEAD_sha1 ne $remoteorigin_sha1) {
> +		# Get every commit in between HEAD and refs/remotes/origin/master,
> +		# including HEAD and refs/remotes/origin/master
> +		my $parsed_sha1 = $remoteorigin_sha1;
> +		while ($parsed_sha1 ne $HEAD_sha1) {
> +			my @commit_info =  grep(/^$parsed_sha1/, `git rev-list --children $_[0]`);

It feels extremely wasteful to traverse the whole history with rev-list
every time you interate this loop. Can't you do better?

> +			my $blob_infos = run_git("diff --raw --abbrev=40 -z $commit_info_split[0] $commit_info_split[1]");
> +			my @blob_info_list = split(/\n/, $blob_infos);

Huh?  Didn't you read from "-z" output?

> +			# Keep the first line of the commit message as mediawiki comment for the revision
> +			my $commit_msg = (split(/\n/, run_git("show --pretty=format:\"%s\" $commit_info_split[1]")))[0];
> +			chomp($commit_msg);
> +			foreach my $blob_info (@blob_info_list) {
> +				# Push every blob
> +				push_file($blob_info, $commit_msg);
> +			}
> +			$parsed_sha1 = $commit_info_split[1];
> +		}
> +
> +		print STDOUT "ok $_[1]\n";
> +		print STDOUT "\n";
> +		
> +		# Pulling from mediawiki after pushing in order to keep things synchronized
> +		exec("git pull --rebase >/dev/null");
> +	} else {
> +		print STDOUT "\n";
> +	}
>  }
