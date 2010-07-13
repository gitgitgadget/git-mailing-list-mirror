From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] revert: refactor code that prints success or
 failure message
Date: Tue, 13 Jul 2010 17:16:20 -0500
Message-ID: <20100713221620.GA4763@burratino>
References: <20100712115455.12251.53947.chriscool@tuxfamily.org>
 <20100712163043.GA1531@burratino>
 <201007132302.59324.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Jul 14 00:17:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYnmt-00016k-MG
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 00:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407Ab0GMWRK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jul 2010 18:17:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37941 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988Ab0GMWRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 18:17:09 -0400
Received: by mail-iw0-f174.google.com with SMTP id 7so6282541iwn.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 15:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=QWhLPbp8uYwxjOvi++Ng89fGhbIsMUUC+SI9/zUvAdw=;
        b=Pu1jv0Cvle8Ha54rffVfkPZlQ/QOurQOVeUqoyeiVXz1fBr9KDUsEavgeUXOjQ4r7h
         wdJO5KsxFUk5vuIiuS0xSXGeItNHpEb80YKeE1hPou3VzFsNtVsdWxrIMlkF5PGVGC9f
         F2Z2cK4SPfX9DSIAqQcJz8h17LN+zF08O+E9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=X5tRM090iiZHQ4XEpJifiex2xL4j2pC7vAug4NAjWdPOBN+lmv35a0qC/bPv/E4LXN
         edON5TGVQmnuSsa2HHNHewrjg9rvmXmVAJcTD21WJel35kk3hfLFpdl94nSN/9I6rVQK
         ysRNNfhbL4WMUnjFxrUS9GBwwwsxnuY5D6DEA=
Received: by 10.231.161.16 with SMTP id p16mr11042128ibx.61.1279059428686;
        Tue, 13 Jul 2010 15:17:08 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id n20sm26940231ibe.17.2010.07.13.15.17.06
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 15:17:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201007132302.59324.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150931>

Christian Couder wrote:

> I don't know about sh -x but there is this code in test-lib.sh to war=
n about=20
> GIT_TRACE use:
>=20
> case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
> 	1|2|true)
> 		echo "* warning: Some tests will not work if GIT_TRACE" \
> 			"is set as to trace on STDERR ! *"
> 		echo "* warning: Please set GIT_TRACE to something" \
> 			"other than 1, 2 or true ! *"
> 		;;
> esac

Oh!  I just remembered

  http://thread.gmane.org/gmane.comp.version-control.git/146767

I guess the answer is we half-support it.  Maybe a test_cmp_err()
helper to strip out xtrace[1] and GIT_TRACE[2] output is needed.

>> Summary: I was misled by the commit message.
[...]
> Ok, I will improve it.

Thanks, and sorry for the unfocused review.

Jonathan

[1] Sadly, it is not obvious to me that the format of output produced
by set -x is portable.  Any sufficiently unixy system (e.g., any
system supporting the Posix User Portability Utilities option) will
use $PS4 which defaults to =E2=80=98+ =E2=80=99 at the beginning of tra=
ce lines, but
even for Posix that is only optional.

[2] All trace output starts with =E2=80=98trace: =E2=80=99, with one ex=
ception.

diff --git a/exec_cmd.c b/exec_cmd.c
index bf22570..75d2930 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -28,7 +28,7 @@ const char *system_path(const char *path)
 	    !(prefix =3D strip_path_suffix(argv0_path, BINDIR)) &&
 	    !(prefix =3D strip_path_suffix(argv0_path, "git"))) {
 		prefix =3D PREFIX;
-		trace_printf("RUNTIME_PREFIX requested, "
+		trace_printf("trace: RUNTIME_PREFIX requested, "
 				"but prefix computation failed.  "
 				"Using static fallback '%s'.\n", prefix);
 	}
--=20
