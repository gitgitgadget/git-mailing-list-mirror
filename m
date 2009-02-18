From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH RFC 1/2] gitweb: Fix warnings with override permitted but no repo override
Date: Wed, 18 Feb 2009 14:09:41 +0100
Message-ID: <200902181409.42407.jnareb@gmail.com>
References: <499AD871.8000808@oak.homeunix.org> <1234926043-7471-1-git-send-email-marcel@oak.homeunix.org> <7vvdr8yw78.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Marcel M. Cary" <marcel@oak.homeunix.org>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Francis Galiegue <fg@one2team.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 14:12:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZmDX-0004Hv-Nw
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 14:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbZBRNJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 08:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754009AbZBRNJw
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 08:09:52 -0500
Received: from mail-bw0-f167.google.com ([209.85.218.167]:51100 "EHLO
	mail-bw0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753916AbZBRNJu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 08:09:50 -0500
Received: by bwz11 with SMTP id 11so2711477bwz.13
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 05:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+sbvY9c06pwgc39XvrUywuX65zdHZwpyOwlRq+XIN/4=;
        b=tVbKN00L5dNOMFq/V8788YdAD77O6gWBK5kqmboyYOV0tlEgUYlzzN9/NIxK7G5UYR
         DrpgyosvpmYgAP2HaTe+/dGv890Eqn5sgPOdAro6+UOPa/mVNupDqLHwncEIYdE3qkrM
         Di9HMV577AM/vYMxWF0hR6aHZzv5P/Y+Cf8co=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=s0yI2jFQg3WA2WvAzoJazD3BuscdcKgCg9zlcSOMH13R+ZTEIRfqlfzoK692/7Ox7O
         Pzx7bgz7Vn8sJ9wBjGLB8X5jYJyvjIQscSM6SpfNpQc1DMOYZGL0NCEY5nsbUdU6v+lq
         ROEfxsntEuDxtlpWnMFOIlNB9MgJ3YDC8faLI=
Received: by 10.103.102.17 with SMTP id e17mr2272897mum.119.1234962587141;
        Wed, 18 Feb 2009 05:09:47 -0800 (PST)
Received: from ?192.168.1.13? (abvn202.neoplus.adsl.tpnet.pl [83.8.211.202])
        by mx.google.com with ESMTPS id d38sm21566117ugf.23.2009.02.18.05.09.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Feb 2009 05:09:46 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vvdr8yw78.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110531>

Fixed up patch at the bottom.

Junio C Hamano wrote:
> "Marcel M. Cary" <marcel@oak.homeunix.org> writes:
> 
> > When a feature like "blame" is permitted to be overridden in the
> > repository configuration but it is not actually set in the
> > repository, a warning is emitted due to the undefined value
> > of the repository configuration, even though it's a perfectly
> > normal condition.
> >
> > The warning is grounds for test failure in the gitweb test script,
> > so it causes some new feature tests of mine to fail.
> >
> > This patch prevents warning and adds a test case to exercise it.
> >
> > Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
> > ---
> >
> > Here's a small patch I put together while tinkering with bug hyperlinking.
> > Does this look reasonable?

Somewhat.

Corrected patch at the bottom.

> 
> To my cursory look, it doesn't, and it is not entirely your fault, but if
> we applied this patch, it would not improve things very much.  It just
> would shift the same problem around.
> 
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 7c48181..653f0be 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -402,13 +402,13 @@ sub feature_bool {
> >  	my $key = shift;
> >  	my ($val) = git_get_project_config($key, '--bool');
> >  
> > -	if ($val eq 'true') {
> > +	if (!defined $val) {
> > +		return ($_[0]);
> > +	} elsif ($val eq 'true') {
> >  		return (1);
> >  	} elsif ($val eq 'false') {
> >  		return (0);
> >  	}
> 
> I think the warning you are talking about is to compare $val with 'true'
> with 'eq' operator when $val could be undef.  The check to see if $val is
> undefined to avoid that 'eq' comparison is fine, and the intent to return
> false is also good, but I think feature_bool is meant to say "yes" or
> "no", and existing code for 'false' is returning (0).  I'd rather see your
> new codepath normalize incoming undef the same way string 'false' is
> normalized to return (0).

Actually git_get_project_config($key, '--bool') can return only three
values: 
 * 'true' if gitweb.$key config variable is 'true', 'yes', 1, or (after
   fixes in the fixed up patch at the bottom) is undefined, i.e.
     [gitweb]
     	blame
   case
 * 'false' if gitweb.$key exists and has other value (that includes
   empty string value: "[section] val" is git-config --bool true, while
   "[section] val = " is --bool false).
 * undef if gitweb.$key does not exist in the config;
   earlier version which used "git config --bool <variable>" returned
   empty string ('') here.

We want to fall back to %feature value (i.e. do not override) if
variable is not set in config.  Variable not set was '', and now is undef,
therefore need for this (correct) change.

> Granted, the caller should be prepared to take 
> the answer as boolean and treat the usual Perl false values (numeric zero,
> a string with single "0", or an undef) without barfing, so returning (undef)
> from here ought to be safe (otherwise the callers are broken), but I'd
> rather see this function play safe.
> 
> But it certainly is not my main complaint.

Well, I think we can now get rid of backwards compatibility (which is
not complete anyway: '' for not existent variable for old version, undef
for new version) with the old version which ran git-config once for each
variable, and do not go through 'true'/'false' to imitate calling
"git config --bool", which has to be converted back to Perl boolean
anyway.

> 
> >  sub feature_snapshot {
> > @@ -1978,6 +1978,8 @@ sub git_get_project_config {
> >  		$config_file = "$git_dir/config";
> >  	}
> >  
> > +	return undef if (!defined $config{"gitweb.$key"});
> > +

It should be !exists, and not !defined here, see my fixed up patch
below.

> 
> I think this change is missing a lot of necessary fixes associated with
> it.  Have you actually audited all the callers of this function you are
> modifying?  For example, feature_bool does this:
> 
>         sub feature_bool {
>                 my $key = shift;
>                 my ($val) = git_get_project_config($key, '--bool');
> 
>                 if ($val eq 'true') {
>                         return (1);
>                 } elsif ($val eq 'false') {
> 	...
> 
> With your above change, I think a missing configuration variable will
> stuff undef in $val, and trigger the same "$val eq 'true'" comparison
> warning here.

Errr... Junio, Marcel DID fix feature_bool, see above:

> > @@ -402,13 +402,13 @@ sub feature_bool {
> >  	my $key = shift;
> >  	my ($val) = git_get_project_config($key, '--bool');
> >  
> > -	if ($val eq 'true') {
> > +	if (!defined $val) {
> > +		return ($_[0]);
> > +	} elsif ($val eq 'true') {
> >  		return (1);
> >  	} elsif ($val eq 'false') {
> >  		return (0);
> >  	}


> 
> Granted, without your change the existing code triggers the same error in
> another way, by calling config_to_bool sub with undef here:
> 
> 	# ensure given type
> 	if (!defined $type) {
> 		return $config{"gitweb.$key"};
> 	} elsif ($type eq 'bool') {
> 		# backward compatibility: 'git config --bool' returns true/false
> 		return config_to_bool($config{"gitweb.$key"}) ? 'true' : 'false';
> 
> and config_to_bool sub is written in the same carelessness like so:
> 
>         sub config_to_bool {
>                 my $val = shift;
> 
>                 # strip leading and trailing whitespace
>                 $val =~ s/^\s+//;
> 
> and triggers the same error here in the s/// operation.  I think the right
> fix for this part would look like this:
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7c48181..2b140cc 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1920,6 +1920,8 @@ sub git_parse_project_config {
>  sub config_to_bool {
>  	my $val = shift;
>  
> +	return 1 if (!defined $val);
> +
>  	# strip leading and trailing whitespace
>  	$val =~ s/^\s+//;
>  	$val =~ s/\s+$//;
> 
> Because
> 
> 	[gitweb]
>         	variable
> 
> parsed by git_parse_project_config('gitweb') should return a hash that
> maps "gitweb.variable" to undef it must be fed as undef to
> config_to_bool.  This variable should be reported as "true".

Right (but not complete).

We do check !defined $val, but too late: _after_ trying to strip leading
and trailing whitespace.  When going through various versions of
config_to_bool I have somehow forgot about this issue...

> 
> There are tons of undef unsafeness in this file from a very cursory look.
> 
> Unrelated to any of these, I think the following is wrong:
> 
>         sub feature_patches {
>                 my @val = (git_get_project_config('patches', '--int'));
> 
>                 if (@val) {
>                         return @val;
>                 }
> 
>                 return ($_[0]);
>         }
> 
> As git_get_project_config() always returns something, hence "if (@val)"
> can never be false.

Actually after the patch below I think that git_get_project_config
returns empty list () in the list (array) context now if variable
does not exist in the config thanks to "return ;" magic.  And empty
list evaluates to false in scalar context: "if (@val)" would be false
if variable does not exist in the config... in which case we would not
override 'default' value in %feature.

Alternate solution would be to use

         sub feature_patches {
                 my $val = git_get_project_config('patches', '--int');
 
                 if (defined $val) {
                         return ($val);
                 }
 
                 return ($_[0]);
         }



-- >8 --
From: Marcel M. Cary <marcel@oak.homeunix.org>
Subject: [PATCH] gitweb: Fix warnings with override permitted but no repo override

When a feature like "blame" is permitted to be overridden in the
repository configuration but it is not actually set in the repository,
a warning is emitted due to the undefined value of the repository
configuration, even though it's a perfectly normal condition.
Emitting warning is grounds for test failure in the gitweb test
script.

This error was caused by rewrite of git_get_project_config from using
"git config [<type>] <name>" for each individual configuration
variable checked to parsing "git config --list --null" output in
commit b201927 (gitweb: Read repo config using 'git config -z -l').
Earlier version of git_get_project_config was returning empty string
if variable do not exist in config; newer version is meant to return
undef in this case, therefore change in feature_bool was needed.

Additionally config_to_* subroutines were meant to be invoked only if
configuration variable exists; therefore we added early return to
git_get_project_config: it now returns no value if variable does not
exists in config.  Otherwise config_to_* subroutines (config_to_bool
in paryicular) wouldn't be able to distinguish between the case where
variable does not exist and the case where variable doesn't have value
(the "[section] noval" case, which evaluates to true for boolean).

While at it fix bug in config_to_bool, where checking if $val is
defined (if config variable has value) was done _after_ stripping
leading and trailing whitespace, which lead to 'Use of uninitialized
value' warning.

Add test case for features overridable but not overriden in repo
config, and case for no value boolean configuration variable.

Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl                     |   16 ++++++++++------
 t/t9500-gitweb-standalone-no-errors.sh |   18 +++++++++++++++++-
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7c48181..83858fb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -402,13 +402,13 @@ sub feature_bool {
 	my $key = shift;
 	my ($val) = git_get_project_config($key, '--bool');
 
-	if ($val eq 'true') {
+	if (!defined $val) {
+		return ($_[0]);
+	} elsif ($val eq 'true') {
 		return (1);
 	} elsif ($val eq 'false') {
 		return (0);
 	}
-
-	return ($_[0]);
 }
 
 sub feature_snapshot {
@@ -1914,18 +1914,19 @@ sub git_parse_project_config {
 	return %config;
 }
 
-# convert config value to boolean, 'true' or 'false'
+# convert config value to boolean: 'true' or 'false'
 # no value, number > 0, 'true' and 'yes' values are true
 # rest of values are treated as false (never as error)
 sub config_to_bool {
 	my $val = shift;
 
+	return 1 if !defined $val;             # section.key
+
 	# strip leading and trailing whitespace
 	$val =~ s/^\s+//;
 	$val =~ s/\s+$//;
 
-	return (!defined $val ||               # section.key
-	        ($val =~ /^\d+$/ && $val) ||   # section.key = 1
+	return (($val =~ /^\d+$/ && $val) ||   # section.key = 1
 	        ($val =~ /^(?:true|yes)$/i));  # section.key = true
 }
 
@@ -1978,6 +1979,9 @@ sub git_get_project_config {
 		$config_file = "$git_dir/config";
 	}
 
+	# check if config variable (key) exists
+	return unless exists $config{"gitweb.$key"};
+
 	# ensure given type
 	if (!defined $type) {
 		return $config{"gitweb.$key"};
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 7c6f70b..6ed10d0 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -662,6 +662,11 @@ cat >>gitweb_config.perl <<EOF
 EOF
 
 test_expect_success \
+	'config override: tree view, features not overridden in repo config' \
+	'gitweb_run "p=.git;a=tree"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
 	'config override: tree view, features disabled in repo config' \
 	'git config gitweb.blame no &&
 	 git config gitweb.snapshot none &&
@@ -669,12 +674,23 @@ test_expect_success \
 test_debug 'cat gitweb.log'
 
 test_expect_success \
-	'config override: tree view, features enabled in repo config' \
+	'config override: tree view, features enabled in repo config (1)' \
 	'git config gitweb.blame yes &&
 	 git config gitweb.snapshot "zip,tgz, tbz2" &&
 	 gitweb_run "p=.git;a=tree"'
 test_debug 'cat gitweb.log'
 
+cat >.git/config <<\EOF
+# testing noval and alternate separator
+[gitweb]
+	blame
+	snapshot = zip tgz
+EOF
+test_expect_success \
+	'config override: tree view, features enabled in repo config (2)' \
+	'gitweb_run "p=.git;a=tree"'
+test_debug 'cat gitweb.log'
+
 # ----------------------------------------------------------------------
 # non-ASCII in README.html
 
-- 
1.6.1
