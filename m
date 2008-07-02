From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: RFC: grafts generalised
Date: Thu, 3 Jul 2008 00:42:30 +0400
Message-ID: <37fcd2780807021342j75f351a5sa525b892caedf965@mail.gmail.com>
References: <m3lk0kfdo1.fsf@localhost.localdomain> <g4gb7a$ket$1@ger.gmane.org>
	 <20080702174255.GB16235@cuci.nl> <20080702182510.GC29559@glandium.org>
	 <g4gho9$g42$1@ger.gmane.org> <20080702143519.GA8391@cuci.nl>
	 <20080702183701.GE16235@cuci.nl>
	 <20080702193157.GA21297@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org,
	"Mike Hommey" <mh@glandium.org>,
	"Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>
To: "Stephan Beyer" <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jul 02 22:43:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE9Ap-00087v-SN
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 22:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414AbYGBUmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 16:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754696AbYGBUme
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 16:42:34 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:49440 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348AbYGBUmd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 16:42:33 -0400
Received: by yw-out-2324.google.com with SMTP id 9so222702ywe.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 13:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=lMcuf4DNVngc5CsOBQDYZZ/xpbsL8SFX4D/0lVTDDoA=;
        b=DGZiClbZcbD4JOykrdY1dZFJ4af8SwI+dw9a6AQGs8Sd8jf8ie+9om0vebwXi6cSxr
         8pNE+1wQT4nWuPM0/8E2E9zeH+MHl30Vgze0ZLNj4GIrtUFIEk30nWms1vXLClGLxwYB
         UYuUM5RFAnL+6IekGfF/KrD0wMB85lHUAODQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=HHzbkIx5aHQkjRf9H0Q9Cq453XmB5QSQDL9k34Dq+ce9Sq2qHVw+cnwC9s3ADq6RKU
         HH7nHsx3bWpiAy4KmQOaTAmsaYMa5qaiNU8KOEcZscHbf1zwXTuY+odsNatU2KZHL0ts
         rpyv+BW5TFMTToJNlp5jVHh8LpB/4C3chV7wQ=
Received: by 10.142.222.4 with SMTP id u4mr3227050wfg.250.1215031350291;
        Wed, 02 Jul 2008 13:42:30 -0700 (PDT)
Received: by 10.143.32.3 with HTTP; Wed, 2 Jul 2008 13:42:30 -0700 (PDT)
In-Reply-To: <20080702193157.GA21297@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87190>

On Wed, Jul 2, 2008 at 11:31 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
>
> I'm somehow quite confused about the desired workflow but I try an
> answer.

I don't think we speak about any normal workflow but about importing
"initially disjunct CVS and SVN repositories into larger complete
histories inside a single git repository." This is one-time work, not
a regular workflow.

>
> Stephen R. van den Berg wrote:
>> As far as I understood it, the new git sequencer rewrites history
>> proper.  That is timeconsuming by definition, and thus it is *not*
>> possible to make a tool based on the sequencer that supports the desired
>> iterative-history-rewrite workflow.
>
> If I got the problem right, it is possible.
> But you have to rewrite and cannot just fake history, of course.

Using grafts allows you to fake history, which is very useful during
import, because it allows you to edit history without running any
filter-branch, which is very timeconsuming. Of course, at the end
you have to run git filter-branch to have the "true" history, otherwise
anyone who clones from you will end up with a broken repo.

The purpose of rebase (and I believe the sequencer too) is rather
different -- to allow you to keep your changes as patches to the
upstream.

> I wonder if grafts can be used in combination with sequencer in such a
> way that you rewrite foo~20000..foo~19950 and then fake the parents of
> foo~19949 to be the rewritten once.

I don't think it is a good idea. During the normal work you should never
use grafts. Well, you can use grafts to add old history, but using it for
anything else is really dangerous, because its *fakes* history. git rebase
(and AFAIK sequencer too) just re-write history of some branch. IOW, it
creates another branch from a different starting point using patches from
some existing branch and then reassign the branch name to it.

Dmitry
