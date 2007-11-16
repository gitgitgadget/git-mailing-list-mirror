From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 4/2] Fix parent rewriting in --early-output
Date: Fri, 16 Nov 2007 09:30:55 +0200
Message-ID: <e5bfff550711152330m401c39e8g7a2ff7be834f0d56@mail.gmail.com>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
	 <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
	 <alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
	 <alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
	 <18221.14113.498416.396006@cargo.ozlabs.ibm.com>
	 <alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org>
	 <alpine.LFD.0.999.0711041004220.15101@woody.linux-foundation.org>
	 <alpine.LFD.0.999.0711041124050.15101@woody.linux-foundation.org>
	 <alpine.LFD.0.9999.0711122046570.2786@woody.linux-foundation.org>
	 <18233.30098.470244.421468@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Nov 16 08:31:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsvfV-0002pB-Na
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 08:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbXKPHa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 02:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbXKPHa5
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 02:30:57 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:44905 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbXKPHa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 02:30:56 -0500
Received: by rv-out-0910.google.com with SMTP id k20so609047rvb
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 23:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RJqDPux6Al9X0Yh/5V5iYbJz/PRiqw5Ukht2ynmbvTs=;
        b=htjI4KLu+VnXUR9DnwcV9NfEsOJG9SA+qvfAd/rUN36vcs0cmW41B5HdUPYsYNgLsvpPp0KHPT9QcF42QMxTFSajEmOvRKjJUwc+CxNCDTLXhO4GVHJlPdKCimATPdz+293ZW/ogX5xSyZZk2H8roUxBTPzK09LqFhuLvBJ7IGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I7U+evSOW6mZdeAhtgg+UY7NfY7uH6qbIf+2cu2C0GnWxF29dx+DZuy5+0lNditNGjKcReUvv86jekfcr8LmjC4acuGnSRBGviHFk0LOjc0YnUhTNmKhfyR8QaN7U8PoHxWrJ5V9D0AI6YrvpeA8D9z2icOEijUt8+DnUG8veIs=
Received: by 10.141.153.16 with SMTP id f16mr461423rvo.1195198255950;
        Thu, 15 Nov 2007 23:30:55 -0800 (PST)
Received: by 10.140.185.19 with HTTP; Thu, 15 Nov 2007 23:30:55 -0800 (PST)
In-Reply-To: <18233.30098.470244.421468@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65198>

On 11/13/07, Paul Mackerras <paulus@samba.org> wrote:
> Linus Torvalds writes:
>
> > However, while the parent is now correctly rewritten, it looks like gitk
> > is confused by this. Gitk will remember the original parent information,
> > even if a replay has given new parenthood information. Since the partial
> > early-output information is triggered by timing, this means that gitk will
> > show some totally random parent that quite possibly won't even be part of
> > the final commit set at all!
>
> Yep.  It will be a little complex to deal with that because there are
> bits of state that I set up for the parents, and if they're the wrong
> parents, I'll have to go back and undo that.
>

Sorry to comment on a gitk thread, but the problem of different
parents for the same sha while replaying was hitted by me also with
qgit when tring to implement --early-output

I don't know if i is suitable also for gitk but in qgit I changed the
match algorithm to check also for same parents and not only for same
sha during a replay to detect something has changed, so to catch
different parents cases early on and avoiding "going back" that is
complex.

IOW when git log print outs a replay qgit enter in a state where it
checks all the arrived sha against the already sent ones and at the
first mismatch flushes the tail at the point of mismatch.

The modified algorithm instead of chek just the sha checks also
parents info (because git log is called with --parents option this
ends up comparing the first line of the commit message).

Marco
