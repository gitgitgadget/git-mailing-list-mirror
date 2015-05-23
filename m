From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/1] send-email: Add sendmail email aliases format
Date: Sat, 23 May 2015 10:45:44 -0700
Message-ID: <xmqqfv6nchmf.fsf@gitster.dls.corp.google.com>
References: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 23 19:45:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwDUd-0000sy-VN
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 19:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758047AbbEWRpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 13:45:47 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34726 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116AbbEWRpq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 13:45:46 -0400
Received: by igbhj9 with SMTP id hj9so13159640igb.1
        for <git@vger.kernel.org>; Sat, 23 May 2015 10:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+wAeu6Vv30oqwzPNZfPPf/OBauXFalxtLAJEON/UFfU=;
        b=ZeTtUzmAwxaMVg/EVHRxkTcr9ZtE8JnB0dN5OU8TC7BWdQOgI6YA7e1jLbQhr0EY8L
         NWF4qoJi7/AaHbB2PUcmwjLRHJcz/wLLEAQe9Q0hpCGB2zegQrRwoIM9w3xuL+uElwHS
         ygejQnqaktjQNAfa9wBffizod4ixBhmze2pJ2nJ3xPedOOnl2A3deMtbc1UldgA3KT3M
         pZsUvhID/0gPsnIyxU+8hiiUorzJC39lBzjkpqDZSFpEjKUbadBk1yHHjJzabSNdRHFN
         4MQ0qNARd3XZYaUb9yxlWq4mlRDtg+lq1v79VFqSdaToJzi75pmdduK0IwKm/mW70ky6
         fNYw==
X-Received: by 10.50.85.113 with SMTP id g17mr13138957igz.46.1432403145821;
        Sat, 23 May 2015 10:45:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:609e:6a22:2d9d:c8d5])
        by mx.google.com with ESMTPSA id p4sm1960039igg.20.2015.05.23.10.45.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 23 May 2015 10:45:45 -0700 (PDT)
