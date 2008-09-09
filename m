From: "Elijah Newren" <newren@gmail.com>
Subject: Re: Revert behavior
Date: Tue, 9 Sep 2008 16:51:20 -0600
Message-ID: <51419b2c0809091551n6f1f627cica23312795502225@mail.gmail.com>
References: <51419b2c0809090626p2196c590j7569fb471e470f0d@mail.gmail.com>
	 <200809091538.13961.jnareb@gmail.com>
	 <20080909212834.GC10544@machine.or.cz>
	 <e06498070809091439q1c543807pd6e74b7ada32434@mail.gmail.com>
	 <7v63p53r93.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Walter" <stevenrwalter@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>, "Jakub Narebski" <jnareb@gmail.com>,
	"Govind Salinas" <govind@sophiasuchtig.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 00:52:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdC4U-0002ux-0h
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 00:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbYIIWvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 18:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753753AbYIIWvW
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 18:51:22 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:13084 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbYIIWvV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 18:51:21 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2098781rvb.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=bPgPhbmbW8ShAk1OIqTFcc4ssex3TkBs7t8KdOExLoI=;
        b=NbQlN+lkoLB2Bc2PdB9eO/2uheSDYMHmie2Tkaqif0nydwNx7iCsB9z/fWZ5zAppMZ
         BF1ESwYSDLaGvBXhgLo3d3hmlFF+zqWc7NRpw8G0c1kMF3CWLMe0AZ/skn9oT01LObwE
         w5pO+frxYYBz5Yj+EjWQRDljnQzp7PsJEsqGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=n9wEYnbnXtwp3R8Bs5qqS+aXUK3MSXDGfO9OL1MKD6Ofp204+LMtSWp6b8N0nBHSxl
         Kd/MneGxoAgrceSYa7NKXyHgT0mVoH4YYTgqpOuW0KjqaJJL3Trntr7YCdoI2V1k3EVH
         pebZOoFVAxe5M1moJsMD3dIDswIt7+pGo4gFU=
Received: by 10.141.197.8 with SMTP id z8mr251840rvp.157.1221000680837;
        Tue, 09 Sep 2008 15:51:20 -0700 (PDT)
Received: by 10.141.5.11 with HTTP; Tue, 9 Sep 2008 15:51:20 -0700 (PDT)
In-Reply-To: <7v63p53r93.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95452>

On Tue, Sep 9, 2008 at 4:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> If you implement "eg svn-like-revert" to checkout the given paths out of
> the last commit, instead of the index, shouldn't that be sufficient?

No, that would leave staged changes unreverted -- a particular case of
which means that revert wouldn't be able to undo an add operation.
For svn-like-revert, the default should be for both staged and
unstaged changes to be undone, unless the user specifically requested
that only part of the changes be reverted (e.g. with --staged or
--unstaged flags).  Making revert work prior to the initial commit for
new adds is another case that needs a command with behavior different
than git's checkout of paths.

>> It it a delicate balance to have the user interface match both the
>> mental model of the user and the storage model of the tool.
>
> I do not think it is that simple.
>
> You could match the user experience to the mental model of the other tool,
> by hiding the differences and insisting that people use only your tool.
>
> The real issue is that you may need to castrate the underlying tool in
> certain places if its world model is richer than the model the tool you
> are trying to emulate.  Ignoring the index by making "svn-like-revert"
> work on both index and the working tree file at the same time is a good
> example of that.

Why?  If the command _by default_ works on both the index and working
tree file, is that necessarily bad ('git checkout BRANCH' operates on
both)?  If the tool can only operate on both at once, then sure, I
agree, but that at least isn't the case with eg and wasn't my
suggestion for git.

Not all alternate porcelains try to hide or destroy the index.  Some
of us really do love it.


Elijah
