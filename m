From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git-rebase --abort eats files
Date: Mon, 28 Jun 2010 11:05:17 +0200
Message-ID: <20100628090517.GA8091@debian>
References: <20100626125924.160F11F212@leonis4.robolove.meer.net>
 <201006262009.30380.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Madhu <enometh@meer.net>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jun 28 11:03:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTAFm-00056Z-Qh
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 11:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754428Ab0F1JDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 05:03:39 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37320 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794Ab0F1JDi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 05:03:38 -0400
Received: by wyb38 with SMTP id 38so1576414wyb.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 02:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fQcS3RrtoVI8TH5bp/So1gBRb4wEiNBhzu2Kjl2/nqs=;
        b=U2wr57Qiq2OY7TA4BGzVzHy6KOmNrhLDiTX3XUMdOpSbr13Gu4Ax7wS4cpi16sgLhJ
         pUyVYGfUapVpNJzvuDRK165LZmFSp+vTuzcp/37xRz68tAlZWNa7yzVAKhe8yia8Qc9J
         qnrziHjakuCjcfA0fNAclmulLoDFXV/tPW9Sw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bntvDlglC9Ax4QkRSntSCBGMrOrLxR9ahVGuVSsNObW2J52fxGKTTzrw7nJR+k/nvC
         J8Z7his2RHGkiorYi1v/SNNYb3Iu54YMcj16dkMzHgpmdmO7qROA2lISBLSWvf7+QE+u
         YzINjEF5oZ2KFid6n1mg5uIgA1MUw+9YCOkUM=
Received: by 10.227.134.16 with SMTP id h16mr3697933wbt.69.1277715817063;
        Mon, 28 Jun 2010 02:03:37 -0700 (PDT)
Received: from debian (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id p17sm64837583wbe.8.2010.06.28.02.03.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Jun 2010 02:03:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201006262009.30380.j6t@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149823>

Hi Madhu,

Johannes Sixt wrote:
> On Samstag, 26. Juni 2010, Madhu wrote:
> > +++ b/git-rebase--interactive.sh
> > @@ -749,6 +749,7 @@ first and then run 'git rebase --continue' again."
> >                         git symbolic-ref HEAD $HEADNAME
> >                         ;;
> >                 esac &&
> > +               git-reset &&
> >                 output git reset --hard $HEAD &&
> >                 rm -rf "$DOTEST"
> >                 exit
> 
> No, it can't be that simple. If rebase stopped due to a conflict on a commit 
> that added new files, then your version of rebase --abort will leave these 
> new files behind as untracked.

Right. The interactive rebase has to be able to differentiate between
files that you added to resolve a conflict and files that you added to
retain at the end of the rebase -- and the interactive rebase has no
information about this. Hence, this problem can't be fixed without
explicitly finding out the intent of the user. In my opinion, you
should simply stash your changes before aborting the rebase instead of
adding files and figuring out some complex way of expressing intent.

-- Ram
