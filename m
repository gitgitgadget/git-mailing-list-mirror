From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: update-index --assume-unchanged doesn't make things go fast
Date: Fri, 27 Jun 2008 13:56:22 -0400
Message-ID: <32541b130806271056k4698a607r11e9fbaf9102e6f1@mail.gmail.com>
References: <32541b130806250944x717cf609x7aa520c77a7c6911@mail.gmail.com>
	 <20080626112233.GA17625@cuci.nl>
	 <32541b130806271001t35eb97d2gb841e194b54f214@mail.gmail.com>
	 <m3lk0qiy2i.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 19:57:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCICK-0006Ps-36
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 19:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189AbYF0R41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 13:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753495AbYF0R40
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 13:56:26 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:22382 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbYF0R40 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 13:56:26 -0400
Received: by fk-out-0910.google.com with SMTP id 18so538673fkq.5
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 10:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JiUKtt5399fUVS3cSm/zRDM5Y/CNad+oEzLGXTPuv7o=;
        b=uAiL1aWG5oJyQU11djlClnz4VWdiQ+AdculHSAvNx5G/GvHJljxEmdRwNDz4hQQChn
         zab0FFKOhPPNVaiKU1WW0R/LYqshKFQPn9WV2k0iOcPQATST+xcC9LS7wuTg8zmi3EpM
         j5cSpwU4syTWNl2xtZayCvraA/dntI/bUcy+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wTiV/7tt9L9HcDFbXyARgoTf1R0iqVeOgnAxHmMXVEGhFxV/892+cbHMC/8IW3JdEz
         GRqJ7eP85n1ujon1HHixZcnaUWyeUN3Qefv5m3k3MGNyIOw7F/dxinxe7AHL7/A64wZb
         vm4BuBJoNw4kVtzWsbAesrOUIkB2i4ITMR088=
Received: by 10.82.156.10 with SMTP id d10mr70443bue.72.1214589382177;
        Fri, 27 Jun 2008 10:56:22 -0700 (PDT)
Received: by 10.82.175.10 with HTTP; Fri, 27 Jun 2008 10:56:22 -0700 (PDT)
In-Reply-To: <m3lk0qiy2i.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86613>

On 6/27/08, Jakub Narebski <jnareb@gmail.com> wrote:
> "Avery Pennarun" <apenwarr@gmail.com> writes:
> > On 6/26/08, Stephen R. van den Berg <srb@cuci.nl> wrote:
>  >> Avery Pennarun wrote:
>  >>> 1) What's a sensible way to tell git to *not* opendir() specific
>  >>> directories to look for unexpected files in "git status"?  (I don't
>  >>> think I know enough to implement this myself.)
>  >>
>  >> Would checking the mtime on the directory itself help?
>  >
>  > I'm guessing it would help somewhat (although not as much as not
>  > checking anything at all).  However, we'd still have to check the
>  > mtime *against* something, and I don't think the index stores
>  > information about directories themselves.
>
> By the way, from time to time there on this mailing list is idea
>  to add entries for directories in the index.  This could help situation
>  like yours, tracking emty directories, faster operations when some trees
>  are unchanged, subtree <-> subproject changes.
>
>  But it always comes back to: 1.) no proposed implementation, 2.) "git
>  tracks contents"...

Yes, I've seen the occasional discussions about this.

I might volunteer to help solve (1) except that I have a feeling that
changing the index format would mangle all sorts of things beyond my
current understanding.  Attaining that understanding might not be so
bad, except for (2), which seems like any proposed changes will
probably be rejected anyhow.

So naturally I was hoping for a magical alternative suggestion for my
current problem instead :)  One option I'm thinking about is to have
my proposed daemon keep its own "index", which tracks *all* the files
on the filesystem, not just the ones that have been
git-update-index'd.  Then anything that needs to compare against the
filesystem can choose to compare against the contents of this file
instead if it exists (and/or the right option is set, etc).  Does that
sound sane?

Have fun,

Avery
