From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: tracking submodules out of main directory.
Date: Mon, 27 Jun 2011 21:02:17 +0200
Message-ID: <4E08D3B9.401@web.de>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>	 <7vvcvrxlol.fsf@alter.siamese.dyndns.org> <1309200051.2497.288.camel@Naugrim.eriador.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: henri GEIST <henri.geist@flying-robots.com>
X-From: git-owner@vger.kernel.org Mon Jun 27 21:03:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbH69-00010s-1v
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 21:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838Ab1F0TC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 15:02:59 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:33386 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768Ab1F0TCU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 15:02:20 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate03.web.de (Postfix) with ESMTP id 7890F192E0B48;
	Mon, 27 Jun 2011 21:02:18 +0200 (CEST)
Received: from [93.240.101.84] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QbH4c-00020Z-00; Mon, 27 Jun 2011 21:02:18 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.18) Gecko/20110616 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <1309200051.2497.288.camel@Naugrim.eriador.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+ZVVop5cXOiPbk2CH53i6TJpRcuKjYt/EIjpY0
	wMqrazIiIGgSU+9ekbamTJwHi8ZEm1UXnjCGA2qGR4SS4wQj6J
	9XyLW4U0LMWBw3nphQDw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176364>

Am 27.06.2011 20:40, schrieb henri GEIST:
> what I really need is to do :
> 
> cd project_1
> git add ../library_1
> 
> then in case of modification in library_1
> 
> A git status in project_1 directory will say me :
> 
> modified:   ../library_1 (modified content)
> or
> modified:   ../library_1 (new commits)
> or even
> modified:   ../library_1 (new commits, modified content)
> 
> Just like it do for submodules with out "../" in the path.
> 
> And I really think the metadata to do so should be stored in project_1
> since it is him which depend on library_1 version "abcd1234..." and this
> information need to be self contained.
> May be in project_1/.git or project_1/.gitmodules
> 
> I do not see the point of having a third party project "Anything" Just
> to say to project_1 hey you need library_1.
> If it need it, it should already know it.

The point is it avoids ambiguity and cross-dependencies. If you have
project_1 requesting the version "123456" of library_1 and project_2
wants "abcdef", you'll always have one project disagreeing (= being
dirty). But "abcdef" might be a direct descendant of "123456" and is
just fixing a bug that affects only project_2. So it would be ok for
both to have "abcdef", but you'll have to add an extra commit to
project_1 saying "updating library_1 because of bug in project_2" to
make it clean again. That would make the projects not so modular and
independent anymore and won't scale well.

If the superproject records these dependencies you just update
library_1, run all tests (including those in project_1 & project_2)
and commit that in the superproject.
