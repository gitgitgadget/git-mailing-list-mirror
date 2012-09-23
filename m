From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Quickly searching for a note
Date: Sun, 23 Sep 2012 17:07:04 +0200
Message-ID: <505F2598.7080704@drmicha.warpmail.net>
References: <505C7C80.3000700@workspacewhiz.com> <7vy5k370n7.fsf@alter.siamese.dyndns.org> <505CB21E.4040607@workspacewhiz.com> <7vtxur3zxi.fsf@alter.siamese.dyndns.org> <505CCD2A.8020003@workspacewhiz.com> <505CD2FA.80200@kdbg.org> <505CD7D0.2000505@workspacewhiz.com> <20120921233723.GA29433@sigill.intra.peff.net> <7v7grn3pfo.fsf@alter.siamese.dyndns.org> <505DE30B.2000805@drmicha.warpmail.net> <7vk3vl3ixv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 23 17:07:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFnmJ-0000N3-0n
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 17:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932Ab2IWPHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2012 11:07:16 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44996 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753602Ab2IWPHO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Sep 2012 11:07:14 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id BE1B02017A;
	Sun, 23 Sep 2012 11:07:13 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Sun, 23 Sep 2012 11:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=8ZpBtQMWoQQOO+bCmMY4Ec
	8+R/A=; b=MosqQCNQ6DVxaTOWG3t/DGnBlFQ3343zB1XNkTqVOjT9HteLXRQXMf
	D5Xbjk80AzC4iX5/qPeJHiNDnj6AeJY2rpuQ638pyvsxG0yhTxdKVxi3/h4xFsC0
	B3GTzoqtgD4jyKav46QdSGdQj/SEWKBSlxfTZUvNEClixTErQbSVA=
X-Sasl-enc: 5Nl159ga2ekGlCLpoWdJNE1LA/dd7objhSvJrwVddT+7 1348412833
Received: from localhost.localdomain (unknown [88.71.254.127])
	by mail.messagingengine.com (Postfix) with ESMTPA id CA13E4827B2;
	Sun, 23 Sep 2012 11:07:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vk3vl3ixv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206241>

Junio C Hamano venit, vidit, dixit 22.09.2012 22:23:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> On my mental scratch pad (yeah, that's where the bald spots are) I have
>> the following more general idea to enhance the revision parser:
>>
>> --limit-run=<script>::
>> --run=<script>:::
>> These options run the script `<script>` on each revision that is walked.
>> The script is run in an environment which has the variables
>> `GIT_<SPECIFIER>` exported, where `<SPECIFIER>` is any of the specifiers
>> for the `--format` option in the long format (the same as for 'git
>> for-each-ref').
>>
>> In the case of `--limit-run`, the return code of `<script>` decides
>> whether the commit is processed further (i.e. shown using the format in
>> effect) or ignored.
> 
> You could argue that the above is not an inpractical solution as
> long as the user of --run, which spawns a new process every time we
> need to check if a commit is worth showing in the log/rev-list
> stream, knows what she is doing and promises not to complain that it
> is no more performant than an external script that reads from
> rev-list output and does the equivalent filtering.
> 
> I personally am not very enthused.
> 
> If we linked with an embeddable scripting language interpreter
> (e.g. lua, tcl, guile, ...), it may be a more practical enhancement,
> though.
> 

Yes, the idea is "extend, don't embed" the other way round, so to say. I
still think extending "git log" so that it can call a script with commit
info already in the environment gives a more convenient approach then
"embedding git rev-list" into your own script. It's not more performant,
of course.

I just see many more requests of the type "grep notes" coming, i.e.
limitting based on other commit info, or in a different way then already
possible. Just image you want to find out who's responsible for those
commits in git.git with subject lengths > 100 ;)

The point is also that when you pipe rev-list into your script you have
to do all the output formatting yourself, or call "git log -1"/"git
show" again to have git do the output formatting after your script
decided about the limitting.

Michael
