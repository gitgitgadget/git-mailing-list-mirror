From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Enhancements to git-protocoll
Date: Mon, 30 Jul 2012 07:03:10 +0530
Message-ID: <CAMK1S_i_jd_C29bBo79iiPMfBZ4XoXhuiP3f05F9xSpUPX=JBQ@mail.gmail.com>
References: <20120728214116.GA3591@paksenarrion.iveqy.com>
	<7vehnvvyta.fsf@alter.siamese.dyndns.org>
	<20120729142458.GB16223@paksenarrion.iveqy.com>
	<CAMK1S_iTv3BOV3LEoj83feuO2iQnPqTrOq0wyFC-GrvvJQqWTA@mail.gmail.com>
	<7vvch6uw89.fsf@alter.siamese.dyndns.org>
	<7vr4ruuu2e.fsf@alter.siamese.dyndns.org>
	<CAMK1S_geKq5DkNAy2wxGt5EmoOesxaSKKuQjVaQVcbRVdR+9gA@mail.gmail.com>
	<CAJo=hJsgMz-=pdG=HB3KtTE7g6Gvu9mr56dg2+V3WUST+rpAQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 03:33:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SverO-0002jd-Uq
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 03:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912Ab2G3BdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 21:33:13 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46391 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377Ab2G3BdM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 21:33:12 -0400
Received: by lbbgm6 with SMTP id gm6so3225600lbb.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 18:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6AA2i40h7QGvJ2GFczxsgw7azMPUuu9MdpfsYfLa+R4=;
        b=rAlEuJbzadxgG60cxnEU70C+YRrW5d69fZ7vqr6jCK6PHtLTwA5O2qBVS2AqCs14q6
         YH9t+5mOqujmVls4Nzg9wa4kbvtVIzpkxBcxTQHyRvzoAT0hFkottJ9zdOu2MKQe3zTF
         ico0mtb34vwZue3OsHqnqSUD0b/PjfE8t8rH32QLWGG7mTGPxqz5iMiyU7eYRu2B9WB9
         YwqlYosjZgVVVkTy6JWA8CwEOLln7Ctaeu4Ey9fM59M8JjDL4xsNpWj4//7nI0KoQ4QJ
         CBXNUBNePlBOtO0d3Bu7NlU7Tw/h17qq1L6LgkpXzl55bB7fB9NyzO7E66h0Dqz2KBz1
         bhFw==
Received: by 10.112.36.97 with SMTP id p1mr4543146lbj.37.1343611990496; Sun,
 29 Jul 2012 18:33:10 -0700 (PDT)
Received: by 10.112.60.194 with HTTP; Sun, 29 Jul 2012 18:33:10 -0700 (PDT)
In-Reply-To: <CAJo=hJsgMz-=pdG=HB3KtTE7g6Gvu9mr56dg2+V3WUST+rpAQg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202517>

On Mon, Jul 30, 2012 at 6:51 AM, Shawn Pearce <spearce@spearce.org> wrote:
> On Sun, Jul 29, 2012 at 6:04 PM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
>> Of course this will only work with ssh.  None of what Fredrik has so
>> far suggested would possibly work on smart http without even more
>> hacks, I think.
>
> Now that we have smart HTTP, and its somewhat popular for sites to
> deploy with, we need to carefully consider all future protocol changes
> to make sure they are compatible with the HTTP one. Since the HTTP is
> single request/response model, its hard to implement a conversation
> with the end-user.
>
> One thing I would like to do with the protocol is add custom site
> specific extensions to the protocol, where hooks are able to advertise
> in the initial capability list something like a namespace prefix that
> `git push` can use to offer site specific command line flags from:
>
>   ....00000000... HEAD^{} report-status delete-refs side-band-64k
> ofs-delta hook=gitolite
>
> and the client seeing this would recognize a push command like:
>
>   git push -Lgitolite,create-repository URL master
>
> passing the string "gitolite,create-repository" as data in the header
> of the push request. gitolite would need to scan more than just the
> git receive-pack command line from SSH to see this data, but you can

I would avoid anything that requires gitolite to even *know* the pack
protocol.  They should be orthogonal.

But if you mean this extra info will be added to the command line
itself in some way (or in http terms to the REQUEST_URI, PATH_INFO,
QUERY_STRING, etc) then that's fine.

People who use gitolite already should try "git ls-remote
git@host:testing.git1" instead of the usual "...testing" or
"...testing.git" to see how a trace capability is currently hacked
into gitolite.  Also change the 1 to a 2 then a 3 if you wish.

I'd certainly love a cleaner way of doing this, and what you suggest
seems it will satisfy.

> use it to implement an "are you sure you want to create this
> repository" exchange by failing a push with sideband information
> telling the user to reinvoke push with the create-repository flag if
> they really mean to create it.
>
> We sort of want this in Gerrit Code Review to pass reviewer names on
> the command line of git push, making it easier for users to upload a
> code review. The idea is similar to what happens with gcc accepting
> linker flags that are just passed onto the linker. From what I
> understand, Mercurial already has something like this in their push
> system for hooks to accept additional data one-way from the client.



-- 
Sitaram
