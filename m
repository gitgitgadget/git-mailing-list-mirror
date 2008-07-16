From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] bash completion: Fix the . -> .. revision range	completion
Date: Wed, 16 Jul 2008 09:20:24 +0200
Message-ID: <487DA138.8040004@op5.se>
References: <7vskudpiqq.fsf@gitster.siamese.dyndns.org> <20080713230724.GJ10151@machine.or.cz> <7vhcatnz80.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807131649380.3305@woody.linux-foundation.org> <20080714000021.GB13066@spearce.org> <alpine.LFD.1.10.0807132210430.3305@woody.linux-foundation.org> <20080714062755.GA15992@spearce.org> <alpine.LFD.1.10.0807140741580.3305@woody.linux-foundation.org> <20080715042553.GD2432@spearce.org> <487C5A2D.3000707@op5.se> <20080715233851.GA23672@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 16 09:22:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ1LA-0003Ap-OL
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 09:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367AbYGPHVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 03:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754202AbYGPHVW
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 03:21:22 -0400
Received: from mail.op5.se ([193.201.96.20]:35055 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753385AbYGPHVV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 03:21:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 69BB71B80383;
	Wed, 16 Jul 2008 09:21:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hn4Q2etpnC3i; Wed, 16 Jul 2008 09:21:26 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.199])
	by mail.op5.se (Postfix) with ESMTP id AFF831B8037B;
	Wed, 16 Jul 2008 09:21:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080715233851.GA23672@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88649>

Shawn O. Pearce wrote:
> Andreas Ericsson <ae@op5.se> wrote:
>> I beat you to it ;-) This works just fine for me regardless of whether
>> or not I have a colon in COMP_WORDBREAKS.
> ...
>> Subject: git-completion.bash: Handle "rev:path" completion properly
> ...
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index d268e6f..e138022 100755
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -293,7 +293,11 @@ __git_complete_file ()
>> 		*)
>> 			ls="$ref"
>> 			;;
>> -	    esac
>> +		esac
>> +		# When completing something like 'rev:path', bash behaves
>> +		# differently whether or not COMP_WORDBREAKS contains a
>> +		# colon or not. This lets it handle both cases
>> +		test "${COMP_WORDBREAKS//:}" = "$COMP_WORDBREAKS" && pfx="$ref:$pfx"
>> 		COMPREPLY=($(compgen -P "$pfx" \
>> 			-W "$(git --git-dir="$(__gitdir)" ls-tree "$ls" \
>> 				| sed '/^100... blob /s,^.*	,,
> 
> Yea, I did more or less the same thing in my patch, but I also
> handled this fix in git-fetch and git-push.  The : is also used
> there in a refspec and we support completion the right side of the
> : in both cases (and yes, on git-push that can be slow as we do
> network IO, possibly over SSH).
> 
> So I'm in favor of my patch over yours, but only because of
> the fetch and push fixes as well.
> 

I agree, although I'd rather not have seen the case statement in
yours. It's bash completion after all, so no need to be "portably
fast" ;-)

I don't care that much though so long as it gets fixed.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
