From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH] Git.pm: discourage casual use
Date: Thu, 2 Dec 2010 13:05:46 -0600
Message-ID: <20101202190546.GI3962@burratino>
References: <20101202114003.GA26070@raven.wolf.lan>
 <AANLkTi=8=k9iNWzTnGz821k9A_CZNiEt_KkC8TXu6oS_@mail.gmail.com>
 <7vpqtkrrtc.fsf@alter.siamese.dyndns.org>
 <AANLkTikQdw3aafsfP+SCQ-z9_TZrPJx694QOSeNTrvp6@mail.gmail.com>
 <20101202181425.GG3962@burratino>
 <AANLkTimKKssBbtuLKCqG9WGbOe+-CH4pc5PDaNxCH_PS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 20:06:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POETi-0001mb-Iw
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 20:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758010Ab0LBTF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 14:05:59 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39685 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757726Ab0LBTF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 14:05:58 -0500
Received: by ewy5 with SMTP id 5so4536953ewy.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 11:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=q8YFbpeEh4wSctk1FuvZ0Z46JlHMMfLO+NzWiQPN6F0=;
        b=nIJQK1s+mN28iLaP2yOoNKWNTun9MDBgWBE2IWG51OLMsGtNC+DcGykqu3YrIE/bm5
         G+6Ld/tDk/eMxJYSuRcyICPJjeFbp+hreKyW9kvrDzVXDVgDPFmlVs2R7SrWZd4BjqaU
         fvujfGkOMAeOO948pw+n9Q+YTe/zYNW32obvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Mr1Hdlu+YS/fzccsApSG+01XRot8R2Hj9i08DnaNJspFTx8WkMFbZYqDk9nz78yIge
         CAOFmHqk8lMvKf2/vmzOfWVdF0qmm3J65lsU3PY1Y8fSUC7DDnsXoNJIGsOm6JQATGDV
         uZff9Ovsk5+67lWcPvTs9/xSNfljaR5ts8yZ4=
Received: by 10.216.15.20 with SMTP id e20mr631147wee.8.1291316757139;
        Thu, 02 Dec 2010 11:05:57 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id w29sm447026weq.19.2010.12.02.11.05.55
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 11:05:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimKKssBbtuLKCqG9WGbOe+-CH4pc5PDaNxCH_PS@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162734>

Git's internal perl interface still does not have a stable API, and
meanwhile CPAN has a number of modules to fulfill the need for a perl
git interface.  The line

	# Totally unstable API.
	$VERSION = '0.01';

in the source makes this clear enough, but users who just looked at
git-svn.perl and then tried "perldoc Git" would not notice.  Add a
note to the manual to warn the reader.

Inspired-by: Yves Orton <demerphq@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
demerphq wrote:

> And well the line:
> 
> # Totally unstable API.
> $VERSION = '0.01';
> 
> STRONGLY suggests that the module should not be used by code outside
> the Git package itself.

So how about something like this patch, to start?

diff --git a/perl/Git.pm b/perl/Git.pm
index 6cb0dd1..7f6c500 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -63,12 +63,16 @@ require Exporter;
 
 =head1 DESCRIPTION
 
-This module provides Perl scripts easy way to interface the Git version control
-system. The modules have an easy and well-tested way to call arbitrary Git
+This module provides an easy way to interact with the Git version control
+system for Git's internal perl scripts.
+The modules have an easy and well-tested way to call arbitrary Git
 commands; in the future, the interface will also provide specialized methods
 for doing easily operations which are not totally trivial to do over
 the generic command interface.
 
+Note: this module should not be used by code outside the Git package itself,
+since the API is not stable yet.
+
 While some commands can be executed outside of any context (e.g. 'version'
 or 'init'), most operations require a repository context, which in practice
 means getting an instance of the Git object using the repository() constructor.
