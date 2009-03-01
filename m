From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH v2] send-email: add --confirm option
Date: Sun, 1 Mar 2009 12:09:17 -0500
Message-ID: <7d1d9c250903010909h7d92f165oc703a05e819671a4@mail.gmail.com>
References: <7vhc2d8vjk.fsf@gitster.siamese.dyndns.org>
	 <1235924234-16923-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 18:10:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdpBi-0007LL-9s
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 18:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756679AbZCARJV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 12:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756034AbZCARJV
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 12:09:21 -0500
Received: from wf-out-1314.google.com ([209.85.200.173]:51278 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755791AbZCARJU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Mar 2009 12:09:20 -0500
Received: by wf-out-1314.google.com with SMTP id 28so2279767wfa.4
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 09:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=7Dudy6PHvBzQo4jsMp8rLp2qT447w+mBGDDXjW/3GcA=;
        b=rWuLGZN2EhWVtt24jZqtrdfYDCLT8S0WXCbdzPBViSEuc6/MpvSPSDR2IN6T4o/d6E
         TzduHqxEOeafj4BDnWy+oWK6htC7XLgl1EOW4WIp+MpfQxgR7aF+rmZE7MB+qAXQNA6p
         aq98z1XOP0UfjN09wneYc1ut54N6HeS1G4BI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=PzFW5MIUfbDtPmQEOlNGeZnZ2fyG7fn8VX00QyFt+NH9YCnXNPpyPM6eySkdkcndrr
         H1YbCJaWMcKGZX4Rl8yC+3Vo+dob4uUzADV/Khr8NWPU6miCrpWRLzN/x1nuGK9p5jcY
         0CvDyxx8EpAtiblhsp2zKPmO+Bjejo0AdRzEc=
Received: by 10.142.102.5 with SMTP id z5mr2493366wfb.334.1235927357729; Sun, 
	01 Mar 2009 09:09:17 -0800 (PST)
In-Reply-To: <1235924234-16923-1-git-send-email-jaysoffian@gmail.com>
X-Google-Sender-Auth: 6556168e0ec92b9e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111856>

On Sun, Mar 1, 2009 at 11:17 AM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
> send-email violates the principle of least surprise by automatically
> cc'ing additional recipients without confirming this with the user.
>
> This patch teaches send-email a --confirm option. It takes the
> following values:
>
> =A0--confirm=3Dalways =A0 always confirm before sending
> =A0--confirm=3Dnever =A0 =A0never confirm before sending
> =A0--confirm=3Dcc =A0 =A0 =A0 confirm before sending when send-email =
has
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0automatically added addresses =
from the patch to
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0the Cc list
> =A0--confirm=3Dcompose =A0confirm before sending the first message wh=
en
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0using --compose. (Needed to ma=
intain backwards
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatibility with existing be=
havior.)
> =A0--confirm=3Dauto =A0 =A0 'cc' + 'compose'
>
> The option defaults to 'compose' if any suppress Cc related options h=
ave
> been used, otherwise it defaults to 'auto'.
>
> Unfortunately, it is impossible to introduce this patch such that it
> helps new users without potentially upsetting some existing users. We
> attempt to mitigate the latter by:
>
> =A0* Allowing the user to "git config sendemail.config never"

I think it should be sendemail.confirm in the above.   Thanks for
taking this seriously -- I think lots of new git users (who probably
will never make it to this list) will benefit from it without ever
even knowing.

Paul.

> =A0* Allowing the user to say "all" after the first prompt to not be
> =A0 prompted on remaining emails during the same invocation.
> =A0* Telling the user about the "sendemail.confirm" setting whenever =
they
> =A0 use "all"
> =A0* Only prompting if no --suppress related options have been passed=
, as
> =A0 using such an option is likely to indicate an experienced send-em=
ail
> =A0 user.
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> Changes from v1:
>
> =A0- Added no-confirm tests, and put them early to prevent the rest o=
f
> =A0 the tests from potentially hanging. Note if one of these tests
> =A0 fails then we exit t9001-send-email.sh immediately.
>
> =A0- Added verification of the --confirm setting. (I had done this
> =A0 previously but somehow failed to stage it.)
>
> =A0- Added additional language to the commit messsage in an attempt t=
o
> =A0 provide justification for the change in default behavior.
>
> =A0- When the user specifies "all" in response to a confirm prompt, w=
e
> =A0 hint them about how to use "sendemail.confirm" config setting.
>
> =A0Documentation/git-send-email.txt | =A0 16 ++++++
> =A0git-send-email.perl =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 72 ++++++++++=
+++++++--------
> =A0t/t9001-send-email.sh =A0 =A0 =A0 =A0 =A0 =A0| =A0108 ++++++++++++=
++++++++++++++++++++------
> =A03 files changed, 157 insertions(+), 39 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-sen=
d-email.txt
> index 164d149..bcf7ff1 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -199,6 +199,22 @@ specified, as well as 'body' if --no-signed-off-=
cc is specified.
> =A0Administering
> =A0~~~~~~~~~~~~~
>
> +--confirm::
> + =A0 =A0 =A0 Confirm just before sending:
> ++
> +--
> +- 'always' will always confirm before sending
> +- 'never' will never confirm before sending
> +- 'cc' will confirm before sending when send-email has automatically
> + =A0added addresses from the patch to the Cc list
> +- 'compose' will confirm before sending the first message when using=
 --compose.
> +- 'auto' is equivalent to 'cc' + 'compose'
> +--
> ++
> +Default is the value of 'sendemail.confirm' configuration value; if =
that
> +is unspecified, default to 'auto' unless any of the suppress options
> +have been specified, in which case default to 'compose'.
> +
> =A0--dry-run::
> =A0 =A0 =A0 =A0Do everything except actually send the emails.
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index adf7ecb..439b70b 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -75,6 +75,8 @@ git send-email [options] <file | directory | rev-li=
st options >
> =A0 =A0 --[no-]thread =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Use In-Rep=
ly-To: field. Default on.
>
> =A0 Administering:
> + =A0 =A0--confirm =A0 =A0 =A0 =A0 =A0 =A0 =A0 <str> =A0* Confirm rec=
ipients before sending;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 auto, cc, compose, always, or never.
> =A0 =A0 --quiet =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Outp=
ut one line of info per email.
> =A0 =A0 --dry-run =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Don't =
actually send the emails.
> =A0 =A0 --[no-]validate =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Perform patc=
h sanity checks. Default on.
> @@ -181,7 +183,7 @@ sub do_edit {
> =A0my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $=
cc_cmd);
> =A0my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encrypt=
ion);
> =A0my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
> -my ($validate);
> +my ($validate, $confirm);
> =A0my (@suppress_cc);
>
> =A0my %config_bool_settings =3D (
> @@ -207,6 +209,7 @@ my %config_settings =3D (
> =A0 =A0 "suppresscc" =3D> \@suppress_cc,
> =A0 =A0 "envelopesender" =3D> \$envelope_sender,
> =A0 =A0 "multiedit" =3D> \$multiedit,
> + =A0 =A0"confirm" =A0 =3D> \$confirm,
> =A0);
>
> =A0# Handle Uncouth Termination
> @@ -258,6 +261,7 @@ my $rc =3D GetOptions("sender|from=3Ds" =3D> \$se=
nder,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"suppress-from!" =3D> \$suppre=
ss_from,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"suppress-cc=3Ds" =3D> \@suppr=
ess_cc,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"signed-off-cc|signed-off-by-c=
c!" =3D> \$signed_off_by_cc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "confirm=3Ds" =3D> \$confirm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dry-run" =3D> \$dry_run,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"envelope-sender=3Ds" =3D> \$e=
nvelope_sender,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"thread!" =3D> \$thread,
> @@ -346,6 +350,13 @@ if ($suppress_cc{'body'}) {
> =A0 =A0 =A0 =A0delete $suppress_cc{'body'};
> =A0}
>
> +# Set confirm
> +if (!defined $confirm) {
> + =A0 =A0 =A0 $confirm =3D scalar %suppress_cc ? 'compose' : 'auto';
> +};
> +die "Unknown --confirm setting: '$confirm'\n"
> + =A0 =A0 =A0 unless $confirm =3D~ /^(?:auto|cc|compose|always|never)=
/;
> +
> =A0# Debugging, print out the suppressions.
> =A0if (0) {
> =A0 =A0 =A0 =A0print "suppressions:\n";
> @@ -663,25 +674,13 @@ if (!defined $smtp_server) {
> =A0 =A0 =A0 =A0$smtp_server ||=3D 'localhost'; # could be 127.0.0.1, =
too... *shrug*
> =A0}
>
> -if ($compose) {
> - =A0 =A0 =A0 while (1) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 $_ =3D $term->readline("Send this email=
? (y|n) ");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 last if defined $_;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "\n";
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 if (uc substr($_,0,1) ne 'Y') {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cleanup_compose_files();
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(0);
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 if ($compose > 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 @files =3D ($compose_filename . ".final=
", @files);
> - =A0 =A0 =A0 }
> +if ($compose && $compose > 0) {
> + =A0 =A0 =A0 @files =3D ($compose_filename . ".final", @files);
> =A0}
>
> =A0# Variables we set as part of the loop over files
> -our ($message_id, %mail, $subject, $reply_to, $references, $message)=
;
> +our ($message_id, %mail, $subject, $reply_to, $references, $message,
> + =A0 =A0 =A0 $needs_confirm, $message_num);
>
> =A0sub extract_valid_address {
> =A0 =A0 =A0 =A0my $address =3D shift;
> @@ -837,6 +836,27 @@ X-Mailer: git-send-email $gitversion
> =A0 =A0 =A0 =A0unshift (@sendmail_parameters,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0'-f', $raw_from) if(de=
fined $envelope_sender);
>
> + =A0 =A0 =A0 if ($needs_confirm && !$dry_run) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "\n$header\n";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chomp ($_ =3D $term->re=
adline(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Send t=
his email? ([y]es|[n]o|[q]uit|[a]ll): "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 last if /^(?:yes|y|no|n=
|quit|q|all|a)/i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "\n";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (/^n/i) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif (/^q/i) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cleanup_compose_files()=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } elsif (/^a/i) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $confirm =3D 'never';
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "You may disable =
all future prompting via sendemail.confirm;\n";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "Run 'git send-em=
ail --help' for details.\n";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if ($dry_run) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# We don't want to send the email.
> =A0 =A0 =A0 =A0} elsif ($smtp_server =3D~ m#^/#) {
> @@ -935,6 +955,7 @@ X-Mailer: git-send-email $gitversion
> =A0$reply_to =3D $initial_reply_to;
> =A0$references =3D $initial_reply_to || '';
> =A0$subject =3D $initial_subject;
> +$message_num =3D 0;
>
> =A0foreach my $t (@files) {
> =A0 =A0 =A0 =A0open(F,"<",$t) or die "can't open file $t";
> @@ -943,11 +964,12 @@ foreach my $t (@files) {
> =A0 =A0 =A0 =A0my $author_encoding;
> =A0 =A0 =A0 =A0my $has_content_type;
> =A0 =A0 =A0 =A0my $body_encoding;
> - =A0 =A0 =A0 @cc =3D @initial_cc;
> + =A0 =A0 =A0 @cc =3D ();
> =A0 =A0 =A0 =A0@xh =3D ();
> =A0 =A0 =A0 =A0my $input_format =3D undef;
> =A0 =A0 =A0 =A0my @header =3D ();
> =A0 =A0 =A0 =A0$message =3D "";
> + =A0 =A0 =A0 $message_num++;
> =A0 =A0 =A0 =A0# First unfold multiline header fields
> =A0 =A0 =A0 =A0while(<F>) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0last if /^\s*$/;
> @@ -1080,6 +1102,13 @@ foreach my $t (@files) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 $needs_confirm =3D (
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 $confirm eq "always" or
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ($confirm =3D~ /^(?:auto|cc)$/ && @cc) =
or
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ($confirm =3D~ /^(?:auto|compose)$/ && =
$compose && $message_num =3D=3D 1));
> +
> + =A0 =A0 =A0 @cc =3D (@initial_cc, @cc);
> +
> =A0 =A0 =A0 =A0send_message();
>
> =A0 =A0 =A0 =A0# set up for the next message
> @@ -1094,13 +1123,10 @@ foreach my $t (@files) {
> =A0 =A0 =A0 =A0$message_id =3D undef;
> =A0}
>
> -if ($compose) {
> - =A0 =A0 =A0 cleanup_compose_files();
> -}
> +cleanup_compose_files();
>
> =A0sub cleanup_compose_files() {
> - =A0 =A0 =A0 unlink($compose_filename, $compose_filename . ".final")=
;
> -
> + =A0 =A0 =A0 unlink($compose_filename, $compose_filename . ".final")=
 if $compose;
> =A0}
>
> =A0$smtp->quit if $smtp;
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 4df4f96..08d5b91 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -35,6 +35,47 @@ test_expect_success 'Extract patches' '
> =A0 =A0 patches=3D`git format-patch -s --cc=3D"One <one@example.com>"=
 --cc=3Dtwo@example.com -n HEAD^1`
> =A0'
>
> +# Test no confirm early to ensure remaining tests will not hang
> +test_no_confirm () {
> + =A0 =A0 =A0 rm -f no_confirm_okay
> + =A0 =A0 =A0 echo n | \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 GIT_SEND_EMAIL_NOTTY=3D1 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 git send-email \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 --from=3D"Example <from@example.com>" \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 --to=3Dnobody@example.com \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 --smtp-server=3D"$(pwd)/fake.sendmail" =
\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 $@ \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 $patches > stdout &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 test_must_fail grep "Send this email" s=
tdout &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 > no_confirm_okay
> +}
> +
> +# Exit immediately to prevent hang if a no-confirm test fails
> +check_no_confirm () {
> + =A0 =A0 =A0 test -f no_confirm_okay || {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 say 'No confirm test failed; skipping r=
emaining tests to prevent hanging'
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 test_done
> + =A0 =A0 =A0 }
> +}
> +
> +test_expect_success 'No confirm with --suppress-cc' '
> + =A0 =A0 =A0 test_no_confirm --suppress-cc=3Dsob
> +'
> +check_no_confirm
> +
> +test_expect_success 'No confirm with --confirm=3Dnever' '
> + =A0 =A0 =A0 test_no_confirm --confirm=3Dnever
> +'
> +check_no_confirm
> +
> +# leave sendemail.confirm set to never after this so that none of th=
e
> +# remaining tests prompt unintentionally.
> +test_expect_success 'No confirm with sendemail.confirm=3Dnever' '
> + =A0 =A0 =A0 git config sendemail.confirm never &&
> + =A0 =A0 =A0 test_no_confirm --compose --subject=3Dfoo
> +'
> +check_no_confirm
> +
> =A0test_expect_success 'Send patches' '
> =A0 =A0 =A0git send-email --suppress-cc=3Dsob --from=3D"Example <nobo=
dy@example.com>" --to=3Dnobody@example.com --smtp-server=3D"$(pwd)/fake=
=2Esendmail" $patches 2>errors
> =A0'
> @@ -175,15 +216,13 @@ test_set_editor "$(pwd)/fake-editor"
>
> =A0test_expect_success '--compose works' '
> =A0 =A0 =A0 =A0clean_fake_sendmail &&
> - =A0 =A0 =A0 echo y | \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 GIT_SEND_EMAIL_NOTTY=3D1 \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 git send-email \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 --compose --subject foo \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 --from=3D"Example <nobody@example.com>"=
 \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 --to=3Dnobody@example.com \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 --smtp-server=3D"$(pwd)/fake.sendmail" =
\
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 $patches \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 2>errors
> + =A0 =A0 =A0 git send-email \
> + =A0 =A0 =A0 --compose --subject foo \
> + =A0 =A0 =A0 --from=3D"Example <nobody@example.com>" \
> + =A0 =A0 =A0 --to=3Dnobody@example.com \
> + =A0 =A0 =A0 --smtp-server=3D"$(pwd)/fake.sendmail" \
> + =A0 =A0 =A0 $patches \
> + =A0 =A0 =A0 2>errors
> =A0'
>
> =A0test_expect_success 'first message is compose text' '
> @@ -375,15 +414,56 @@ test_expect_success '--suppress-cc=3Dcc' '
> =A0 =A0 =A0 =A0test_suppression cc
> =A0'
>
> +test_confirm () {
> + =A0 =A0 =A0 echo y | \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 GIT_SEND_EMAIL_NOTTY=3D1 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 git send-email \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 --from=3D"Example <nobody@example.com>"=
 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 --to=3Dnobody@example.com \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 --smtp-server=3D"$(pwd)/fake.sendmail" =
\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 $@ \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 $patches | grep "Send this email"
> +}
> +
> +test_expect_success '--confirm=3Dalways' '
> + =A0 =A0 =A0 test_confirm --confirm=3Dalways --suppress-cc=3Dall
> +'
> +
> +test_expect_success '--confirm=3Dauto' '
> + =A0 =A0 =A0 test_confirm --confirm=3Dauto
> +'
> +
> +test_expect_success '--confirm=3Dcc' '
> + =A0 =A0 =A0 test_confirm --confirm=3Dcc
> +'
> +
> +test_expect_success '--confirm=3Dcompose' '
> + =A0 =A0 =A0 test_confirm --confirm=3Dcompose --compose
> +'
> +
> +test_expect_success 'confirm by default (due to cc)' '
> + =A0 =A0 =A0 CONFIRM=3D$(git config --get sendemail.confirm) &&
> + =A0 =A0 =A0 git config --unset sendemail.confirm &&
> + =A0 =A0 =A0 test_confirm &&
> + =A0 =A0 =A0 git config sendemail.confirm $CONFIRM
> +'
> +
> +test_expect_success 'confirm by default (due to --compose)' '
> + =A0 =A0 =A0 CONFIRM=3D$(git config --get sendemail.confirm) &&
> + =A0 =A0 =A0 git config --unset sendemail.confirm &&
> + =A0 =A0 =A0 test_confirm --suppress-cc=3Dall --compose
> + =A0 =A0 =A0 ret=3D"$?"
> + =A0 =A0 =A0 git config sendemail.confirm ${CONFIRM:-never}
> + =A0 =A0 =A0 test $ret =3D "0"
> +'
> +
> =A0test_expect_success '--compose adds MIME for utf8 body' '
> =A0 =A0 =A0 =A0clean_fake_sendmail &&
> =A0 =A0 =A0 =A0(echo "#!$SHELL_PATH" &&
> =A0 =A0 =A0 =A0 echo "echo utf8 body: =E0=E9=EC=F6=FA >>\"\$1\""
> =A0 =A0 =A0 =A0) >fake-editor-utf8 &&
> =A0 =A0 =A0 =A0chmod +x fake-editor-utf8 &&
> - =A0 =A0 =A0 echo y | \
> =A0 =A0 =A0 =A0 =A0GIT_EDITOR=3D"\"$(pwd)/fake-editor-utf8\"" \
> - =A0 =A0 =A0 =A0 GIT_SEND_EMAIL_NOTTY=3D1 \
> =A0 =A0 =A0 =A0 =A0git send-email \
> =A0 =A0 =A0 =A0 =A0--compose --subject foo \
> =A0 =A0 =A0 =A0 =A0--from=3D"Example <nobody@example.com>" \
> @@ -405,9 +485,7 @@ test_expect_success '--compose respects user mime=
 type' '
> =A0 =A0 =A0 =A0 echo " echo utf8 body: =E0=E9=EC=F6=FA) >\"\$1\""
> =A0 =A0 =A0 =A0) >fake-editor-utf8-mime &&
> =A0 =A0 =A0 =A0chmod +x fake-editor-utf8-mime &&
> - =A0 =A0 =A0 echo y | \
> =A0 =A0 =A0 =A0 =A0GIT_EDITOR=3D"\"$(pwd)/fake-editor-utf8-mime\"" \
> - =A0 =A0 =A0 =A0 GIT_SEND_EMAIL_NOTTY=3D1 \
> =A0 =A0 =A0 =A0 =A0git send-email \
> =A0 =A0 =A0 =A0 =A0--compose --subject foo \
> =A0 =A0 =A0 =A0 =A0--from=3D"Example <nobody@example.com>" \
> @@ -421,9 +499,7 @@ test_expect_success '--compose respects user mime=
 type' '
>
> =A0test_expect_success '--compose adds MIME for utf8 subject' '
> =A0 =A0 =A0 =A0clean_fake_sendmail &&
> - =A0 =A0 =A0 echo y | \
> =A0 =A0 =A0 =A0 =A0GIT_EDITOR=3D"\"$(pwd)/fake-editor\"" \
> - =A0 =A0 =A0 =A0 GIT_SEND_EMAIL_NOTTY=3D1 \
> =A0 =A0 =A0 =A0 =A0git send-email \
> =A0 =A0 =A0 =A0 =A0--compose --subject utf8-s=FCbj=EBct \
> =A0 =A0 =A0 =A0 =A0--from=3D"Example <nobody@example.com>" \
> @@ -445,7 +521,7 @@ test_expect_success 'detects ambiguous reference/=
file conflict' '
> =A0test_expect_success 'feed two files' '
> =A0 =A0 =A0 =A0rm -fr outdir &&
> =A0 =A0 =A0 =A0git format-patch -2 -o outdir &&
> - =A0 =A0 =A0 GIT_SEND_EMAIL_NOTTY=3D1 git send-email \
> + =A0 =A0 =A0 git send-email \
> =A0 =A0 =A0 =A0--dry-run \
> =A0 =A0 =A0 =A0--from=3D"Example <nobody@example.com>" \
> =A0 =A0 =A0 =A0--to=3Dnobody@example.com \
> --
> 1.6.2.rc1.309.g5f417
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
