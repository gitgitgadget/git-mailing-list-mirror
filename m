From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/5] gitweb: Use block form of map/grep in a few cases more
Date: Sun, 10 May 2009 02:40:37 +0200
Message-ID: <200905100240.37772.jnareb@gmail.com>
References: <200905100203.51744.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 02:42:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2x7Q-0005rl-Gm
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 02:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451AbZEJAmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 20:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754842AbZEJAmB
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 20:42:01 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:53967 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755313AbZEJAlz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 20:41:55 -0400
Received: by mail-ew0-f176.google.com with SMTP id 24so2659316ewy.37
        for <git@vger.kernel.org>; Sat, 09 May 2009 17:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Mg9vPspvAHufTSyUoA4u5MoPPbcrPLR++f+ya5MK4Bc=;
        b=xl7gAlaVbU826otRLhqC/ZblhBeiBfRyUC26O24F9FwZceuICkUeR3CdyRrGWUsaps
         /SmrP2+ggF/1oGDxATjiYBEUnw5j1c86SKSZW4Ghp97T2MgC9pPxb984lR/pZUPyqGIh
         1Z+7QeVGJVOH4HKEJZY2yeaLcBFjF9D+bx2zU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=VawbffHhbgh12rRtXPrRv4wbg0VZtQ/GQD2GC5zOT11DD8orIkNRu/dRkDph/Shmk2
         3UWoOb14Vi0GQkwCzdweXr75sVra4SFSWHyGxHcG4xwnkRJdNFqD/tV2cSrGu0SIswwB
         ZjisxgldoSCebWI+2cjxvavlqBwJddscYJxUk=
Received: by 10.210.86.10 with SMTP id j10mr6884142ebb.1.1241916116103;
        Sat, 09 May 2009 17:41:56 -0700 (PDT)
Received: from ?192.168.1.13? (abvf146.neoplus.adsl.tpnet.pl [83.8.203.146])
        by mx.google.com with ESMTPS id 7sm4827142eyb.25.2009.05.09.17.41.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 May 2009 17:41:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200905100203.51744.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118691>

Use block form of 'grep' i.e. 'grep {BLOCK} LIST' rather than
'grep(EXPR, LIST)' in filter_snapshot_fmts subroutine.  This makes
code more readable, as expression is rather long, and statement above
there is 'map' with very similar expression also in the block form.

Remove unnecessary and misleading parentheses around block form 'map'
arguments in quote_command subroutine.

The inner "map" in format_snapshot_links was left alone, as it is not
clear whether adding parentheses or changing it into block form would
improve readibility and clarity of this code.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Perl::Critic::Policy::BuiltinFunctions::RequireBlockGrep

  Write grep { $_ =~ /$pattern/ } @list instead of grep /$pattern/, @list.

  The expression forms of grep and map are awkward and hard to read. Use the
  block forms instead.

See also Damian Conway's book "Perl Best Practices", section
8.13. Mapping and Grepping (Always use a block with a map and grep.)

NOTE: In my opinion the expression form when using function-like call to
"grep" or "map" e.g. grep(/$pattern/, @list) is readable enough.  In more
complicated cases (with more complicated expressions, especially with
explicit $_) it might be better to use block form instead, as stated above.

And what do *you* think?

 gitweb/gitweb.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1cb3a4f..f465666 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -458,8 +458,8 @@ sub filter_snapshot_fmts {
 	@fmts = map {
 		exists $known_snapshot_format_aliases{$_} ?
 		       $known_snapshot_format_aliases{$_} : $_} @fmts;
-	@fmts = grep(exists $known_snapshot_formats{$_}, @fmts);
-
+	@fmts = grep {
+		exists $known_snapshot_formats{$_} } @fmts;
 }
 
 our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
@@ -1838,7 +1838,7 @@ sub git_cmd {
 # Try to avoid using this function wherever possible.
 sub quote_command {
 	return join(' ',
-		    map( { my $a = $_; $a =~ s/(['!])/'\\$1'/g; "'$a'" } @_ ));
+		map { my $a = $_; $a =~ s/(['!])/'\\$1'/g; "'$a'" } @_ );
 }
 
 # get HEAD ref of given project as hash
-- 
1.6.3
