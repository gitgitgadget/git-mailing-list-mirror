From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git repack vs git gc --aggressive
Date: Fri, 10 Aug 2012 13:09:37 -0700
Message-ID: <7v393ujypq.fsf@alter.siamese.dyndns.org>
References: <87zk66r28y.fsf@bitburger.home.felix>
 <20120807184405.GA440@sigill.intra.peff.net>
 <7vvcguv7y2.fsf@alter.siamese.dyndns.org>
 <87ehnewolp.fsf@bitburger.home.felix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felix Natter <fnatter@gmx.net>
X-From: git-owner@vger.kernel.org Fri Aug 10 22:09:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzvWk-0000Aw-2Q
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 22:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013Ab2HJUJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 16:09:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37381 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751661Ab2HJUJk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 16:09:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2991954A;
	Fri, 10 Aug 2012 16:09:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gzRK7ritkSwDfmoGXguhva1Ammo=; b=CSQqui
	loBTC4FRMunX/xN7SvLUx9DMIsZ9rdONxI7cn+2iJ/WeDy9TAJkaNwL35dnhq6Dk
	SIBYlOYslH8sdOZoxXZ2iuJQsG4SUyeq3Vn10ETZwUsGN7pJ/jYGYw4MHozqajQU
	cbrdKNvwPVJ0EIlq3GS964L+px9p2KChkec/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O8tLRAuyoTYmob0LVIY533ltj3MLdy/H
	gjL+uoeA+/5Z5NTmQPpdae1KUSJ9yHfB2w2vp7vtnEZP350wwPUqAtEwF6OEVuwn
	C6UE4CUt6lPUY6DVcy0cAaTEVWesXOFwDdXualUbOPY2/JKsK0iVGq0pzA4w+mGB
	69hbpbI+Td0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEF1E9549;
	Fri, 10 Aug 2012 16:09:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 140E19548; Fri, 10 Aug 2012
 16:09:38 -0400 (EDT)
In-Reply-To: <87ehnewolp.fsf@bitburger.home.felix> (Felix Natter's message of
 "Fri, 10 Aug 2012 21:09:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5074F7B4-E327-11E1-806E-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203256>

Felix Natter <fnatter@gmx.net> writes:

> I have a few questions about this:
>
>> As I am coming from "large depth is harmful" school, I would
>> recommend
>>
>>  - "git repack -a -d -f" with large "--window" with reasonably short
>>    "--depth" once, 
>
> So something like --depth=250 and --window=500? 

I would use more like --depth=16 or 32 in my local repositories.

>> and mark the result with .keep;
>
> I guess you refer to a toplevel '.keep' file.

Not at all.  And it is not documented, it seems X-<.

Typically you have a pair of files in .git/objects/pack, e.g.

  .git/objects/pack/pack-2e3e3b332b446278f9ff91c4f497bc6ed2626d00.idx
  .git/objects/pack/pack-2e3e3b332b446278f9ff91c4f497bc6ed2626d00.pack

And you can add another file next to them

  .git/objects/pack/pack-2e3e3b332b446278f9ff91c4f497bc6ed2626d00.keep

to prevent the pack from getting repacked.  I think "git clone" does
this for you after an initial import.
