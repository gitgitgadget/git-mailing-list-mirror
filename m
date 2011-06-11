From: JD Horelick <jdhore1@gmail.com>
Subject: [PATCH] ciabot: Add a revamped Perl version.
Date: Sat, 11 Jun 2011 18:35:57 -0400
Message-ID: <BANLkTin+U2x-Lk_qKrGD4hbxnRWySgHFLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3054a47355bf0a04a5774f50
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jun 12 00:36:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVWml-00089p-0k
	for gcvg-git-2@lo.gmane.org; Sun, 12 Jun 2011 00:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210Ab1FKWgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jun 2011 18:36:00 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63128 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679Ab1FKWf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2011 18:35:59 -0400
Received: by fxm17 with SMTP id 17so2148284fxm.19
        for <git@vger.kernel.org>; Sat, 11 Jun 2011 15:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=6nNOeTspvqW/nkL74GAPC6qfLqFFihkjL0mic0UM3QE=;
        b=ogbz70YVql3FD/FnOPEEnfkalWjYBAXsa4m5mRwFWMq3P3PkO+sMj2k0RerhciSjBH
         AxljjR/D5Iv2RrHrYslyo8T234NIOdHe6yyOka2n3AOyBY88rsXRWM1Oijvg9WCgkI/p
         ZQxopljadDA2YLMjonUXmPhSLkTiVpmR9JyHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=FjHjc6+rzuTTMMFIZUOgHzKrhIt3vXYWnnonjJTdjM0c+oXyfWyVGXZFCAYpUzhJuM
         zQjE9eHGp9683xmv7lB8zw8l/0KcEx9lc44kTdlMXMabDkzBWBF3vQ88BYJPPaqcW8h/
         jue0Hncd7dy1nl2NnRh9uWZ9OVtI1L2WH/pNc=
Received: by 10.223.74.195 with SMTP id v3mr1767209faj.13.1307831757553; Sat,
 11 Jun 2011 15:35:57 -0700 (PDT)
Received: by 10.223.29.138 with HTTP; Sat, 11 Jun 2011 15:35:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175648>

--20cf3054a47355bf0a04a5774f50
Content-Type: text/plain; charset=ISO-8859-1

Attached (and pasted below, but I believe Gmail messes up the
whitespace) is a patch for a new ciabot script that is the revamped
version of the old Perl script.

---

>From f80c041dcd7db6abfa0354c89adcb8b811b27e89 Mon Sep 17 00:00:00 2001
From: JD Horelick <jdhore1@gmail.com>
Date: Sat, 11 Jun 2011 18:16:16 -0400
Subject: [PATCH] ciabot: Add a revamped Perl version.

This revamped Perl version offers more features and uses the recommended
interface to the CIA.vc Service (XML-RPC, with email as a backup option).

Some of the additional features include the ability to send a module
field to CIA and the ability to set script all relevant script options
with git config.

Signed-off-by: JD Horelick <jdhore1@gmail.com>
---
 contrib/ciabot/README    |   13 +-
 contrib/ciabot/ciabot.pl |  321 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 329 insertions(+), 5 deletions(-)
 create mode 100755 contrib/ciabot/ciabot.pl

diff --git a/contrib/ciabot/README b/contrib/ciabot/README
index 3b916ac..5683fa2 100644
--- a/contrib/ciabot/README
+++ b/contrib/ciabot/README
@@ -1,12 +1,15 @@
 These are hook scripts for the CIA notification service at <http://cia.vc/>

-They are maintained by Eric S. Raymond <esr@thyrsus.com>.  There is an
-upstream resource page for them at <http://www.catb.org/esr/ciabot/>,
+The Perl version is maintained by JD Horelick <jdhore1@gmail.com>.
+
+The Python and shell versions are maintained by Eric S. Raymond
<esr@thyrsus.com>.
+There is an upstream resource page for them at
<http://www.catb.org/esr/ciabot/>,
 but they are unlikely to change rapidly.

-You probably want the Python version; it's faster, more capable, and
-better documented.  The shell version is maintained only as a fallback
-for use on hosting sites that don't permit Python hook scripts.
+You probably want the Perl version; it's faster, more capable, uses the
+recommended CIA interface and is better documented.  The shell version
+is maintained only as a fallback for use on hosting sites that don't
+permit Perl hook scripts.

 You will find installation instructions for each script in its comment
 header.
