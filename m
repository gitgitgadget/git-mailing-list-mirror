From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Performance issue of 'git branch'
Date: Fri, 24 Jul 2009 16:28:08 -0700
Message-ID: <7vr5w564qf.fsf@alter.siamese.dyndns.org>
References: <20090723160740.GA5736@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907230913230.21520@localhost.localdomain>
 <20090723165335.GA15598@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain>
 <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain>
 <20090723195548.GA28494@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain>
 <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain>
 <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain>
 <20090724225415.GC6832@mit.edu> <20090724225917.GA11191@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Carlos R. Mafra" <crmafra2@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 01:28:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUUBh-0004JA-Iu
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 01:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192AbZGXX2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 19:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753440AbZGXX2T
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 19:28:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52954 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbZGXX2T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 19:28:19 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 772B21083D;
	Fri, 24 Jul 2009 19:28:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4A3C91083B; Fri, 24 Jul 2009
 19:28:10 -0400 (EDT)
In-Reply-To: <20090724225917.GA11191@spearce.org> (Shawn O. Pearce's message
 of "Fri\, 24 Jul 2009 15\:59\:17 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ABC8AE80-78A9-11DE-AE8C-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123976>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Theodore Tso <tytso@mit.edu> wrote:
>> On Fri, Jul 24, 2009 at 02:21:20PM -0700, Linus Torvalds wrote:
>> > 
>> > I wonder if there is some way to only load the crazy curl stuff when we 
>> > actually want open a http: connection.
>> 
>> Well, we could use dlopen(), but I'm not sure that qualifies as a
>> _sane_ solution --- especially given that there are approximately 15
>> interfaces used by git, that we'd have to resolve using dlsym().
>
> Yea, that's not sane.
>
> Probably the better approach is to have git fetch and git push be a
> different binary from main git, so we only pay the libcurl loading
> overheads when we hit transport.

Even though that still will hurt people who do not use http, I think it
would be a right approach (in the sense that it should not be too painful
and with a reasonable gain for local-only operations).
