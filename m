From: Uri Okrent <uokrent@gmail.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Sun, 29 Nov 2009 11:45:39 -0800
Message-ID: <4B12CF63.3040400@gmail.com>
References: <20091125203922.GA18487@coredump.intra.peff.net>	 <20091125210034.GC18487@coredump.intra.peff.net>	 <7vmy2as319.fsf@alter.siamese.dyndns.org>	 <20091125214949.GA31473@coredump.intra.peff.net>	 <7vtywiqmbs.fsf@alter.siamese.dyndns.org>	 <20091125222625.GB2861@coredump.intra.peff.net>	 <4B0DB29D.5010101@gmail.com>	 <20091125225318.GA10127@coredump.intra.peff.net>	 <4B0DB894.7010800@gmail.com>	 <20091125232210.GA15538@coredump.intra.peff.net> <94a0d4530911290338h459dd5a2p4752f7d58c455964@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, A Large Angry SCM <gitzilla@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 20:46:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEpib-0006OD-Cp
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 20:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbZK2Tpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 14:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbZK2Tpk
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 14:45:40 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:41747 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909AbZK2Tpj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 14:45:39 -0500
Received: by pzk1 with SMTP id 1so2043618pzk.33
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 11:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=qC1TK07p2Pjn7m7OAycSZpdCaoXQRRaG6bC9b5v3h7Q=;
        b=oAd8TiWQLabms0IM3TihquW8av7u5rMPIKPe3CEZE/5M1TBwFyN6y+Bf8tlRVv4vkC
         BEwv6nUFh/IS4ZMIHRJhlkEg7IWQLqW/B99ayxrbYp+zc9jwRk5OPVfkSEBe5lodDqUb
         Y4MPHDN1yU2XrVAbkBgeuMC8+NvkiWiqW6PQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=BlOh7HZlfQ0f9TkNTHV2YcTTRzfNhy8SWkW/qx2Bin/z3Dr2x0RmNX9h541O+Sf5OE
         vtx9pJebuipAIzfdfQc2ZP/BY4u4TVYxgOb6+6nuOmtzqRnk9l3CzibGKhvGU3E0J2ps
         XnpWXJ916APRn4L2sadpmYeFElvlQm5xbD6Vc=
Received: by 10.114.237.24 with SMTP id k24mr5460489wah.5.1259523946131;
        Sun, 29 Nov 2009 11:45:46 -0800 (PST)
Received: from ?192.168.0.8? (cpe-76-90-12-237.socal.res.rr.com [76.90.12.237])
        by mx.google.com with ESMTPS id 23sm2480063pzk.0.2009.11.29.11.45.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Nov 2009 11:45:45 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <94a0d4530911290338h459dd5a2p4752f7d58c455964@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134034>

Felipe Contreras wrote:
> On Thu, Nov 26, 2009 at 1:22 AM, Jeff King <peff@peff.net> wrote:
>> Probably we would want something flexible, but with sane defaults. Like
>> an environment variable to ignore all (or most) config options, but then
>> the ability to opt into specific ones. Something like:
>>
>>  GIT_PLUMBING=1; export GIT_PLUMBING
>>  git log ;# does not respect any non-plumbing config
>>  git --respect='log.showroot' ;# respect just the one variable
>>  git --respect='color.*' log ;# you get all color
>>
>> But there are two big obstacles (besides the obvious issue that
>> introducing this in itself needs a gentle transition plan):
>>
>>  1. We need to annotate every config option with whether it is
>>     potentially problematic. For example, core.filemode should probably
>>     be respected no matter what (but I'm not sure if it is simply true
>>     for core.*).
>>
>>  2. Script writers need to actually use the system, which is somewhat
>>     more verbose and annoying than what they have to do now. But at
>>     least it defaults to safety when they are lazy, and then they can
>>     re-add options. Of course, they are stuck on an upgrade treadmill
>>     of analyzing and approving each new option that appears in git.
> 
> +1 on this.
> 
> This would make it easier to add options in the future that would be
> potentially dangerous to scripts otherwise. But more than
> "non-plumbing" I would rather define these variables as *preferences*;
> things that are not essential to the proper functioning of git
> commands, and would vary from user to user.
> 

Sounds like a good idea to me, speaking as someone who has git support
scripts. Dealing with configuration soup in every script would be very
bad.

The same type of insulation though could probably be achieved by not
adding configuration options that alter the behavior of commands,
and instead have user's rely on aliases for that purpose. (The cat's
probably already out of the bag WRT to configuration though).

-- 
    Uri

Please consider the environment before printing this message.
http://www.panda.org/how_you_can_help/
