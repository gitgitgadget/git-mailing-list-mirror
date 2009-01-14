From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: git merge and cherry-pick and duplicated commits?
Date: Wed, 14 Jan 2009 10:38:40 +0200
Message-ID: <496DA490.5020708@panasas.com>
References: <2729632a0901131840v5c7ce0c7l3f87c03caabf68de@mail.gmail.com>	 <5EA96780-EF4C-4B31-9C60-6ABAF21663FA@silverinsanity.com>	 <2729632a0901132221r746144a1y9628615be1c6ad04@mail.gmail.com>	 <496D9572.2090303@viscovery.net> <2729632a0901140008r59e429aeq3ce367e1bc7df71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Wed Jan 14 09:40:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN1IF-0008CV-Kv
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 09:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760237AbZANIis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 03:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760149AbZANIir
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 03:38:47 -0500
Received: from mail-ew0-f31.google.com ([209.85.219.31]:51098 "EHLO
	mail-ew0-f31.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759596AbZANIiq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 03:38:46 -0500
Received: by ewy12 with SMTP id 12so140053ewy.13
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 00:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=5MZ99oEwKZbwSEeRmRuNFArADU3kjjllCz9BSHNGRts=;
        b=q0QPwnzKOSHu41AUj3+ir2QUHAC4GSRJzZN43bVrpI38YV+xlhEt4apUqJXuYQ4wgN
         iUEKW38HeQ8imIMT0ziGv1pcMZUPx5if1C2Dcix1Lv/LMQaiqhEzXTK62lHbsnHy761a
         7LiooYG0e6hh6MKUqE2+UsAipOpLcwq12wl/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=CdW7FFMvnNMDB+wWoRq/Q5M+SlePJm695Elh8s/mC1Hd7PS83JsUwldrQAX2AKOaDE
         fbwCqGq2Xtu2g0in+ZZOWZceVB1wwuiG8Jsbj00Bk04mQUK38ohdduvMR0PewGv8OKr7
         SRjMNIJrRPLqsLMnXayiWHmJNZUOiKrLwsp8w=
Received: by 10.210.92.8 with SMTP id p8mr36784043ebb.55.1231922324467;
        Wed, 14 Jan 2009 00:38:44 -0800 (PST)
Received: from bh-buildlin2.bhalevy.com (DSL212-235-53-3.bb.netvision.net.il [212.235.53.3])
        by mx.google.com with ESMTPS id 7sm3689231eyb.11.2009.01.14.00.38.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jan 2009 00:38:43 -0800 (PST)
User-Agent: Thunderbird/3.0a2 (X11; 2008072418)
In-Reply-To: <2729632a0901140008r59e429aeq3ce367e1bc7df71@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105604>

skillzero@gmail.com wrote:
> On Tue, Jan 13, 2009 at 11:34 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> 
>> Well, the way to do it is "careful planning".
>>
>> If you have a *slight* suspicion that some change *might* be needed on a
>> different branch, then:
>>
>> 1. you commit the change on a branch of its own that forks off of the
>> merge-base of *all* the branches that *might* need it;
>>
>> 2. next, you merge this fix-up branch into the branch where you need it
>> first, which is very likely your current topic-under-development.
>>
>> 3. Later you can merge the branch into the other branches if you find that
>> it is really needed.
> 
> If I create a separate bug-fix-only branch X that forks from the
> latest common commit of all the branches that might need it and some
> of those branches already have commits after that merge base (e.g.
> branch Z is 5 commits after the common merge base by the time I fix
> the bug), will git be able to merge the new branch X into Z in a way
> that will allow me to also merge branch X into my original feature
> branch A and then later merge A into Z without duplicating the commit
> that is now in both branch X and Z?
> 
> It seems like I'd run into my original duplicate commit problem
> because even though branch X was originally based off the same parent
> commit, it will have a different parent when it is merged into Z
> because Z is no longer at that common merge commit (it's 5 commits
> beyond it).
> --

No, if you use merges it will not duplicate. It will know exactly what
to do because it is the same commit in all branches.
Only git-cherry-pick will duplicate the same patch, but as a different
new commit. Then when merging the merge sees a merge conflict but since
it is exactly the same change it will accept it. The same happens if
two different patches have exact same hunk, the merge is smart to accept
the same change from two sources. What happen with cherry-pick is that all
the hunks match.

Boaz