In-Reply-To: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
	(Allen Hubbe's message of "Sat, 23 May 2015 09:21:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269812>

Allen Hubbe <allenbh@gmail.com> writes:

> Note that this only adds support for a limited subset of the sendmail
> format.  The format is is as follows.
>
> 	<alias>: <address|alias>[, <address|alias>...]
>
> Aliases are specified one per line, and must start on the first column of the
> line.  Blank lines are ignored.  If the first non whitespace character
> on a line is a '#' symbol, then the whole line is considered a comment,
> and is ignored.
>
> Example:
>
> 	alice: Alice W Land <awol@example.com>
> 	bob: Robert Bobbyton <bob@example.com>
> 	# this is a comment
> 	   # this is also a comment
> 	chloe: chloe@example.com
> 	abgroup: alice, bob
> 	bcgrp: bob, chloe, Other <o@example.com>
>
> Unlike the standard sendmail format, this does not support quoted
> aliases or quoted addresses.  Line continuations are not supported.
> Warnings are printed for explicitly unsupported constructs, and any
> other lines that are not recognized.
>
> Signed-off-by: Allen Hubbe <allenbh@gmail.com>
> ---
>
> Notes:
>     This v5 renames the parser 'sendmail' again, from 'simple'.
>     Therefore, the subject line is changed again, too.
>     
>     Previous subject line: send-email: Add simple email aliases format
>     
>     The format is restricted to a subset of sendmail.  When the subset
>     diverges from sendmail, the parser warns about the line that diverges,
>     and ignores the line.  The supported format is described in the
>     documentation, as well as the behavior when an unsupported format
>     construct is detected.
>     
>     A badly constructed sentence was corrected in the documentation.
>     
>     The test case was changed to use a here document, and the unsupported
>     comment after an alias was removed from the test case alias file input.

Thanks.

A small thing I noticed in the test (and this patch is not adding a
new "breakage"---there are a few existing instances) is the use of
"~/"; it should be spelled "$HOME/" instead for portability (not in
POSIX, even though bash, dash and ksh all seem to understand it).

I think this round looks good from a cursory read.

Eric, what do you think?

>  Documentation/git-send-email.txt | 37 ++++++++++++++++++++++++++++++++++++-
>  git-send-email.perl              | 29 +++++++++++++++++++++++++++++
>  t/t9001-send-email.sh            | 27 +++++++++++++++++++++++++++
>  3 files changed, 92 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 804554609def..97387fd27a8d 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -383,7 +383,42 @@ sendemail.aliasesFile::
>  
>  sendemail.aliasFileType::
>  	Format of the file(s) specified in sendemail.aliasesFile. Must be
> -	one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
> +	one of 'sendmail', 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
> ++
> +If the format is 'sendmail', then the alias file format is described below.
> +Descriptions of the other file formats can be found by searching the
> +documentation of the email program of the same name.
> ++
> +The 'sendmail' format is is as follows.  Note that 'git-send-email' currently
> +only supports a limited subset of the sendmail format.
> ++
> +	<alias>: <address|alias>[, <address|alias>...]
> ++
> +Aliases are specified one per line, and must start on the first column of the
> +line.  Blank lines are ignored.  If the first non whitespace character on a
> +line is a `#` symbol, then the whole line is considered a comment, and is
> +ignored.
> ++
> +Example of the 'sendmail' format:
> ++
> +	alice: Alice W Land <awol@example.com>
> +	bob: Robert Bobbyton <bob@example.com>
> +	# this is a comment
> +	   # this is also a comment
> +	chloe: chloe@example.com
> +	abgroup: alice, bob
> +	bcgrp: bob, chloe, Other <o@example.com>
> ++
> +Unlike the standard sendmail format, 'git-send-email' currently diverges in the
> +following ways.
> ++
> +*	Quoted aliases and quoted addresses are not supported: lines that
> +	contain a `"` symbol are ignored.
> +*	Line continuations are not supported: any lines that start with
> +	whitespace, or end with a `\` symbol are ignored.
> +*	Warnings are printed on the standard error output for any explicitly
> +	unsupported constructs, and any other lines that are not recognized
> +	by the parser.
>  
>  sendemail.multiEdit::
>  	If true (default), a single editor instance will be spawned to edit
> diff --git a/git-send-email.perl b/git-send-email.perl
> index e1e9b1460ced..ffea50094a48 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -487,6 +487,8 @@ sub split_addrs {
>  }
>  
>  my %aliases;
> +
> +
>  my %parse_alias = (
>  	# multiline formats can be supported in the future
>  	mutt => sub { my $fh = shift; while (<$fh>) {
> @@ -516,6 +518,33 @@ my %parse_alias = (
>  			  }
>  		      } },
>  
> +	sendmail => sub { my $fh = shift; while (<$fh>) {
> +		# ignore comment lines
> +		if (/^\s*(?:#.*)?$/) { }
> +
> +		# warn on lines that contain quotes
> +		elsif (/"/) {
> +			print STDERR "sendmail alias with quotes is not supported: $_\n";
> +			next;
> +		}
> +
> +		# warn on lines that continue
> +		elsif (/^\s|\\$/) {
> +			print STDERR "sendmail continuation line is not supported: $_\n";
> +			next;
> +		}
> +
> +		# recognize lines that look like an alias
> +		elsif (/^(\S+)\s*:\s*(.+?)$/) {
> +			my ($alias, $addr) = ($1, $2);
> +			$aliases{$alias} = [ split_addrs($addr) ];
> +		}
> +
> +		# warn on lines that are not recognized
> +		else {
> +			print STDERR "sendmail line is not recognized: $_\n";
> +		}}},
> +
>  	gnus => sub { my $fh = shift; while (<$fh>) {
>  		if (/\(define-mail-alias\s+"(\S+?)"\s+"(\S+?)"\)/) {
>  			$aliases{$1} = [ $2 ];
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 7be14a4e37f7..b04d26364767 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -1549,6 +1549,33 @@ test_expect_success $PREREQ 'sendemail.aliasfile=~/.mailrc' '
>  	grep "^!someone@example\.org!$" commandline1
>  '
>  
> +test_expect_success $PREREQ 'sendemail.aliasfiletype=sendmail' '
> +	clean_fake_sendmail && rm -fr outdir &&
> +	git format-patch -1 -o outdir &&
> +	cat >>~/.tmp-email-aliases <<-\EOF &&
> +	alice: Alice W Land <awol@example.com>
> +	bob: Robert Bobbyton <bob@example.com>
> +	# this is a comment
> +	   # this is also a comment
> +	chloe: chloe@example.com
> +	abgroup: alice, bob
> +	bcgrp: bob, chloe, Other <o@example.com>
> +	EOF
> +	git config --replace-all sendemail.aliasesfile \
> +		"$(pwd)/.tmp-email-aliases" &&
> +	git config sendemail.aliasfiletype sendmail &&
> +	git send-email \
> +		--from="Example <nobody@example.com>" \
> +		--to=alice --to=bcgrp \
> +		--smtp-server="$(pwd)/fake.sendmail" \
> +		outdir/0001-*.patch \
> +		2>errors >out &&
> +	grep "^!awol@example\.com!$" commandline1 &&
> +	grep "^!bob@example\.com!$" commandline1 &&
> +	grep "^!chloe@example\.com!$" commandline1 &&
> +	grep "^!o@example\.com!$" commandline1
> +'
> +
>  do_xmailer_test () {
>  	expected=$1 params=$2 &&
>  	git format-patch -1 &&
