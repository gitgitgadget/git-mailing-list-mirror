From: David Aguilar <davvid@gmail.com>
Subject: Re: Running vimdiff in read-only mode with git-difftool?
Date: Sun, 17 May 2009 22:51:14 -0700
Message-ID: <20090518055113.GB32259@gmail.com>
References: <9e00fd550905172201n6c95dc1bia48c9ac25d8ec98f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nick Welch <nick@incise.org>
X-From: git-owner@vger.kernel.org Mon May 18 07:51:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5vl7-0004rN-EZ
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 07:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324AbZERFvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 01:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755128AbZERFvW
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 01:51:22 -0400
Received: from mail-pz0-f115.google.com ([209.85.222.115]:62306 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755186AbZERFvV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 01:51:21 -0400
Received: by pzk13 with SMTP id 13so1842226pzk.33
        for <git@vger.kernel.org>; Sun, 17 May 2009 22:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kEDKlvlvrbTMiU36d+x6PHKP9t5VGCzihKK7WgBpqik=;
        b=IUHrQBxtOmEWe3RIugIVF1+zzMIH0+DvjB9mnWDgzwhBJ1C++uPd15txCVSAaphOT9
         1U3UZ2ZBmyG9ckr7E8uwLJxEAgNIDHcStjMFZOkX/FNl6riavHMc+nbUIWNcZhor5uKg
         5LMtNbl/7YIU0NTpOaFFdXX52vWb7dNqtidw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=POlVADXJexy90tMMqDJn2KTtAwy2wRfc5QCVnuzfQQwsgPFGJmZW8TYPqiOWpnWD9r
         p2iMFJM2hn3pcdHzyXBk7i1lspcEErLwpizhtrBZJIHmmWtTI20AXYypuhOf9WMuTXiX
         YeCeMAsaOp6cZfIgTyA69iIC5cZfgZr/f4tOc=
Received: by 10.114.208.20 with SMTP id f20mr10334458wag.225.1242625882263;
        Sun, 17 May 2009 22:51:22 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m28sm4498528waf.2.2009.05.17.22.51.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 May 2009 22:51:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9e00fd550905172201n6c95dc1bia48c9ac25d8ec98f@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119416>

On Sun, May 17, 2009 at 10:01:02PM -0700, Nick Welch wrote:
> I'm running:
> 
> git difftool -y --tool=vimdiff -U99999 --patience
> 
> and I have the following in ~/.gitconfig:
> 
> [difftool "vimdiff"]
>     cmd = "vimdiff -R"

I forgot to mention a couple of things.


If you do change that to e.g. "myvimdiff" you'll need
the $LOCAL and $REMOTE params as well; probably something
like:

[difftool "myvimdiff"]
	cmd = vim -R -d -c wincmd l \"$LOCAL\" \"$REMOTE\"


$ git difftool -y -t myvimdiff


Secondly, git-difftool receives both the pre and post-image
and doesn't actually receive the output of git-diff, so passing
--patience unfortunately won't do what you're expecting it to
do.  Piping the output of git-diff to something like kompare(?)
is probably the only way to get the nice --patience result.

It'd be nice if all diff/merge tools supported the patience
diff algorithm but that's not the case right now.

-- 

	David
