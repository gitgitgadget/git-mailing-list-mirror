From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Use of field flags in struct object
Date: Mon, 16 Aug 2010 18:21:04 +1000
Message-ID: <AANLkTikvP1oKAiFNVwZ+kqy=jLhUKP1RRET8cq=XeyzT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 16 10:21:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkuwV-0007q2-Dt
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 10:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986Ab0HPIVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 04:21:07 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36527 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854Ab0HPIVG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 04:21:06 -0400
Received: by wyb32 with SMTP id 32so5398573wyb.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=mSHpvYeUGtXl0fej479MOQR1xtRejM2+dnZeilcpoQs=;
        b=qkeqKPo10cHUPuxe8RJPQmqPKm6Sz4u7XIgGrF21ZqVGJk2udb9Tq31taXXfiD8wFS
         CTeGqEy/06dtupZPoPyImyAVLDl4ZbUgBfHGl1O0VQ6nkQY+5WyqebjoB7jVzM/Te/Im
         jSgHZavGw0lm3Jptm8yGqVNNENLn6J1P8Rwn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=NsnNzcXiL9LQ0KdLNR9YsCoYOMK/k/4JUMhZzc6xUnpbBm/ifxZ97EQFolUygkQD8y
         29iFU2XguzYWrCUm+g0iGkofbtMmtdU7otdkQAyWu9W/I3cuT58vZofeJ6EkqbSuHeLL
         8awl+w5p6/hsWsJZ6dJyPRCMBebVSFpaLLZVI=
Received: by 10.227.136.69 with SMTP id q5mr4084670wbt.202.1281946864062; Mon,
 16 Aug 2010 01:21:04 -0700 (PDT)
Received: by 10.216.173.133 with HTTP; Mon, 16 Aug 2010 01:21:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153655>

Hi,

The "flags" field in struct object (object.h) is used in a lot of
places. The thing is, the bit definition of this field is distributed
across files (16 according to my "object.flags |=" grep). This makes
it quite easy for one function to misunderstand a bit set by another
function, for a different purpose. For instance, in upload-pack.c,
there is a comment:

/* bits #0..7 in revision.h, #8..10 in commit.c */

which is no longer true as commit.c has moved on and used another set
of bits (16..19). Luckily, commit.c seems to clean its flags. But
there's a chance we will get bit definition overlap again.

Should all of those bit definitions be gathered in one place instead?
-- 
Duy
