From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@lavabit.com>
Subject: Re: is rebase the same as merging every commit?
Date: Fri, 27 Jun 2008 19:33:28 +0900
Message-ID: <20080627193328.6117@nanako3.lavabit.com>
References: <7vzlp7n1j4.fsf@gitster.siamese.dyndns.org>
    <1006.35704952783$1214525911@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "David Jeske" <jeske@willowmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 12:35:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCBIK-0003dD-Ji
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 12:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbYF0KeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 06:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbYF0KeK
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 06:34:10 -0400
Received: from karen.lavabit.com ([72.249.41.33]:52154 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128AbYF0KeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 06:34:09 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 728B5C843A;
	Fri, 27 Jun 2008 05:33:59 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id U6Z2LS1G49VZ; Fri, 27 Jun 2008 05:34:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=CHd5UkWVxHyfXJwPEFY+g4ftnq1twR+uXfoCAXKiYJJPFVZfDOAb4rxGOmRbkn6hgyZEHvOTrt6YltDVIFMEnes+y0FheboAoCSUjkvXXaYZ91Z9Fg17YwQ6JEfZDkGVF+VzCYE8pzxfS8D3dt+MiNvOmiDHsv19iO/vNrTklU8=;
  h=From:Subject:To:Cc:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Quoting Junio C Hamano <gitster@pobox.com>;
In-Reply-To: <7vzlp7n1j4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86538>

Quoting Junio C Hamano <gitster@pobox.com>:

> "David Jeske" <jeske@willowmail.com> writes:
>
>> If I understand it right (and that's a BIG if), it's the same as doing a merge
>> of C into G where every individual commit in the C-line is individually
>> committed into the new C' line.
>>
>> ...........-------------A---B---C
>> ........../            /   /   /
>> ........./        /---A'--B'--C'  topic
>> ......../        /
>> ....D---E---F---G - master
>>
>>
>> (1) Is the above model a valid explanation?
>
> I would presume that the resulting trees A' in the second picture and in
> the first picture would be the same, so are B' and C'.  But that is only
> true when commits between A and C do not have any duplicate with the
> development that happened between E and G.

Sorry, but I think you are wrong, Junio.

Rebase can be used to backport changes, not just porting your changes forward, using --onto option:

..........maint
............1-------A'--B'--C'   
.........../       .   .   . <-- ???
........../.......A---B---C
........./......./
......../......./
.......0--...--D---E---F---G - master

Here, A, B, C that are based on D (that is way ahead of the top of the maintenance branch 1) is rebased to the maintenance branch.

But in this case, A' is *not* a merge between 1 and A.  For A' to be a merge between 1 and A, it *must* contain all the development that happened up to 1 and all the development that happened up to A since these two branches were forked (that is 0 in the above picture).

Instead, the difference to go from 1 to A' is similar to the difference to go from D to A. It does not and must not include anything that happened between 0 and D.  That is not a merge.

I agree that your explanation why A is not recorded as a parent of A' is right for the philosophical reason (the purpose of rebasing to create A' is so that you do not have to record them).  But from the point-of-view of correctness of commit history, I think A must not be recorded as a parent of A', either.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
