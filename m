From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] repack: find -> /usr/bin/find, as for cygwin
Date: Sat, 19 Mar 2011 23:07:54 +0700
Message-ID: <20110319160754.GA5871@do>
References: <AANLkTimHof_MNSGbU2KGX=7Q3MQpjkzXK+xyGGVjbngR@mail.gmail.com>
 <AANLkTimPbz2s=Maafhqg-7wOk_TT4fFSh7AQ-3rWY0A3@mail.gmail.com>
 <4D84D0C0.7080808@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: ryenus =?utf-8?B?4peH?= <ryenus@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Mar 19 17:10:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0yjG-0001gv-WC
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 17:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756619Ab1CSQKK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 12:10:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59000 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754906Ab1CSQKI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 12:10:08 -0400
Received: by iwn34 with SMTP id 34so5015398iwn.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=3/C0N7sOnYqJoTY/8mwDq/ysvvLcrp8L1hhmiH7/QTA=;
        b=Fx1Cv4e1NWyUmlWqzRPTrn42YhpYX/MECjdtpnUBV/EIEO2B7OBANKOPz4SxBHYAvS
         pJlngjDDu4jL9hrg1H1WanOP9wIWN1EMUCpjwvFBr4tPVbwyC550yIZPnk5Bv2LDE2Vb
         acMXC4G+U08QrO6dfn3+U+NK4QpD00xO7f93w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ky7bs9EpzTRocLl2uT9dHEhmsMBS8lliFEu5XyS55pZBcCcTRgirmfVEx7kxbX+uBM
         ZAUKnyGS8v0xXfTocNlPBEDd9CSBPOPXe0L2QV+Ivtsk5yCglumKLnQ6o9TD7vvpMQU9
         M7E83+hmRmLd/PEBWR7MbjWgOLE7pHg17eK0s=
Received: by 10.42.244.129 with SMTP id lq1mr3548527icb.239.1300551008225;
        Sat, 19 Mar 2011 09:10:08 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.209.201])
        by mx.google.com with ESMTPS id y10sm2318830iba.28.2011.03.19.09.10.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 09:10:07 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 19 Mar 2011 23:07:54 +0700
Content-Disposition: inline
In-Reply-To: <4D84D0C0.7080808@lsrfire.ath.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169443>

On Sat, Mar 19, 2011 at 04:50:24PM +0100, Ren=E9 Scharfe wrote:
> Do we need to support pack files in subdirectories of $PACKDIR?  If
> not -- and I don't immediately see why, except that the current code
> does with its find call -- then the following patch might be a quick
> bandaid.  Untested, please be careful.

I looked at test-lib.sh but forgot git-sh-setup.sh, which does
aliasing for find in MINGW build. With your patch, the last use of
find is gone. So we might as well do this

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index aa16b83..e891edc 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -232,9 +232,6 @@ case $(uname -s) in
 	sort () {
 		/usr/bin/sort "$@"
 	}
-	find () {
-		/usr/bin/find "$@"
-	}
 	is_absolute_path () {
 		case "$1" in
 		[/\\]* | [A-Za-z]:*)

--=20
Duy
