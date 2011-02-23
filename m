From: Shawn Pearce <spearce@spearce.org>
Subject: Re: RFD: Handling case-colliding filenames on case-insensitive filesystems
Date: Wed, 23 Feb 2011 11:01:03 -0800
Message-ID: <AANLkTi=gAM3LGwU47_EkENerZeKmjwuhWhpHZJGSiW=n@mail.gmail.com>
References: <201102231811.45948.johan@herland.net> <7vmxlm8trt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 20:01:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsJxp-0005WM-L5
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 20:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565Ab1BWTBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 14:01:24 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59893 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab1BWTBX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 14:01:23 -0500
Received: by iwn34 with SMTP id 34so1739216iwn.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 11:01:23 -0800 (PST)
Received: by 10.231.19.131 with SMTP id a3mr3488383ibb.85.1298487683106; Wed,
 23 Feb 2011 11:01:23 -0800 (PST)
Received: by 10.231.144.14 with HTTP; Wed, 23 Feb 2011 11:01:03 -0800 (PST)
In-Reply-To: <7vmxlm8trt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167711>

On Wed, Feb 23, 2011 at 10:56, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>
>> Are there better suggestions on how to deal with this?
>
> Just from the top off my head, perhaps you can go to the same route as
> symbolic link support on filesystems that are not symlink-capable?

I don't know how that helps here Junio. On those systems we write a
text file holding the symlink contents. That text file name is at
least still unique in the working directory.


Perhaps instead the "colliding file" becomes a directory that stores
all of the files below it, each with a unique name and a table of
contents, e.g.:

  foo.txt/

    git-contents:
      file-A foo.TXT
      file-B FOO.txt

    file-A:
      ... the contents of foo.TXT ..

    file-B:
      ... the contents of FOO.txt ..

It would be hard to work with in the index, and the project's build
system might fail, but at least the user can edit both files using
normal tools in the working tree, and can see which one is which using
the magic git-contents file.

This is such an odd corner case though, we need really good tests for
it, because it won't come up in daily usage very often. :-(

-- 
Shawn.
