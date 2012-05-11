From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: merge unpack-objects to index-pack?
Date: Fri, 11 May 2012 19:02:14 +0700
Message-ID: <CACsJy8BjA-L=jOZ7G9TbDY6D0rqhuzCCRwAjazEfBx_=HcqcqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 11 14:02:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSoYe-0001bF-HI
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 14:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066Ab2EKMCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 08:02:47 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:52674 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511Ab2EKMCq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 08:02:46 -0400
Received: by lbbgm6 with SMTP id gm6so1820380lbb.19
        for <git@vger.kernel.org>; Fri, 11 May 2012 05:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=kpQtZi2RmJ4cIKNT+hWzKWMfEPqhbJGRK/hfcPRtYyc=;
        b=WlAcCW9+9zHbJOVRL0eZgsT6mW02adv5o2/rcnFvnt+T37il570LjDWVk4eNn4ILiu
         2T8csCPEVEhmjlk0wdIamyLascAatOBGDkQRJ9nner+Xn2d5tMxQXx1y4+MaxmP77D8A
         gTQ3bUYoMUlfqxnlFykhwbVb/++u7NbxqvqVqfkZvv1DNTto3GjVm67U7kmQc0ikPy8I
         i7ocf7aIMuKSsPSugYRFKdhl/DFnEqdKI4Y2SMGy43gYyBn0DvDO3khoTCW9tqeQZj/n
         QgsoLWgiFsM2xHIb2BA07mDrfCRbEWK3h4l9VPPF5KimA91Khfe7svBKj9AMNAOKyivi
         tZQQ==
Received: by 10.112.24.194 with SMTP id w2mr3462831lbf.75.1336737764840; Fri,
 11 May 2012 05:02:44 -0700 (PDT)
Received: by 10.112.17.167 with HTTP; Fri, 11 May 2012 05:02:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197665>

Hi,

I'm looking at adding large file support to unpack-objects. A simple
way is just to stream large blobs into loose large blobs. But I'd
rather keep those blobs in pack because pack-objects is happier that
way. I'm looking at unpack-objects and thinking maybe it's best to
just merge it back to index-pack.

In normal mode (all small objects), index-pack receives the pack
stream. Objects will be unpacked in phase two, resolving objects in
index-pack. The only downside I can see is the new unpack-objects now
write temporary pack on disk, which does not sound too bad to me.
unpack-packs is called on small packs so extra space is small. For
single-huge-blob packs, it's good to keep them on disk anyway. When
the pack has large blobs, we could either just keep full pack.

After this, the only pack receiver at client side is index-pack.
fetch-pack does not have to choose between unpack-objects and
index-pack, just pass --unpack-limit <n> to index-pack.

What do you think?
-- 
Duy
