From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Question about "git log --cherry"
Date: Fri, 27 Sep 2013 10:28:05 +0200
Message-ID: <CAC9WiBgzWXhoEuD1adwD+SwFScSwH+JFBLRq=26G5k8JxFysEg@mail.gmail.com>
References: <CAC9WiBjLqdqSKgLv_M6FPx3a2J-+ZKAQnk9OGn3h5SfqSpiT3g@mail.gmail.com>
	<20130926202153.GC27238@serenity.lan>
	<CAC9WiBjykt5qj2sRtTK=VHp0B5x===7oqVP7VRC6BOdCMTn9yg@mail.gmail.com>
	<20130927081113.GE27238@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Sep 27 10:28:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPTPJ-0003i7-FU
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 10:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134Ab3I0I2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 04:28:09 -0400
Received: from mail-vb0-f45.google.com ([209.85.212.45]:65384 "EHLO
	mail-vb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab3I0I2G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 04:28:06 -0400
Received: by mail-vb0-f45.google.com with SMTP id e15so1604499vbg.4
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 01:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dz5VBT+2rJF7zHr6qYTszFiOMjLWy6sBU4hPZKWqkSg=;
        b=AebN4x7lDpnPj++aOKGvXwpeBPelDJtD0NcmqyEIuzNCgW0BOF9duxrTtSGLPfLrVH
         gNDsqfLVJrHpoWN4620hUIvGMkBNUIMjFH+tcREGq/DKYgEe4mBJsgg5gq9wQLmml9OI
         uTkh1QVNJ8yLTjT0ztk+4dxf4Jn8LsGNK2E1V6C8+fpE3HA1z2hZD7wXrxPPOkGE/SlN
         6wRBhdxDnK8XsVd+xru35D0ID8lL2mmZ5T+xpZvZ6CkDobPuYHfirESa6t7oQoXJAy5t
         Cr+w6qEYodFpabAReKU7dlkwR06q9eMedhkUblzYTs22r6zF5m46NQDlKJWjON1LBhI3
         vKdQ==
X-Received: by 10.221.27.73 with SMTP id rp9mr174530vcb.29.1380270485234; Fri,
 27 Sep 2013 01:28:05 -0700 (PDT)
Received: by 10.58.8.169 with HTTP; Fri, 27 Sep 2013 01:28:05 -0700 (PDT)
In-Reply-To: <20130927081113.GE27238@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235446>

On Fri, Sep 27, 2013 at 10:11 AM, John Keeping <john@keeping.me.uk> wrote:
> On Fri, Sep 27, 2013 at 07:09:03AM +0200, Francis Moreau wrote:
>> Hi,
>>
>> On Thu, Sep 26, 2013 at 10:21 PM, John Keeping <john@keeping.me.uk> wrote:
>> > On Thu, Sep 26, 2013 at 06:35:57PM +0200, Francis Moreau wrote:
>> >> I'm trying to use "git log --cherry ..." in order to display new, kept
>> >> and removed commits between two branches A and B.
>> >>
>> >> So commits which are only in B are considered new and should be marked
>> >> with '+'. Commits which are in both branches are marked with '=' but
>> >> only commit in branch B are shown. Eventually commits which are in A
>> >> but not in B anymore should be marked with '-'.
>> >>
>> >> So far I found this solution:
>> >>
>> >>   $ git log --cherry-mark --right-only A...B
>> >>   $ git log --cherry-pick  --left-only   A...B
>> >>
>> >> but I have to call twice git-log. This can be annoying since depending
>> >> on A and B, calling git-log can take time.
>> >>
>> >> Is there another option that I'm missing which would do the job but
>> >> with only one call to git-log ?
>> >
>> > Does this do what you want?
>> >
>> >     git log --cherry-mark --left-right A...B |
>> >     sed -e '/^commit / {
>> >         y/<>/-+/
>> >     }'
>>
>> Nope because --left-right shows common commits (with '=' mark) that
>> belong to A *and* B, and I'd like to have only the ones in B.
>
> I think the only way you can address this is to post-process the result,
> I don't know any way to remove a left side commit only if it is
> patch-identical to a right side commit.
>
> It should be relatively easy to filter out any '=' commits that are in
> the output of "git rev-list --left-only A...B".

yes that's what I'm doing but I was wondering if that's possible to do
that with only one run of git-log/git-rev-list.

Thanks
-- 
Francis
