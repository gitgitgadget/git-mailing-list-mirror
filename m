From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Fri, 15 May 2009 18:21:42 +0200
Message-ID: <4A0D9696.1040805@op5.se>
References: <op.utv93sdo1e62zd@merlin.emma.line.org>	 <op.utwdsutn1e62zd@merlin.emma.line.org>	 <7v8wl01iev.fsf@alter.siamese.dyndns.org>	 <op.utwyczlf1e62zd@merlin.emma.line.org>	 <20090514182249.GA11919@sigill.intra.peff.net>	 <op.utxydvnu1e62zd@merlin.emma.line.org>	 <20090515020206.GA12451@coredump.intra.peff.net>	 <op.uty0pjb51e62zd@balu> <m34ovmlcve.fsf@localhost.localdomain>	 <4A0D8211.5010806@viscovery.net> <81b0412b0905150851q232b3f6s95df89e72d4dc381@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthias Andree <matthias.andree@gmx.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Brandon Casey <casey@nrlssc.navy.mil>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 18:21:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M50AW-0003Y2-F0
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 18:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886AbZEOQVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 12:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755257AbZEOQVr
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 12:21:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:4256 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843AbZEOQVq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 12:21:46 -0400
Received: by fg-out-1718.google.com with SMTP id 16so706085fgg.17
        for <git@vger.kernel.org>; Fri, 15 May 2009 09:21:45 -0700 (PDT)
Received: by 10.86.29.8 with SMTP id c8mr1231031fgc.2.1242404505253;
        Fri, 15 May 2009 09:21:45 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.163.94])
        by mx.google.com with ESMTPS id 3sm947445fge.24.2009.05.15.09.21.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 09:21:44 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <81b0412b0905150851q232b3f6s95df89e72d4dc381@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119263>

Alex Riesen wrote:
> 2009/5/15 Johannes Sixt <j.sixt@viscovery.net>:
>> Jakub Narebski schrieb:
>>> "Matthias Andree" <matthias.andree@gmx.de> writes:
>>>>      commit <-- signed-by-- NIL (removed) <--signed-by-- tag1.
>>> THIS IS A FEATURE, NOT A BUG.
>> Please stop it. Everone agrees about this.
>>
>> Matthias only wants a patch like below. Matthias, if you are serious about
>> it, please pick this up and turn it into a proper submission. I don't care
>> enough.
>>
> ...
>> +       if ((tag_object = (struct tag *)parse_object(object)) &&
>> +           tag_object->object.type == OBJ_TAG &&
>> +           tag_object->tag &&
>> +           !strcmp(tag_object->tag, tag)) {
>> +               error("A tag cannot tag itself. If you meant to tag the commit");
> 
> If it ever turned into submission, I'll always patch this out. It is stupid.

Is it? Does it really make sense to have a tag named "foo" point to a tag object
that in turn points to a tag object without a tag ref? I mean, if you're signing
a tag, it makes sense to want to keep the original tag around so people can
reference it. If you want to *replace* a tag, it doesn't make sense to create
this chain which, iiuc, goes something like this:

   tag ref -> tag object -> tag object without ref -> something

Honestly, I can see how this turned out to be confusing, as you end up with a
tag object without a tag, but a new tag in its place. Not to mention that the
new tag won't be push-able without --force in case the old tag was pushed earlier.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
