From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: is hosting a read-mostly git repo on a distributed file system practical?
Date: Wed, 13 Apr 2011 12:29:32 +1000
Message-ID: <BANLkTimvRoj_dop-s=RUdQBENN6Es_TBsA@mail.gmail.com>
References: <BANLkTiniGcRAHbt5LP2NVhE+c8grOr5sLA@mail.gmail.com>
	<BANLkTimPYchTXiMpnmE47kxiXvJ_c6QZ9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 13 04:29:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9ppr-00027G-7d
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 04:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320Ab1DMC3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 22:29:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55576 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247Ab1DMC3d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 22:29:33 -0400
Received: by iwn34 with SMTP id 34so173792iwn.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 19:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5ru4mc10BfV6W30+1mqe/Ycq63TQlT8MetH66YpXD80=;
        b=Bk3AmYqD1eCq9ghBPrpIEnYg0MCrU+gyauRrUMGgmDpEtsizDhMJK7DC6Iuzgx0Cc5
         zRZQcXNLBiw0OBRe9BLadu4vL2jgn6zUCJ4VU9wX0n4sZe5/vD3alDnxXq21XsP4YwhS
         JjP1XBE7M1aCDSpCoOm/g9+N5q4YayI7VHPMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=BFSZKUP3P1coMrhTXGzULeHkLpEEGlgg8jo440uFrbL5rMjzv7filWtTHEDw3Qct3L
         gjx4eJjQxROl93nd3wcLtNfm4/U+dN8cslh+TiEhAuYNV+aQdtXUR5Cvr/sg3/icYyGs
         X87fO+fo3BUh0DCcy0ldZQpg1FO9YS6joaaMM=
Received: by 10.42.141.202 with SMTP id p10mr1647651icu.124.1302661772704;
 Tue, 12 Apr 2011 19:29:32 -0700 (PDT)
Received: by 10.42.218.68 with HTTP; Tue, 12 Apr 2011 19:29:32 -0700 (PDT)
In-Reply-To: <BANLkTimPYchTXiMpnmE47kxiXvJ_c6QZ9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171430>

On Wed, Apr 13, 2011 at 12:06 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Tue, Apr 12, 2011 at 21:40, Jon Seymour <jon.seymour@gmail.com> wrote:
>> The idea is that most developers would use the DFS-based repo to track
>> the tip of the development stream, but only the integrator would
>> publish updates to the DFS-based repo.
>>
>> As such, the need to repack the DFS-based repo will be somewhat, but
>> not completely, reduced.
>
> Serving git clone is basically a repack operation when run over
> git://, http:// or SSH. If the DFS was mounted as a local filesystem,
> git clone would turn into a cpio to copy the directory contents. I'm
> not sure if that is what you are suggesting to do here or not.
>

All clients, including the client that occasionally updates the
read-mostly repo would be mounting the DFS
as a local file system. My environment is one where DFS is easy, but
establishing a shared server is more complicated (ie. bureaucratic).

I guess I am prepared to put up with a slow initial clone (my
developer pool will be relatively stable and pulling from a
peer via git: or ssh: will usually be acceptable for this occasional need).

What I am most interested in is the incremental performance. Can my
integrator, who occasionally
updates the shared repo, avoid automatically repacking it (and hence
taking the whole of repo latency hit)
and can my developers who are pulling the updates do so reliably
without a whole of repo scan?

>> Is this going to be practical, or are whole of repo operations
>> eventually going to kill me because of latency and bandwidth issues
>> associated with use of the DFS?
>
> Latency is a problem. The Git pack file has decent locality, but there
> are some things that could still stand to be improved. It really
> doesn't work well unless the pack is held completely in the machine's
> memory.

I understand that avoiding repacking for an extended period brings its
own problems, so I guess I could live with a local repack followed by
an rsync transfer to re-initial the shared remote, if this was
warranted.

I agree, there is no substitute for testing this, but experience of
others can be helpful in deciding whether it is even worth attempting.

>
> --
> Shawn.
>
