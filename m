From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Huge win, compressing a window of delta runs as a unit
Date: Wed, 16 Aug 2006 13:20:30 -0400
Message-ID: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 16 19:20:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDP4N-0004OS-OR
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 19:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWHPRUk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 13:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWHPRUk
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 13:20:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:48157 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751162AbWHPRUj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 13:20:39 -0400
Received: by nf-out-0910.google.com with SMTP id o25so706366nfa
        for <git@vger.kernel.org>; Wed, 16 Aug 2006 10:20:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uiXt8ihLr+vEf7mMDVIOgAOJdMn5wP6pdK95J9edvL5QW55qHJfY8yGGLv3giEe/3bV10nTt8HRSMUw1iams0rAL+CDRu54NK1lwFtZuozqNO2OhqZLgTOeU/129XuFW7wCie+CkhUlLZ03KdzPx20tp7wTwjcTgc6U06f5LMC4=
Received: by 10.48.163.19 with SMTP id l19mr941101nfe;
        Wed, 16 Aug 2006 10:20:33 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Wed, 16 Aug 2006 10:20:30 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25519>

Shawn put together a new version of his import utility that packs all
of the deltas from a run into a single blob instead of one blob per
delta. The idea is to put 10 or more deltas into each delta entry
instead of one. The index format would map the 10 sha1's to a single
packed delta entry which would be expanded when needed. Note that you
probably needed multiple entries out of the delta pack to generate the
revision you were looking for so this is no real loss on extraction.

I ran it overnight on mozcvs. If his delta pack code is correct this
is a huge win.

One entry per delta -  845,42,0150
Packed deltas - 295,018,474
65% smaller

The effect of packing the deltas is to totally eliminate many of the
redundant zlib dictionaries.

This is without using a zlib dictionary which gains another 4% form a
4KB dictionary.

-- 
Jon Smirl
jonsmirl@gmail.com
