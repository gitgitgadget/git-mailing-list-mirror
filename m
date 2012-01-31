From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Tue, 31 Jan 2012 02:09:18 -0800 (PST)
Message-ID: <m3k448che9.fsf@localhost.localdomain>
References: <4F24E287.3040302@alum.mit.edu>
	<7vwr8bvvxj.fsf@alter.siamese.dyndns.org>
	<4F263AEE.4080409@alum.mit.edu>
	<7v39axc9gp.fsf@alter.siamese.dyndns.org>
	<4F27ACED.2050709@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 31 11:09:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsAea-0001Zt-EY
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 11:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879Ab2AaKJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 05:09:23 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:63204 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152Ab2AaKJV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 05:09:21 -0500
Received: by werb13 with SMTP id b13so182592wer.19
        for <git@vger.kernel.org>; Tue, 31 Jan 2012 02:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=2lBltKuXYPHh4tRN8cLH54M2sYIzC2OBBcetdkUmP+M=;
        b=W2XaucpDLthfmpk/M1hSpzD02ToxItAnZqr5/vEulEk5Mf6+VfAAVbjsXLuiZKOlyt
         GyrBCJJad8i3D+ucVl3Aiio4sBOspH424DtNRZMT3h81JIwBte0jLvV3x6kI7HO0AxDS
         o88/F7vJFAPW9upANVpo/Weu50AeF2zVYPVxw=
Received: by 10.216.139.147 with SMTP id c19mr8677403wej.11.1328004559958;
        Tue, 31 Jan 2012 02:09:19 -0800 (PST)
Received: from localhost.localdomain (abwf108.neoplus.adsl.tpnet.pl. [83.8.229.108])
        by mx.google.com with ESMTPS id n5sm61415425wiw.7.2012.01.31.02.09.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 Jan 2012 02:09:18 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q0VA9rFv000374;
	Tue, 31 Jan 2012 11:09:54 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q0VA9qLI000371;
	Tue, 31 Jan 2012 11:09:52 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4F27ACED.2050709@alum.mit.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189448>

Michael Haggerty <mhagger@alum.mit.edu> writes:
> On 01/30/2012 07:48 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>>> [3] If commit 0000000 were treated specially, then there would be no
>>> unborn branches but only branches pointing at the empty commit.  In that
>>> case, my expectation would change--the old branch should be left
>>> pointing at 0000000.  But currently git has no concept of an unborn
>>> branch that is not HEAD.
>> 
>> And it probably is not a good thing to add such. Under that constraints,
>> HEAD that says refs/heads/foo where foo does not exist yet needs to be
>> special cased at places where it matters.
>> 
>> For that matter, even if we artificially created refs/heads/foo before any
>> commit is made and made it point at 0{40}, you would need to add special
>> cases to other parts of the system
> 
> No, the idea is to avoid special casing by making 0{40} into a real (but
> empty) revision.
> 
>> (e.g. "commit" needs to notice that the
>> result should be a root, not a child of 0{40};
> 
> No, commits that were previously generated as orphans *would* now be
> generated as children of the special 0{40} commit.

You would still have to have quite a bit of special cases about 0{40}
NUL commit.  Perhaps less special cases, but new special cases.
 
[...]
>> so it does not change the fact that the unborn branch is case
>> is special.
> 
> On the contrary, I believe that much special casing could be eliminated
> and the UI made more uniform by treating everything as a descendant of a
> special "NULL" commit.

I don't see how this can be done in backward-compatibile way.

Please note that in Git it is quite natural to have more than one root
(parentless) commit, even without presence of disconnected / orphan
branches.  They are result of joining originally separate projects.
git.git has quite a few of them (more than 6, IIRC).

-- 
Jakub Narebski
