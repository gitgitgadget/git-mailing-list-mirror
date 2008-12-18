From: "Whit Armstrong" <armstrong.whit@gmail.com>
Subject: Re: is it possible filter the revision history of a single file into another repository?
Date: Thu, 18 Dec 2008 09:19:17 -0500
Message-ID: <8ec76080812180619k78a28e30t591b514148202869@mail.gmail.com>
References: <8ec76080812180551p8c97a0dqa2025e67792946c7@mail.gmail.com>
	 <200812181504.02105.thomas.jarosch@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Thomas Jarosch" <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 15:21:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDJkB-0008RI-18
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 15:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbYLROTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 09:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbYLROTU
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 09:19:20 -0500
Received: from wf-out-1314.google.com ([209.85.200.169]:37535 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbYLROTS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 09:19:18 -0500
Received: by wf-out-1314.google.com with SMTP id 27so480296wfd.4
        for <git@vger.kernel.org>; Thu, 18 Dec 2008 06:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=6wNTRI4MxkNxDz2YsN6cRbfkQwRo+xM+CCoNzNUZqvg=;
        b=dx+IiTHmKrvuZaRFb1uiEvO4XRxYLP3qlg8YNzzWiGL10kMwpeyAMTkNONQ89hAmaY
         Ioky2bop0NKDOuh2zRQl8ByUVspk/i6/LZpvh1ay0IXk22zrkW6Dj4FADrDC5tfebEn8
         MJnHGDxkUVDoeYIqZZDJkT291j2ySoMh+WXkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FHuL4Z7ya08AvOAa5ra+othb+2WDt5e++OfNsspvLMjyjH0vYOk7FlaL+0BOgr5BNF
         njARP0nzTUr6eJ57/H9WlPGOEEWE3XB9ojTsZsUVxOTgQ+O2b2lsp9LRRyjt382oLH99
         GLH0PzNyx2DPjLt8zyyU1IsKTIrAkQxazc7gw=
Received: by 10.115.110.1 with SMTP id n1mr1132084wam.102.1229609957399;
        Thu, 18 Dec 2008 06:19:17 -0800 (PST)
Received: by 10.114.136.7 with HTTP; Thu, 18 Dec 2008 06:19:17 -0800 (PST)
In-Reply-To: <200812181504.02105.thomas.jarosch@intra2net.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103465>

thanks, I will give this a try.

On Thu, Dec 18, 2008 at 9:04 AM, Thomas Jarosch
<thomas.jarosch@intra2net.com> wrote:
> On Thursday, 18. December 2008 14:51:12 Whit Armstrong wrote:
>> For instance, if my repository contains foo.c, and 100 other files.
>>
>> I would like to create a new and separate repository containing only
>> the revision history of foo.c.
>>
>> Would someone mind pointing me at some documentation for this
>> procedure if it exists?
>
> This worked for me:
>
> git filter-branch --tag-name-filter cat --index-filter \
>    'git ls-files -s |grep -P "\t(DIR1|DIR2)" \
>    |GIT_INDEX_FILE=$GIT_INDEX_FILE.new git update-index --index-info &&
>    mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' -- --all
>
> Run "git ls-files -s" to see the output format.
> Replace the "DIR1|DIR2" with "foo.c".
>
> Later on you might want to remove empty commits from the history:
> git filter-branch --tag-name-filter cat --commit-filter 'if [ z$1 = z`git rev-parse $3^{tree}` ]; then skip_commit "$@"; else git commit-tree "$@"; fi' "$@" -- --all
>
> If you want to run two filter-branch commands in a row
> or you want to free up the space in .git afterwards:
>
> - git for-each-ref --format='%(refname)' refs/original | xargs -i git update-ref -d {}
> - git reflog expire --expire=0 --all
> - git repack -a -d
> - git prune
>
> Cheers,
> Thomas
>
>
