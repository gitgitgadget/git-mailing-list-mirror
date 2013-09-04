From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Transfer notes when rebasing
Date: Wed, 4 Sep 2013 10:03:09 +0200
Message-ID: <CAC9WiBiXsPM7f4ji6TxJMQ3V6w8tG7Hu5inp=cwp1=ZbzWb2gA@mail.gmail.com>
References: <CAC9WiBiSLMO+JM3aEHZ8xdwKE=jh+mDuo4REQ7rnQ-rTDNb9qA@mail.gmail.com>
	<20130904075310.GB9637@sigill.intra.peff.net>
	<20130904075941.GA2582@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Sep 04 10:03:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH83c-0007iT-Rq
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 10:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762238Ab3IDIDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 04:03:13 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:48899 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762213Ab3IDIDK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 04:03:10 -0400
Received: by mail-vc0-f178.google.com with SMTP id ha12so4917196vcb.9
        for <git@vger.kernel.org>; Wed, 04 Sep 2013 01:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8Xri1Nvkd7tkn12eQgO2GqA3VxHd+Uum/8OiQnVvHz4=;
        b=KrrDjGeD/WBUdRkrlU1QLjT3ydCrsBJ8HWfMfdahpCguOXAeZpvUGdG6iKTZOhb6KU
         /P4tyEfke3agviLyLdWmTPPKDIylIjiB+SSVwYwaMMXYhzXyXwBIgymHgTDZSbJvZitB
         S0t2KYB3YC4MMooLOxOjf/6BEAebYq9+cBRvsdinBrrr+Ci4Vht1i1Pbe6rxa2vBOlNg
         Uvznliil9wC+D1O6+NjTX6CWiUY1meLK/0XOVSHmYTH2g7eiiO1IU5uhbzl6I3CigueS
         MtIuvEru7QmjgC+KzJA4puMKpLNGAnGuxRPhcWznIKGsoy5mhV573NUEbCAzcGZPUfUW
         bAcQ==
X-Received: by 10.221.40.10 with SMTP id to10mr1444918vcb.22.1378281789954;
 Wed, 04 Sep 2013 01:03:09 -0700 (PDT)
Received: by 10.58.96.109 with HTTP; Wed, 4 Sep 2013 01:03:09 -0700 (PDT)
In-Reply-To: <20130904075941.GA2582@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233816>

On Wed, Sep 4, 2013 at 9:59 AM, John Keeping <john@keeping.me.uk> wrote:
> On Wed, Sep 04, 2013 at 03:53:10AM -0400, Jeff King wrote:
>> On Wed, Sep 04, 2013 at 09:51:26AM +0200, Francis Moreau wrote:
>>
>> > When rebasing a branch which contains commits with notes onto another
>> > branch it happens that some commits are already presents in the target
>> > branch.
>> >
>> > In that case git-rebase correctly drops those (already present)
>> > commits but it also drops the notes associated with them.
>> >
>> > Can the notes be transfered somehow in the target branch on the
>> > already present commits ?
>>
>> Yes, see the notes.rewriteRef config option to enable this.
>
> Does that actually work for this case?  It sounds like Francis has the
> notes copying correctly when commits are rewritten but the notes are not
> copied anywhere if the commit becomes empty.

I don't think so:

$ git config -l
...
notes.rewriteref=refs/notes/*

$ git notes show
note 1

$ git checkout -b target master~1
Switched to a new branch 'target'

$ git cherry-pick -x master
[target 93740ff] commit 6 (cherry picked from commit
5dc90209d7c0195dd9d671c234c49c903b9e1b10)
 1 file changed, 1 insertion(+)

$ git rebase target master
First, rewinding head to replay your work on top of it...

$ git notes show
error: No note found for object 93740ff96b37b2ed7aa0a78861c8beb87fdad474.

Thanks
-- 
Francis
