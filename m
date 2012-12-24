From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Find the starting point of a local branch
Date: Mon, 24 Dec 2012 18:16:05 +0700
Message-ID: <CACsJy8Dt94XLSa8Sg3T0URJYG9cHD_sUySuhm3Vu4ESy-VrXag@mail.gmail.com>
References: <20121224035825.GA17203@zuhnb712> <201212240409.qBO49wkV020768@no.baka.org>
 <CACsJy8CNd3W_WUMbZ1QZ4ReZ5ziX90QejK9mh1TMs0ig33kGMw@mail.gmail.com> <20121224061938.GA25186@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Seth Robertson <in-gitvger@baka.org>,
	Woody Wu <narkewoody@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 24 12:16:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tn61f-0008TV-Hu
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 12:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215Ab2LXLQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 06:16:38 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:40298 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678Ab2LXLQg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 06:16:36 -0500
Received: by mail-ob0-f181.google.com with SMTP id oi10so6524200obb.26
        for <git@vger.kernel.org>; Mon, 24 Dec 2012 03:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=F2xj5UGHIX170XibZx4a+7ozHn+d64d5mOqgn4UxNoo=;
        b=e/t3OjGauvnDnFP9LwCpnw/TvaIL9xuFsDVdI7p2k+j5K4A0fhTIb0VUwtQBAlrNUK
         ENXE5+xecBYjZhG0FTADyyiIY7ZVS9RePT9b4PG3ywqkxhyWpXQUMTdoy/cazs++7Bq6
         YxKZGmHNTTiCq7WjwTgh6FNbGO4Lx6IJo2RI6AfVhAVTHd6F/7OA7u8y9NpiL0vX99lR
         i+rSUwJJz3Bnwn9ERtIjjO6wY1YeIAliWXpstrAx108HmMOtrqgklRMgk/XAc7Ong3K4
         rGNhkm0j5uyoyHlpFLToabRQxYq5CtLG/CY4D1pe4S6UETxjMLB+50Oyu/DxYqgflLA8
         MhGQ==
Received: by 10.182.41.6 with SMTP id b6mr17664244obl.23.1356347796188; Mon,
 24 Dec 2012 03:16:36 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Mon, 24 Dec 2012 03:16:05 -0800 (PST)
In-Reply-To: <20121224061938.GA25186@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212106>

On Mon, Dec 24, 2012 at 1:19 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Dec 24, 2012 at 12:28:45PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> > You want to know "what commit was I at when I typed `git branch
>> > mybranch`"?  The problem is git doesn't record this information and
>> > doesn't have the slightest clue.
>>
>> Maybe we should store this information. reflog is a perfect place for
>> this, I think. If this information is reliably available, git rebase
>> can be told to "rebase my whole branch" instead of my choosing the
>> base commit for it.
>
> Is that what you really want, though? We record the "upstream" branch
> already, and you can calculate the merge base with that branch to see
> which commits are unique to your branch. In simple cases, that is the
> same as "where did I start the branch". In more complex cases, it may
> not be (e.g., if you merged some of the early commits in the branch
> already).  But in that latter case, would you really want to rebase
> those commits that had been merged?
>
> The reason that git does not bother storing "where did I start this
> branch" is that it is usually not useful. The right question is usually
> "what is the merge base". There are exceptions, of course (e.g., if you
> are asking something like "what work did I do while checked out on the
> 'foo' branch"). But for merging and rebasing, I think the computed
> merge-base is much more likely to do what people want.

Rebasing is exactly why I want this. Merge base works most of the time
until you rewrite upstream (which I do sometimes). There are also
cases when I create a branch without upstream, or when upstream is
renamed. Still, making "rebase -i --topic" == "rebase -i $(git
merge-base HEAD @{upstream})" would be cool.
-- 
Duy
