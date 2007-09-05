From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: .gitignore, .gitattributes, .gitmodules, .gitprecious?,.gitacls? etc.
Date: Wed, 5 Sep 2007 01:06:03 -0700
Message-ID: <a1bbc6950709050106j137215obd7272b2a77c3b13@mail.gmail.com>
References: <7vhcmmpxed.fsf@gitster.siamese.dyndns.org>
	 <B4A2AE9980774365B5D14B442A7A22F6@ntdev.corp.microsoft.com>
	 <20070826100647.GH1219@pasky.or.cz>
	 <4C603F7C51884DF8AFAEC3F6E263798D@ntdev.corp.microsoft.com>
	 <a1bbc6950708271327x4dd948d4m8e9e35f757a7d92e@mail.gmail.com>
	 <Pine.LNX.4.64.0708280945350.28586@racer.site>
	 <20070904202326.GC3786@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Petr Baudis" <pasky@suse.cz>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Sep 05 10:06:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISpu0-0001zr-JN
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 10:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404AbXIEIGI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 04:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754633AbXIEIGI
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 04:06:08 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:41739 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755167AbXIEIGF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 04:06:05 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1389832rvb
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 01:06:03 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K82+NhRL9fX2oaitHL/TtR5WtVk07uC4mkRUKFrZuGcREWscTaZVkfbb5QxrlduMVlgQT8AB2oIst5TVu1r2W97t0XzO7DVjp9M24U0ln9hG8390CWXWLUbSbQNMHtgAfs+H12MIeE9AnZ5CtaQ6x1Z9KUe2fxa9241rwD67ZIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cH32zRGUaSg0WqJfMqBuYtRjTqRXzhtcMz4r5yMl3vDl7SyKFDAxP1NGs4MHYkbcyAW4xSjjl+cqgZrFBv9EpK0o09IKrWczCACzMeLEtrnV7OfwyRmmnDlZKw2EfyVGBlB+C0huYB30O3shUxipm8AHN0pEyrQmt5EMgzMRM4o=
Received: by 10.141.167.5 with SMTP id u5mr2708886rvo.1188979563229;
        Wed, 05 Sep 2007 01:06:03 -0700 (PDT)
Received: by 10.141.2.18 with HTTP; Wed, 5 Sep 2007 01:06:03 -0700 (PDT)
In-Reply-To: <20070904202326.GC3786@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57681>

On 9/4/07, Jan Hudec <bulb@ucw.cz> wrote:
> On Tue, Aug 28, 2007 at 09:49:47 +0100, Johannes Schindelin wrote:
> > On Mon, 27 Aug 2007, Dmitry Kakurin wrote:
> >
> > > Here is the problem: we need to apply crlf attributes to a file. We
> > > could have .gitattributes both in the index and in the worktree.
> > > Which one do we use?
> > > In general .gitattributes file could be (U)nchanged, (C)hanged, (NP)
> > > NotPresent in each place.
> >
> > I do not see these cases.  You can have these cases, basically:
> >
> > - .gitattributes in worktree (then it does not matter what else we have),
> > - .gitattributes not in the worktree, but in the index (then that is taken)
> >
> > In the latter case, there could be conflicts _in_ .gitattributes, in which
> > case those .gitattributes are ignored.
> >
> > I do not see any problem with that.
>
> I do.
>
> IMNSHO it should be the other way around:
>  .gitattributes in index, than index version is used.
>  .gitattributes not in index, but in worktree, than that tree version is used.

Consider scenario when my commit #1 has .gitattributes:
    a.txt -nocrlf
and file a.txt
You pull it.
Now I make some changes to a.txt and realize that a.txt *is* a text
file now. I remove the entry from .gitattributes and notice that it
becomes empty. So I just remove .gitattributes file all together. It
becomes commit#2.
Now you pull it again. There *is* .gitattributes in local directory,
but index does not have it (because I've removed it on purpose). What
should happen?
I assert that since index does not have .gitattributes the one from
local directory should not be used.

Think about dedicated build machine scenario: I have a machine that
always does sync + build. After every sync the local directory should
always be identical to what-was-committed.
With every commit 3 things could happen: .gitattributes could appear,
disappear or change. In every case "build machine" must produce the
exact copy of what-was-checked-in. The only way I see this happening
is by using *only* index version of .gitattributes when files are
moved index -> workspace.

A similar reasoning works for other direction (workplace -> index).
-- 
- Dmitry
