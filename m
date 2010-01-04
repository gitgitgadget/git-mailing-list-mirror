From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Sun, 03 Jan 2010 23:08:46 -0800
Message-ID: <7vhbr2pcsh.fsf@alter.siamese.dyndns.org>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
 <fcaeb9bf1001021115j7b23264n42cfba7855c2253e@mail.gmail.com>
 <7v7hs09tpi.fsf@alter.siamese.dyndns.org> <87ljgfgbl0.fsf@catnip.gol.com>
 <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
 <877hrzga16.fsf@catnip.gol.com>
 <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
 <7v3a2mzzg4.fsf@alter.siamese.dyndns.org>
 <20100104053125.GA5083@coredump.intra.peff.net>
 <7vbphaquwl.fsf@alter.siamese.dyndns.org>
 <20100104064408.GA7785@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 04 08:09:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRh3w-0003Fi-7i
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 08:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268Ab0ADHJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 02:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752971Ab0ADHJG
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 02:09:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325Ab0ADHJF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 02:09:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D0FA9AB01D;
	Mon,  4 Jan 2010 02:09:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6/t4QySJXlcdJkTG1WvIvy4OC7g=; b=hH9Hj8
	06fOwevadhxLfUCCbmDB2w7GlrH+Pzj7WvpDV+vLqIM62nkTbDDQYQ7nmsE+M/il
	VNb1cZzQwblWCzqDb7+sPEMp/jR87y4zrEPGf32+3SvpxCAMKyyH+/c/fQM8O6wu
	fex8ehEHRPhizCQapvAzhn/dUNUAXeR3u1NQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J8bw9lKRqHiG9nqteBVTehdWxal9nJUu
	aAnIFlBKuAMjj42Mm3LUWQAo2O8x4ErOKpNEwdXMdLBBqsUuhPTa0hYlEHotAruA
	9qX56xLIFWWg7sR64IiiuD2/4tY7aBRZWYON3XqvwRs3PPr0NaaSG5bFI3umbZSg
	Fp4NnRgc9N0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 84839AB01B;
	Mon,  4 Jan 2010 02:08:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DC765AB01A; Mon,  4 Jan 2010
 02:08:48 -0500 (EST)
In-Reply-To: <20100104064408.GA7785@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 4 Jan 2010 01\:44\:08 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 057BAD8E-F900-11DE-A9BC-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136098>

Jeff King <peff@peff.net> writes:

> I have to wonder, though...did anybody ever actually profile our
> internal grep to find out _why_ it was so much slower than GNU grep?

I vaguely recall that somebody fairly competent mentioned that modern grep
implementations are based on DFA engines, but I offhand don't remember if
the discussion had concrete numbers.

> Could we simply ship a better grep engine and obsolete external grep?

Yes, that is a very constructive longer term solution.
