From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] tests: Test how well "git apply" copes with weird
 filenames
Date: Sat, 24 Jul 2010 03:48:48 -0500
Message-ID: <20100724084847.GB7150@burratino>
References: <20100724010618.GA13670@burratino>
 <20100724011114.GC13670@burratino>
 <m2r5iti9w0.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
	Giuseppe Iuculano <iuculano@debian.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Jul 24 10:49:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcaQd-00023d-Tv
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 10:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280Ab0GXItv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 04:49:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51233 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab0GXItt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 04:49:49 -0400
Received: by iwn7 with SMTP id 7so1016798iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 01:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=a1RYQBpDV+6p8GEXxVpqBAZS7ESoG2HnpAXxwG7EsNg=;
        b=FoJcpq4brT2cdt17SQFyRUu97y/86ddyGKYfBFUSGhxw6p/T79NE0+2HHVXlTMWDyZ
         RnnIxSeC7T+8JqKSKzoONu+fe5CqOFJziLVj9+bIuGUk3BRnWzMR4Rejlj0yiqG+wjHZ
         xkdvN8W3n4KrZpJBLYVXFHlcC8KNCrS5bBGuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ZUlJa9nIjADwhglkRNw+0Gg5L48zuTjInJHSCtTys6AOM/4emCbaBUgWAZwXGE0bd9
         DdxJMXaC+yZVic+8QYfzamjVvUolAO4akB+BJ+LrXZEJW2XBNoLfC71Yst6Ih/CDqbWs
         zigx+62XyDSrnXP5w3Ggig1mAhVFPLGPXkew0=
Received: by 10.231.17.137 with SMTP id s9mr5033717iba.163.1279961389039;
        Sat, 24 Jul 2010 01:49:49 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r3sm1140663ibk.7.2010.07.24.01.49.48
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 01:49:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m2r5iti9w0.fsf@igel.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151608>

Andreas Schwab wrote:

> pr -T is not portable.  What's wrong with expand?

Nothing at all.  Here=E2=80=99s a patch for squashing in.

-- 8< --
Subject: t4135 (apply): use expand instead of pr for portability

expand is just the thing for expanding tabs into spaces, and
unlike pr -T, it is portable.  Use it.

Noticed-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thank you. :)

 t/t4135-apply-weird-filenames.sh |   17 ++---------------
 1 files changed, 2 insertions(+), 15 deletions(-)

diff --git i/t/t4135-apply-weird-filenames.sh w/t/t4135-apply-weird-fil=
enames.sh
index 2dcb040..dda554e 100755
--- i/t/t4135-apply-weird-filenames.sh
+++ w/t/t4135-apply-weird-filenames.sh
@@ -34,15 +34,6 @@ test_expect_success 'setup: test prerequisites' '
 	if diff -pruN 1 2
 	then
 		test_set_prereq FULLDIFF
-	fi &&
-
-	echo "tab ->  ." >expected &&
-	echo "tab ->	." >with-tab &&
-
-	pr -tT -e8 with-tab >actual &&
-	if test_cmp expected actual
-	then
-		test_set_prereq PR
 	fi
 '
=20
@@ -99,16 +90,12 @@ try_filename 'with tab'         'post	image.txt' su=
ccess failure failure
 try_filename 'with backslash'   'post\image.txt'
 try_filename 'with quote'       '"postimage".txt' success failure succ=
ess
=20
-if test_have_prereq FULLDIFF && test_have_prereq PR
-then
-	test_set_prereq FULLDIFFPR
-fi
-test_expect_success FULLDIFFPR 'whitespace-damaged traditional patch' =
'
+test_expect_success FULLDIFF 'whitespace-damaged traditional patch' '
 	reset_preimage &&
 	reset_subdirs &&
 	echo postimage >b/postimage.txt &&
 	! diff -pruN a b >diff-plain.txt &&
-	pr -tT -e8 diff-plain.txt >damaged.diff &&
+	expand diff-plain.txt >damaged.diff &&
=20
 	mv postimage.txt postimage.saved &&
 	git apply -v damaged.diff &&
--=20
