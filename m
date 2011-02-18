From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Thu, 17 Feb 2011 20:27:01 -0600
Message-ID: <20110218022701.GA23435@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 03:27:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqG3y-0005tJ-TJ
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 03:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010Ab1BRC1N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Feb 2011 21:27:13 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54284 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab1BRC1M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 21:27:12 -0500
Received: by qwd7 with SMTP id 7so18037qwd.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 18:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jw09CBWQMynETFMwATRHl5CArfMCZQIYT+5343GNrGE=;
        b=XR15MZ2jECTczB0uG/ITasyH2ra6NS+VBtW2YszYkLu82YFadhaR5PcLZHRR9xIE9P
         7tOoSSFUh+NYlFHYTsgVLVfM/ayG5mM6mp7+Ft2RcEMbNEUFpZTeQysy0ALFFrsxJOBj
         ugfr8J8wExZs82mjwOHQQe+ZzSN8NIpBzdGJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=c7YsG5K/nyqWCMm0lS7VVwdEVeSOhBJVxDaCEk5ySVqK7uTVMMMCmb2KM2LSQ6Km6P
         kAV2M7GxcZQcMHW46TMiPvaORZ9D/prBISdU1Fg4veWg5ktQ8oVuV4N8uFeuHaViUA/h
         bGQ2QNwM4ATPo3KZOH6eym72eaDHO7sMOIoN4=
Received: by 10.224.73.205 with SMTP id r13mr113514qaj.368.1297996031304;
        Thu, 17 Feb 2011 18:27:11 -0800 (PST)
Received: from elie (adsl-69-209-72-148.dsl.chcgil.sbcglobal.net [69.209.72.148])
        by mx.google.com with ESMTPS id h20sm1201257qck.12.2011.02.17.18.27.05
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 18:27:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297304069-14764-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167154>

Hi,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

>  .gitignore                                         |   19 ----------=
--
>  Makefile                                           |   30 ++++++++++=
----------
>  t/helper/.gitignore                                |   19 ++++++++++=
++
[...]
>  24 files changed, 38 insertions(+), 38 deletions(-)

Here's a variation on the theme that just moves source and .o files
(leaving questions about how to cope with breaking muscle memory for
the resulting executables for later).  What do you think?

Patch 1 moves the sources for libgit.a to a subdirectory.  This seems
appealing anyway, to encourage people to start thinking about how to
make it into a standalone and reusable library.

Patch 2 moves source for test programs like test-sha1 to a subdirectory=
=2E

Patch 3 dumps header files into an include/ subdirectory.  I'm not
thrilled with it but it does make the toplevel directory listing
shorter.

After this series:

 $ ls | wc -l
 86

which fits nicely on a 113x31 terminal (but certainly not an 80x24
one).

The change descriptions need work.  Help would be appreciated.

Thoughts?
Jonathan Nieder (3):
  Move libgit.a sources into a libgit/ subdirectory
  Move test-* into a test-programs/ subdirectory
  Move header files into a include/ subdirectory

 Makefile                                           |  418 ++++++++++--=
--------
 [plus a bunch of renames]
 208 files changed, 212 insertions(+), 206 deletions(-)
