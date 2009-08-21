From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Raw commands to add object to existing tree
Date: Fri, 21 Aug 2009 22:39:49 +0000
Message-ID: <32541b130908211539ke64bd2bif0aa7cff6bc6ae8f@mail.gmail.com>
References: <ef72456d0908211531m5e261805p2f67d3a8a16a0b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: D Sundstrom <sunds@peapod.net>
X-From: git-owner@vger.kernel.org Sat Aug 22 00:40:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MecmV-0003QI-4a
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 00:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932800AbZHUWkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 18:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbZHUWkJ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 18:40:09 -0400
Received: from mail-gx0-f205.google.com ([209.85.217.205]:37034 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396AbZHUWkI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 18:40:08 -0400
Received: by gxk1 with SMTP id 1so1369584gxk.17
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 15:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=QoHBHCNNX2C7RelMbLuqQVc1liKapPG3Upmc2l8/3q0=;
        b=AMsuuNA9hB6bgCzSEoRZrrunIH8ALh1EMI6NVGko/pkSXl5GjhTwCsufjekMn8hSHE
         Lf3pn/xafL/sCPrrPFMm6PtsuBXhNaw8U6Yp868W5kqExbd/Hs4UbDNfMXtdnuL7CY2l
         hD2aNj9e8NPPniDsBWqeLhJtDi+Z7R58yCGzY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=PyuS5vp84OSpfjevj6gkWjGSBVhU/WvoWeQ+oQU2XjZxZ3rLTd3FM6xYDEvwytvv07
         5x0B79XkucL2o148Dy5WRW/NAcZxTyFeiTj5PT6+vwbwG30ykPewZ7IpZvzBOqGnjazX
         Rw3MzuxW3QmTVeassuAFFPoI58R8mTnu3IM90=
Received: by 10.150.159.19 with SMTP id h19mr3212088ybe.221.1250894409080; 
	Fri, 21 Aug 2009 15:40:09 -0700 (PDT)
In-Reply-To: <ef72456d0908211531m5e261805p2f67d3a8a16a0b5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126768>

On Fri, Aug 21, 2009 at 10:31 PM, D Sundstrom<sunds@peapod.net> wrote:
> Both the community git manual:
> http://book.git-scm.com/7_raw_git.html
>
> and Pro Git book:
> http://progit.org/book/ch9-2.html
>
> walk you though low level details of creating objects and trees in git, and
> then committing these new trees.
>
> However, they do not show you how to add and commit into existing trees.

Naturally, you can't change an "existing" tree, because any given tree
(identified by its sha-1 hash) can never change.  You presumably want
to create a *new* tree and commit that.

The easiest way I know to do this is to create a new indexfile, fill
it with what you want, and create the tree for that.

(Warning: untested code follows)

export GIT_INDEX_FILE=/tmp/my-temp-index
git read-tree PREVIOUS_COMMIT_OR_TREE_ID
hash=$(git hash-object NEW_FILE)
git update-index --cacheinfo "0644 $hash path/of/file/in/tree"
commitid=$(echo COMMIT MESSAGE | git commit-tree $(git write-tree))
git update-ref refs/heads/BRANCHNAME $commitid PREVIOUS_COMMIT_OR_TREE_ID

Have fun,

Avery
