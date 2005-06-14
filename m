From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Semantics for one step undo/redo
Date: Tue, 14 Jun 2005 23:54:17 +1000
Message-ID: <2cfc4032050614065443119d5f@mail.gmail.com>
References: <2cfc403205061406507af5a66@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Jun 14 15:49:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiBnG-00020c-0A
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 15:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVFNNyW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 09:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVFNNyW
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 09:54:22 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:41827 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261210AbVFNNyR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2005 09:54:17 -0400
Received: by rproxy.gmail.com with SMTP id i8so1606519rne
        for <git@vger.kernel.org>; Tue, 14 Jun 2005 06:54:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IUtaFK08pRGI0HG7v/cmGM68snNY69fwezzgWJj/voYviFkfEWWSEMic2RiMA6DPaKzRkG9A9VerSkZxa5vr8tCsFh7AfbZz4qvb0rHKyqxlG1ykn3bpCfaXTf2JFEn1R0DOao/fH2EQqbnj8RSHturn/oBLWJgEJ/N0l6y+fFg=
Received: by 10.38.66.68 with SMTP id o68mr1562039rna;
        Tue, 14 Jun 2005 06:54:17 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Tue, 14 Jun 2005 06:54:17 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <2cfc403205061406507af5a66@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sorry, I omitted an important aspect of REDO Post-conditions - corrected below

> REDO Semantics
>     - redo will replay a previous commit but any or all of the tree,
> the parents, the message may be replaced by edited values.
> 
> REDO Pre-conditions:
>     - at least one entry exists in the .git/redo-log
>     - the cache matches the working tree
>     - .nextmsg contains the commit message
>     - HEAD contains the commit id of the current predecessor (which
> may differ from the logged value)
> 
> REDO Post-conditions:
>     - the working tree is committed with .nextmsg as its message, the
> first parent replaced by HEAD and the remaining parents read from .the
> tail of .git/redo-log
>     - .nextmsg is cleared
>     - the last line of .git/redo-log is removed

additional post-conditions:

     - the diff between the old head and its old parent (as read from
the log) is applied to the workspace and cache.

     - if the re-applied diff fails, the workspace and cache are
returned back to the state immediately following the previous commit
and the user has the chance to manually reapply the diffs before
updating the index into a state that allows further redos

jon.
