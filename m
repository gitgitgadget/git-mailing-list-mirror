From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 14/14] merge-recursive: add a label for ancestor
Date: Sat, 20 Mar 2010 19:52:21 -0500
Message-ID: <20100321005221.GI23888@progeny.tock>
References: <7vr5ne908y.fsf@alter.siamese.dyndns.org>
 <20100321002535.GA23681@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 01:51:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt9O4-00051q-CL
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 01:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527Ab0CUAvX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 20:51:23 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38891 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab0CUAvW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 20:51:22 -0400
Received: by gyg8 with SMTP id 8so2114878gyg.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 17:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=k9UOzOtb/gzA8A3xl0ilK8lrNTVoqvirPrVDhwQied8=;
        b=JuYq4kl17aaRvlRm8Nek19hSafZ+KuoqGCrcZ6NwM6ngtMD86hDK8HwLeHte1m8uFD
         nSHiXoeuP+TEIHpS8yy3awXt/XYjjeBkUgd5TH4M6PqGo+rjL6BUmVtWP00/fFHWfXcx
         9kaa9na1WxDiXXTZgGsSgI8FlSY5R7bsvp+5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=vQUH2RCpgkUmwxNE/eum+kwMeE+L17OPMYM6aZ+to8tR6Hce+RZleMB5q6MhMjmGJD
         /wxvYh+6nBRwywrxcjUg6MMXkXEJ4a3+YtsST5vcM/c4kicE1d3CVrc9Khd8LUNIlXIm
         PPs0lCKYuvTMFUgyI3fP2ipBVgWzDc49zQItQ=
Received: by 10.100.21.27 with SMTP id 27mr11974045anu.93.1269132681563;
        Sat, 20 Mar 2010 17:51:21 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm2740897iwn.10.2010.03.20.17.51.20
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 17:51:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100321002535.GA23681@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142782>

git merge-recursive (and hence git merge) will present conflict hunks
in output something like what =E2=80=98diff3 -m=E2=80=99 produces if th=
e
merge.conflictstyle configuration option is set to diff3.
There is a small difference from diff3: diff3 -m includes a label
for the merge base on the ||||||| line.

Tools familiar with the format and humans unfamiliar with the format
both can benefit from such a label.  So mark the start of the text
from the merge bases with the heading "||||||| merged common
ancestors".

It would be nicer to use a more informative label.  Perhaps someone
will provide one some day.

git rerere does not have trouble parsing the new output, and its
preimage ids are unchanged since it has its own code for re-creating
conflict hunks.  No other code in git parses conflict hunks.

Requested-by: Stefan Monnier <monnier@iro.umontreal.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
=46rom <http://thread.gmane.org/gmane.comp.version-control.git/142374/f=
ocus=3D142391>.

The new series has a small conflict with =E2=80=98next=E2=80=99 (the ch=
erry-pick --no-ff
change).  I=E2=80=99ll try resolving it and put up the result at

 git://repo.or.cz/git/jrn.git merge-diff3-label/for-next

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
1.7.0.2
