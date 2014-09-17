From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] pretty: add %D format specifier
Date: Tue, 16 Sep 2014 21:30:50 -0700
Message-ID: <xmqqy4tizx51.fsf@gitster.dls.corp.google.com>
References: <541875ef.6153c20a.4ef5.ffff8cbb@mx.google.com>
	<xmqqegvb2yza.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Harry Jeffery <harry@exec64.co.uk>
X-From: git-owner@vger.kernel.org Wed Sep 17 06:31:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XU6tU-0007N8-Sh
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 06:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbaIQEay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 00:30:54 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54341 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893AbaIQEax (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 00:30:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F0E343BB25;
	Wed, 17 Sep 2014 00:30:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=amjVbZQE/w5ZUUF1qYT+H3ZSuI0=; b=WZ6fd0
	BrdEnYLRlr5/es+X/YiR0ygbm26Aya7lhi1xQvThQS2/4Nctg/HYUB4JqeAT+UO6
	81AzjAhdkxets+SfhR4iYH9zJ5WhR8KyS+8VpNC2fwgANEZS+wzBBtW/x9JMm+qc
	Ob9bsfTzFoWKVZBIi6BINLxreSkkSq6ly0pPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FDWwtP4fcAO5M8u8LCMZ17hxkfeyQozD
	oIecugBbSd9ZhsjHItzRI7D8KUOGwddotWc84nNqOrCClnecLEsVvIdTE4zAaUYX
	cbh3YhJe6BXAJ+NHIjzO25veiPbU0jp/8RwFvia8pM9IluX79BfVOmm+UGsM9+hm
	ylOF8VdLXiQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E6AC83BB24;
	Wed, 17 Sep 2014 00:30:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0526E3BB23;
	Wed, 17 Sep 2014 00:30:51 -0400 (EDT)
In-Reply-To: <xmqqegvb2yza.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 16 Sep 2014 11:37:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6829DE66-3E23-11E4-9B01-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257210>

Junio C Hamano <gitster@pobox.com> writes:

>> +test_expect_success 'clean log decoration' '
>> +	git log --no-walk --tags --pretty="%H %D" --decorate=full >actual &&
>> +	cat <<EOF >expected &&
>> +$head1 tag: refs/tags/tag2
>> +$head2 tag: refs/tags/message-one
>> +$old_head1 tag: refs/tags/message-two
>> +EOF
> ...
> Hmph.  I actually think the part that prepares the history makes
> sure that the output order of the commits is predictable by using
> test_commit and test_tick.  I see existing tests at the end (which
> is a sign that they were added more recently than the rest of the
> test script, and can indicate a careless addition) already has
> "sort", but we shouldn't have to sort.

Actually --tags may feed the tips in unspecified order and --no-walk
ensures the commits will be shown in that unspecified order, so for
a test that runs "log --no-walk --tags", sorting is unavoidable.
