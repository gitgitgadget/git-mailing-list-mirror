From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: User's mailing list? And multiple cherry pick
Date: Wed, 4 Jun 2008 10:50:08 +0200
Message-ID: <200806041050.09701.jnareb@gmail.com>
References: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com> <m3r6bdzm22.fsf@localhost.localdomain> <18c1e6480806040111s606701dfwc8a2ae5f742307b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David <wizzardx@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 10:51:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3oi7-00064J-VN
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 10:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbYFDIuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 04:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbYFDIuT
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 04:50:19 -0400
Received: from hu-out-0506.google.com ([72.14.214.232]:27494 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbYFDIuR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 04:50:17 -0400
Received: by hu-out-0506.google.com with SMTP id 28so5668256hub.21
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 01:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=A/kC+TuLKh33w21H2tNlvDZI9lWcJeb1rcdEmCjn/NE=;
        b=NoU+U8EDQzhZmCgozVblSiXZOY9kkVMC/Gm/poZFk/pM07TJU+XfuUqm7/VtQKVLM+T8oHM1uMrBUcy952CCAFL7N7rj43kkZtIz4hvWk8ftj8VXY+0X09f97+ihlV/13WZEplCPqGbcDJPIB9ZFTSEFM8Rf/j+jtnCkJrBgh4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pKeSZnQ9HjH6D58NcfNyDP/661sNAKWcAGWJ6obF9wyih8DvFWfI4ddN0zyr+T+H+1QhkK+ZR28B/OXf9t/HTnjRTjIjqt/9wnyd3whKTwTS1pgFJjT7yQSAVcr+/75rCz07cXlaGoMyiMLBCuDIUUOKiE4KEK+ctlzVrJ191c0=
Received: by 10.86.73.3 with SMTP id v3mr5316920fga.68.1212569415674;
        Wed, 04 Jun 2008 01:50:15 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.251.199])
        by mx.google.com with ESMTPS id 4sm1253558fgg.9.2008.06.04.01.50.12
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 04 Jun 2008 01:50:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <18c1e6480806040111s606701dfwc8a2ae5f742307b5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83763>

On Wed, 4 June 2008, David wrote:
> 
> Thanks, but this doesn't quite solve the problem. I'm on the verge of
> figuring it out, and would appreciate any further tips :-)
> 
> Here is an example:
> 
> o--o--O master
>        \
>         o--o--X--X--X--X--o--o topic
> 
> I want to copy the "X" patches from the topic branch over to master.
> The other patches aren't appropriate for master for whatever reason.
> eg, temporary debugging hacks, but I fixed a few problems in master in
> the X patches and now want to apply them on top of master, and keep
> working on "topic"
> 
> I want to end up with a tree like this:
> 
> 
> o--o--O--X'--X'--X'--X' master
>        \
>         o--o--X--X--X--X--o--o topic

I think the simplest solution would be to mark old master, change it
to topic (merge or branch -f), and use interactive rebase.

  $ git checkout master
  $ git branch TMP
         
  o--o--O *master, TMP
         \
          o--o--X--X--X--X--o--o topic

where '*master' means that 'master' is current branch.

Then to rewind 'master' to 'topic' you can use either
  $ git merge topic 
which should fast-forward to 'topic', or use git-reset
  $ git reset --hard topic

  o--o--O TMP
         \
          o--o--X--X--X--X--o--o topic, *master

Then there is simply a matter of rebasing master interactively, picking 
commits marked X.

  $ git rebase --interactive TMP
  # pick commits marked X in above diagram, backup (save) both original
  # list of commits, and final list of commits.

It is now safe to delete 'TMP' branch

  $ git branch -d TMP

  o--o--O--X'--X'--X'--X' *master
         \
          o--o--X--X--X--X--o--o topic

Now, if all goes well it would be simply a matter of rebasing 'topic' on 
top of 'master'; git-rebase would skip commits that are already there.

If it is not the case, use interactive rebase again, this time picking 
commits marked 'o' (if you saved original series, and list of commits 
rebased, this should be fairly easy to find/do).
 
> After getting the branches like this, I would then (try to) rebase
> topic like this:
> 
> o--o--O--X'--X'--X'--X' master
>                       \
>                        o'--o'--o'--o' topic

And here you are.

HTH
-- 
Jakub Narebski
Poland