diff --git a/contrib/ciabot/ciabot.pl b/contrib/ciabot/ciabot.pl
new file mode 100755
index 0000000..56c37ca
--- /dev/null
+++ b/contrib/ciabot/ciabot.pl
@@ -0,0 +1,321 @@
+#!/usr/bin/perl -w
+#
+# ciabot -- Mail a git log message to a given address, for the purposes of CIA
+#
+# Loosely based on cvslog by Russ Allbery <rra@stanford.edu>
+# Copyright 1998  Board of Trustees, Leland Stanford Jr. University
+#
+# Copyright 2001, 2003, 2004, 2005  Petr Baudis <pasky@ucw.cz>
+# Copyright 2011 JD Horelick <jdhore1@gmail.com>
+#
+# This program is free software; you can redistribute it and/or modify it under
+# the terms of the GNU General Public License version 2, as published by the
+# Free Software Foundation.
+#
+# The master location of this file is in the Cogito repository
+# (see http://www.kernel.org/git/).
+#
+# This program is designed to run as the .git/hooks/post-commit hook. It takes
+# the commit information, massages it and mails it to the address given below.
+#
+# The calling convention of the post-commit hook is:
+#
+#	.git/hooks/post-commit $commit_sha1 $branch_name
+#
+# If it does not work, try to disable $xml_rpc in the configuration section
+# below. Also, remember to make the hook file executable.
+#
+#
+# Note that you can (and it might be actually more desirable) also use this
+# script as the GIT update hook:
+#
+#	refname=${1#refs/heads/}
+#	[ "$refname" = "master" ] && refname=
+#	oldhead=$2
+#	newhead=$3
+#	for merged in $(git rev-list $newhead ^$oldhead | tac); do
+#		/path/to/ciabot.pl $merged $refname
+#	done
+#
+# This is useful when you use a remote repository that you only push to. The
+# update hook will be triggered each time you push into that repository, and
+# the pushed commits will be reported through CIA.
+
+use strict;
+use Carp;
+use vars qw ($project $module $repo $baseurl $from_email $dest_email
$noisy $rpc_uri $sendmail
+		$xml_rpc $ignore_regexp $alt_local_message_target);
+
+
+
+
+### Configuration
+
+# Project name (as known to CIA).
+chomp($project = `git config --get cia.project`);
+
+# Module name (if applicable)
+chomp($module = `git config --get cia.module`);
+
+# Repository name in the web interface
+chomp($repo = `git config --get cia.repo`);
+
+# Base URL for a GitWeb or cgit instance
+# You must comment all the baseurl lines out if you do not have a web interface
+# or do not want the web interface URL for the commit displayed
+# Gitweb
+#$baseurl = "http://git.example.com/cgi-bin/gitweb.cgi?p=$repo;a=commit;h=";
+# cgit
+$baseurl = "http://git.example.com/$repo/commit/?id=";
+
+# The from address in generated mails.
+$from_email = 'cia@example.com';
+
+# Mail all reports to this address.
+$dest_email = 'cia@cia.vc';
+
+# If using XML-RPC, connect to this URI.
+$rpc_uri = 'http://cia.vc/RPC2';
+
+# Path to your USCD sendmail compatible binary (your mailer daemon created this
+# program somewhere).
+$sendmail = '/usr/sbin/sendmail';
+
+# If set, the script will send CIA the full commit message. If unset, only the
+# first line of the commit message will be sent.
+$noisy = 1;
+
+# This script can communicate with CIA either by mail or by an XML-RPC
+# interface. The XML-RPC interface is faster and more efficient, however you
+# need to have RPC::XML perl module installed, and some large CVS hosting sites
+# (like Savannah or Sourceforge) might not allow outgoing HTTP connections
+# while they allow outgoing mail. Also, this script will hang and eventually
+# not deliver the event at all if CIA server happens to be down, which is
+# unfortunately not an uncommon condition.
+$xml_rpc = 1;
+
+# This variable should contain a regexp, against which each file will be
+# checked, and if the regexp is matched, the file is ignored. This can be
+# useful if you do not want auto-updated files, such as e.g. ChangeLog, to
+# appear via CIA.
+#
+# The following example will make the script ignore all changes in two specific
+# files in two different modules, and everything concerning module 'admin':
+#
+# $ignore_regexp = "^(gentoo/Manifest|elinks/src/bfu/inphist.c|admin/)";
+$ignore_regexp = "";
+
+# It can be useful to also grab the generated XML message by some other
+# programs and e.g. autogenerate some content based on it. Here you can specify
+# a file to which it will be appended.
+$alt_local_message_target = "";
+
+
+
+
+### The code itself
+
+use vars qw ($commit $tree @parent $author $committer);
+use vars qw ($user $branch $rev @files $logmsg $message $shorturl);
+my $line;
+
+if ($project eq "") {
+	croak "Project variable is required. Please set one with git config
--add cia.project";
+}
+
+if ($repo eq "") {
+	undef $baseurl;
+}
+
+# Let's be extra-safe here
+if ($module eq "") {
+	undef $module;
+}
+
+
+### Input data loading
+
+
+# The commit stuff
+$commit = $ARGV[0];
+$branch = $ARGV[1];
+
+open COMMIT, "git cat-file commit $commit|" or die "git cat-file
commit $commit: $!";
+my $state = 0;
+$logmsg = '';
+while (defined ($line = <COMMIT>)) {
+  if ($state == 1) {
+    $logmsg .= $line;
+    $noisy or $state++;
+    next;
+  } elsif ($state > 1) {
+    next;
+  }
+
+  chomp $line;
+  unless ($line) {
+    $state = 1;
+    next;
+  }
+
+  my ($key, $value) = split(/ /, $line, 2);
+  if ($key eq 'tree') {
+    $tree = $value;
+  } elsif ($key eq 'parent') {
+    push(@parent, $value);
+  } elsif ($key eq 'author') {
+    $author = $value;
+  } elsif ($key eq 'committer') {
+    $committer = $value;
+  }
+}
+close COMMIT;
+
+
+open DIFF, "git diff-tree -r $parent[0] $tree|" or die "git diff-tree
$parent[0] $tree: $!";
+while (defined ($line = <DIFF>)) {
+  chomp $line;
+  my @f;
+  (undef, @f) = split(/\t/, $line, 2);
+  push (@files, @f);
+}
+close DIFF;
+
+
+# Figure out who is doing the update.
+# XXX: Too trivial this way?
+($user) = $author =~ /<(.*?)@/;
+
+
+$rev = substr($commit, 0, 12);
+
+
+
+
+### Remove to-be-ignored files
+
+@files = grep { $_ !~ m/$ignore_regexp/; } @files
+  if ($ignore_regexp);
+exit unless @files;
+
+
+
+### Compose the mail message
+
+
+my ($VERSION) = '2.0';
+my $ts = time;
+
+$message = <<EM
+<message>
+   <generator>
+       <name>CIA Perl client for Git</name>
+       <version>$VERSION</version>
+   </generator>
+   <source>
+       <project>$project</project>
+
+EM
+;
+$message .= "       <module>$module</module>" if ($module);
+$message .= "       <branch>$branch</branch>" if ($branch);
+$message .= <<EM
+   </source>
+   <timestamp>
+       $ts
+   </timestamp>
+   <body>
+       <commit>
+           <author>$user</author>
+           <revision>$rev</revision>
+           <files>
+EM
+;
+
+foreach (@files) {
+  s/&/&amp;/g;
+  s/</&lt;/g;
+  s/>/&gt;/g;
+  $message .= "  <file>$_</file>\n";
+}
+
+$logmsg =~ s/&/&amp;/g;
+$logmsg =~ s/</&lt;/g;
+$logmsg =~ s/>/&gt;/g;
+
+if (defined $baseurl) {
+	$shorturl = $baseurl . $rev;
+	$logmsg = $logmsg . $shorturl;
+}
+
+$message .= <<EM
+           </files>
+	<log>$logmsg</log>
+       </commit>
+   </body>
+</message>
+EM
+;
+
+
+
+### Write the message to an alt-target
+
+if ($alt_local_message_target and open (ALT, ">>$alt_local_message_target")) {
+  print ALT $message;
+  close ALT;
+}
+
+
+
+### Send out the XML-RPC message
+
+
+if ($xml_rpc) {
+  # We gotta be careful from now on. We silence all the warnings because
+  # RPC::XML code is crappy and works with undefs etc.
+  $^W = 0;
+  $RPC::XML::ERROR if (0); # silence perl's compile-time warning
+
+  require RPC::XML;
+  require RPC::XML::Client;
+
+  my $rpc_client = new RPC::XML::Client $rpc_uri;
+  my $rpc_request = RPC::XML::request->new('hub.deliver', $message);
+  my $rpc_response = $rpc_client->send_request($rpc_request);
+
+  unless (ref $rpc_response) {
+    carp "XML-RPC Error: $RPC::XML::ERROR. No CIA notification will
be displayed for what was pushed.\n";
+  }
+  exit;
+}
+
+
+
+### Send out the mail
+
+
+# Open our mail program
+
+open (MAIL, "| $sendmail -t -oi -oem") or die "Cannot execute
$sendmail : " . ($?>>8);
+
+
+# The mail header
+
+print MAIL <<EOM;
+From: $from_email
+To: $dest_email
+Content-type: text/xml
+Subject: DeliverXML
+
+EOM
+
+print MAIL $message;
+
+
+# Close the mail
+
+close MAIL;
+die "$0: sendmail exit status " . ($? >> 8) . "\n" unless ($? == 0);
+
+# vi: set sw=2:
-- 
1.7.5.1

