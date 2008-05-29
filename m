From: "Geoffrey Irving" <irving@naml.us>
Subject: caching commit patch-ids for fast git-cherry
Date: Thu, 29 May 2008 10:01:58 -0700
Message-ID: <7f9d599f0805291001mdbb4b42q6f3a1b79bc9bc4e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 29 19:03:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1lWe-0006Uk-6s
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 19:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbYE2RB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 13:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbYE2RB7
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 13:01:59 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:29737 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbYE2RB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 13:01:59 -0400
Received: by rv-out-0506.google.com with SMTP id l9so4182151rvb.1
        for <git@vger.kernel.org>; Thu, 29 May 2008 10:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=qZ+tc6QXcyPtMAcpbheUgeB5/WpnG24L8l51yB1aUos=;
        b=pAxg8iZRDu1J8BabNJRBxFrWBC6RcdCqo7AtZ+bwhJzTgSWzN5B3z2z1kGFq9YuxOvuCDdqRDvCtJu6IR0GXWJH82WDZ4mnLCfmxWv4RB9wBF9lr77OrphBVbspHZKbpNdGQiOGAN+dAwk4qGrnU9dAiZ5jSTcjVR2meHm97gz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=EOs4KYKR42GItsy+5uPrNghMPyFpUUtwSEXgSofVjgWvAZp+WlainmM0FK9qxeiaumdBp2szYl38uCUEVigQMRH1CBXbcV3pnvsfKHdYS47D7Tou6RfB/4zMENqiOP28fpU2nD3W0tf3UlDewgzPP7JS0wapwpdJ7ANbbL4qRwM=
Received: by 10.141.42.10 with SMTP id u10mr2255796rvj.296.1212080518335;
        Thu, 29 May 2008 10:01:58 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Thu, 29 May 2008 10:01:58 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: ce499f2d777bab5e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83218>

I'm planning to use cherry picking to manage long term syncing between
cvs/perforce and git repositories.  This means I'll have scripts
running git-cherry between branches with hundreds of uncommon commits,
and I want git-cherry to be much, much, faster.

It looks like I can do this by caching commit->patch-id pairs from
commit_patch_id() in patch-ids.c to a file, say
$GIT_DIR/commit-patch-id-cache.  The file would be binary and append
only, and could be blown away if .  Any suggestions / concerns before
I write this?  Is there any reusable efficient map code for storing
the commit->patch-id map, or should I just mirror the blocked storage
+ binary search used for struct patch_ids?

Thanks,
Geoffrey
