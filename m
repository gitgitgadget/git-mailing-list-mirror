From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 4/4] builtin-remote: add set-head verb
Date: Fri, 13 Feb 2009 21:59:06 -0500
Message-ID: <76718490902131859u4645dc62h79632cb20ee90d69@mail.gmail.com>
References: <1234515275-91263-1-git-send-email-jaysoffian@gmail.com>
	 <1234515275-91263-2-git-send-email-jaysoffian@gmail.com>
	 <1234515275-91263-3-git-send-email-jaysoffian@gmail.com>
	 <1234515275-91263-4-git-send-email-jaysoffian@gmail.com>
	 <1234515275-91263-5-git-send-email-jaysoffian@gmail.com>
	 <7vtz6yabsy.fsf@gitster.siamese.dyndns.org>
	 <20090214002253.GA7769@coredump.intra.peff.net>
	 <7vab8p4w1u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	barkalow@iabervon.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 04:09:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYAug-0007rz-8w
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 04:09:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbZBNC7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 21:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753407AbZBNC7K
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 21:59:10 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:60606 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbZBNC7H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 21:59:07 -0500
Received: by rv-out-0506.google.com with SMTP id g37so900764rvb.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 18:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3HGhRzOP9vZ6wuIBxCm/+H070125J5z0M5WXHRe0RIE=;
        b=VeIuh0bXF/Gf5QgtD9Ps/L2q6r8pXKa4IfKlpiG6kPh8iL5U+6JkF4zH+fmdhEQMuv
         YhxxlLnmUhZ+SHhnKKYSB9/wePKOwj2ky+F8XItVcrcmBA3l5o72hCwvGi6Cpjh6t52/
         zeZMFzPWABBAP8vlwkxsGWVy18OOa4MAW7IkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h5qnayOMQjd2Yv0fW4LWM48PboIWynUmhhmbLgd4VV8wp3zHUkVC81KCeqiOYcDDSZ
         hbjVcSyD8v0xbtA4mjK3SkHv2oUNqv51nTlQtda8em3yS3M5Fbo/RrmsG0mQg5nYd+z5
         5DQ/j0IZZ7z+/Xo2ejdofZKZS3/6hIyLRtD4M=
Received: by 10.141.76.21 with SMTP id d21mr1460713rvl.34.1234580346955; Fri, 
	13 Feb 2009 18:59:06 -0800 (PST)
In-Reply-To: <7vab8p4w1u.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109811>

On Fri, Feb 13, 2009 at 9:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I do not care too deeply if an explicit request to "set-head --auto"
> screws up and sets a HEAD that was pointing at the right branch to another
> branch because the command is not taught to give preference to the branch
> HEAD originally points at

So I don't mind fixing this, but here's the thing.

Say user has refs/remotes/origin/HEAD set to frotz. They then run "git
show remote origin" and we see that HEAD on the remote end could be
either master or frotz (both have the same SHA1).

What should we show in the output of "git remote show origin" next to
the HEAD line? master, or frotz? If we show master, then user might
wonder why "git remote set-head origin --auto" leaves
refs/remotes/origin/HEAD set to frotz. If we show frotz, then user
might wonder why when they cloned the repo in the first place they
ended up with HEAD set to master.

I'm bothered by that inconsistency, which is why I didn't follow-up
with another patch immediately.

But I will propose an alternative. In the output of "get remote show
origin", we show all matching branches. If the user does a set-head
--auto and we cannot determine HEAD unambiguously, we do something
like:

$ git remote set-head origin --auto
error: Multiple branches match HEAD. Please choose one explicitly with:
   git remote set-head origin master
   git remote set-head origin frotz

Hmm?

j.
