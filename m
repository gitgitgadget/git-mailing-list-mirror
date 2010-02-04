From: demerphq <demerphq@gmail.com>
Subject: Dealing with many many git repos in a /home directory
Date: Thu, 4 Feb 2010 09:29:46 +0100
Message-ID: <9b18b3111002040029x1c7de0afw4a5ef883588f7a18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 09:30:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncx6J-0004va-M9
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 09:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756932Ab0BDI3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 03:29:49 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:64733 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756752Ab0BDI3s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 03:29:48 -0500
Received: by fxm20 with SMTP id 20so2220853fxm.21
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 00:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=Dkd05rbixepSEa0OZhuQUnEGBqzRRTC+NgXBnA22+Ks=;
        b=Mfb1Wlde1GHKHcaX8m2Js3/TVL2CHNq+TsKkavU/ARnIi72bvwNtGxj+Aj/PpcliHk
         Nq7tPUxTkjDkm5tBwyQJK+NbZ+63/G/zK0kaAc+ksG3f+YCBYpcYYxS+byeqrojPudGa
         8vw8Pzo9nlyKB4zxJ4TEFBYv/ojGrJcXUAuos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=BcI30oUHYhEGfsOV8j8B7SEXFhr4ZNkyVl5bHPYWOo37JJDRQ/PWhyJnStpd8ekb6f
         lbnBT6bMpCZb9LbxrGLJ/aTi1WztFTC2SwkXi7nWKCwMIUJuUMsbZNlanF/oKdFXTbdF
         781jiQFCR3RWQ9Oo3o+2ncnzPnIY1FM9odWtc=
Received: by 10.239.142.18 with SMTP id e18mr77186hba.181.1265272186408; Thu, 
	04 Feb 2010 00:29:46 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138957>

At $work we have a host where we have about 50-100 users each with
their own private copies of the same repos. These are cloned froma
remote via git/ssh and are not thus automatically hardlinking their
object stores.

This is starting to take a lot of space.

I was thinking it should be possible to hardlink all of the objects in
the different repos to a canonical single copy.

Would i be correct in thinking that if i have to repos with an
equivalent  .git/objects/../..... file in them that the files are
necessarily identical and one can be replaced by a hardlink to the
other?

If this is correct then is there some tool known to the list that
already does this?  I whipped this together:

find /home -regex .\*/.git/objects/.\* | perl -lne'if
(m!(\.git/objects/../.+)!) { if (my $t= $seen{$1}) { link $t,$_ } else
{ $seen{$1}=$_ } }'

But a proper script with a sign off of some git dev would make me feel
a lot safer :-)

cheers,
Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
