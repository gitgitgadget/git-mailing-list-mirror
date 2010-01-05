From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH v3] Smart-http documentation: add example of how to 
	execute from userdir
Date: Mon, 4 Jan 2010 23:59:10 -0800
Message-ID: <905315641001042359h7850c6cdrf9160030aff67839@mail.gmail.com>
References: <be6fef0d0912301818o678976ebqa3e339dc1ff1f2e8@mail.gmail.com> 
	<1262467101-5755-1-git-send-email-tarmigan+git@gmail.com> 
	<7vzl4v1t91.fsf@alter.siamese.dyndns.org> <20100104140616.GB22872@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 05 08:59:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS4KH-0007Pq-2o
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 08:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109Ab0AEH7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 02:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754277Ab0AEH7c
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 02:59:32 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:39834 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754252Ab0AEH7b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 02:59:31 -0500
Received: by pwj9 with SMTP id 9so9977594pwj.21
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 23:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type;
        bh=x9D55+I0xt2Ftso0ryZ4qUT8mcxQhELLCc7OTuJBc38=;
        b=jj3bJ2T6ZU2JfZKMKqOHbCJBIGl1pM1JaKvXz2FcHE/lCPkpqFdibEkUmdXOabWpxz
         Ep4NoGBomillpuEBywqt4tf+nIriIdO3s0lvEKdTKreC1/zB8d6LYt0vaG35HgHOZIol
         s+RlaTcpC9uzCEUNiUjtx5n9ZqDYpZlBCA0RU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=h28KWpkCbYjRqkiKJkfzzbzK75Ks1es7urEgm9COhXu6rDcahwljHJBoUWzjVmoiWw
         ySfISzkKT0tD0q0iae05AYkISeq9lXYY593Fqz9Lj4nmWRjrmqVhoQiIzItSULWfBvYE
         3VewQM6t1Kqh1S/yiGryyb8b8g4IoHaKfp+uM=
Received: by 10.142.6.11 with SMTP id 11mr15681106wff.79.1262678370548; Mon, 
	04 Jan 2010 23:59:30 -0800 (PST)
In-Reply-To: <20100104140616.GB22872@spearce.org>
X-Google-Sender-Auth: c0845031b2018ddc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136173>

On Mon, Jan 4, 2010 at 6:06 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
>> I still see Cc: here; are people named above (and others commented on
>> earlier versions) happy with this round?
>
> I don't get why Options +SymLinksIfOwnerMatch is needed here.
>
> If we are linking to the root installed git-http-backend Apache
> will actually reject the link, because the link owner is likely to
> be $USER while the target is owned by root.
>
> So I really can't ACK this, the instructions don't jive with my
> understanding of the Apache configuration.

Fair enough.

There seem to be three reasonable ways to run from a userdir
(depending on what the global configuration allows):
- symlink to global git installation (if FollowSymLinks)
- symlink to user's git installation (if not FollowSymLink and only
SymLinkIfOwnerMatch)
- copy of git-http-backend binary (if no symlinks are followed)

The Options +SymLinksIfOwnerMatch is left over from when there was a
more detailed description of the second scenario and should probably
be removed now.  The user may not have a choice about which of those
three can be used because it depends on the global server
configuration (which presumably the user does not control) so it's
difficult to provide instructions that will work for everyone.  The
last option is likely to be the most portable, but also does not get
updated when the primary http-backend binary is updated.

Enumerating the details of setting up all of these configurations in
the man page seems excessive, but it would also be nice to have enough
information to still make it easy.

We could do one or more of the following:
- Remove the Options +SymLinksIfOwnerMatch as it is too specific to an
unknown configuration and let users figure out how to get symlinks to
work for their particular configuration
- Add a note to remind the user about SymLinksIfOwnerMatch or FollowSymLinks
- Emphasize copying git-http-backend binary into the cgi-bin directory
as that is likely the most portable across configurations
- Expand all three scenarios in detail

I'm inclined to do the first two with the following patch (cut-n-paste
warning) squashed in.  I'll send the complete patch as a follow up.

Thanks,
Tarmigan

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend
index 0485033..7af1288 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -160,13 +160,14 @@ From UserDir on Apache 2.x::
 +
 ----------------------------------------------------------------
 SetHandler cgi-script
-Options +SymLinksIfOwnerMatch
 SetEnv GIT_PROJECT_ROOT /home/$username/devel
 ----------------------------------------------------------------
 +
 Also add any needed authentication to the .htaccess file as discussed
 in earlier examples.
 +
+Depending on the global configuration of the web server, the
+"FollowSymLinks" or "SymLinksIfOwnerMatch" options might be needed.
 If the web server does not follow any symbolic links, the
 'git-http-backend' executable may be copied into the cgi-bin directory
 and renamed to 'git' to acheive the same effect, but it will also need
