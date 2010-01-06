From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule
 working directory in git gui and gitk
Date: Wed, 06 Jan 2010 22:19:20 +0100
Message-ID: <4B44FE58.3030209@web.de>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de> <4B42F425.4010901@web.de> <7v1vi428w0.fsf@alter.siamese.dyndns.org> <4B43292C.5060106@web.de> <7vd41oz9mp.fsf@alter.siamese.dyndns.org> <4B439A86.3020500@web.de> <7vbph8oxg0.fsf@alter.siamese.dyndns.org> <4B4498BC.5040400@web.de> <7vbph7181x.fsf@alter.siamese.dyndns.org> <fcaeb9bf1001060923m6559f00bp794bb5fdd4af704c@mail.gmail.com> <7vljgbw21x.fsf@alter.siamese.dyndns.org> <4B44D73F.6000607@web.de> <7vbph7uhn9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 22:20:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSdJD-0004T5-Qq
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 22:20:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516Ab0AFVUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 16:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755100Ab0AFVUr
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 16:20:47 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:48096 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178Ab0AFVUq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 16:20:46 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 06F301447631F;
	Wed,  6 Jan 2010 22:19:26 +0100 (CET)
Received: from [80.128.107.143] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NSdHl-0001k3-00; Wed, 06 Jan 2010 22:19:21 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7vbph7uhn9.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19rCRhTf3A4O59Qsku2HEUebjvue22VbWj75z+/
	AbB6zBnCleXk7cyiJcQrmsj/9yNQ4Ww+l2mq/ESl5ViuYrVl/P
	pua4VBU8cIn7csLMFZAQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136299>

Am 06.01.2010 21:01, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 06.01.2010 18:55, schrieb Junio C Hamano:
>>> I was envisioning that the "git status" in submodule will be run with its
>>> recent --porcelain option, and "git status" or "git commit" would read it
>>> to postprocess and incorporate into its own output.
>>
>> And i thought about printing just one line for each dirty submodule that
>> contains uncommitted and/or new files. I did not intend to list every
>> file, for the same reason a "git diff --submodule" only shows the first
>> line of the commit messages, not the actual differences of all changed
>> files in the submodule. I am not against being able to show all files
>> too, but i really would want to have an option to get a short output for
>> git gui and gitk.
> 
> I don't think what you are saying is inconsistent with "git status/commit
> that reads from 'git status --porcelain' it runs in a submodule directory,
> postprocesses it and incorporates it into its own output."  When the
> sub-status reports changes, your "postprocess" would condense it down to
> "this has a potential change that user could want to commit".  How the
> dirtiness is shown is entirely up to the caller that detected that change.
> 
> Let's explain it in another way.
> 
> The original "diff" for a submodule entry was implemented by preparing a
> 
> 	"Subproject commit %s\n"
> 
> line for the submodule commit recorded in the preimage and postimage, and
> compare these as if they are one-line files.  When the postimage was work
> tree, it looked at submodule's .git/HEAD to learn what to stuff in %s
> there.
> 
> But nobody forced you to limit the check only to .git/HEAD in the
> submodule.  To make the comparison richer, you could check if the
> submodule directory is dirty (and we have already discussed the potential
> definition of dirtiness earlier), and add "-dirty" in the string as well.
> With such a change, if you make some changes to a file in the work tree of
> the submodule after a clean "clone", "git diff" between the index and the
> work tree would report:
> 
> 	-Subproject commit 37bae10e38a66e4f1ddd5350daded00b21735126
> 	+Subproject commit 37bae10e38a66e4f1ddd5350daded00b21735126-dirty
> 
> The suggestion to read from "status --porcelain" that is run in the
> submodule directory was about how to implement the part that determines
> this "dirtiness" information, and not about how that dirtiness is
> expressed in the output.  The above is an illustration that even the
> traditional output format can be made aware of this submodule dirtiness
> check.  "diff --submodule" can express that dirtiness information in any
> way it wants.

I see, we seem to agree again :-)

While looking into "git status" in the last hours i became aware that
there is some infrastructure for calling "git submodule summary" (when
that is enabled via "git config status.submodulesummary"). I think this
can be extended to transfer the dirty information from "git diff
--submodule" (which can and should replace "git submodule summary" IMO)
into "git status".

Will send a patch for discussion tomorrow, i have to get some sleep now.
