From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: using git without blobs in the object database
Date: Thu, 07 Jul 2005 08:10:37 -0400
Message-ID: <42CD1BBD.8070306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jul 07 14:30:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqVVm-0003qn-Iy
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 14:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVGGMZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 08:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVGGMXe
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 08:23:34 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:27053 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261436AbVGGMUW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 08:20:22 -0400
Received: by zproxy.gmail.com with SMTP id 8so78970nzo
        for <git@vger.kernel.org>; Thu, 07 Jul 2005 05:20:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=D0hwXXj4E0q01p+C935sLsWnTAY0rZPnNbgwr4KvEHBualIL8JVd7SCeot1GBRKGtihCyy7yFmve1E0CwqG/Lfu3MjI+3wH7TncZfeFjYMrLTlk1qL3KuzIhGWBa070osMTvEBZ7rU1/C02x2xZ7K+Glm/FOod5tndcMQyOr6pY=
Received: by 10.36.60.18 with SMTP id i18mr271678nza;
        Thu, 07 Jul 2005 05:20:18 -0700 (PDT)
Received: from ?192.168.1.100? ([70.26.43.137])
        by mx.gmail.com with ESMTP id 7sm408505nzn.2005.07.07.05.20.18;
        Thu, 07 Jul 2005 05:20:18 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Use Case:  A large set of large binary files, geographically 
distributed.  Each location has some unique files, some identical files 
and some slightly modified files.

I want to use git to tell me what changed and when.  But I cannot afford 
to have it store the blobs in the object database, nor do I need to; 
knowing the signature of previous objects is good enough.

It seems to me that most operations should work without these objects, 
and that some people do so.  For instance, git-update-cache has a 
--cacheinfo option that facilitates this operation.

But not all commands work so well.  For instance, git-write-tree will 
fail if --cacheinfo was used to add a file.  This failure is caused by a 
call to check_valid_sha1().  It appears that this check is not strictly 
necessary, just very useful for normal operation.

Would a patch that added a flag "--disable-sha1-check" to git-write-tree 
be accepted?  I hope that's all I need to add, but I haven't completed 
my evaluation yet.

thanks,
Bryan
