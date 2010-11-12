From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3 2/3] Add the 'fetch.recurseSubmodules' config setting
Date: Fri, 12 Nov 2010 12:54:33 +0100
Message-ID: <4CDD2AF9.6040403@web.de>
References: <4CDB3063.5010801@web.de> <4CDB30D6.5040302@web.de> <20101111000216.GA14189@burratino> <4CDBA5FD.20802@web.de> <20101111082748.GA15525@burratino> <7v1v6rhfut.fsf@alter.siamese.dyndns.org> <20101111190053.GH16972@burratino>
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
X-From: git-owner@vger.kernel.org Fri Nov 12 13:18:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGsag-0002R8-9X
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 13:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757147Ab0KLMSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 07:18:45 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:45949 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab0KLMSo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 07:18:44 -0500
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id E6406171A6EA2;
	Fri, 12 Nov 2010 12:54:33 +0100 (CET)
Received: from [93.246.52.137] (helo=[192.168.178.29])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PGsDB-00018j-00; Fri, 12 Nov 2010 12:54:33 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20101111190053.GH16972@burratino>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+RvcUFmpg1j1icRORxEztZwbrmgmrwCZpTUSff
	QG+t4H5qcI9j7lZ5pzAIyT7aorB7gmPjdjF/jjSL6KwTFHilb7
	+LutD4PDYcxwPIQVCWmw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161339>

Am 11.11.2010 20:00, schrieb Jonathan Nieder:
> Junio C Hamano wrote:
> 
>> I think the motivation behind having a way to read it from .gitmodules is
>> so that project can suggest the default for convenience (e.g. "almost
>> everybody who interacts with this project wants these submodules checked
>> out and kept updated").
> 
> Yes, that makes some sense to me.  Except wouldn't it be a single
> configuration item?  "These submodules should be checked out in all
> but unusual situations, so check them out automatically and keep them
> updated."

Hmm, but we have at least three modes of how to update them:

1) Never fetch the submodule (to get new commits the user has to run
   "git fetch --recurse-submodules" by hand)

2) Fetch the submodule each time you fetch the superproject (Which is
   really handy when you do development in the submodule too but can
   be really inconvenient when you don't)

3) Update submodules only when new recorded commits are fetched in
   the superproject (This mode is not added with the current patch
   series but will be in one of the next)

So you would need a config option for that anyway, no? And that is why
I'd rather like to have a separate fetch option to control that behavior
instead of an implicit "if-it's-to-be-checked-out-fetch-it-too" approach.


> Maybe a person setting this to false actually means "This submodule
> has its url set to a repository that is updated very frequently, and
> most updates are not relevant to the superproject."  Unfortunately, I
> think the result would be a poor user experience: when an update comes
> that _is_ important to the superproject, what happens?
> 
>  $ git fetch
>  ... go on plane ...
>  $ git merge @{u} && git submodule update --no-fetch --recursive
>  [...]
>  fatal: reference is not a tree: f1c596a3895643d0969a15b8e945bf0c0072e470
> 
> Hmm.  I think in that scenario a better solution would be to point the
> submodule url point to a project-specific clone that is updated less
> frequently.
> 
> What am I missing?

That situation should be handled by method 3) above which was proposed
for such a use case.
