From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 09/10] replace: check mergetags when using --graft
Date: Tue, 08 Jul 2014 07:35:01 +0200 (CEST)
Message-ID: <20140708.073501.2265697032770915844.chriscool@tuxfamily.org>
References: <20140707063342.3708.83493.chriscool@tuxfamily.org>
	<20140707063540.3708.29773.chriscool@tuxfamily.org>
	<xmqqion8by82.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	jnareb@gmail.com, sunshine@sunshineco.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 08 07:35:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4O3j-0002SR-Oh
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 07:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbaGHFfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 01:35:05 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:38058 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751834AbaGHFfE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 01:35:04 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 0404C59;
	Tue,  8 Jul 2014 07:35:01 +0200 (CEST)
In-Reply-To: <xmqqion8by82.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253002>

From: Junio C Hamano <gitster@pobox.com>
>
> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> When using --graft, with a mergetag in the original
>> commit, we should check that the commit pointed to by
>> the mergetag is still a parent of then new commit we
>> create, otherwise the mergetag could be misleading.
>>
>> If the commit pointed to by the mergetag is no more
>> a parent of the new commit, we could remove the
>> mergetag, but in this case there is a good chance
>> that the title or other elements of the commit might
>> also be misleading. So let's just error out and
>> suggest to use --edit instead on the commit.
> 
> I do not quite understand the reasoning.  If you have a merge you
> earlier made with a signed tag, and then want to redo the merge with
> an updated tip of that branch (perhaps the side branch was earlier
> based on maint but now was rebased on master), it will perfectly be
> normal to expect that the title or other elements of the resulting
> merge to stay the same.  

Yeah, but then you might also want to have a mergetag for the updated
tip of the branch and --graft will not put it in the new commit, so it
would be better to use --edit in this case.

> Why is it a good idea to error it out?

Because sometimes, in complex cases, it is misleading to do as if you
can do the right thing, when there is a good chance you cannot.

> If the argument were '"replace --graft" that changes the parents is
> likely to affect merge summary message, so error out and suggest to
> use --edit instead', regardless of the 'mergetag', I'd understand
> it, but that would essentially mean that 'replace --graft' should
> never be used, so...

I think that when "replace --graft" is used on a regular commit there
is much better chance that the resulting replacement commit will be as
the user expect it to be.

Thanks,
Christian.
