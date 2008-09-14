From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Convert "sink" to the new infrastructure
Date: Sun, 14 Sep 2008 22:19:41 +0100
Message-ID: <b0943d9e0809141419q6facb21at627e658805f1d223@mail.gmail.com>
References: <20080912215613.10270.20599.stgit@localhost.localdomain>
	 <20080914085118.GC30664@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 23:20:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kez1X-0007NA-AY
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 23:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbYINVTn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 17:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754180AbYINVTn
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 17:19:43 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:29297 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389AbYINVTm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Sep 2008 17:19:42 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1852601rvb.1
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=z0JXL5EkrGkug9kyrYnkqVV+kOpR78sSwDfSjCz87PA=;
        b=Qukj6oW21+qPR+BKFJVI4835xfIfDsaPlTpGF0pwNamHaZK8etH+EWJEAxg0w6bGin
         HGy/zmCw1TF2Njkr5sCqnEt7Na9Hsvx0QgqZ5sxRH9Bv+sCIKe7nkDqX8CBdJGMixSOk
         ZiJHwYUf2qn141CGbZK1oN+4ZpqBdAsdeaU4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=pTzx4da7aQ+EwzJtPyJUaDht6JopMZugGmGvr8+QTRNOJcnatv6l+P+QnF5Vg0Hskv
         FrpokDCF+Q8LeiXR56aYk8sY7cy4bESdNUbLkGXaPOuaQLewB09L5jp1ZovO3w8+NTyv
         im6E1qbGG/mNwNsh3Juc2QX77/N5dll/NXJTE=
Received: by 10.140.165.21 with SMTP id n21mr4266894rve.244.1221427182046;
        Sun, 14 Sep 2008 14:19:42 -0700 (PDT)
Received: by 10.140.199.1 with HTTP; Sun, 14 Sep 2008 14:19:41 -0700 (PDT)
In-Reply-To: <20080914085118.GC30664@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95865>

2008/9/14 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-09-12 23:01:27 +0100, Catalin Marinas wrote:
>
>> This patch converts the sink command to use stgit.lib. The behaviour
>> is also changed slightly so that it only allows to sink a set of
>> patches if there are applied once,
>
> "if they are applied"?

Without the spelling mistakes - "if there are applied patches (ones)".
Of course, unapplied patches can be sinked but when there are no
applied patches, it is equivalent to a push and decided to make it
fail.

>> I'm not sure about the conflict resolution. In this implementation,
>> if a conflict happens, the transaction is aborted. In case we allow
>> conflicts, I have to dig further on how to implement it with the new
>> transaction mechanism (I think "delete" does this).
>
> goto does it too. The docstring of the StackTransaction class explain=
s
> how it works (if it doesn't, we need to improve it):

I wasn't used to reading documentation in StGit files :-). Thanks for
the info, I'll repost. I'll make the default behaviour to cancel the
transaction and revert to the original state unless an option is given
to allow conflicts.

>> An additional point - the transaction object supports functions like
>> pop_patches and push_patch. Should we change them for consistency
>> and simplicity? I.e., apart from current pop_patches with predicate
>> add functions that support popping a list or a single patch. The
>> same goes for push_patch.
>
> The current set of functions made sense from an implementation
> perspective. But you are right that other variants would be helpful
> for some callers.

I can see calls to pop_patches(lambda pn: pn in patch_list). I think
we could have a helper for this. I'll try to post a patch sometime
next week.

--=20
Catalin
