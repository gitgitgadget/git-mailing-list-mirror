From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 15/16] checkout: add new options to support narrow checkout
Date: Wed, 17 Sep 2008 20:49:54 +0700
Message-ID: <fcaeb9bf0809170649w418f4af5x3055c04994c694dc@mail.gmail.com>
References: <48cdde2837b2d_12d73fc6eb2c355c27876@app02.zenbe.com.tmail>
	 <200809152205.15388.jnareb@gmail.com>
	 <fcaeb9bf0809160521o24fd26e4l40f1798228d51712@mail.gmail.com>
	 <200809171107.35826.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 15:51:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfxQx-0007yj-65
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 15:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361AbYIQNt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 09:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752217AbYIQNt5
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 09:49:57 -0400
Received: from gv-out-0910.google.com ([216.239.58.189]:7099 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbYIQNt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 09:49:56 -0400
Received: by gv-out-0910.google.com with SMTP id e6so1587027gvc.37
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 06:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=acH9kzgQl8SoE0vZBP++sSQdhtTxOlE81v79L9JsUDY=;
        b=x0OidGOg1wUyPCIRV6ACwRxWJjMouKBqHg2Z+liKaBHTq3vIcBDEKP++9TQ+YqVCe1
         5RBtg3YDj18cpGyEJvFAG8xHyBwzcK/4+By6/9KKN18zLN1RCOgl0Wysf/lltTI9EakB
         CelL062CxKmOS+H6bEvANUhD8NSfGJ8nB9pLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PH/Fevyb7Vq6tUSqV3S08BsaWJwaVPmLJtgjalqMxaKjJDxrd/Q7KB+mkdk3ANyzc/
         1VJKZFBaNXy/uJisEAD3VVI9FJq9j74ckaM/JXO964A3O3s34GoIszkQ6ux9AYraeqV1
         b1QcxU33cvFcfRhFzKN7MkSlO8CxeMpFM8pLc=
Received: by 10.86.59.2 with SMTP id h2mr1038828fga.40.1221659394515;
        Wed, 17 Sep 2008 06:49:54 -0700 (PDT)
Received: by 10.86.59.5 with HTTP; Wed, 17 Sep 2008 06:49:54 -0700 (PDT)
In-Reply-To: <200809171107.35826.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96114>

On 9/17/08, Jakub Narebski <jnareb@gmail.com> wrote:
>  >> You have decided then on the term 'narrow checkout', and not
>  >>  'partial checkout' or 'sparse checkout', then?
>  >
>  > Not yet. I tend to prefer partial/sparse checkout. Probably should
>  > have a look at how other SCMs do and what term they use. If Git's
>  > functionality is so different, a different term might notice people
>  > about that.
>
>
> Perhaps whip up a survey? Just kidding (or not).

Well I've been asking about the name on this list long enough. I'm
going with 'sparse checkout' as svn' sparse directories does not look
too different from git's.

>  >>> When you apply new narrow spec to your working directory using either
>  >>> --path, --add-path or --remove-path, it will update "checkout" status
>  >>> in index accordingly. Moreover, if a file is marked "no-checkout" and
>  >>> is present in working directory, it will be removed. If a file is
>  >>> turned from "no-checkout" to "checkout", then it will be added again
>  >>> to working directory. Modified and unmerged entries can't bear
>  >>> "no-checkout" status, if narrow spec applies to them, "git checkout"
>  >>> will refuse to update working directory.
>  >>
>  >>
>  >> Do I understand correctly, that if one uses --path=<colon separated list>
>  >>  _only_ filenames matching one of patterns specified would be checked out,
>  >>  --add-path=<path> would additionally checkout given path and mark "wanted",
>  >>  and  --remove-path=<path> would additionally mark "no-checkout" and remove
>  >>  path?
>  >
>  > --add-path/--remove-path also use narrow spec, which could be more
>  > than one pattern.
>
>
> What is the difference then between --add-path and --path? The fact
>  that --add-path can be incremental, and --path starts always from
>  an empty set?

--path clears out all no-checkout bits and set again based on the
given spec. --add-path adds more checkout entries based on the given
spec, think of widening checkout area. --remove-path does narrow the
checkout area. They are like '=', '+=' and '-=' operators
respectively.

>
>  >>  What --add-path starts from, i.e. does
>  >>
>  >>   $ git checkout --add-path=.gitignore
>  >>
>  >>  starts from empty set if --add-path is first, or from full set as without
>  >>  --add-path?
>  >
>  > I'm not sure I understand this.
>
>
> Well, what I wanted to ask is if --remove-path starts from fully
>  checked out repository, for example if
>
>   $ git checkout --remove-path=some_large_file
>
>  would checkout all files _except_ 'some_large_file'.

No, there is no negative spec. Like I said above, --remove-path is to
remove some files based on the given spec.

>
>  >>  And is <pathspec> matched against full pathname, or like .gitignore
>  >>  rules, i.e. as full pathname if it has at least one '/' in it?
>  >
>  > like shell wildcard, full pathname must match. On my way back home, I
>  > thought I should have removed mention of "pathspec", which behaves a
>  > little bit different.
>  >
>  > Also those specs are relative to working directory though, so if you
>  > are in b/c and want to match d, you only need to type --add-path=d
>  > instead of --add-path=b/c/d. Will add this to doc.
>
>
> I would have thought that you follow the same rules (perhaps with
>  exception of !path excluding rule) like for gitignore and gitattributes.
>

Um.. never thought of gitignores/gitattributes rules before. It's a
good idea all narrowspec/gitignore/gitattributes using the same rules.
Thanks.
-- 
Duy
