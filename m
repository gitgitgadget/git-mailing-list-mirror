From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] update-index: add --swap to swap index and worktree content
Date: Wed, 17 Aug 2011 21:32:55 +0700
Message-ID: <CACsJy8Cc5PLLXj8TgGS0EjZ5SRyBGfo6WUnYaZNkdnZv62WQZQ@mail.gmail.com>
References: <1313158058-7684-1-git-send-email-pclouds@gmail.com>
 <7vippxgm6y.fsf@alter.siamese.dyndns.org> <20110816210108.GA13710@sigill.intra.peff.net>
 <7vbovpggva.fsf@alter.siamese.dyndns.org> <20110816222212.GA19471@sigill.intra.peff.net>
 <7vzkj9eza2.fsf@alter.siamese.dyndns.org> <20110816230654.GA21793@sigill.intra.peff.net>
 <CACsJy8Ad4xPz79jT3O64c3XsCeM8XETJ9bnjK0aisagrYN0CMA@mail.gmail.com>
 <20110817021727.GA29585@sigill.intra.peff.net> <CAOeW2eFx-ETS+1a5b2bUXeT8JJ0WGudKGyF6mxuqyK2OM35qQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 16:33:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QthBT-0000mf-R5
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 16:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922Ab1HQOd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 10:33:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54406 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865Ab1HQOd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 10:33:26 -0400
Received: by bke11 with SMTP id 11so741544bke.19
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 07:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SbCG1/dAQ8Wu2kNZzUdAHaYz+WF2LZI+jDnx+oCKuYg=;
        b=UgPiRrvPF7H87YoS1uVIlcpyhGi1UEYVjBi2nQh1cEMEjNczFftCoM5+xn2w7gT8xQ
         CbPii3PMAEj6YUdn56IxijG7WdeH/CZirQ3KJYGcwTn+ERCISWCsQtji9FE2JlZl1wvh
         wIXpCM2GfuUFsUp9VPhYC3uYS1MKjFWQhMtCE=
Received: by 10.204.174.130 with SMTP id t2mr474133bkz.383.1313591605126; Wed,
 17 Aug 2011 07:33:25 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Wed, 17 Aug 2011 07:32:55 -0700 (PDT)
In-Reply-To: <CAOeW2eFx-ETS+1a5b2bUXeT8JJ0WGudKGyF6mxuqyK2OM35qQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179513>

On Wed, Aug 17, 2011 at 9:13 PM, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> Hi,
>
> On Tue, Aug 16, 2011 at 10:17 PM, Jeff King <peff@peff.net> wrote:
>> On Wed, Aug 17, 2011 at 09:11:32AM +0700, Nguyen Thai Ngoc Duy wrote:
>>
>>> Two reasons. I already mentioned the ability to quickly checkout index
>>> for a quick test (though there could be more problems down that road).
>>
>> That's a good thought. However, in practice, I find I also need other
>> files from the index to do a successful test. So I end up just
>> committing what I think is right, and then afterwards do:
>
> Maybe a stupid question, but "update-index --swap" would swap all
> files, right? So what "other files from the index" would there be?

That's some of the "problems down that road", another one being
removed files in index. Still the ability to do a quick compile on a
single file is cool.

> Maybe the above shows that I'm missing something. Still, would it be
> possible to achieve the use case with something like the following?
>
> git stash --keep-index
> # fix up files, test etc.
> git add ....
> git commit
> git cherry-pick --strategy=theirs stash && git stash drop

Pretty much (if I understand git-stash correctly, I haven't used it
much), except that if I change my mind mid way, I can switch back to
the original state and keep working:

1. git add -p ...
2. git update-index --swap foo # index <-> wt
3. # make some minor edit, "make foo.o", oops failed, I missed some hunks
4. git checkout -p ...
5. # still not happy, more changes should be made on both index and wt
6. git update-index --swap foo # now index is index, wt is wt
7. # edit some more, when ready to commit, repeat steps 2-6 again
8. git commit
-- 
Duy
