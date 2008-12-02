From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: git-svn rebase "problems"
Date: Tue, 2 Dec 2008 10:21:36 -0500
Message-ID: <eaa105840812020721t299009bcv15e2805cc040854@mail.gmail.com>
References: <73fd69b50811301917j6535f289uf177976707914e46@mail.gmail.com>
	 <73fd69b50812020656u3fd17015n267f694236982e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Joe Fiorini" <joe@faithfulgeek.org>
X-From: git-owner@vger.kernel.org Tue Dec 02 16:23:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7X5U-0008RG-NX
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 16:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474AbYLBPVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 10:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754528AbYLBPVi
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 10:21:38 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:24721 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242AbYLBPVi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 10:21:38 -0500
Received: by qw-out-2122.google.com with SMTP id 3so668132qwe.37
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 07:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=c9QN+4Gi/VFrcgkoPwkod65vux8znK6sYe+FRz/SqDQ=;
        b=Dexvtuex05R1xGeG8IL/Lx6dcLS5w/FANxHy4ZZfvRou7lx5xfVLWHT0QMFv5wjJB/
         aaBdN51HAurcOjA/9NeABdmqLs0OFvcePaYvHFBy3Y1vm8fbCk4+EIrvyCfIiU7LXXVP
         NASgn8Lf3qrfiTl21w6v7HuGgEuWVhZcSLs3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=hqtkDckb56P4Hlm26U2zeDVB7z5IDzvKfQZaTRjOYJ6rE/H6qg9+3oWLEMNNIcvEM8
         CYqJNHzwlNFxZMqNbR28G7RhSm0iEHPI8AYFhVsArctSqMOIOijs8vRQ4xuiJLdJcSgx
         MLKqAxPsrrCln7hHldiN73vnft1cO66ks4NqI=
Received: by 10.65.215.14 with SMTP id s14mr12961620qbq.5.1228231296327;
        Tue, 02 Dec 2008 07:21:36 -0800 (PST)
Received: by 10.65.230.19 with HTTP; Tue, 2 Dec 2008 07:21:36 -0800 (PST)
In-Reply-To: <73fd69b50812020656u3fd17015n267f694236982e5@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 993a5e1a841ae3ac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102142>

On Tue, Dec 2, 2008 at 9:56 AM, Joe Fiorini wrote:
> Are there any other details I can provide to get an answer on this?

Maybe an actual script that reproduces the problem you're seeing?

> On Sun, Nov 30, 2008 at 10:17 PM, Joe Fiorini wrote:
>>
>> So I'm using git-svn. My team tends to commit to the svn server fairly
>> often. It has happened more than once that, because git svn rebase
>> applies each svn commit sequentially, some of the commits will
>> conflict with each other - whether or not I have ever touched the
>> file.

That sounds like you're "git pull"ing from each other, yes? I can't
imagine any other way you'd get conflicts on files you have never
touched.

>> Is there anything I could do to get around this without having to
>> merge code I'm unfamiliar with?

If the problem is that git-svn doesn't recognize git-svn commits that
have come from others via git-pull, you might be able to get away with
"rm -rf .git/svn" to force git-svn to rebuild its index. Git 1.6.1rc
or newer doesn't need this workaround, since it has incremental index
updating.

If the problem is that others' branches are conflicting with svn
checkins, switch back to your own branch so you're only rebasing your
own code, ask the person who wrote the other code to fix the
conflicts, and re-pull. This assumes a work-flow where you only ever
make commits on top of an un-merged state (which you pretty much have
to adopt anyway in a rebase-heavy environment such as one based on
git-svn).

Peter Harris
