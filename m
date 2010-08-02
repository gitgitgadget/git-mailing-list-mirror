From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: jk/tag-contains (Re: What's cooking in git.git (Jul 2010, #05;
 Wed, 28))
Date: Mon, 2 Aug 2010 15:02:09 -0500
Message-ID: <20100802200209.GD2180@burratino>
References: <7vvd7zuecv.fsf@alter.siamese.dyndns.org>
 <20100730183709.GC18544@coredump.intra.peff.net>
 <20100731060703.GA21207@burratino>
 <20100731123328.GA5273@coredump.intra.peff.net>
 <7vocdlpsmw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 22:03:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og1Ef-0000L7-9s
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 22:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755145Ab0HBUDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 16:03:39 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43320 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767Ab0HBUDi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 16:03:38 -0400
Received: by yxg6 with SMTP id 6so1386071yxg.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=cNgd7lF3pm9TwxCqAcG6Mo797CSVXk3u77ZUTzqJ6DQ=;
        b=OWoVt+gCBGC+ddvOkS5JS0618Ywb9WvmYnNnBjkJDv+fl0XhgZvPDeuSN9bPj42Sk7
         OTHvUAnrMAQiZX1U9jPidyp7F6Z8DrE5Idx9TED+W37bSnhg9tFTuys7AFM86ZqLSroC
         XK8HXgkVUfM0LVsyjywBv+bTYEUz8/FgbemSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Z+HCwfSaMxAs3ykJ2FYOfMCeUAEXTflBkrdlNRpM0kV7g9+XeWgIcDPwpZOYxwipCT
         Pp22gwNuMtIUvUWZipWM9V+Wz2ybEg8gQfsbUlwRYNGbVkcxVpI9F0kT5Bk4yjf0hS61
         AO+jIo3coZ7IG79jQwg0JpNY+3fg2tuFFe2fU=
Received: by 10.90.71.2 with SMTP id t2mr1421701aga.26.1280779409818;
        Mon, 02 Aug 2010 13:03:29 -0700 (PDT)
Received: from burratino ([64.107.3.126])
        by mx.google.com with ESMTPS id g31sm5788183ibh.4.2010.08.02.13.03.25
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 13:03:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vocdlpsmw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152448>

Junio C Hamano wrote:

> You need to be careful here, though.  What if you pulled from somebody
> whose clock is set grossly in the future?

We could check for that and give relevant advice:

 fatal: committer date <date> precedes parent date <date>
 hint: It looks like you are trying to commit on top of a commit
 hint: from 5 years into the future.
 hint: Use "git rebase -f" to rewrite the commit with a more
 hint: sensible date, and please, fix your clocks!

> I wonder if we can make fsck to notice a commit with a wrong timestamp
> (i.e. older than some of its parents) and make a note of it (hopefully
> they are miniscule minority)---then during the revision traversal when we
> hit such a commit, we perhaps ignore its timestamp (pretending as if its
> timestamp is one of its children or parent---I haven't thought about the
> details, but the note fsck leaves can record what adjusted timestamp
> should be used) to fix the issue?

Thanks --- at first glance, this idea would seem to allow much faster
revision limiting.
