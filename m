From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 4/4] builtin-remote: add set-head verb
Date: Fri, 13 Feb 2009 05:52:57 -0500
Message-ID: <76718490902130252t18f4f9dav7aada6fe7bb6ab1b@mail.gmail.com>
References: <1234515275-91263-1-git-send-email-jaysoffian@gmail.com>
	 <1234515275-91263-2-git-send-email-jaysoffian@gmail.com>
	 <1234515275-91263-3-git-send-email-jaysoffian@gmail.com>
	 <1234515275-91263-4-git-send-email-jaysoffian@gmail.com>
	 <1234515275-91263-5-git-send-email-jaysoffian@gmail.com>
	 <7vtz6yabsy.fsf@gitster.siamese.dyndns.org>
	 <7vhc2yaak8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, barkalow@iabervon.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 11:54:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXvgo-0000iC-Hk
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 11:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758146AbZBMKxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 05:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758140AbZBMKxA
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 05:53:00 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:56478 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758119AbZBMKw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 05:52:58 -0500
Received: by rv-out-0506.google.com with SMTP id g37so646785rvb.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 02:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KVvLK/8b+2Ye1sAYIaXOQS4TNWmftUyVpeq4Sh2C3Y8=;
        b=X681y/dHtsl0S6TFvom4+1FhLj4MwY++TVkEEvh8wLTncJLn1GNB/ZN5XgrCTgfpl+
         yg7aHKCLg9iUYRKkBWv6gpnZGbGSXsT+D84Y2o5aCFADco6E2Ehop9rw8mGqn6LINfHi
         SPgEj8m7KIpn6OKGVp1qGRbchA14YUh9f2KqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gVo5SPR4y2ndPD4AtX0NnZAVz9+DLF84E4OKsPEYs0Ig3gK/LT3C04bT3WOfWVJYH3
         2XWSdg4lBnHNbFqlGNciLT788CGUwfg5IGRXnEp5trOUOBxOZX4Sr6gCvDPYI6ciPWPh
         FFOdzhgYCmeWQW+QxVNK7hQBZVYqlxHJuWYfA=
Received: by 10.141.29.14 with SMTP id g14mr1085909rvj.232.1234522377197; Fri, 
	13 Feb 2009 02:52:57 -0800 (PST)
In-Reply-To: <7vhc2yaak8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109739>

On Fri, Feb 13, 2009 at 5:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> A few things I forgot (and before I go to bed).
>
> If remotes/<name>/HEAD already points at a branch frotz, and you peek the
> remote (i.e. you do not actually run "fetch" to download objects, but just
> "ls-remote" it) and find out that "HEAD" does not point at the same commit
> as "frotz" but it now points at the same commit as another branch
> "nitfol", you probably would want to update it to point at "nitfol", but
> it was unclear from the description in the documentation if this option
> was meant to perform this kind fo update, or only to set a missing HEAD.

- set-head -d <remote> deletes
- set-head -a <remote> sets HEAD to whatever remote it
- set-head <remote> <foo> sets HEAD to foo

I don't know how to be more explicit than that I think that's what the
documentation indicates.

> If you meant to do an update, there is one thing to watch out for when you
> reuse the logic used by clone.  It favors "master" if more than one
> branches point at the same commit as HEAD.

Yes, I know.

> You need to customize it to
> favor the one that the HEAD points at on the local side before you start
> (iow, try to keep the current value when you can).
>
> For example, if it points at "frotz" locally when the command was started,
> and you found out that HEAD now points at the commit at the tip of "frotz"
> and "master" branches by peeking, you do not want to repoint HEAD from
> "frotz" to "master".

I think that is an unnecessary complication for what is really a
corner case. And anyway, it is just hacking around the fact that we
don't really know what the remote side is if multiple branch heads
have the same SHA1 as HEAD.

You proposed a series a while back so that git could unambiguously
determine what a remote symref points to, and I think that's the
better way to fix this problem.

If the user runs "git remote set-head -a <remote>" they will get
whatever "git show <remote>" indicates is the remote HEAD. If they
don't like that, they can set their <remote>/HEAD explicitly using the
alternate syntax.

j.
