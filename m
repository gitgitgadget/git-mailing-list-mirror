From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/10] merge-recursive: add a label for ancestor
Date: Mon, 15 Mar 2010 03:07:04 -0500
Message-ID: <20100315080703.GJ8824@progeny.tock>
References: <20100305215253.364.63583.reportbug@localhost>
 <20100305221950.GB5083@progeny.tock>
 <20100315074748.GA28827@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 09:07:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr5KT-0003rq-PX
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 09:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759775Ab0COIHG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 04:07:06 -0400
Received: from mail-yw0-f201.google.com ([209.85.211.201]:37962 "EHLO
	mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759770Ab0COIHD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 04:07:03 -0400
X-Greylist: delayed 628 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Mar 2010 04:07:03 EDT
Received: by ywh39 with SMTP id 39so1556612ywh.21
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 01:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jdIKE6Q526Y5XeXH7LVUPJyeCF4kTSHm21q8dPEm3B0=;
        b=SMIYGsZ3iA0osc5GFrGPmCWQIO4Cg+5+k9jx8Tm1q0PSULY13UR1tBiG+notCUSc8A
         zLljBTbsXifGXftZ9RdhXa+sL8QvNGUqXNjuM3Eim09H0uF7nM/Wv8sWWUmz51KLt5ca
         w8yznC6/Nfe+NrHP8jHCGy/sdESg3NsoxAbOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=C/fU/1fYOHyfkiwR3ulUMdpbOwfzU41eaCWpG6kIFGTUMUnIMEjDJymZxSiIdeYljg
         +JLviKKVwqKORjuUBrtvFaJsyDhpTmylj4U76cY7Ey2u6UDj1ZZ+JHANBFe0JTJD7+xM
         n1cf8QaaSWwSNDOJc8QlcVPsGcxMT4inyiaeo=
Received: by 10.151.88.21 with SMTP id q21mr1832828ybl.199.1268640421197;
        Mon, 15 Mar 2010 01:07:01 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm4022030iwn.15.2010.03.15.01.07.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Mar 2010 01:07:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100315074748.GA28827@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142186>

git merge-recursive (and hence git merge) will present conflict hunks
in output something like what =E2=80=98diff3 -m=E2=80=99 produces if th=
e
merge.conflictstyle configuration option is set to diff3.

Unfortunately, some tools reportedly cannot parse the conflict hunks
because of a small difference from diff3: diff3 -m includes a label
for the merge base on the ||||||| line.  Humans unfamiliar with the
format would do a better job with a label, too.  Mark the start of the
text from the merge bases with the heading "||||||| merged common
ancestors".

It would be nicer to use a more informative label, and that might
happen in the future.

git rerere does not have trouble parsing this output, since instead of
looking for a newline, it looks for whitespace after the |||||||
marker.  No other code in git tries to parse conflict hunks.

Reported-by: Stefan Monnier <monnier@iro.umontreal.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I would be interested to know which merge tool chokes on |||||||. ;)
As it is, since I haven=E2=80=99t experienced the mechanical misbehavio=
r, I
am targetting humans.

That=E2=80=99s the end of the series.  Thanks for reading.

Good night,
Jonathan

 merge-recursive.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 017cafd..917397c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1347,6 +1347,7 @@ int merge_recursive(struct merge_options *o,
 	if (!o->call_depth)
 		read_cache();
=20
+	o->ancestor =3D "merged common ancestors";
 	clean =3D merge_trees(o, h1->tree, h2->tree, merged_common_ancestors-=
>tree,
 			    &mrtree);
=20
--=20
1.7.0
