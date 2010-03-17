From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 16/16] merge-recursive: add a label for ancestor
Date: Wed, 17 Mar 2010 07:26:53 -0500
Message-ID: <20100317122653.GP25641@progeny.tock>
References: <20100317113655.GA25470@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 13:26:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrsKY-0002Ql-U3
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 13:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768Ab0CQM0a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 08:26:30 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:51616 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722Ab0CQM03 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 08:26:29 -0400
Received: by qyk9 with SMTP id 9so500639qyk.1
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 05:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=OgNWllDQGVLg9/Dn4QOpapvaUr/B8+n8tn5qaif9C+A=;
        b=VyMLtJw3WoDOR0qBrZ/yX3bueA5xmGwKittrw16gslB4PCALDRX+zXV8Q3AOuR3Uk1
         Wjpgn7mOE6uUB1/al9o/qBECBGStZ83gSufLBHvX67U9nvjfsxoHjmQ44N1mwQRgqfFn
         FChtWTsJ3SsmGNmJXX0blJPuoNPqswmLPmgs4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=wdxleHUCwXW+x0o4z2/Tkrgd3t+BHXqQwYi/rMiyXnhYG2tSuVA3LCft0CBGiZApMa
         32r+8nkWmqjlIiFQG5FqiTguMBHpxMrfUSqM7LM2XAimFMGA9JuEHjMBLAm89QXvGQjG
         MV99nbEx/OUQvpQgagxNiNe2PQezEs02kDsWM=
Received: by 10.229.222.76 with SMTP id if12mr706093qcb.17.1268828788815;
        Wed, 17 Mar 2010 05:26:28 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm637880iwn.4.2010.03.17.05.26.28
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 05:26:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100317113655.GA25470@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142391>

git merge-recursive (and hence git merge) will present conflict hunks
in output something like what =E2=80=98diff3 -m=E2=80=99 produces if th=
e
merge.conflictstyle configuration option is set to diff3.
There is a small difference from diff3: diff3 -m includes a label
for the merge base on the ||||||| line.

Tools familiar with the format and humans unfamiliar with the format
do a better job with a label.  Mark the start of the text from the
merge bases with the heading "||||||| merged common ancestors".

It would be nicer to use a more informative label.  Perhaps someone
will provide one some day.

git rerere does not have trouble parsing the new output, and its
preimage ids are unchanged since it has its own code for re-creating
conflict hunks.  No other code in git parses conflict hunks.

Requested-by: Stefan Monnier <monnier@iro.umontreal.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
As before.

That=E2=80=99s all.  I hope you enjoyed the patches and that the added
complication for the new cherry-pick messages was not too unpleasant to
look at.

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
