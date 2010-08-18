From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [BUG?] Fresh clone of jquery.git shows modifications?
Date: Wed, 18 Aug 2010 20:55:08 +0200
Message-ID: <39E322E1-DA85-48D8-A279-75CDDD3A2881@gmail.com>
References: <1282135226.24584.92.camel@wpalmer.simply-domain> <2F030CF4-995A-4BA2-9D79-DA2A71F9FF79@gmail.com> <1282140854.24584.112.camel@wpalmer.simply-domain>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 20:55:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlnnA-0006pa-96
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 20:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795Ab0HRSzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 14:55:13 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56634 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab0HRSzL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 14:55:11 -0400
Received: by mail-ey0-f174.google.com with SMTP id 5so620907eyg.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=lfXUrFMMTUeT3dMxS7SptkCQPoTsQM+YnkSXz97RMxA=;
        b=dxZmIRyLGhnWCPZLxSIvqnU//P7azczQDagxrQBsQlACcG4j+pXq484kTsiwy7tNHf
         MT68a5nYHN7GOr0p27el5UJoGAXevmd0yvHMJF1RLSutBCMmH1puJ83JSOm1u+cyTXSC
         Vs6UDWcXZ4dag2k8NFlYIdxwFv9TgUCAFqxfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=UBdROC/EcEVEYqS8sQvQQa4MloLwe6CDbcSnZUDUThrYF9QdQWBvf6g9Ru+2HZwYoA
         0KkGKgiy6txQ4BwLAars5oToKyvehWpADEbVjrosIYEz51CzfpJrRw4nbRvZKtKuwu/K
         L5pk8sOCAGfzdzYtJRXhsZZWv4N/B1OBLtSMU=
Received: by 10.213.33.136 with SMTP id h8mr2387452ebd.94.1282157710790;
        Wed, 18 Aug 2010 11:55:10 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id v59sm1015812eeh.16.2010.08.18.11.55.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 11:55:10 -0700 (PDT)
In-Reply-To: <1282140854.24584.112.camel@wpalmer.simply-domain>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153873>

On 18. aug. 2010, at 16.14, Will Palmer wrote:

[...]

> I don't know when the .gitattributes file was added, surely git should
> account for varied settings over time, especially when the meanings of
> those settings have changed over time? Something like "only apply when
> there are other changes to this file", or only when the newline-status
> of the file itself has otherwise changed, for that matter.

"core.autocrlf" now does something like this: it only converts a file if it contains no CRs in the repository.  The downside to this behaviour is that line endings are no longer normalised, but since normalisation never worked very well as a configuration setting, that's a worthwhile tradeoff.

The attributes are used to enable normalisation unconditionally, and this _should_ be okay since they are versioned along with the contents of the repository so those contents _should_ reflect the attributes' settings.  Unfortunately, as you discovered, this isn't necessarily true in older repositories.  Fortunately, as Thomas Rast noted elsewhere, .git/info/attributes can work around the problem.

[...]

>> If you turn on core.autocrlf=input or core.autocrlf=true you should get the same behaviour with older gits as well.  Note that msysgit has had autocrlf enabled by default for years, so no positive action is required to do this.
> 
> This was one of the first things I tried, but with no luck. Perhaps
> there is some extra step involved to tell git "update the working copy
> using the new setting"? I have tried both git checkout --force HEAD, and
> git reset --hard HEAD, but neither seem to have an effect.

"rm .git/index && git reset" usually does the trick for me.  If the index is intact, git will know that you haven't touched any files and won't bother to check them.

[...]

>> Git _is_ giving you a real pristine copy, it's just informing you that your repository is not consistent with the attributes you have set.
> 
> "pristine" to me means "no changes". If there is an inconsistency which
> git doesn't like, git should complain about that, refuse to checkout,
> declare "broken repository! Oh no!" and refuse all operations, etc. It
> git can determine that it is unable to act in a sane manner, I don't
> want git to just go ahead making wild guesses.

I don't see how refusing to check out would be helpful.  How would you recover from that?  I think git does the least it can in this situation: no files are modified in any way, but the user is notified that some of them will be modified if they are "git add"ed.  If they are then committed, the problem is solved and future checkouts _will_ be "pristine".

In your case, simply committing the normalised files isn't an option since some of them are binaries and will be corrupted, so modifying .gitattributes is the way to go there.

[...]

> If it were "my repository", and there were some problem like this, then
> I would probably use filter-branch to remove the error from history.

Hopefully, the owner of the repository will at least remove the error from future versions, if not actually filter it out of existence.  But it _is_ an error, it's just that prior to git 1.7.2 only people with autocrlf set could see it.

I did consider this as a potential problem when implementing the new crlf conversion behaviour, but reasoned that very few repositories would be affected in this way: there was no reason to set the crlf attribute unless you worked with people who had core.autocrlf set, and if you did, they would notice the spurious "modifications".

I'm sorry you hit a repository with an incorrectly set crlf, and I hope there aren't many more out there.

- Eyvind
