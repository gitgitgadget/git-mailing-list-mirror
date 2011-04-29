From: Guy Rouillier <guyr@burntmail.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Fri, 29 Apr 2011 00:27:00 -0400
Message-ID: <4DBA3E14.7090602@burntmail.com>
References: <4D0ED5EC.9020402@burntmail.com> <4D119015.6020207@burntmail.com> <4D2AB63D.7040803@burntmail.com> <AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com> <4D2FEF49.8070205@burntmail.com> <20110114074449.GA11175@burratino> <7v8vynnokt.fsf@alter.siamese.dyndns.org> <4D450655.5090501@burntmail.com> <AANLkTik0Mp=Ww_+ZN_jw6t4gsFwLo1UTw5JOpho8bCd=@mail.gmail.com> <7vhbcb35xk.fsf@alter.siamese.dyndns.org> <4D5E1116.7040501@burntmail.com> <7voc69p4xu.fsf@alter.siamese.dyndns.org> <4D5F6E97.4000402@burntmail.com> <7vy65bkw72.fsf@alter.siamese.dyndns.org> <4D61EA4B.3020708@burntmail.com> <7vtyfxgdz2.fsf@alter.siamese.dyndns.org> <7vipwbbrcc.fsf@alter.siamese.dyndns.org> <AANLkTinUtUNGO3NK=JPTqnwcTtPMYjmLw82wJZ5nC -32@mail.gmail.com> <4D644FEE.5030004@burntmail.com> <7vaahnbmu2.fs
 f@alter.siamese.dyndns.org> <4D69DF29.8030701@burntmail.com> <7vvd056fyk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin@laptop.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pa
X-From: git-owner@vger.kernel.org Fri Apr 29 06:57:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFflz-00063N-2i
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 06:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309Ab1D2E5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 00:57:41 -0400
Received: from mx02.burntmail.com ([70.87.63.122]:41048 "EHLO
	mx02.burntmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024Ab1D2E5k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 00:57:40 -0400
X-Greylist: delayed 1783 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Apr 2011 00:57:39 EDT
Received: from [108.18.101.175] (helo=[192.168.1.60])
	by mx02.burntmail.com with esmtpa (Exim 4.72)
	(envelope-from <guyr@burntmail.com>)
	id 1QFfIM-0006fr-DU; Thu, 28 Apr 2011 23:27:10 -0500
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <7vvd056fyk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172424>

On 2/27/2011 3:26 AM, Junio C Hamano wrote:
> Guy Rouillier<guyr@burntmail.com>  writes:
>
>> As I suspected after reading how the cvspass file is read and written,
>> CVSNT doesn't work with repositories with an equal sign in the
>> repository name.  You can init it fine, and you can set up a password
>> for it.  But if you try to login things go very wrong:
>> ...
>> Since CVSNT can't handle a repository with an equal sign in its name,
>> I say we don't worry about this.  I say the same about the original
>> CVS with a repository name with embedded spaces.  We certainly don't
>> want to try to solve problems the original product doesn't solve.
>
> Thanks; your observation matches my earlier suspicion.  So in short:
>
>   - CVSNT does not work with repository path with an '=' in it, but does work
>     with ones with a SP in it; and
>
>   - CVS has trouble with repository path with a SP in it, but works with
>     ones with an '=' in it just fine.
>
> Have I summarized it correctly?
>
> So I agree that cvsimport should not worry about supporting repository
> path with an '=' in it, but we do need to make sure we work with one with
> a SP in it, when we are reading from cvspass file for CVSNT.
>
> Similarly when we are reading from cvspass file for CVS, we should make
> sure we don't break with repository path with an '=' in it.
>
> Do we already have such a solution in the thread?  Can somebody conclude
> the discussion with a final, tested and applyable patch, please?

I've integrated the untested version you submitted several iterations ago,
and tested it with CVSNT.  Unfortunately, I don't have a CVS repo to test
with, so if anyone else watching this thread has access to CVS, it would
be good if they can test with CVS.  Here is my hopefully final revision.

Note that I've left this test in, although I still think it is a bad idea:

   elsif (!$pass) {
      $pass = "A";
   }

I looked back at the revisions around 9/17/2009.  That revision puts
this test back in because two revisions earlier on 8/14/2009 took it out.
But that doesn't explain why it was put in there in the first
place.  I still say a better idea, if we don't want to allow an empty
password, is to error out rather than silently set a bogus password.

---
From bea4854fca07ff3a7034a04ad2f163701f9f581c Mon Sep 17 00:00:00 2001
From: Guy Rouillier <guyr@burntmail.com>
Date: Fri, 29 Apr 2011 00:01:52 -0400
Subject: [PATCH] Look for password in both CVS and CVSNT password files.

In conn, if password is not passed on command line, look for a password
entry in both the CVS password file and the CVSNT password file.  If only
one file is found and the requested repository is in that file, or if both
files are found but the requested repository is found in only one file, use
the password from the single file containing the repository entry.  If both
files are found and the requested repository is found in both files, then
produce an error message.

The CVS password file separates tokens with a space character, while
the CVSNT password file separates tokens with an equal (=) character.
Add a sub find_password_entry that accepts the password file name
and a delimiter to eliminate code duplication.
---
 git-cvsimport.perl |   52 ++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index bbf327f..abf5759 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -227,6 +227,30 @@ sub new {
 	return $self;
 }

+sub find_password_entry {
+	my ($cvspass, @cvsroot) = @_;
+	my ($file, $delim) = @$cvspass;
+	my $pass;
+	local ($_);
+
+	if (open(my $fh, $file)) {
+		# :pserver:cvs@mea.tmt.tele.fi:/cvsroot/zmailer Ah<Z
+		while (<$fh>) {
+			chomp;
+			s/^\/\d+\s+//;
+			my ($w, $p) = split($delim,$_,2);
+			for my $cvsroot (@cvsroot) {
+				if ($w eq $cvsroot) {
+					$pass = $p;
+					last;
+				}
+			}
+		}
+		close($fh);
+	}
+	return $pass;
+}
+
 sub conn {
 	my $self = shift;
 	my $repo = $self->{'fullrep'};
@@ -259,19 +283,23 @@ sub conn {
 		if ($pass) {
 			$pass = $self->_scramble($pass);
 		} else {
-			open(H,$ENV{'HOME'}."/.cvspass") and do {
-				# :pserver:cvs@mea.tmt.tele.fi:/cvsroot/zmailer Ah<Z
-				while (<H>) {
-					chomp;
-					s/^\/\d+\s+//;
-					my ($w,$p) = split(/\s/,$_,2);
-					if ($w eq $rr or $w eq $rr2) {
-						$pass = $p;
-						last;
-					}
+			my @cvspass = ([$ENV{'HOME'}."/.cvspass", qr/\s/],
+				       [$ENV{'HOME'}."/.cvs/cvspass", qr/=/]);
+			my @loc = ();
+			foreach my $cvspass (@cvspass) {
+				my $p = find_password_entry($cvspass, $rr, $rr2);
+				if ($p) {
+					push @loc, $cvspass->[0];
+					$pass = $p;
 				}
-			};
-			$pass = "A" unless $pass;
+			}
+
+			if (1 < @loc) {
+				die("More than one cvs password files have ".
+				    "entries for CVSROOT $opt_d: @loc");
+			} elsif (!$pass) {
+				$pass = "A";
+			}		
 		}

 		my ($s, $rep);
--
1.7.4.rc1.5.ge17aa

-- 
Guy Rouillier
