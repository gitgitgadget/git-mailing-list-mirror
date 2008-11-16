From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH v2 05/11] gitweb: git_split_heads_body function.
Date: Sun, 16 Nov 2008 03:53:31 +0100
Message-ID: <cb7bb73a0811151853r418f02ear2f50518f89577054@mail.gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200811150059.14515.jnareb@gmail.com>
	 <cb7bb73a0811150204v15463275sf63098b819c6d259@mail.gmail.com>
	 <200811160213.43343.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 03:58:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1XqD-0005wY-Cb
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 03:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbYKPCxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 21:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbYKPCxe
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 21:53:34 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:13566 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbYKPCxd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 21:53:33 -0500
Received: by nf-out-0910.google.com with SMTP id d3so956233nfc.21
        for <git@vger.kernel.org>; Sat, 15 Nov 2008 18:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XAFbntbJ6nJr0OBBE5jD1psMhu5hPPI15uJhiYT9ilo=;
        b=AosR8J3b+SLH6wy0X4o3zMZtScL7861Qyt9RnpdKyPXQvM92PFlsdk2NUghOw8miiz
         rML9baXcr/1LfKI0vJJubshu/hs2tuHSIMyiF6dkicnKdbcW+skWJdqDIyJSkNYA5wzV
         BGyRlELk691fB1HR5MCPwte7VytOMEnmC8DGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cxxqlDQmyt/qv5VcgMaXxNWs49k3EKhlHPy5jBTKHKWLrCSVZ4tLL6VGiCbCIuadxk
         qTfhd0nEYiMHIsNl2CP8BtylpwXCO8ni/SPlIs4UPrvqBvXMomaJG7N/dfafw5dNUt5J
         JlOWsrgs0Ckc39ppxhtcTQ3iYVKsIb8OmflrE=
Received: by 10.210.67.4 with SMTP id p4mr2641315eba.136.1226804011863;
        Sat, 15 Nov 2008 18:53:31 -0800 (PST)
Received: by 10.210.132.16 with HTTP; Sat, 15 Nov 2008 18:53:31 -0800 (PST)
In-Reply-To: <200811160213.43343.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101116>

On Sun, Nov 16, 2008 at 2:13 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sat, 15 Nov 2008, Giuseppe Bilotta wrote:
>> The initially intended purpose for this patch was to group remote
>> heads by remotes, but an interesting side-effect of doing it this way
>> was that it allowed to group _local_ heads too, by using the
>> stuff/morestuff syntax. For example, I could group gitweb/pathinfo and
>> gitweb/allheads together (although I disabled this grouping for local
>> heads in the patchset).
>
> I'm not sure if it would be that useful. How many people have _many_
> stuff/morestuff branches for some values of stuff/? The convention of
> <initials>/<topic> of topic branches in git.git doesn't usually lead
> to many branches with the same <initials>/ prefix.

Well, even if it's just two of them, it would still be nice. Or even
better, we could make it so that the grouping is skipped unless there
are at least N (to be decided) entries. This, btw, would be true for
the remotes idea too.

> Now I thought about it a bit, I think your solution has merit.
>
> Splitting by remotes is hard and difficult to do right, especially if
> you consider than 'remote' prefix doesn't need to have anything in
> common with names (common prefix) of refs/remotes/* remote-tracking
> branches used. It is fairly easy to do it right in common case, but
> hard in uncommon one.
>
> So perhaps the idea of using first dirname as a kind of category for
> remotes is a good idea. And usually it would be also remote name.
>
> But it really needs explanation in commit message... and quite a bit
> of commit squashing.

I'll probably do a single commit with a rather different logic than
the current one, too.

>> It would also probably be a good idea to separate the actual head
>> grouping from the display of the grouped head lists. I wonder if Perl
>> has a 'tree' data structure that could be used to store the grouped
>> head lists ...
>
> Hash of hashes (well, hash references), see perldsc(1)?

Ah, good, I always get those wrong. Will be an interesting challenge 8-D

>> Would you say that in this case we want 'gsoc2008/gitweb-caching' as
>> the group head, or would you rather have nested groups [gsoc2008
>> [gitweb-caching [branches in gsoc2008/gitweb-caching] [etc]] ? I must
>> say that I think the latter would be quite interesting, but I _am_ a
>> little afraid we could turn up with way too much nested groups ...
>
> Now I think that having [gsoc2008] subgroup here might be a good
> thing...

And subgroups (one for each remote) therein?

My idea would be that, if you only have
gsoc2008/gitweb-caching/branch[1-n], then you'd have a
gsoc2008/gitweb-caching group, and branch1 ... branchn as entries. If
OTOH we have gsoc2007/{gitweb-caching,gitstats}/branch*, we'd have
gsoc2008 group with gitweb-caching and gitstats subgroups, each with
its list of branches.


-- 
Giuseppe "Oblomov" Bilotta
