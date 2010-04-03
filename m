From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: update defaults for modern Cygwin
Date: Sat, 3 Apr 2010 02:47:00 -0500
Message-ID: <20100403074700.GA24176@progeny.tock>
References: <1270161834-9597-1-git-send-email-eblake@redhat.com>
 <7vaatmmju9.fsf@alter.siamese.dyndns.org>
 <4BB5F94F.3090403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jon.seymour@gmail.com
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Sat Apr 03 09:47:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxy4X-0003JR-AC
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 09:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888Ab0DCHq4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Apr 2010 03:46:56 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35513 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238Ab0DCHqz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 03:46:55 -0400
Received: by gwb19 with SMTP id 19so484586gwb.19
        for <git@vger.kernel.org>; Sat, 03 Apr 2010 00:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ev4nxHaltfhNWxHmtnJtRtHrc2xwg42QlNCUIlWt0YA=;
        b=RqiZ5zUx8sCjUA63PvZb1vVYvVTDlylZepuTONhbp1D6ikMlhSnoVSt67DaaVBGCLM
         PZ9PWlqoMfIyN1LqfSBa8w2vXVOOfrCcrqpSs88T3g4ZNCSX/zCF50miq730J/ujMWnu
         tnucgGtzr8Sixpm5JuFtBcQgXcxJ8v2h4hlQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=owEjdO8jkeJG6WITlv/ihmgx1B+MX+jSFPHtvVyWsD5Jqjt+sDGDCz+XZdKE/v2K34
         tUYkZkplbU8EyIAN430sopTjQMVon1ZfZuqN+sdE7IK6eWfMYiakVDOkv/kIWkH/keoL
         by4ywNsJ0HWb2MSFHxs2vgmIpgPdJLQMS2TEM=
Received: by 10.150.120.41 with SMTP id s41mr3951908ybc.83.1270280814471;
        Sat, 03 Apr 2010 00:46:54 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm2718789iwn.11.2010.04.03.00.46.53
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 03 Apr 2010 00:46:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BB5F94F.3090403@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143881>

Eric Blake wrote:
> On 04/02/2010 12:47 AM, Junio C Hamano wrote:

>> Replacing
>> this with "ifeq(... ,1 5)" may not be an improvement either, unless =
we are
>> sure that nobody is using 1.4 or older, but I wonder if somebody els=
e have
>> better ideas?
>
> Nothing short of using $(shell) and doing some actual computation on =
the
> string in $(uname_R).  But that's not too hard, if people think it's
> worth it; speak up if you want me to rework it along those lines,
> otherwise I'll assume that things are good enough as-is.

Red Hat internal people might want to be able to use 1.8 when it comes
out.  Maybe something like this would do the trick?  I don=E2=80=99t kn=
ow whether
Cygwin 1.6 has the fixes 1.7 does, so in my ignorance I lumped it with
1.5.

What you sent is probably good enough already; just trying to avoid
future work.

-- %< --
Subject: Makefile: future-proof Cygwin version check

Tweak the condition that detects old Cygwin versions to not include
versions such as 1.8, 1.11, and 2.1.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/Makefile b/Makefile
index 11ec3e2..a712430 100644
--- a/Makefile
+++ b/Makefile
@@ -831,7 +831,7 @@ ifeq ($(uname_S),SunOS)
 	BASIC_CFLAGS +=3D -D__EXTENSIONS__ -D__sun__ -DHAVE_ALLOCA_H
 endif
 ifeq ($(uname_O),Cygwin)
-	ifneq ($(wordlist 1, 2, $(subst ., ,$(uname_R))),1 7)
+	ifeq ($(shell expr "$(uname_R)" : '1\.[1-6]\.'),4)
 		NO_D_TYPE_IN_DIRENT =3D YesPlease
 		NO_D_INO_IN_DIRENT =3D YesPlease
 		NO_STRCASESTR =3D YesPlease
--=20
