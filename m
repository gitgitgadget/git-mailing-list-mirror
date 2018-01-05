Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B32D51F428
	for <e@80x24.org>; Fri,  5 Jan 2018 18:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752342AbeAEShY (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 13:37:24 -0500
Received: from mut-mta1-se01a-zose1-fr.yulpa.io ([185.49.21.248]:60852 "EHLO
        mut-mta1-se01a-zose1-fr.yulpa.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752226AbeAEShW (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Jan 2018 13:37:22 -0500
Received: from zose-mx-out01.web4all.fr ([185.49.20.46] helo=zose-mta-hub-out-mua-02.web4all.fr)
        by mut-mta1-se01c-fr.yulpa.io with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <git@matthieu-moy.fr>)
        id 1eXWrf-0004jo-TP; Fri, 05 Jan 2018 19:37:17 +0100
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTP id 2EC7260E4A;
        Fri,  5 Jan 2018 19:37:10 +0100 (CET)
Received: from zose-mta-hub-out-mua-02.web4all.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-mua-02.web4all.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id P53_Bfsc1UKD; Fri,  5 Jan 2018 19:37:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTP id 1B19D60E62;
        Fri,  5 Jan 2018 19:37:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at zose1.web4all.fr
Received: from zose-mta-hub-out-mua-02.web4all.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-mua-02.web4all.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FeSzF7_rAaPg; Fri,  5 Jan 2018 19:37:05 +0100 (CET)
Received: from moylip.numericable.fr (3.136.192.77.rev.sfr.net [77.192.136.3])
        (Authenticated sender: matthieu.moy@matthieu-moy.fr)
        by zose-mta-hub-out-mua-02.web4all.fr (Postfix) with ESMTPSA id 920E960E4A;
        Fri,  5 Jan 2018 19:37:02 +0100 (CET)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Thomas Adam <thomas@xteddy.org>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH v2 1/3] send-email: add and use a local copy of Mail::Address
Date:   Fri,  5 Jan 2018 19:36:51 +0100
Message-Id: <1515177413-12526-1-git-send-email-git@matthieu-moy.fr>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1515092151-14423-1-git-send-email-git@matthieu-moy.fr>
References: <1515092151-14423-1-git-send-email-git@matthieu-moy.fr>
X-Originating-IP: 185.49.20.46
X-SpamExperts-Domain: zose1.web4all.fr
X-SpamExperts-Username: 185.49.20.46
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.49.20.46@zose1.web4all.fr
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (1.01910025254e-05)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5tQfB5uPthMakY5yQL6nrfzj1g3/PwYZaTCzSym8uE9HPImhfA8k5/zW
 UdbqUfA/+atZAIrjsCRyglG39ay7s40zkSakW8+kgCjGkeOx1qmz3ywmUacsjxjAsJqLMS98bO5z
 ycA319z5HV3CMmoHwxoemuNNL7GGp+zW501rEhQ5LqisX5+l+fRB3wYlhH1KyOfHzJ6mVE7ewsip
 SVIfs4ZV9soi43hSDLq5n1FuV1nJZoJMI94JyDNTYfA50Otxn/jk0+YoVjbPYBbwrj5eWUnOiXFL
 iKIvpft9mm8OdmYqEPKqj4wpSPprxfaL4KUPa+d7ax+3+Jf/9S3laQAPwF4OOPS2BLJ6Do0LA2bx
 tTWVqi2fY8oW0hCeiKrXsIHuXDVcbwW2vZRbwlTsaou4YdkkTMgPdccxEqDs1YXBmdsdph+zJwql
 Pd7TjGfWxGLgmXGIZgivQPDIYm4WSM8blQV7LjJv6mzjqKuJJhZmAO87f5jxqIuHmumvO07FITnq
 MT3dKxLhoxcmaInYbR5vlqHMyA/lkPBbC6c0vlSRGDQGZ79loFWGs6aHjUJ9h7NVQthDlN3ZFexZ
 fYgAG9qTPTpp5PS1j/T/np9d21JHIowhxzFHIp09+LXjBI7tFUvo6Ni0le2DVmUTXV7P/TeeGAfH
 /05LUTem00Ynpr9mP7eS6czPGfhHXpvg07sfD/y5oRYyV5KHfiKBno8OsMogRnWlQ9fDAeXihC1X
 mRU9VPw70z6bhalFEM/pjPCQA+BAlngHvY0q9Gw5NOloxVW0K/tO3saCFey4hE3JznGRzrizu129
 acHYDxLXrLFZ27x/ie0MfCO+YExgoSF8M3YgxuFc9aUV1oY4fX3W5eOCNA39aaEeNVeYHTQ4qc4p
 rBw6OWxEnZ+B9jntbFMsB5h9L3Pcq6EXKX3cZxLzrCA9pYo1HvE2dZcCZBCEfYvQUHiJ0yEw/ggH
 k6NxP0mFXr1FslXeNHk15VolAGHS5rCXQKDyHv3TiDImoWFJv2x8Vhm7/dDfeKdHWm+j+q2hZS63
 ia/tIkSE0ngbX0T3LvR1Khr2Eo2bTut7ztDdNHV3VH6Kds23J7LHDHZzGBAiCeuHbrg=
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We used to have two versions of the email parsing code. Our
parse_mailboxes (in Git.pm), and Mail::Address which we used if
installed. Unfortunately, both versions have different sets of bugs, and
changing the behavior of git depending on whether Mail::Address is
installed was a bad idea.

A first attempt to solve this was cc90750 (send-email: don't use
Mail::Address, even if available, 2017-08-23), but it turns out our
parse_mailboxes is too buggy for some uses. For example the lack of
nested comments support breaks get_maintainer.pl in the Linux kernel
tree:

  https://public-inbox.org/git/20171116154814.23785-1-alex.bennee@linaro.org/

This patch goes the other way: use Mail::Address anyway, but have a
local copy from CPAN as a fallback, when the system one is not
available.

The duplicated script is small (276 lines of code) and stable in time.
Maintaining the local copy should not be an issue, and will certainly be
less burden than maintaining our own parse_mailboxes.

Another option would be to consider Mail::Address as a hard dependency,
but it's easy enough to save the trouble of extra-dependency to the end
user or packager.

Signed-off-by: Matthieu Moy <git@matthieu-moy.fr>
---
Change since v1: just reworded the commit message.

 git-send-email.perl               |   3 +-
 perl/Git/FromCPAN/Mail/Address.pm | 276 ++++++++++++++++++++++++++++++++++++++
 perl/Git/Mail/Address.pm          |  24 ++++
 3 files changed, 302 insertions(+), 1 deletion(-)
 create mode 100644 perl/Git/FromCPAN/Mail/Address.pm
 create mode 100755 perl/Git/Mail/Address.pm

diff --git a/git-send-email.perl b/git-send-email.perl
index edcc6d3..340b5c8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -30,6 +30,7 @@ use Error qw(:try);
 use Cwd qw(abs_path cwd);
 use Git;
 use Git::I18N;
+use Git::Mail::Address;
 
 Getopt::Long::Configure qw/ pass_through /;
 
@@ -489,7 +490,7 @@ my ($repoauthor, $repocommitter);
 ($repocommitter) = Git::ident_person(@repo, 'committer');
 
 sub parse_address_line {
-	return Git::parse_mailboxes($_[0]);
+	return map { $_->format } Mail::Address->parse($_[0]);
 }
 
 sub split_addrs {
diff --git a/perl/Git/FromCPAN/Mail/Address.pm b/perl/Git/FromCPAN/Mail/Address.pm
new file mode 100644
index 0000000..13b2ff7
--- /dev/null
+++ b/perl/Git/FromCPAN/Mail/Address.pm
@@ -0,0 +1,276 @@
+# Copyrights 1995-2017 by [Mark Overmeer <perl@overmeer.net>].
+#  For other contributors see ChangeLog.
+# See the manual pages for details on the licensing terms.
+# Pod stripped from pm file by OODoc 2.02.
+package Mail::Address;
+use vars '$VERSION';
+$VERSION = '2.19';
+
+use strict;
+
+use Carp;
+
+# use locale;   removed in version 1.78, because it causes taint problems
+
+sub Version { our $VERSION }
+
+
+
+# given a comment, attempt to extract a person's name
+sub _extract_name
+{   # This function can be called as method as well
+    my $self = @_ && ref $_[0] ? shift : undef;
+
+    local $_ = shift
+        or return '';
+
+    # Using encodings, too hard. See Mail::Message::Field::Full.
+    return '' if m/\=\?.*?\?\=/;
+
+    # trim whitespace
+    s/^\s+//;
+    s/\s+$//;
+    s/\s+/ /;
+
+    # Disregard numeric names (e.g. 123456.1234@compuserve.com)
+    return "" if /^[\d ]+$/;
+
+    s/^\((.*)\)$/$1/; # remove outermost parenthesis
+    s/^"(.*)"$/$1/;   # remove outer quotation marks
+    s/\(.*?\)//g;     # remove minimal embedded comments
+    s/\\//g;          # remove all escapes
+    s/^"(.*)"$/$1/;   # remove internal quotation marks
+    s/^([^\s]+) ?, ?(.*)$/$2 $1/; # reverse "Last, First M." if applicable
+    s/,.*//;
+
+    # Change casing only when the name contains only upper or only
+    # lower cased characters.
+    unless( m/[A-Z]/ && m/[a-z]/ )
+    {   # Set the case of the name to first char upper rest lower
+        s/\b(\w+)/\L\u$1/igo;  # Upcase first letter on name
+        s/\bMc(\w)/Mc\u$1/igo; # Scottish names such as 'McLeod'
+        s/\bo'(\w)/O'\u$1/igo; # Irish names such as 'O'Malley, O'Reilly'
+        s/\b(x*(ix)?v*(iv)?i*)\b/\U$1/igo; # Roman numerals, eg 'Level III Support'
+    }
+
+    # some cleanup
+    s/\[[^\]]*\]//g;
+    s/(^[\s'"]+|[\s'"]+$)//g;
+    s/\s{2,}/ /g;
+
+    $_;
+}
+
+sub _tokenise
+{   local $_ = join ',', @_;
+    my (@words,$snippet,$field);
+
+    s/\A\s+//;
+    s/[\r\n]+/ /g;
+
+    while ($_ ne '')
+    {   $field = '';
+        if(s/^\s*\(/(/ )    # (...)
+        {   my $depth = 0;
+
+     PAREN: while(s/^(\(([^\(\)\\]|\\.)*)//)
+            {   $field .= $1;
+                $depth++;
+                while(s/^(([^\(\)\\]|\\.)*\)\s*)//)
+                {   $field .= $1;
+                    last PAREN unless --$depth;
+	            $field .= $1 if s/^(([^\(\)\\]|\\.)+)//;
+                }
+            }
+
+            carp "Unmatched () '$field' '$_'"
+                if $depth;
+
+            $field =~ s/\s+\Z//;
+            push @words, $field;
+
+            next;
+        }
+
+        if( s/^("(?:[^"\\]+|\\.)*")\s*//       # "..."
+         || s/^(\[(?:[^\]\\]+|\\.)*\])\s*//    # [...]
+         || s/^([^\s()<>\@,;:\\".[\]]+)\s*//
+         || s/^([()<>\@,;:\\".[\]])\s*//
+          )
+        {   push @words, $1;
+            next;
+        }
+
+        croak "Unrecognised line: $_";
+    }
+
+    push @words, ",";
+    \@words;
+}
+
+sub _find_next
+{   my ($idx, $tokens, $len) = @_;
+
+    while($idx < $len)
+    {   my $c = $tokens->[$idx];
+        return $c if $c eq ',' || $c eq ';' || $c eq '<';
+        $idx++;
+    }
+
+    "";
+}
+
+sub _complete
+{   my ($class, $phrase, $address, $comment) = @_;
+
+    @$phrase || @$comment || @$address
+       or return undef;
+
+    my $o = $class->new(join(" ",@$phrase), join("",@$address), join(" ",@$comment));
+    @$phrase = @$address = @$comment = ();
+    $o;
+}
+
+#------------
+
+sub new(@)
+{   my $class = shift;
+    bless [@_], $class;
+}
+
+
+sub parse(@)
+{   my $class = shift;
+    my @line  = grep {defined} @_;
+    my $line  = join '', @line;
+
+    my (@phrase, @comment, @address, @objs);
+    my ($depth, $idx) = (0, 0);
+
+    my $tokens  = _tokenise @line;
+    my $len     = @$tokens;
+    my $next    = _find_next $idx, $tokens, $len;
+
+    local $_;
+    for(my $idx = 0; $idx < $len; $idx++)
+    {   $_ = $tokens->[$idx];
+
+        if(substr($_,0,1) eq '(') { push @comment, $_ }
+        elsif($_ eq '<')    { $depth++ }
+        elsif($_ eq '>')    { $depth-- if $depth }
+        elsif($_ eq ',' || $_ eq ';')
+        {   warn "Unmatched '<>' in $line" if $depth;
+            my $o = $class->_complete(\@phrase, \@address, \@comment);
+            push @objs, $o if defined $o;
+            $depth = 0;
+            $next = _find_next $idx+1, $tokens, $len;
+        }
+        elsif($depth)       { push @address, $_ }
+        elsif($next eq '<') { push @phrase,  $_ }
+        elsif( /^[.\@:;]$/ || !@address || $address[-1] =~ /^[.\@:;]$/ )
+        {   push @address, $_ }
+        else
+        {   warn "Unmatched '<>' in $line" if $depth;
+            my $o = $class->_complete(\@phrase, \@address, \@comment);
+            push @objs, $o if defined $o;
+            $depth = 0;
+            push @address, $_;
+        }
+    }
+    @objs;
+}
+
+#------------
+
+sub phrase  { shift->set_or_get(0, @_) }
+sub address { shift->set_or_get(1, @_) }
+sub comment { shift->set_or_get(2, @_) }
+
+sub set_or_get($)
+{   my ($self, $i) = (shift, shift);
+    @_ or return $self->[$i];
+
+    my $val = $self->[$i];
+    $self->[$i] = shift if @_;
+    $val;
+}
+
+
+my $atext = '[\-\w !#$%&\'*+/=?^`{|}~]';
+sub format
+{   my @addrs;
+
+    foreach (@_)
+    {   my ($phrase, $email, $comment) = @$_;
+        my @addr;
+
+        if(defined $phrase && length $phrase)
+        {   push @addr
+              , $phrase =~ /^(?:\s*$atext\s*)+$/o ? $phrase
+              : $phrase =~ /(?<!\\)"/             ? $phrase
+              :                                    qq("$phrase");
+
+            push @addr, "<$email>"
+                if defined $email && length $email;
+        }
+        elsif(defined $email && length $email)
+        {   push @addr, $email;
+        }
+
+        if(defined $comment && $comment =~ /\S/)
+        {   $comment =~ s/^\s*\(?/(/;
+            $comment =~ s/\)?\s*$/)/;
+        }
+
+        push @addr, $comment
+            if defined $comment && length $comment;
+
+        push @addrs, join(" ", @addr)
+            if @addr;
+    }
+
+    join ", ", @addrs;
+}
+
+#------------
+
+sub name
+{   my $self   = shift;
+    my $phrase = $self->phrase;
+    my $addr   = $self->address;
+
+    $phrase    = $self->comment
+        unless defined $phrase && length $phrase;
+
+    my $name   = $self->_extract_name($phrase);
+
+    # first.last@domain address
+    if($name eq '' && $addr =~ /([^\%\.\@_]+([\._][^\%\.\@_]+)+)[\@\%]/)
+    {   ($name  = $1) =~ s/[\._]+/ /g;
+	$name   = _extract_name $name;
+    }
+
+    if($name eq '' && $addr =~ m#/g=#i)    # X400 style address
+    {   my ($f) = $addr =~ m#g=([^/]*)#i;
+	my ($l) = $addr =~ m#s=([^/]*)#i;
+	$name   = _extract_name "$f $l";
+    }
+
+    length $name ? $name : undef;
+}
+
+
+sub host
+{   my $addr = shift->address || '';
+    my $i    = rindex $addr, '@';
+    $i >= 0 ? substr($addr, $i+1) : undef;
+}
+
+
+sub user
+{   my $addr = shift->address || '';
+    my $i    = rindex $addr, '@';
+    $i >= 0 ? substr($addr,0,$i) : $addr;
+}
+
+1;
diff --git a/perl/Git/Mail/Address.pm b/perl/Git/Mail/Address.pm
new file mode 100755
index 0000000..2ce3e84
--- /dev/null
+++ b/perl/Git/Mail/Address.pm
@@ -0,0 +1,24 @@
+package Git::Mail::Address;
+use 5.008;
+use strict;
+use warnings;
+
+=head1 NAME
+
+Git::Mail::Address - Wrapper for the L<Mail::Address> module, in case it's not installed
+
+=head1 DESCRIPTION
+
+This module is only intended to be used for code shipping in the
+C<git.git> repository. Use it for anything else at your peril!
+
+=cut
+
+eval {
+    require Mail::Address;
+    1;
+} or do {
+    require Git::FromCPAN::Mail::Address;
+};
+
+1;
-- 
2.7.4

