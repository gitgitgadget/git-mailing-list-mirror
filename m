From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: rename detection limit checking, cherry picking, and git am -3
Date: Mon, 17 Sep 2007 20:18:27 -0400
Message-ID: <46EF1953.6060106@gmail.com>
References: <46EDF54F.5030503@gmail.com> <20070917034742.GG3099@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 02:18:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXQnZ-0004hd-EZ
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 02:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758404AbXIRASd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 20:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757642AbXIRASd
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 20:18:33 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:33696 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757468AbXIRASb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 20:18:31 -0400
Received: by an-out-0708.google.com with SMTP id d31so255592and
        for <git@vger.kernel.org>; Mon, 17 Sep 2007 17:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=58HjSgvE9l4rTXYP8yCBpeYQYvsxwthjmMq2nvRDx0Y=;
        b=kV/yYFP1Boz1REYbrgpE1n28BAWrK+KR7y/KNj8s3B30vgkprqHhl6w1EMB3qx6pqU7BJ8auGBmdURsKaSzZzdAfP98mt/PLKMflYoi6CUhmsC9bE73ZQmgshDx1AELdE84p7LvTSYX8DqvOgdHmbbIWKVUjNMxDUzqr/h0ULKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Cu35HgYLrFwOeDOGZyWrtgNQ7RAEmyJFHp/jrZNtS48uSjrmI/8BAzU0m9WdyBbk9bUb67dQ5SpB3IUDNW2F8gdKpUueDdchFmOPJTqsmnE1VMUbqWW4ogUwINvyuW8QT9XEE3rx1wh+a+tY/7G/AiWodOlSJXusk2h1Tz8nU64=
Received: by 10.100.139.12 with SMTP id m12mr8607368and.1190074710974;
        Mon, 17 Sep 2007 17:18:30 -0700 (PDT)
Received: from ?192.168.100.117? ( [71.246.202.205])
        by mx.google.com with ESMTPS id h38sm9757796wxd.2007.09.17.17.18.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Sep 2007 17:18:29 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20070917034742.GG3099@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58511>

Shawn O. Pearce wrote:
> In this case `git am -3` creates a tree object containing only
> the files modified by the patch and then feeds that tree into
> git-merge-recursive.  Now if you go study git-revert's code you'll
> see it actually just calls git-merge-recursive on three trees,
> but these are three complete trees.
>
> So what's probably happening here is there's less candidates on one
> side in the `am -3` case, so we spend a lot less time generating
> the rename matrix, searching for a match, and we get better changes
> of finding a match.
>
>   
Thanks for the explanation. For my case, there are < 500 files 
(including renamed files) in common between the two branches, giving 
~2000*4000 files that have no correspondence for which git can try to 
find renames. Clearly, reducing the one side from 4000 files to 1 file 
has an enormous payoff.

Mark