--20cf3054a47355bf0a04a5774f50
Content-Type: text/x-patch; charset=US-ASCII; name="new-ciabot.patch"
Content-Disposition: attachment; filename="new-ciabot.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_got58o7m0

RnJvbSBmODBjMDQxZGNkN2RiNmFiZmEwMzU0Yzg5YWRjYjhiODExYjI3ZTg5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKRCBIb3JlbGljayA8amRob3JlMUBnbWFpbC5jb20+CkRhdGU6
IFNhdCwgMTEgSnVuIDIwMTEgMTg6MTY6MTYgLTA0MDAKU3ViamVjdDogW1BBVENIXSBjaWFib3Q6
IEFkZCBhIHJldmFtcGVkIFBlcmwgdmVyc2lvbi4KClRoaXMgcmV2YW1wZWQgUGVybCB2ZXJzaW9u
IG9mZmVycyBtb3JlIGZlYXR1cmVzIGFuZCB1c2VzIHRoZSByZWNvbW1lbmRlZAppbnRlcmZhY2Ug
dG8gdGhlIENJQS52YyBTZXJ2aWNlIChYTUwtUlBDLCB3aXRoIGVtYWlsIGFzIGEgYmFja3VwIG9w
dGlvbikuCgpTb21lIG9mIHRoZSBhZGRpdGlvbmFsIGZlYXR1cmVzIGluY2x1ZGUgdGhlIGFiaWxp
dHkgdG8gc2VuZCBhIG1vZHVsZQpmaWVsZCB0byBDSUEgYW5kIHRoZSBhYmlsaXR5IHRvIHNldCBz
Y3JpcHQgYWxsIHJlbGV2YW50IHNjcmlwdCBvcHRpb25zCndpdGggZ2l0IGNvbmZpZy4KClNpZ25l
ZC1vZmYtYnk6IEpEIEhvcmVsaWNrIDxqZGhvcmUxQGdtYWlsLmNvbT4KLS0tCiBjb250cmliL2Np
YWJvdC9SRUFETUUgICAgfCAgIDEzICstCiBjb250cmliL2NpYWJvdC9jaWFib3QucGwgfCAgMzIx
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMg
Y2hhbmdlZCwgMzI5IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAx
MDA3NTUgY29udHJpYi9jaWFib3QvY2lhYm90LnBsCgpkaWZmIC0tZ2l0IGEvY29udHJpYi9jaWFi
b3QvUkVBRE1FIGIvY29udHJpYi9jaWFib3QvUkVBRE1FCmluZGV4IDNiOTE2YWMuLjU2ODNmYTIg
MTAwNjQ0Ci0tLSBhL2NvbnRyaWIvY2lhYm90L1JFQURNRQorKysgYi9jb250cmliL2NpYWJvdC9S
RUFETUUKQEAgLTEsMTIgKzEsMTUgQEAKIFRoZXNlIGFyZSBob29rIHNjcmlwdHMgZm9yIHRoZSBD
SUEgbm90aWZpY2F0aW9uIHNlcnZpY2UgYXQgPGh0dHA6Ly9jaWEudmMvPgogCi1UaGV5IGFyZSBt
YWludGFpbmVkIGJ5IEVyaWMgUy4gUmF5bW9uZCA8ZXNyQHRoeXJzdXMuY29tPi4gIFRoZXJlIGlz
IGFuCi11cHN0cmVhbSByZXNvdXJjZSBwYWdlIGZvciB0aGVtIGF0IDxodHRwOi8vd3d3LmNhdGIu
b3JnL2Vzci9jaWFib3QvPiwKK1RoZSBQZXJsIHZlcnNpb24gaXMgbWFpbnRhaW5lZCBieSBKRCBI
b3JlbGljayA8amRob3JlMUBnbWFpbC5jb20+LgorCitUaGUgUHl0aG9uIGFuZCBzaGVsbCB2ZXJz
aW9ucyBhcmUgbWFpbnRhaW5lZCBieSBFcmljIFMuIFJheW1vbmQgPGVzckB0aHlyc3VzLmNvbT4u
CitUaGVyZSBpcyBhbiB1cHN0cmVhbSByZXNvdXJjZSBwYWdlIGZvciB0aGVtIGF0IDxodHRwOi8v
d3d3LmNhdGIub3JnL2Vzci9jaWFib3QvPiwKIGJ1dCB0aGV5IGFyZSB1bmxpa2VseSB0byBjaGFu
Z2UgcmFwaWRseS4KIAotWW91IHByb2JhYmx5IHdhbnQgdGhlIFB5dGhvbiB2ZXJzaW9uOyBpdCdz
IGZhc3RlciwgbW9yZSBjYXBhYmxlLCBhbmQKLWJldHRlciBkb2N1bWVudGVkLiAgVGhlIHNoZWxs
IHZlcnNpb24gaXMgbWFpbnRhaW5lZCBvbmx5IGFzIGEgZmFsbGJhY2sKLWZvciB1c2Ugb24gaG9z
dGluZyBzaXRlcyB0aGF0IGRvbid0IHBlcm1pdCBQeXRob24gaG9vayBzY3JpcHRzLgorWW91IHBy
b2JhYmx5IHdhbnQgdGhlIFBlcmwgdmVyc2lvbjsgaXQncyBmYXN0ZXIsIG1vcmUgY2FwYWJsZSwg
dXNlcyB0aGUKK3JlY29tbWVuZGVkIENJQSBpbnRlcmZhY2UgYW5kIGlzIGJldHRlciBkb2N1bWVu
dGVkLiAgVGhlIHNoZWxsIHZlcnNpb24KK2lzIG1haW50YWluZWQgb25seSBhcyBhIGZhbGxiYWNr
IGZvciB1c2Ugb24gaG9zdGluZyBzaXRlcyB0aGF0IGRvbid0CitwZXJtaXQgUGVybCBob29rIHNj
cmlwdHMuCiAKIFlvdSB3aWxsIGZpbmQgaW5zdGFsbGF0aW9uIGluc3RydWN0aW9ucyBmb3IgZWFj
aCBzY3JpcHQgaW4gaXRzIGNvbW1lbnQKIGhlYWRlci4KZGlmZiAtLWdpdCBhL2NvbnRyaWIvY2lh
Ym90L2NpYWJvdC5wbCBiL2NvbnRyaWIvY2lhYm90L2NpYWJvdC5wbApuZXcgZmlsZSBtb2RlIDEw
MDc1NQppbmRleCAwMDAwMDAwLi41NmMzN2NhCi0tLSAvZGV2L251bGwKKysrIGIvY29udHJpYi9j
aWFib3QvY2lhYm90LnBsCkBAIC0wLDAgKzEsMzIxIEBACisjIS91c3IvYmluL3BlcmwgLXcKKyMK
KyMgY2lhYm90IC0tIE1haWwgYSBnaXQgbG9nIG1lc3NhZ2UgdG8gYSBnaXZlbiBhZGRyZXNzLCBm
b3IgdGhlIHB1cnBvc2VzIG9mIENJQQorIworIyBMb29zZWx5IGJhc2VkIG9uIGN2c2xvZyBieSBS
dXNzIEFsbGJlcnkgPHJyYUBzdGFuZm9yZC5lZHU+CisjIENvcHlyaWdodCAxOTk4ICBCb2FyZCBv
ZiBUcnVzdGVlcywgTGVsYW5kIFN0YW5mb3JkIEpyLiBVbml2ZXJzaXR5CisjCisjIENvcHlyaWdo
dCAyMDAxLCAyMDAzLCAyMDA0LCAyMDA1ICBQZXRyIEJhdWRpcyA8cGFza3lAdWN3LmN6PgorIyBD
b3B5cmlnaHQgMjAxMSBKRCBIb3JlbGljayA8amRob3JlMUBnbWFpbC5jb20+CisjCisjIFRoaXMg
cHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3Ig
bW9kaWZ5IGl0IHVuZGVyCisjIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExp
Y2Vuc2UgdmVyc2lvbiAyLCBhcyBwdWJsaXNoZWQgYnkgdGhlCisjIEZyZWUgU29mdHdhcmUgRm91
bmRhdGlvbi4KKyMKKyMgVGhlIG1hc3RlciBsb2NhdGlvbiBvZiB0aGlzIGZpbGUgaXMgaW4gdGhl
IENvZ2l0byByZXBvc2l0b3J5CisjIChzZWUgaHR0cDovL3d3dy5rZXJuZWwub3JnL2dpdC8pLgor
IworIyBUaGlzIHByb2dyYW0gaXMgZGVzaWduZWQgdG8gcnVuIGFzIHRoZSAuZ2l0L2hvb2tzL3Bv
c3QtY29tbWl0IGhvb2suIEl0IHRha2VzCisjIHRoZSBjb21taXQgaW5mb3JtYXRpb24sIG1hc3Nh
Z2VzIGl0IGFuZCBtYWlscyBpdCB0byB0aGUgYWRkcmVzcyBnaXZlbiBiZWxvdy4KKyMKKyMgVGhl
IGNhbGxpbmcgY29udmVudGlvbiBvZiB0aGUgcG9zdC1jb21taXQgaG9vayBpczoKKyMKKyMJLmdp
dC9ob29rcy9wb3N0LWNvbW1pdCAkY29tbWl0X3NoYTEgJGJyYW5jaF9uYW1lCisjCisjIElmIGl0
IGRvZXMgbm90IHdvcmssIHRyeSB0byBkaXNhYmxlICR4bWxfcnBjIGluIHRoZSBjb25maWd1cmF0
aW9uIHNlY3Rpb24KKyMgYmVsb3cuIEFsc28sIHJlbWVtYmVyIHRvIG1ha2UgdGhlIGhvb2sgZmls
ZSBleGVjdXRhYmxlLgorIworIworIyBOb3RlIHRoYXQgeW91IGNhbiAoYW5kIGl0IG1pZ2h0IGJl
IGFjdHVhbGx5IG1vcmUgZGVzaXJhYmxlKSBhbHNvIHVzZSB0aGlzCisjIHNjcmlwdCBhcyB0aGUg
R0lUIHVwZGF0ZSBob29rOgorIworIwlyZWZuYW1lPSR7MSNyZWZzL2hlYWRzL30KKyMJWyAiJHJl
Zm5hbWUiID0gIm1hc3RlciIgXSAmJiByZWZuYW1lPQorIwlvbGRoZWFkPSQyCisjCW5ld2hlYWQ9
JDMKKyMJZm9yIG1lcmdlZCBpbiAkKGdpdCByZXYtbGlzdCAkbmV3aGVhZCBeJG9sZGhlYWQgfCB0
YWMpOyBkbworIwkJL3BhdGgvdG8vY2lhYm90LnBsICRtZXJnZWQgJHJlZm5hbWUKKyMJZG9uZQor
IworIyBUaGlzIGlzIHVzZWZ1bCB3aGVuIHlvdSB1c2UgYSByZW1vdGUgcmVwb3NpdG9yeSB0aGF0
IHlvdSBvbmx5IHB1c2ggdG8uIFRoZQorIyB1cGRhdGUgaG9vayB3aWxsIGJlIHRyaWdnZXJlZCBl
YWNoIHRpbWUgeW91IHB1c2ggaW50byB0aGF0IHJlcG9zaXRvcnksIGFuZAorIyB0aGUgcHVzaGVk
IGNvbW1pdHMgd2lsbCBiZSByZXBvcnRlZCB0aHJvdWdoIENJQS4KKwordXNlIHN0cmljdDsKK3Vz
ZSBDYXJwOwordXNlIHZhcnMgcXcgKCRwcm9qZWN0ICRtb2R1bGUgJHJlcG8gJGJhc2V1cmwgJGZy
b21fZW1haWwgJGRlc3RfZW1haWwgJG5vaXN5ICRycGNfdXJpICRzZW5kbWFpbAorCQkkeG1sX3Jw
YyAkaWdub3JlX3JlZ2V4cCAkYWx0X2xvY2FsX21lc3NhZ2VfdGFyZ2V0KTsKKworCisKKworIyMj
IENvbmZpZ3VyYXRpb24KKworIyBQcm9qZWN0IG5hbWUgKGFzIGtub3duIHRvIENJQSkuCitjaG9t
cCgkcHJvamVjdCA9IGBnaXQgY29uZmlnIC0tZ2V0IGNpYS5wcm9qZWN0YCk7CisKKyMgTW9kdWxl
IG5hbWUgKGlmIGFwcGxpY2FibGUpCitjaG9tcCgkbW9kdWxlID0gYGdpdCBjb25maWcgLS1nZXQg
Y2lhLm1vZHVsZWApOworCisjIFJlcG9zaXRvcnkgbmFtZSBpbiB0aGUgd2ViIGludGVyZmFjZQor
Y2hvbXAoJHJlcG8gPSBgZ2l0IGNvbmZpZyAtLWdldCBjaWEucmVwb2ApOworCisjIEJhc2UgVVJM
IGZvciBhIEdpdFdlYiBvciBjZ2l0IGluc3RhbmNlCisjIFlvdSBtdXN0IGNvbW1lbnQgYWxsIHRo
ZSBiYXNldXJsIGxpbmVzIG91dCBpZiB5b3UgZG8gbm90IGhhdmUgYSB3ZWIgaW50ZXJmYWNlCisj
IG9yIGRvIG5vdCB3YW50IHRoZSB3ZWIgaW50ZXJmYWNlIFVSTCBmb3IgdGhlIGNvbW1pdCBkaXNw
bGF5ZWQKKyMgR2l0d2ViCisjJGJhc2V1cmwgPSAiaHR0cDovL2dpdC5leGFtcGxlLmNvbS9jZ2kt
YmluL2dpdHdlYi5jZ2k/cD0kcmVwbzthPWNvbW1pdDtoPSI7CisjIGNnaXQKKyRiYXNldXJsID0g
Imh0dHA6Ly9naXQuZXhhbXBsZS5jb20vJHJlcG8vY29tbWl0Lz9pZD0iOworCisjIFRoZSBmcm9t
IGFkZHJlc3MgaW4gZ2VuZXJhdGVkIG1haWxzLgorJGZyb21fZW1haWwgPSAnY2lhQGV4YW1wbGUu
Y29tJzsKKworIyBNYWlsIGFsbCByZXBvcnRzIHRvIHRoaXMgYWRkcmVzcy4KKyRkZXN0X2VtYWls
ID0gJ2NpYUBjaWEudmMnOworCisjIElmIHVzaW5nIFhNTC1SUEMsIGNvbm5lY3QgdG8gdGhpcyBV
UkkuCiskcnBjX3VyaSA9ICdodHRwOi8vY2lhLnZjL1JQQzInOworCisjIFBhdGggdG8geW91ciBV
U0NEIHNlbmRtYWlsIGNvbXBhdGlibGUgYmluYXJ5ICh5b3VyIG1haWxlciBkYWVtb24gY3JlYXRl
ZCB0aGlzCisjIHByb2dyYW0gc29tZXdoZXJlKS4KKyRzZW5kbWFpbCA9ICcvdXNyL3NiaW4vc2Vu
ZG1haWwnOworCisjIElmIHNldCwgdGhlIHNjcmlwdCB3aWxsIHNlbmQgQ0lBIHRoZSBmdWxsIGNv
bW1pdCBtZXNzYWdlLiBJZiB1bnNldCwgb25seSB0aGUKKyMgZmlyc3QgbGluZSBvZiB0aGUgY29t
bWl0IG1lc3NhZ2Ugd2lsbCBiZSBzZW50LgorJG5vaXN5ID0gMTsKKworIyBUaGlzIHNjcmlwdCBj
YW4gY29tbXVuaWNhdGUgd2l0aCBDSUEgZWl0aGVyIGJ5IG1haWwgb3IgYnkgYW4gWE1MLVJQQwor
IyBpbnRlcmZhY2UuIFRoZSBYTUwtUlBDIGludGVyZmFjZSBpcyBmYXN0ZXIgYW5kIG1vcmUgZWZm
aWNpZW50LCBob3dldmVyIHlvdQorIyBuZWVkIHRvIGhhdmUgUlBDOjpYTUwgcGVybCBtb2R1bGUg
aW5zdGFsbGVkLCBhbmQgc29tZSBsYXJnZSBDVlMgaG9zdGluZyBzaXRlcworIyAobGlrZSBTYXZh
bm5haCBvciBTb3VyY2Vmb3JnZSkgbWlnaHQgbm90IGFsbG93IG91dGdvaW5nIEhUVFAgY29ubmVj
dGlvbnMKKyMgd2hpbGUgdGhleSBhbGxvdyBvdXRnb2luZyBtYWlsLiBBbHNvLCB0aGlzIHNjcmlw
dCB3aWxsIGhhbmcgYW5kIGV2ZW50dWFsbHkKKyMgbm90IGRlbGl2ZXIgdGhlIGV2ZW50IGF0IGFs
bCBpZiBDSUEgc2VydmVyIGhhcHBlbnMgdG8gYmUgZG93biwgd2hpY2ggaXMKKyMgdW5mb3J0dW5h
dGVseSBub3QgYW4gdW5jb21tb24gY29uZGl0aW9uLgorJHhtbF9ycGMgPSAxOworCisjIFRoaXMg
dmFyaWFibGUgc2hvdWxkIGNvbnRhaW4gYSByZWdleHAsIGFnYWluc3Qgd2hpY2ggZWFjaCBmaWxl
IHdpbGwgYmUKKyMgY2hlY2tlZCwgYW5kIGlmIHRoZSByZWdleHAgaXMgbWF0Y2hlZCwgdGhlIGZp
bGUgaXMgaWdub3JlZC4gVGhpcyBjYW4gYmUKKyMgdXNlZnVsIGlmIHlvdSBkbyBub3Qgd2FudCBh
dXRvLXVwZGF0ZWQgZmlsZXMsIHN1Y2ggYXMgZS5nLiBDaGFuZ2VMb2csIHRvCisjIGFwcGVhciB2
aWEgQ0lBLgorIworIyBUaGUgZm9sbG93aW5nIGV4YW1wbGUgd2lsbCBtYWtlIHRoZSBzY3JpcHQg
aWdub3JlIGFsbCBjaGFuZ2VzIGluIHR3byBzcGVjaWZpYworIyBmaWxlcyBpbiB0d28gZGlmZmVy
ZW50IG1vZHVsZXMsIGFuZCBldmVyeXRoaW5nIGNvbmNlcm5pbmcgbW9kdWxlICdhZG1pbic6Cisj
CisjICRpZ25vcmVfcmVnZXhwID0gIl4oZ2VudG9vL01hbmlmZXN0fGVsaW5rcy9zcmMvYmZ1L2lu
cGhpc3QuY3xhZG1pbi8pIjsKKyRpZ25vcmVfcmVnZXhwID0gIiI7CisKKyMgSXQgY2FuIGJlIHVz
ZWZ1bCB0byBhbHNvIGdyYWIgdGhlIGdlbmVyYXRlZCBYTUwgbWVzc2FnZSBieSBzb21lIG90aGVy
CisjIHByb2dyYW1zIGFuZCBlLmcuIGF1dG9nZW5lcmF0ZSBzb21lIGNvbnRlbnQgYmFzZWQgb24g
aXQuIEhlcmUgeW91IGNhbiBzcGVjaWZ5CisjIGEgZmlsZSB0byB3aGljaCBpdCB3aWxsIGJlIGFw
cGVuZGVkLgorJGFsdF9sb2NhbF9tZXNzYWdlX3RhcmdldCA9ICIiOworCisKKworCisjIyMgVGhl
IGNvZGUgaXRzZWxmCisKK3VzZSB2YXJzIHF3ICgkY29tbWl0ICR0cmVlIEBwYXJlbnQgJGF1dGhv
ciAkY29tbWl0dGVyKTsKK3VzZSB2YXJzIHF3ICgkdXNlciAkYnJhbmNoICRyZXYgQGZpbGVzICRs
b2dtc2cgJG1lc3NhZ2UgJHNob3J0dXJsKTsKK215ICRsaW5lOworCitpZiAoJHByb2plY3QgZXEg
IiIpIHsKKwljcm9hayAiUHJvamVjdCB2YXJpYWJsZSBpcyByZXF1aXJlZC4gUGxlYXNlIHNldCBv
bmUgd2l0aCBnaXQgY29uZmlnIC0tYWRkIGNpYS5wcm9qZWN0IjsKK30KKworaWYgKCRyZXBvIGVx
ICIiKSB7CisJdW5kZWYgJGJhc2V1cmw7Cit9CisKKyMgTGV0J3MgYmUgZXh0cmEtc2FmZSBoZXJl
CitpZiAoJG1vZHVsZSBlcSAiIikgeworCXVuZGVmICRtb2R1bGU7Cit9CisKKworIyMjIElucHV0
IGRhdGEgbG9hZGluZworCisKKyMgVGhlIGNvbW1pdCBzdHVmZgorJGNvbW1pdCA9ICRBUkdWWzBd
OworJGJyYW5jaCA9ICRBUkdWWzFdOworCitvcGVuIENPTU1JVCwgImdpdCBjYXQtZmlsZSBjb21t
aXQgJGNvbW1pdHwiIG9yIGRpZSAiZ2l0IGNhdC1maWxlIGNvbW1pdCAkY29tbWl0OiAkISI7Citt
eSAkc3RhdGUgPSAwOworJGxvZ21zZyA9ICcnOword2hpbGUgKGRlZmluZWQgKCRsaW5lID0gPENP
TU1JVD4pKSB7CisgIGlmICgkc3RhdGUgPT0gMSkgeworICAgICRsb2dtc2cgLj0gJGxpbmU7Cisg
ICAgJG5vaXN5IG9yICRzdGF0ZSsrOworICAgIG5leHQ7CisgIH0gZWxzaWYgKCRzdGF0ZSA+IDEp
IHsKKyAgICBuZXh0OworICB9CisKKyAgY2hvbXAgJGxpbmU7CisgIHVubGVzcyAoJGxpbmUpIHsK
KyAgICAkc3RhdGUgPSAxOworICAgIG5leHQ7CisgIH0KKworICBteSAoJGtleSwgJHZhbHVlKSA9
IHNwbGl0KC8gLywgJGxpbmUsIDIpOworICBpZiAoJGtleSBlcSAndHJlZScpIHsKKyAgICAkdHJl
ZSA9ICR2YWx1ZTsKKyAgfSBlbHNpZiAoJGtleSBlcSAncGFyZW50JykgeworICAgIHB1c2goQHBh
cmVudCwgJHZhbHVlKTsKKyAgfSBlbHNpZiAoJGtleSBlcSAnYXV0aG9yJykgeworICAgICRhdXRo
b3IgPSAkdmFsdWU7CisgIH0gZWxzaWYgKCRrZXkgZXEgJ2NvbW1pdHRlcicpIHsKKyAgICAkY29t
bWl0dGVyID0gJHZhbHVlOworICB9Cit9CitjbG9zZSBDT01NSVQ7CisKKworb3BlbiBESUZGLCAi
Z2l0IGRpZmYtdHJlZSAtciAkcGFyZW50WzBdICR0cmVlfCIgb3IgZGllICJnaXQgZGlmZi10cmVl
ICRwYXJlbnRbMF0gJHRyZWU6ICQhIjsKK3doaWxlIChkZWZpbmVkICgkbGluZSA9IDxESUZGPikp
IHsKKyAgY2hvbXAgJGxpbmU7CisgIG15IEBmOworICAodW5kZWYsIEBmKSA9IHNwbGl0KC9cdC8s
ICRsaW5lLCAyKTsKKyAgcHVzaCAoQGZpbGVzLCBAZik7Cit9CitjbG9zZSBESUZGOworCisKKyMg
RmlndXJlIG91dCB3aG8gaXMgZG9pbmcgdGhlIHVwZGF0ZS4KKyMgWFhYOiBUb28gdHJpdmlhbCB0
aGlzIHdheT8KKygkdXNlcikgPSAkYXV0aG9yID1+IC88KC4qPylALzsKKworCiskcmV2ID0gc3Vi
c3RyKCRjb21taXQsIDAsIDEyKTsKKworCisKKworIyMjIFJlbW92ZSB0by1iZS1pZ25vcmVkIGZp
bGVzCisKK0BmaWxlcyA9IGdyZXAgeyAkXyAhfiBtLyRpZ25vcmVfcmVnZXhwLzsgfSBAZmlsZXMK
KyAgaWYgKCRpZ25vcmVfcmVnZXhwKTsKK2V4aXQgdW5sZXNzIEBmaWxlczsKKworCisKKyMjIyBD
b21wb3NlIHRoZSBtYWlsIG1lc3NhZ2UKKworCitteSAoJFZFUlNJT04pID0gJzIuMCc7CitteSAk
dHMgPSB0aW1lOworCiskbWVzc2FnZSA9IDw8RU0KKzxtZXNzYWdlPgorICAgPGdlbmVyYXRvcj4K
KyAgICAgICA8bmFtZT5DSUEgUGVybCBjbGllbnQgZm9yIEdpdDwvbmFtZT4KKyAgICAgICA8dmVy
c2lvbj4kVkVSU0lPTjwvdmVyc2lvbj4KKyAgIDwvZ2VuZXJhdG9yPgorICAgPHNvdXJjZT4KKyAg
ICAgICA8cHJvamVjdD4kcHJvamVjdDwvcHJvamVjdD4KKworRU0KKzsKKyRtZXNzYWdlIC49ICIg
ICAgICAgPG1vZHVsZT4kbW9kdWxlPC9tb2R1bGU+IiBpZiAoJG1vZHVsZSk7CiskbWVzc2FnZSAu
PSAiICAgICAgIDxicmFuY2g+JGJyYW5jaDwvYnJhbmNoPiIgaWYgKCRicmFuY2gpOworJG1lc3Nh
Z2UgLj0gPDxFTQorICAgPC9zb3VyY2U+CisgICA8dGltZXN0YW1wPgorICAgICAgICR0cworICAg
PC90aW1lc3RhbXA+CisgICA8Ym9keT4KKyAgICAgICA8Y29tbWl0PgorICAgICAgICAgICA8YXV0
aG9yPiR1c2VyPC9hdXRob3I+CisgICAgICAgICAgIDxyZXZpc2lvbj4kcmV2PC9yZXZpc2lvbj4K
KyAgICAgICAgICAgPGZpbGVzPgorRU0KKzsKKworZm9yZWFjaCAoQGZpbGVzKSB7CisgIHMvJi8m
YW1wOy9nOworICBzLzwvJmx0Oy9nOworICBzLz4vJmd0Oy9nOworICAkbWVzc2FnZSAuPSAiICA8
ZmlsZT4kXzwvZmlsZT5cbiI7Cit9CisKKyRsb2dtc2cgPX4gcy8mLyZhbXA7L2c7CiskbG9nbXNn
ID1+IHMvPC8mbHQ7L2c7CiskbG9nbXNnID1+IHMvPi8mZ3Q7L2c7CisKK2lmIChkZWZpbmVkICRi
YXNldXJsKSB7CisJJHNob3J0dXJsID0gJGJhc2V1cmwgLiAkcmV2OworCSRsb2dtc2cgPSAkbG9n
bXNnIC4gJHNob3J0dXJsOworfQorCiskbWVzc2FnZSAuPSA8PEVNCisgICAgICAgICAgIDwvZmls
ZXM+CisJPGxvZz4kbG9nbXNnPC9sb2c+CisgICAgICAgPC9jb21taXQ+CisgICA8L2JvZHk+Cis8
L21lc3NhZ2U+CitFTQorOworCisKKworIyMjIFdyaXRlIHRoZSBtZXNzYWdlIHRvIGFuIGFsdC10
YXJnZXQKKworaWYgKCRhbHRfbG9jYWxfbWVzc2FnZV90YXJnZXQgYW5kIG9wZW4gKEFMVCwgIj4+
JGFsdF9sb2NhbF9tZXNzYWdlX3RhcmdldCIpKSB7CisgIHByaW50IEFMVCAkbWVzc2FnZTsKKyAg
Y2xvc2UgQUxUOworfQorCisKKworIyMjIFNlbmQgb3V0IHRoZSBYTUwtUlBDIG1lc3NhZ2UKKwor
CitpZiAoJHhtbF9ycGMpIHsKKyAgIyBXZSBnb3R0YSBiZSBjYXJlZnVsIGZyb20gbm93IG9uLiBX
ZSBzaWxlbmNlIGFsbCB0aGUgd2FybmluZ3MgYmVjYXVzZQorICAjIFJQQzo6WE1MIGNvZGUgaXMg
Y3JhcHB5IGFuZCB3b3JrcyB3aXRoIHVuZGVmcyBldGMuCisgICReVyA9IDA7CisgICRSUEM6OlhN
TDo6RVJST1IgaWYgKDApOyAjIHNpbGVuY2UgcGVybCdzIGNvbXBpbGUtdGltZSB3YXJuaW5nCisK
KyAgcmVxdWlyZSBSUEM6OlhNTDsKKyAgcmVxdWlyZSBSUEM6OlhNTDo6Q2xpZW50OworCisgIG15
ICRycGNfY2xpZW50ID0gbmV3IFJQQzo6WE1MOjpDbGllbnQgJHJwY191cmk7CisgIG15ICRycGNf
cmVxdWVzdCA9IFJQQzo6WE1MOjpyZXF1ZXN0LT5uZXcoJ2h1Yi5kZWxpdmVyJywgJG1lc3NhZ2Up
OworICBteSAkcnBjX3Jlc3BvbnNlID0gJHJwY19jbGllbnQtPnNlbmRfcmVxdWVzdCgkcnBjX3Jl
cXVlc3QpOworCisgIHVubGVzcyAocmVmICRycGNfcmVzcG9uc2UpIHsKKyAgICBjYXJwICJYTUwt
UlBDIEVycm9yOiAkUlBDOjpYTUw6OkVSUk9SLiBObyBDSUEgbm90aWZpY2F0aW9uIHdpbGwgYmUg
ZGlzcGxheWVkIGZvciB3aGF0IHdhcyBwdXNoZWQuXG4iOworICB9CisgIGV4aXQ7Cit9CisKKwor
CisjIyMgU2VuZCBvdXQgdGhlIG1haWwKKworCisjIE9wZW4gb3VyIG1haWwgcHJvZ3JhbQorCitv
cGVuIChNQUlMLCAifCAkc2VuZG1haWwgLXQgLW9pIC1vZW0iKSBvciBkaWUgIkNhbm5vdCBleGVj
dXRlICRzZW5kbWFpbCA6ICIgLiAoJD8+PjgpOworCisKKyMgVGhlIG1haWwgaGVhZGVyCisKK3By
aW50IE1BSUwgPDxFT007CitGcm9tOiAkZnJvbV9lbWFpbAorVG86ICRkZXN0X2VtYWlsCitDb250
ZW50LXR5cGU6IHRleHQveG1sCitTdWJqZWN0OiBEZWxpdmVyWE1MCisKK0VPTQorCitwcmludCBN
QUlMICRtZXNzYWdlOworCisKKyMgQ2xvc2UgdGhlIG1haWwKKworY2xvc2UgTUFJTDsKK2RpZSAi
JDA6IHNlbmRtYWlsIGV4aXQgc3RhdHVzICIgLiAoJD8gPj4gOCkgLiAiXG4iIHVubGVzcyAoJD8g
PT0gMCk7CisKKyMgdmk6IHNldCBzdz0yOgotLSAKMS43LjUuMQoK
--20cf3054a47355bf0a04a5774f50--
