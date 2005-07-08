From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: patches to support working without the object database
Date: Fri, 08 Jul 2005 06:37:24 -0400
Message-ID: <42CE5764.9010405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 08 12:58:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqqYY-0004U4-CQ
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 12:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbVGHKr4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 06:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbVGHKrY
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 06:47:24 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:737 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262494AbVGHKrM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 06:47:12 -0400
Received: by zproxy.gmail.com with SMTP id 16so186490nzp
        for <git@vger.kernel.org>; Fri, 08 Jul 2005 03:47:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=tQq0Pt8RQzf0X07wrNGTzdgkcToR9KRtgJnlad2+keTWBcEGEOE98mK6cIJT/DyAbCEgMaof+xCITF3BbWULZ3G0LTPbth7Urg4Oa+helL7jayliiSdu3J4rz0y/mPP4EpIz29pKbqkCr45zUZGrxsgjtY8t8rEcZ8FeBNNwe88=
Received: by 10.36.43.4 with SMTP id q4mr544059nzq;
        Fri, 08 Jul 2005 03:47:07 -0700 (PDT)
Received: from ?192.168.1.100? ([70.26.43.137])
        by mx.gmail.com with ESMTP id 19sm922159nzp.2005.07.08.03.47.07;
        Fri, 08 Jul 2005 03:47:07 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sometimes you may wish to keep an audit trail of what changed, where, 
and by whom.  You do not need to know the exact details of the change, 
and the files are so large that keeping an extra copy of the data in the 
object database cache is prohibitively expensive.

Git is (almost) ideally suited for this.  There's very little out there 
that is faster than git-diff-cache.

The design of git also facilitates this.  git-update-cache --cacheinfo 
allows the index to be updated without an object in the database, and 
operations can then be performed around the index.  However, there are 
some things that are inconvenient and one show stopper.

I will separately mail a series of patches.  The first will address the 
show stopper, the rest the inconveniences.  Once applied, cg-init, 
cg-commit and cg-add will all take the "-N" option to update the index 
without moving the objects into the database.  Operations that don't 
require the database such as cg-status and cg-log -f work fine and are 
very useful.

I don't expect the patches to be accepted as is.  One was designed to be 
minimally intrusive, but I suspect that there is a better way to do it: 
suggestions are welcome.  The controversial one switches 
git-update-cache --refresh to rely on the SHA1 being unique rather than 
doing a byte comparison against the (possibly missing) object database. 
  It could be made an option, but I think that's ugly.

All patches are against cogito-0.12.

cheers,
Bryan
