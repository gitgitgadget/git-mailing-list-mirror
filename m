From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Pass "-O xhtml" param to highlight instead of "-xhtml"
Date: Wed, 26 Jan 2011 13:43:48 -0800
Message-ID: <7vaainjq7f.fsf@alter.siamese.dyndns.org>
References: <20110126171118.GA867@traged.englab.brq.redhat.com>
 <m339ofbb9t.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Tkac <atkac@redhat.com>, git@vger.kernel.org,
	Jochen Schmitt <Jochen@herr-schmitt.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 22:44:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiD9t-0005sh-BT
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 22:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893Ab1AZVoD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 16:44:03 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504Ab1AZVoC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 16:44:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 636C93DCB;
	Wed, 26 Jan 2011 16:44:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ySSWhEjzzX4DCBzAE2PAYP58tbs=; b=dXOAT2
	5bhGQLbSJ2442Aldrbd27zKuAihNCos/kJG3RMCt1sHSk98pKzi9toDPw6+muHCE
	xJmoTcEoUP7A8wYTsrCu8G6DpWSw0ZkdN7iA1IqY+jaOui828MBP95DmY8TBqqMV
	tP+0dy/8RTTe4vi3Knu0hTN8RHiz5RNENlMw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mp8ustYbc37/iwAw/jPeuDrPT3pCUTmm
	Rzy6hGx+hgOpIaz/ZTNPs8eVEazAWULdyEOb1UkOQnrzLB7rQk55EPMl0Z9snE6b
	zFTT32oC2nmobupNt7TrRnnrkLXmkFQ8Bm9DWi3G0a40hB12ugBEByEJ7IJgq0B7
	lXjCljJv974=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 17F003DCA;
	Wed, 26 Jan 2011 16:44:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9C74F3DC5; Wed, 26 Jan 2011
 16:44:38 -0500 (EST)
In-Reply-To: <m339ofbb9t.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Wed\, 26 Jan 2011 13\:34\:32 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7CBAE6AA-2995-11E0-9036-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165555>

Jakub Narebski <jnareb@gmail.com> writes:

>> Current highlight utility doesn't recognize "--xhtml" parameter, it
>> recognizes only "-O xhtml" parameter.
>> 
>> Reference: https://bugzilla.redhat.com/show_bug.cgi?id=672293
>
> Shouldn't the above be in commit message?

Actually, I prefer not having that "Reference" in the commit message
myself, but I do want to have some relevant details
missing from the proposed commit message but is in
that ticket (especially the comment #5) in the commit message.

> In highlight 2.4.5 '-O' means "name of output directory", i.e. --outdir.
> There is no --out-format either.

Thanks for digging about 2.4.5; in that case, unlike the redhat ticket
hinted, this change may not be backward compatible enough, as it seems
that the compatibility goes only back to 3.0.something.

>
> WTF this backward incompatibile change in highlight... the only
> solution that would make it work both for old and for new versions is
> to rely on the fact that HTML is default output format, i.e.
>
>   	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
>   	          quote_command($highlight_bin).
>  -	          " --xhtml --fragment --syntax $syntax |"
>  +	          " --fragment --syntax $syntax |"
>   		or die_error(500, "Couldn't open file or run syntax highlighter");

Adam, Jochen?  How does the counterproposal look to you?

Without knowing much about highlight nor using gitweb in general myself,
the above looks a bit more reasonable fix to the issue, if the default
format has been and will stay to be HTML.
