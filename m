From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v5 5/7] add tests for rebasing merged history
Date: Wed, 05 Jun 2013 08:12:08 +0200
Message-ID: <51AED6B8.8080406@viscovery.net>
References: <1369982987-18954-1-git-send-email-martinvonz@gmail.com> <1370292135-1236-1-git-send-email-martinvonz@gmail.com> <1370292135-1236-6-git-send-email-martinvonz@gmail.com> <7vk3m994mu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 08:12:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk6xX-0005e8-99
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 08:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375Ab3FEGMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 02:12:18 -0400
Received: from so.liwest.at ([212.33.55.13]:51309 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346Ab3FEGMO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 02:12:14 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Uk6x6-0001oa-P5; Wed, 05 Jun 2013 08:12:08 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 533F21660F;
	Wed,  5 Jun 2013 08:12:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <7vk3m994mu.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226433>

Am 6/4/2013 19:18, schrieb Junio C Hamano:
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
> 
>> ---
>> +#TODO: make all flavors of rebase use --topo-order
>> +test_run_rebase success 'e n o' ''
>> +test_run_rebase success 'e n o' -m
>> +test_run_rebase success 'n o e' -i
> 
> I do not quite follow this TODO.
> 
> While I think it would be nice to update "rebase" so that all
> variants consider replaying the commits in the same order, in this
> history you have:
> 
> +# a---b-----------c
> +#      \           \
> +#       d-------e   \
> +#        \       \   \
> +#         n---o---w---v
> +#              \
> +#               z
> 
> as long as o comes after n and e is shown before n or after o, which
> all three expected results satisify, it is in --topo-order, isn't it?

The comment is really just about the inconsistency, not about a request to
have a guaranteed order among the parents of a merge commit.

Having said that, wouldn't it be useful (generally, not just in this
context) to have a guarantee in which order --topo-order lists parents of
a merge?

>> +test_expect_success "rebase -p re-creates merge from side branch" "
>> +     reset_rebase &&
>> +     git rebase -p z w &&
>> +     test_cmp_rev z HEAD^ &&
>> +     test_cmp_rev w^2 HEAD^2
>> +"
> 
> Hmm, turning the left one to the right one?
> 
> +#       d-------e               d-------e    
> +#        \       \               \       \   
> +#         n---o---w     ===>      n---o   \
> +#              \                       \   \ 
> +#               z                       z---W
> 
> If w were a merge of o into e (i.e. w^1 were e not o), what should
> happen?  Would we get the same topology?

'git rebase -p z w' is a nonsense request in this situation. (I.e., there
is no requirement on the result.) At best, we could detect it and bail out
or warn.

-- Hannes
