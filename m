From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-completion: Add git help completion for aliases
Date: Tue, 22 Mar 2011 10:23:42 +0100
Message-ID: <4D886A9E.6050405@drmicha.warpmail.net>
References: <4D871972.7080008@elegosoft.com> <7vhbawno11.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakob Pfender <jpfender@elegosoft.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, lee.marlow@gmail.com,
	markus.heidelberg@web.de, szeder@ira.uka.de, spearce@spearce.org,
	bebarino@gmail.com, ted@tedpavlic.com, tlikonen@iki.fi,
	trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 10:27:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1xs1-0004tC-Jc
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 10:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932Ab1CVJ1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 05:27:17 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:41008 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751268Ab1CVJ1P (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2011 05:27:15 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A4503202E4;
	Tue, 22 Mar 2011 05:27:14 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 22 Mar 2011 05:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=cJEQrgjeGA+qjRQg6iji7acXiUw=; b=Epz22D2QunfV6ULn4nRVimmzavvSCbGmGOqHMtsO5ZzbwMo/q1GwRwaARTEkmaqcNiPmPo39POlGw/Fijw08qzGP2ZYv0tuuFyfi71dyNNXLElTcH/YQsslQwepdppS2+TSIsyzXtSqArOxhZfoWXsJlGa7EXxTlRnRx0VArO5g=
X-Sasl-enc: PaeImX0dGk89SbgRQP9FZZjV9zc8yWojXdLM4HPzoB9G 1300786034
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5E5D644019D;
	Tue, 22 Mar 2011 05:27:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7vhbawno11.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169715>

Junio C Hamano venit, vidit, dixit 21.03.2011 22:48:
> Jakob Pfender <jpfender@elegosoft.com> writes:
> 
>> Enable bash completion for "git help <alias>", analogous to "git
>> <alias>", which was already implemented.
>>
>> Signed-off-by: Jakob Pfender <jpfender@elegosoft.com>
>> ---
>>  contrib/completion/git-completion.bash |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/contrib/completion/git-completion.bash
>> b/contrib/completion/git-completion.bash
>> index 893b771..f9a74d3 100755
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1506,7 +1506,7 @@ _git_help ()
>>  		;;
>>  	esac
>>  	__git_compute_all_commands
>> -	__gitcomp "$__git_all_commands
>> +	__gitcomp "$__git_all_commands $(__git_aliases)
>>  		attributes cli core-tutorial cvs-migration
>>  		diffcore gitk glossary hooks ignore modules
>>  		repository-layout tutorial tutorial-2
> 
> This patch may not be _wrong_ per-se, but it it useful in practice?
> 
> I dunno.
> 
> Don't people usually use aliases so that they do not have to type long
> command names that would need completion?

I'd say this would be a perfect argument for "do not suggest aliases for
'git <cmd>'"; independent of that, we could still suggest aliases for
'git help <cmd>' since, presumably, you use commands more often than you
look up help...

But currently, we do it the other way round, and even worse:

git for<TAB>
for-each-ref-do   format-patch

git help for<TAB>
for-each-ref   format-patch

That is, git command completion lists aliases (for-each-ref-do) and
common commands, and git help completion lists no aliases and all commands.

The patch makes it so that the suggestions for git command are a subset
of those for git help command, which is a good thing. (Not completing
aliases for 'git <cmd>' would be good also, on top of that.)

And yes, I use git help <alias> a lot, because I don't like git config
--get alias.<alias>, and our config files tend to grow in ugliness over
time. (We need git config --broomstick or git config --vacuum.)

Michael
