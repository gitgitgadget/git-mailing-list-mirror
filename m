From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3 2/3] Add the 'fetch.recurseSubmodules' config setting
Date: Fri, 12 Nov 2010 12:40:38 +0100
Message-ID: <4CDD27B6.3070907@web.de>
References: <4CDB3063.5010801@web.de> <4CDB30D6.5040302@web.de> <20101111000216.GA14189@burratino> <4CDBA5FD.20802@web.de> <20101111082748.GA15525@burratino> <7v1v6rhfut.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 12 12:40:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGrzw-0000RD-IZ
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 12:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757413Ab0KLLkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 06:40:47 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:35993 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756934Ab0KLLkq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 06:40:46 -0500
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id A1C80177F4C02;
	Fri, 12 Nov 2010 12:40:44 +0100 (CET)
Received: from [93.246.52.137] (helo=[192.168.178.29])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PGrzo-0006hM-00; Fri, 12 Nov 2010 12:40:44 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <7v1v6rhfut.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+9kBuvx7mc1kF5KkNJ+6y/Bt8TGxSJe1J+2lKC
	ug2k237Xb49J64LE9lkMt/sR7hUJc/ILOo+J2uI32NPpaobW7r
	vY49ZnIUj6F2vlK6YthA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161338>

Am 11.11.2010 19:31, schrieb Junio C Hamano:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>>> "fetch.recurseSubmodules" is only read from .git/config. The one read
>>> first from .gitmodules and then from .git/config is the per-submodule
>>> setting "submodule.<name>.fetchRecurseSubmodules" added in 3/3.
>>
>> Sorry for the nonsense.  Would it be easy (or desirable) to make
>> _that_ one not be read from .gitmodules?
> 
> I think the motivation behind having a way to read it from .gitmodules is
> so that project can suggest the default for convenience (e.g. "almost
> everybody who interacts with this project wants these submodules checked
> out and kept updated").

Yes, and to achieve that it should /not/ be necessary to run a "git
submodule sync" manually afterwards to activate those changes.

Jonathan, I think when we allow upstream to configure which submodules
are to be cloned and checked out by default (which seems an option almost
everyone likes to have), doesn't it make sense to let upstream set a
default which submodules should be fetched too (so that new commits there
can be checked out recursively later)? I would rather not like to do that
implicitly just because a submodule is configured for recursive checkout
...


> Traditionally the suggestions kept in .gitmodules were propagated to the
> config when the submodule was initialized, and at runtime we read only
> from the config from then on without reading from .gitmodules, so that
> once the user decides to follow what the project suggests (or customize
> that away), the preference would stick to the repository.
> 
> That arrangement does not cater well to people who want to follow along
> whatever the project's suggestion of the day, so we might want to change
> things so that we if we find it in the config, we stop there and use what
> we found, otherwise we use what is in the in-tree gitmodules; I suspect we
> might require some changes to "submodule init" not to copy certain things
> to the config for that to work, though...

Right. But this would enable you to have branches where different sets
of submodules are fetched, checked out and/or considered to make the
superproject dirty depending on the topic the branch is for.
