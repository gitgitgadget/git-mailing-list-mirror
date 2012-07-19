From: Dan Johnson <computerdruid@gmail.com>
Subject: Re: Feature request: fetch --prune by default
Date: Thu, 19 Jul 2012 10:03:30 -0400
Message-ID: <CAPBPrnsFk-Ww-52W-=qkTK7Yifjowx3tpsELznO4ncmqwfP_Qg@mail.gmail.com>
References: <2C63E314-2EF5-4B8E-B96A-5306E317E045@gmail.com>
	<20120719115558.GC29774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexey Muranov <alexey.muranov@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 19 16:03:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrrKL-0000Np-Hx
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 16:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851Ab2GSODd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 10:03:33 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:45848 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab2GSODb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 10:03:31 -0400
Received: by weyx8 with SMTP id x8so1769765wey.19
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 07:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7MkK+oPD+UJjCEkAWYgrN1cm75BZERi5JssbRDFD2ms=;
        b=Al8TtSjs8AakNZ+XReK6iKGweLbGODYGVl3cWzTtvMvTkpkwD/9b9MAwbnfTJ1My/u
         DLwvih8K9sdEOd1VCmyFYP31uB2l8Xu70nc4/O+z7Vk1kBpBgzK7eJ18yLOGkoihFHCe
         1w7pxnMvyIuWcmcw6CWN6Nsiuef0ebCAfGAz9St9L59fJE6Pxw1eEhqWa96XTKUrlUF4
         whedEi+AqD8Cg4/POWPqvUWBmPgv3KFejzJ0UxJ1TDNv8yBoGWYyiBduxQBoM5g5BUX5
         A8uXsrZrAm57V4G7wPaovWCct/ZOx90cSa8lpgv/g3ysu1RStJkB/nP8JpK6Y0s0UcLv
         BmNA==
Received: by 10.216.237.161 with SMTP id y33mr1277765weq.62.1342706610334;
 Thu, 19 Jul 2012 07:03:30 -0700 (PDT)
Received: by 10.14.201.4 with HTTP; Thu, 19 Jul 2012 07:03:30 -0700 (PDT)
In-Reply-To: <20120719115558.GC29774@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201735>

On Thu, Jul 19, 2012 at 7:55 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Jul 19, 2012 at 09:30:59AM +0200, Alexey Muranov wrote:
>
>> i would like
>>
>> `git fetch --prune <remote>`
>>
>> to be the default behavior of
>>
>> `git fetch <remote>`
>>
>> In fact, i think this is the only reasonable behavior.
>> Keeping copies of deleted remote branches after `fetch` is more confusing than useful.
>
> I agree it would be much less confusing. However, one downside is that
> we do not keep reflogs on deleted branches (and nor did the commits in
> remote branches necessarily make it into the HEAD reflog). That makes
> "git fetch" a potentially destructive operation (you irrevocably lose
> the notion of which remote branches pointed where before the fetch, and
> you open up new commits to immediate pruning by "gc --auto".
>
> So I think it would be a lot more palatable if we kept reflogs on
> deleted branches. That, in turn, has a few open issues, such as how to
> manage namespace conflicts (e.g., the fact that a deleted "foo" branch
> can conflict with a new "foo/bar" branch).

In the meantime, would it make sense to introduce a configuration
variable to request this behavior?

If so, should it be global?

fetch.prune = always

or per-remote?

remote.<name>.prune = always

The global option seems to be more in line with what Alexey is looking
for, but the per-remote one is similar to the tagopt option, which is
a similar idea.

Of course, this might be just a waste of time to introduce a feature
no one would use, in which case we obviously should not introduce such
options.
-- 
-Dan
