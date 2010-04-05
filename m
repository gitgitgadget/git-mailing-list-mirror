From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] diff: add --word-diff option that generalizes
 --color-words
Date: Mon, 05 Apr 2010 11:46:11 -0700
Message-ID: <7v6345pwjw.fsf@alter.siamese.dyndns.org>
References: <cover.1270388195.git.trast@student.ethz.ch>
 <a1e9ef6a4eb1d7930f69e9ac4b63dc3152ebc98c.1270388195.git.trast@student.ethz.ch> <7v39zay7or.fsf@alter.siamese.dyndns.org> <201004051220.47400.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Paul Mackerras <paulus@samba.org>, Miles Bader <miles@gnu.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:46:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrJi-0007m2-43
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756170Ab0DESq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 14:46:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39235 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755907Ab0DESq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:46:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E424A80F5;
	Mon,  5 Apr 2010 14:46:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jgyjo794GGkZOip+2j0lI8CP1eA=; b=GO98Jb
	Vuw70WdAu5evfu+RsKPFeDjv1KfyI4vz2dYoBbp5zqPGpW6/gAqYAczxVugGizmd
	2ssAfm/L/BVgp9FmBQgtFijbCSNQ+2j19WgPAOaBkkAQZLtP/JRudzCG9rsBjDGB
	7qHYuS8lZ1rHiaFVXixEkTnVVYnbQdtFlodyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oEb8VzDhn9POvhi60es0uHYLSdp2v1lN
	0BxCktjx90BMxw5sy5TP8Kwbz2qyfcxSW8BW1DdMkVApX0IvA0SUv2/i95oPwaqd
	UmdkkyTaJqdahyJX3NsQVYLkE0Aslsg23DAEXUv91KIhxHsO6wfYACEKD0wSu2CL
	dhSr9LODHTU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A0C05A80DD;
	Mon,  5 Apr 2010 14:46:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A5C4A80CE; Mon,  5 Apr
 2010 14:46:12 -0400 (EDT)
In-Reply-To: <201004051220.47400.trast@student.ethz.ch> (Thomas Rast's
 message of "Mon\, 5 Apr 2010 12\:20\:46 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 861D337E-40E3-11DF-A86F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144042>

Thomas Rast <trast@student.ethz.ch> writes:

>> I think it is a bug that "git show --word-diff" gives the colored format
>> output when I have "color.ui" configuration.
>> 
>> Even though I may have "color.ui = auto" in the configuration, I am
>> telling the command to do a --word-diff, not --color-words, from the
>> command line, and that should override color.ui settings.
>
> I don't really see why the user would forfeit the convenience and
> readability of a color-words diff when the terminal supports colors.

There is one difference between other uses of colors and color-words, but
I can imagine that ordinary people may not have even realized nor thought
about it.

To people who are somewhat but not completely color-challenged (like
myself), it still helps to paint hunk headers in a color that is different
from the body text to make the boundary of each hunk more visible.  Even
without the perception of exact color/hue, the contrast alone helps in
that case.

The body of the diff is painted in deleted and added colors; the color is
used only as a way to additionally enhance the output, while still keeping
the plus/minus/SP at the leftmost column.  Even to somebody who is
completely color challenged, the necessary information is still there.

Compare --color-words with these.  The output uses color as the _only_ way
to say which words appear before and after.  The contrast among the three
colors used for the plain body, deleted and added text may still help, or
it may not, to a partially color challenged person.

I also happen to see "--word-diff=color" more as just a customization to
the "plain" output formatting to say "use these byte sequences that happen
to be ANSI color codes, instead of '{+', '+}', etc." than as a part of
what the ui.color switch wants to specify, which is "are various parts of
the output colored to further help distinguishing them visually?"

So color me somewhat biased, but there is a case where the suggestion in
the message you are responding to makes a difference.

I also think --color --word-diff=plain could show "{+new+}" in green and
"[-old-]" in red and that may make things more consistent.
