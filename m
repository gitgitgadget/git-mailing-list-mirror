From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #03; Wed, 24)
Date: Fri, 3 Dec 2010 15:12:44 +0100
Message-ID: <201012031512.45793.jnareb@gmail.com>
References: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org> <201012031402.49169.jnareb@gmail.com> <201012031406.55854.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Dec 03 15:13:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POWNk-0002Xh-Pn
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 15:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758143Ab0LCOM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 09:12:59 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46175 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006Ab0LCOM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 09:12:58 -0500
Received: by bwz15 with SMTP id 15so8362012bwz.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 06:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=epXGLvzHahWA9xfA2W6mN2zKKAM632lNuiHWXOBGM2g=;
        b=dsqLtcKomf5/Z1QudbMNt9h1n5i1qJptBo8ppZ17AM997L4VjD7Er0RzXO/Df26/CR
         s7X6qVizIxdDDpI2spmEApob3USLLFg14fW1Tct3yPUsjOHhM3n75f0z8ziYCFxGLsl5
         vHfcz5BRlriOo6XXO7TN5Lg9bbrGxcFCRowig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QIB4lX1c7LclOIOR5RO+jkh0RNL/tOCCLeRGdXYqL7VhXRNFnCFBbZNWnx6u6TKdIK
         h/1EGsZXh9oRTD2hhLDhJ+bB1ZLYEmwP48f8gPbDV652JS1gnouIxbOqnzpjuUEUrsji
         FY2RUWoVZrvTneYca+qGOv8E5szBlfuOYmjlQ=
Received: by 10.204.114.77 with SMTP id d13mr2425432bkq.150.1291385577128;
        Fri, 03 Dec 2010 06:12:57 -0800 (PST)
Received: from [192.168.1.13] (abrz239.neoplus.adsl.tpnet.pl [83.8.119.239])
        by mx.google.com with ESMTPS id 11sm914693bkj.0.2010.12.03.06.12.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 06:12:55 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201012031406.55854.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162800>

On Fri, 3 Dec 2010, Thomas Rast wrote:
> Jakub Narebski wrote:
> > Could you add 'exit' just after second test in 
> > t/t9502-gitweb-standalone-parse-output.sh test script, or running it
> > with `--immediate' option, and show us the results (after 'cd t') of
> > 
> >   $ file "trash directory.t9502-gitweb-standalone-parse-output/gitweb.body"
> >   should be:
> > 
> >     trash directory.t9502-gitweb-standalone-parse-output/gitweb.body: tar archive
> 
> Well, you're onto something...
> 
>   trash directory.t9502-gitweb-standalone-parse-output$ file *
>   file_list:          empty
>   foo:                ASCII text
>   gitweb.body:        empty
>   gitweb_config.perl: perl script text executable
>   gitweb.headers:     ASCII text, with CRLF line terminators
>   gitweb.log:         empty
>   gitweb.output:      ASCII text, with CRLF line terminators
>   GLOB(0xdf18fc0):    tar archive
> 
> Huh.  Seems something got confused about what to use as a filename?

Hmmm... let me examine 17b15d4 (gitweb: File based caching layer
(from git.kernel.org), 2010-11-01)

Ah, I see.  It looks like I forgot to update git_blob_plain and 
git_snapshot when I was modifying original patch by J.H. (which didn't
pass test suite for other reasons) to have test for $caching_enabled
outside cache_fetch().

Could you try if the following patch applied on top of 17b15d4 fixes
it for you?  If it does, I'll resend fixed series (yet again, I'm sorry
Junio).

It is not most elegant solution.


Sidenote: 

  open BINOUT, '>', \$fullhashbinpath

should open in-memory file, and not be equivalent to

  open BINOUT, '>', "\$fullhashbinpath"

Hmmm... in the case of !$caching_enabled, $fullhasbinpath is *STDOUT.


BTW replacing 

  open BINOUT, '>', \$fullhashbinpath

with

  open BINOUT, '>&STDOUT'

or

  open BINOUT, '>&', \$fullhashbinpath

could be simpler, alternate solution.

-- 8< -- 8< --
diff --git i/gitweb/gitweb.perl w/gitweb/gitweb.perl
index abaeec6..3d787c1 100755
--- i/gitweb/gitweb.perl
+++ w/gitweb/gitweb.perl
@@ -5648,13 +5648,14 @@ sub git_blob_plain {
 	local $/ = undef;
 	if ($caching_enabled) {
 		open BINOUT, '>', $fullhashbinpath or die_error(500, "Could not open bin dump file");
-	}else{
-		open BINOUT, '>', \$fullhashbinpath or die_error(500, "Could not open bin dump file");
+		binmode BINOUT, ':raw';
+		print BINOUT <$fd>;
+		close BINOUT;
+	} else {
+		binmode STDOUT, ':raw';
+		print <$fd>;
+		binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
 	}
-	binmode BINOUT, ':raw';
-	print BINOUT <$fd>;
-	binmode BINOUT, ':utf8'; # as set at the beginning of gitweb.cgi
-	close BINOUT;
 	close $fd;
 }
 
@@ -5941,13 +5942,14 @@ sub git_snapshot {
 		or die_error(500, "Execute git-archive failed");
 	if ($caching_enabled) {
 		open BINOUT, '>', $fullhashbinpath or die_error(500, "Could not open bin dump file");
-	}else{
-		open BINOUT, '>', \$fullhashbinpath or die_error(500, "Could not open bin dump file");
+		binmode BINOUT, ':raw';
+		print BINOUT <$fd>;
+		close BINOUT;
+	} else {
+		binmode STDOUT, ':raw';
+		print <$fd>;
+		binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
 	}
-	binmode BINOUT, ':raw';
-	print BINOUT <$fd>;
-	binmode BINOUT, ':utf8'; # as set at the beginning of gitweb.cgi
-	close BINOUT;
 	close $fd;
 }
 

-- >8 -- >8 -- 
-- 
Jakub Narebski
Poland
