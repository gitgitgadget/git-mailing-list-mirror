From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/5] gitweb: Some code cleanups (up to perlcritic --stern)
Date: Sun, 10 May 2009 02:03:50 +0200
Message-ID: <200905100203.51744.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Bill Pemberton <wfp5p@virginia.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 02:42:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2x7O-0005rl-2j
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 02:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244AbZEJAly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 20:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754409AbZEJAlx
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 20:41:53 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:35126 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbZEJAlw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 20:41:52 -0400
Received: by ewy24 with SMTP id 24so2659310ewy.37
        for <git@vger.kernel.org>; Sat, 09 May 2009 17:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=O1IU5rNYSo7SffW5ZILhjP+Oi6UbvFPN26gpz0enB9Y=;
        b=DQxgk4YisYawvH3NsVs5o9v80c4lwVCiSnp0/7DQi4HD+2wJMp0lOeQCf6ySXhayq0
         v+1CjmN9Sz7g+kzQfA4FcvM8I49Cfut1JyDOggcvOFURg2ssXudbU5No92oawdrKKkre
         mi2gRYrVi3pXpyXRKV14XpkJSXmla+u1dCL70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=UX3PC7TA6wo/GDv9A1XE+08LFw1zFqcGyDX/0c83MqPyAPS5qqEtHF0gRy6E4GcOoI
         0Kcp7OGvZpYZBUSGX+R4/oIE4Ngsh5Xc8GmvEz+RUWGtxLX/qYZd6QaePO/jo2H6NllH
         ISOo3ysacc9fJwTb4biCRNAQ+TquUwdx8EjOU=
Received: by 10.210.63.2 with SMTP id l2mr3148313eba.10.1241916111299;
        Sat, 09 May 2009 17:41:51 -0700 (PDT)
Received: from ?192.168.1.13? (abvf146.neoplus.adsl.tpnet.pl [83.8.203.146])
        by mx.google.com with ESMTPS id 7sm4827142eyb.25.2009.05.09.17.41.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 May 2009 17:41:50 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118690>

The following series consist of some code cleanups for gitweb.perl.
They're based on suggestions by perlcritic (Perl::Critic).  Most
policy modules are in turn based on Damian Conway's book "Perl Best
Practices" (PBP).

This series was inspired by similar series of patches for git-send-email by
Bill Pemberton:
  Subject: [PATCH 0/6] cleanups for git-send-email
  Msg-Id: <1241010743-7020-1-git-send-email-wfp5p@virginia.edu>
  URL: http://thread.gmane.org/gmane.comp.version-control.git/117881

Not all suggestions by perlcritic were implemented (or, to be more
exact, by its online version at http://perlcritic.com, which is
running Perl-Critic version 1.096).

Below there is list of perlcritic suggestions, sorted by severity
(gentle, stern, harsh, cruel, brutal): first list of patches in series
which applied perlcritic suggestions, then suggestions not applied,
with short explanation why they were not used.

This series deals with suggestion with severity level >= 4 (gentle and
stern suggestions); perlcritic suggestions with severity level >= 3
(harsh) are in the works - but there are many more rules, and they are
also more subjective.


Shortlog (part 1/2):
=================
Jakub Narebski (3):
  gitweb: Remove function prototypes
  gitweb: Do not use bareword filehandles
  gitweb: Always use three argument form of open

All of those are for severity gentle (5).  The following policies
(suggestions) with severity 5 were not implemented:

* Perl::Critic::Policy::ValuesAndExpressions::ProhibitLeadingZeros
  Write 'oct(755)' instead of '0755'.

  We know what we are doing here; besides above Perl::Critic policy
  has exceptions for chmod, mkdir, sysopen, umask, and we use octal
  numbers for filemode.

* Perl::Critic::Policy::Subroutines::ProhibitExplicitReturnUndef
  Return failure with bare 'return' instead of 'return undef'.

  First, this is a matter of taste; second, this would require more
  detailed review. So it is left as it is... for now.

* Perl::Critic::Policy::Subroutines::ProhibitNestedSubs
  Declaring a named sub inside another named sub does not prevent
  the inner sub from being global.

  This is more about possibility of mismatched expectations.


Shortlog (part 2/2):
=================
Jakub Narebski (1):
  gitweb: Localize magic variable $/
  gitweb: Use block form of map/grep in a few cases more

All of those are for severity stern (4).  The following policies
(suggestions) with severity 4 were not implemented:

* Perl::Critic::Policy::Subroutines::RequireArgUnpacking
  Always unpack @_ first.

  This requires careful handling (wrapper functions are exception of
  this policy, but the tool does not detect it), and in most cases
  this is the matter of the following techique:
     my $a = shift;
     my ($b, $c) = @_;
  which could be improved.

* Perl::Critic::Policy::Subroutines::RequireFinalReturn
  End every path through a subroutine with an explicit return statement.

  This is I think the matter of taste; note that this policy is not to
  be followed blindly, according to documentation. I think that all
  functions that do not return would be procedures (void as return
  type) in C.

* Perl::Critic::Policy::ValuesAndExpressions::ProhibitConstantPragma
  Don't use 'constant FOO => 15', because it doesn't interpolate, but
  the Readonly module.

  The constants S_IFINVALID and S_IFGITLINK we declare follow naming
  of filemode constants S_IFMT and S_IXUSR from Fcntl module we use in
  our code.

* Perl::Critic::Policy::InputOutput::RequireBriefOpen
  Close filehandles as soon as possible after opening them
  (because fFilehandles are a finite resource).
  
  In gitweb we use very small number of filehandles concurrently;
  usually only one filehandle is open.  On the other hand for bigger
  output we try to stream it.

* Perl::Critic::Policy::ValuesAndExpressions::ProhibitMixedBooleanOperators
  Don't mix high- and low-precedence booleans.

  The code in question is list form of magic "-|" open ... or die ...,
  where one of arguments uses '||' to set default value.  This is
  intended, and not that cryptic.


Diffstat:
=========
 gitweb/gitweb.perl |   72 ++++++++++++++++++++++++++--------------------------
 1 files changed, 36 insertions(+), 36 deletions(-)

-- 
Jakub Narebski
ShadeHawk on #git
