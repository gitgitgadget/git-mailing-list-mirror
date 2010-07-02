From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] Teach fast-import to import subtrees named by tree
 id
Date: Thu, 1 Jul 2010 23:42:20 -0500
Message-ID: <20100702044220.GB7209@burratino>
References: <20100701031819.GA12524@burratino>
 <AANLkTinSvg6fqu0Y-EHpMoQDZcYBIRP3qRprsHQQwjZE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 06:43:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUY5n-0004Bt-OE
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 06:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247Ab0GBEmv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 00:42:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56469 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221Ab0GBEmt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 00:42:49 -0400
Received: by iwn7 with SMTP id 7so2820175iwn.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 21:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=IFNm76kTuJe0hPCMGxRLEwXeKAELM7Wv2hupVxVDFyY=;
        b=p3Uzuas2F96VWHLVJUHnu2W2Ju4EqlA0lqxTy48GXJoKalmJaW2P92FgKbWW0n0r1M
         r9OZZJehqEXoAo5PNZhnwy1jVkST9JyLVCho197h1SEX14TWnLne9hFWa+PeqaWHfAc7
         +ScMn1rH4FiJ/T1251ljxqdCwarHf02N3znyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=VYYOyToH/7ZlD1tPK4+YcLOZdDssK+moOFB/OLHBRlJg64vPcKcGhcN5Ylu90ScpQq
         nOkx+TDw9Hk9JiKJzHwXhIdp0oZF/nH26l/c8cjcRgaDOB2CCXHk/ZZnCJLUjIR9h9fB
         JiTP6nzFKCT6Tt4bShUYWkX3Sg6pNbm+qQ30g=
Received: by 10.231.149.12 with SMTP id r12mr217765ibv.57.1278045767408;
        Thu, 01 Jul 2010 21:42:47 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm1128517ibi.6.2010.07.01.21.42.46
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 21:42:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinSvg6fqu0Y-EHpMoQDZcYBIRP3qRprsHQQwjZE@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150106>

Sverre Rabbelier wrote:
> On Thu, Jul 1, 2010 at 05:18, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:

>> I was not sure whether to add a "feature" specification for
>> this, so I=E2=80=99ll try that as a separate patch.
[...]
> That should be as easy as adding an option though?

Yes, I think so.

-- 8< --
Subject: fast-import: And a feature option for importing subtrees

The "feature external-trees" command avoids wasting time
importing with old backends only to error out on a later
"M 040000 <tree hash> <path>".

Its use is completely optional.  In particular, if backends
without the external-trees feature become extinct, then there
will be no reason to keep using it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-fast-import.txt |   17 +++++++++++++----
 fast-import.c                     |    3 +++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast=
-import.txt
index 5edf059..54a3ea1 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -484,9 +484,12 @@ External data format::
 +
 Here usually `<dataref>` must be either a mark reference (`:<idnum>`)
 set by a prior `blob` command, or a full 40-byte SHA-1 of an
-existing Git blob object.  If `<mode>` is `040000` then
-`<dataref>` must be the full 40-byte SHA-1 of an existing
-Git tree object or a mark reference set with `--import-marks`.
+existing Git blob object.
++
+If `<mode>` is `040000` then `<dataref>` must be the full 40-byte
+SHA-1 of an existing Git tree object or a mark reference set with
+`--import-marks`.  Frontends can check for a backend supporting
+this mode with the `feature external-trees` command.
=20
 Inline data format::
 	The data content for the file has not been supplied yet.
@@ -889,7 +892,8 @@ The <feature> part of the command may be any string=
 matching
 ^[a-zA-Z][a-zA-Z-]*$ and should be understood by fast-import.
=20
 Feature work identical as their option counterparts with the
-exception of the import-marks feature, see below.
+exception of the import-marks and external-trees features;
+see below.
=20
 The following features are currently supported:
=20
@@ -898,6 +902,7 @@ The following features are currently supported:
 * export-marks
 * relative-marks
 * no-relative-marks
+* external-trees
 * force
=20
 The import-marks behaves differently from when it is specified as
@@ -905,6 +910,10 @@ commandline option in that only one "feature impor=
t-marks" is allowed
 per stream. Also, any --import-marks=3D specified on the commandline
 will override those from the stream (if any).
=20
+The `feature external-trees` command can be used to abort early
+if the backend does not support `M 040000 <tree hash> <path>`.
+It has no effect in recent fast-import verisons.
+
 `option`
 ~~~~~~~~
 Processes the specified option so that git fast-import behaves in a
diff --git a/fast-import.c b/fast-import.c
index ad6843a..290d4b1 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2820,6 +2820,9 @@ static void parse_feature(void)
 	if (seen_data_command)
 		die("Got feature command '%s' after data command", feature);
=20
+	if (!prefixcmp(feature, "external-trees"))
+		/* Yes, we do support the M 040000 command. */
+		return;
 	if (parse_one_feature(feature, 1))
 		return;
=20
--=20
1.7.1.1
