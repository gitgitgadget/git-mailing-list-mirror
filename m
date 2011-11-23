From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Possible bug with branch names and case sensitivity
Date: Wed, 23 Nov 2011 21:50:44 +0100
Message-ID: <CACBZZX4qs8-u33bZbrxYS1CrwjTQc=4YOk2SUjtYzL=vc9KYgA@mail.gmail.com>
References: <D144F6C9-C6A3-4516-BC88-B9EB50890EF4@bitart.com>
 <CAG+J_Dz6nK5fPhBRmoojmgYSv5OviN7pfgNKnRy9_9WmDS1_2w@mail.gmail.com>
 <4ECB315F.4080701@alum.mit.edu> <CAG+J_DxREbykWggrD49L7qvR9M36wKL7+_kOYbvcWmLBCF2Gog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Gerd Knops <gerti@bitart.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 21:51:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTJmk-00070a-Uc
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 21:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234Ab1KWUvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 15:51:09 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54969 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754822Ab1KWUvG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 15:51:06 -0500
Received: by bke11 with SMTP id 11so2049788bke.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 12:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ANgn+OzdeH9bG6aCR/uQlfJp4xh9bzgbPrhC/cdff7Y=;
        b=TldiqXQOGxAmTvgawbw8QTMbKzqK1IWYQclZ7fF75S90VowK7GdOf9+TU0wOPx4QlD
         kz9l4kg/X/Ce5ujjo40RnGATltJ8qMttdc6KoJYvAZIjKYyhB0rOxPOewdj073DnyBHe
         qdDOX5p7fR4qjmaX4IH4NjEvITgwp4iKVb5pY=
Received: by 10.205.117.134 with SMTP id fm6mr22175856bkc.93.1322081465160;
 Wed, 23 Nov 2011 12:51:05 -0800 (PST)
Received: by 10.204.69.71 with HTTP; Wed, 23 Nov 2011 12:50:44 -0800 (PST)
In-Reply-To: <CAG+J_DxREbykWggrD49L7qvR9M36wKL7+_kOYbvcWmLBCF2Gog@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185873>

On Tue, Nov 22, 2011 at 18:31, Jay Soffian <jaysoffian@gmail.com> wrote:
> I wonder what the downside would be of always using packed refs on
> case-insenstive file systems. This would seem analogous to how git no
> longer uses symlinks.

Note that Git doesn't only have confusing behavior with refs on
case-insensitive filesystems. The other day HFS+ users @ work had
issues because of a case collision in the checked out tree, which
confused git status et al.

Note that HFS+ in particular is case-insensitive *but* case
preserving. E.g.:

    $ touch Foo; perl -wle 'opendir my $d, "."; print while readdir
$d; -f and print "yes" for qw(foo Foo FOO)'
    .
    ..
    Foo
    yes
    yes
    yes

On case-insensitive and not-case-preserving systems the third line
would usually print either "foo" or "FOO", but on HFS+ the system
preserves the original name.

This means that you can in some cases figure out what's going on by
doing a readdir() in addition to a stat() as you could do on
POSIX-compliant systems.
