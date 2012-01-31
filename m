From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Tue, 31 Jan 2012 17:32:00 +0100
Message-ID: <4F281780.1070804@alum.mit.edu>
References: <4F24E287.3040302@alum.mit.edu>	<7vwr8bvvxj.fsf@alter.siamese.dyndns.org>	<4F263AEE.4080409@alum.mit.edu>	<7v39axc9gp.fsf@alter.siamese.dyndns.org>	<4F27ACED.2050709@alum.mit.edu> <m3k448che9.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	demerphq@gmail.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 17:32:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsGct-0002Rl-Pz
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 17:32:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002Ab2AaQcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 11:32:06 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:35176 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368Ab2AaQcF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 11:32:05 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0VGW0Qu013315
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 31 Jan 2012 17:32:01 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <m3k448che9.fsf@localhost.localdomain>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189458>

On 01/31/2012 11:09 AM, Jakub Narebski wrote:
> I don't see how this can be done in backward-compatibile way.

Yes, backwards compatibility would probably prevent the NULL commit idea
from ever being implemented in a literal way.

But it is conceivable that it could be faked with some strategic

    if sha1 == '0'*40:
        treat_as_special_null_commit
    elif len(parents) == 0:
        parents = ['0'*40]

In other words, include a little special case fakery in the data
structures near root commits (an O(1) amount of work) to avoid special
cases in all commands that can touch root commits (an O(number of
commands) amount of work).

Alternatively, the NULL commit could be a UI construct that has no
manifestation in the object model.  This would not save implementation
work, but would perhaps give a more consistent way to deal with root
commits in the UI than the current array of --orphan etc. options.

> Please note that in Git it is quite natural to have more than one root
> (parentless) commit, even without presence of disconnected / orphan
> branches.  They are result of joining originally separate projects.
> git.git has quite a few of them (more than 6, IIRC).

I don't see the problem, unless you mean that it would be difficult to
merge repositories that don't link back to a NULL commit with
hypothetical future repositories that do include a NULL commit.  But a
world in which two kinds of repositories have to be supported is
pointless anyway, because then the git code would have to include *both*
kinds of special cases and nothing would be gained.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
