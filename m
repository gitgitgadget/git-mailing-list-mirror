From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Wed, 1 Aug 2007 15:23:08 +0200
Message-ID: <81b0412b0708010623x5248612cm78db342c04a0e633@mail.gmail.com>
References: <200708010216.59750.jnareb@gmail.com>
	 <alpine.LFD.0.999.0707311850220.4161@woody.linux-foundation.org>
	 <7vodhrby6f.fsf@assigned-by-dhcp.cox.net>
	 <20070801092428.GB28106@thunk.org>
	 <7vr6mn5znm.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0708010620h6bf44aarb35da301db967855@mail.gmail.com>
	 <81b0412b0708010620g776fb89ei574ece00ac45bf30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Theodore Tso" <tytso@mit.edu>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 15:23:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGEAg-0000iO-P7
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 15:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762646AbXHANXO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 09:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764330AbXHANXN
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 09:23:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:60284 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764244AbXHANXL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 09:23:11 -0400
Received: by ug-out-1314.google.com with SMTP id j3so204592ugf
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 06:23:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YcvDjbjEzF+bNVqJJ1tjL6yu/ivWLQ2Fufc338yzakLkPYe20b9MaRVGIthfA8xdtHmQ84lXCvin6gc6E4klx6CoybByewbsyU0f6bA5QczuJCbChtbJoP81RiTkUpka8R4fkpVIQ7t6/6fUOU4YDxzG+6Tf988ZVrvu7IGTeF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QqBKgG5mPbmxp2phyvOQuVfcG8vbGY5sGE2RZB174xQ0Q3Q244WPrhqaHXwEJpb7Xy+WK1atiHpGx5jRfR3LKEYLs1VDj05s0QNOsYf+l4gJf9ABn1iig3WxJTSwS/riCt7jdQxbfxKCkA95RPaGiG073pZi79gO6ibC6h7HytQ=
Received: by 10.78.142.14 with SMTP id p14mr191379hud.1185974589245;
        Wed, 01 Aug 2007 06:23:09 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 1 Aug 2007 06:23:08 -0700 (PDT)
In-Reply-To: <81b0412b0708010620g776fb89ei574ece00ac45bf30@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54435>

On 8/1/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 8/1/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> >             if ln "$repo/$sample_file" "$GIT_DIR/objects/sample" 2>/dev/null
> >             then
> > +                   echo >&2 "Hardlinks not supported. Falling back to copy"
> >                     l=l
> >             fi &&
>
> Err, the other way around, of course.
>

diff --git a/git-clone.sh b/git-clone.sh
index 0922554..483b91d 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -264,8 +264,10 @@ yes,yes)
 	    test -f "$repo/$sample_file" || exit

 	    l=
-	    if ln "$repo/$sample_file" "$GIT_DIR/objects/sample" 2>/dev/null
+	    if ! ln "$repo/$sample_file" "$GIT_DIR/objects/sample" 2>/dev/null
 	    then
+		    echo >&2 "Hardlinks not supported. Falling back to copy"
+	    else
 		    l=l
 	    fi &&
 	    rm -f "$GIT_DIR/objects/sample" &&
