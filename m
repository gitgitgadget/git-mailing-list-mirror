From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Am able to delete a file with no trace in the log
Date: Wed, 3 Jun 2009 06:17:17 +0530
Message-ID: <2e24e5b90906021747v327c9db1o16d03af5dcf50546@mail.gmail.com>
References: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net>
	 <20090602213439.GA7584@coredump.intra.peff.net>
	 <alpine.LFD.2.01.0906021439030.4880@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Graham Perks <gperks@ausperks.net>,
	Git List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 02:49:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBef6-0000Jr-LG
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 02:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbZFCArS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 20:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbZFCArR
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 20:47:17 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:42760 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbZFCArQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 20:47:16 -0400
Received: by qw-out-2122.google.com with SMTP id 5so5897542qwd.37
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 17:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SCMtHf4gvKkfPGMLgFP+QPM6Yrw3tePkCCM+Z6xNIlM=;
        b=xYNRGTnEb+XLQHGC4YDVIK+U5uYeqdmwAd7I9ZQG5DcM+gxlni8it4CjdyK41nW0Dz
         BpxOSgOACwrL7cSU/DSwaQcXoG2TFNXfTEub88THoxM2omT3e1z16ncXPthXCSKdg4jC
         ONTT/gf1ZvG+JnyXpaqLJQ7nXOC74w3a6zATo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tBvz2xKjK3w94n0YtLH6CU/M/OQyH7/AgnuBPn6VK3mpfwpYkUbhImbJf42HRAgyG+
         ekYXYvdAgKwhLmpyyqeyuiX0tt1JU29rE+3idFJI/LdrFLBlG3L+HbRhEeRh6pJxU3Y9
         pL1hsoy2akYTMy6b0x2rZ1IXu2hfZ5dvl8J7E=
Received: by 10.231.12.77 with SMTP id w13mr87956ibw.56.1243990037609; Tue, 02 
	Jun 2009 17:47:17 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0906021439030.4880@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120565>

On Wed, Jun 3, 2009 at 3:25 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Tue, 2 Jun 2009, Jeff King wrote:
>>
>> But it doesn't show up in "git log". I believe this is because the rule
>> for what to show in a merge commit is "if content is exactly the same as
>> one of the parents, it's not interesting".
>
> Correct.
>
> What happens is that "git log" with a filename will always simplify the
> history to the side that matches. And yes, "matching" can and does include
> "doesn't exist in child, doesn't exist in parent"
>
> Now, I admit that in this case the matching heuristic is dubious, and
> maybe we should consider "does not exist in result" to not match any
> parent. We already think that "all new" is special ("REV_TREE_NEW" vs
> "REV_TREE_DIFFERENT"), so maybe we should think that "all deleted" is also
> special ("REV_TREE_DEL")

"git merge -s ours" would do precisely the same thing, wouldn't it?
That has happened to me before, and I noticed that git log does not
show the deletion, but rationalised it as being because I had
explicitly done a "-s ours".

Fixing this would fix that (maybe more common) case too, and show that
the merge commit removed the file.
