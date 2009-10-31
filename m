From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] Provide a build time default-editor setting
Date: Sat, 31 Oct 2009 12:51:34 -0700
Message-ID: <7vzl775ol5.fsf@alter.siamese.dyndns.org>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock> <20091031014441.GH5160@progeny.tock>
 <7vfx90co1e.fsf@alter.siamese.dyndns.org>
 <20091031032647.GA5583@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 20:52:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4Jzh-0004rL-Hy
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 20:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933215AbZJaTvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 15:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933205AbZJaTvo
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 15:51:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55089 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933213AbZJaTvn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2009 15:51:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6BE968D170;
	Sat, 31 Oct 2009 15:51:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KFGqvaJa/K4eldM0WXUIB9cM9CQ=; b=Numh+v
	iByv1byz/a+k/tD0/NYjytVSLyBx11xxADcOjTgfrPnvNbOqgGm/UP46PFzzh1Gz
	3o3X2+TBWZJb7GdUtwuLQgEbti7zUX+XkRYLNN+9SrP8niNoqu/CWJf/JHCwAxlj
	PMc/qyJBxYMuefEAmkDzt8fDtnRa8B2hHXIJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xa5iLGwgTaPFK6540QgCYw87uIiB6lTs
	5tamsdGvh2bEjaF/z/PsM/1bA1rbQSZdO0NKAg/kQ4Z3Z7iMnGoqXbqlgKACXEEq
	pcVIzplXXEPghgwSLjbB6c+zdd++/cMpzfEnrnrr8tDiLLoZPo11103KtKpzfHqZ
	OtIc2XjNrzc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2A3178D16F;
	Sat, 31 Oct 2009 15:51:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6784C8D16E; Sat, 31 Oct 2009
 15:51:36 -0400 (EDT)
In-Reply-To: <20091031032647.GA5583@progeny.tock> (Jonathan Nieder's message
 of "Fri\, 30 Oct 2009 22\:26\:47 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D0441A06-C656-11DE-9491-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131852>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>  
>>> +test_expect_success 'does editor have a simple name (no slashes, etc)?' '
>>> +
>>> +	editor=$(TERM=vt100 git var GIT_EDITOR) &&
>>> +	test -n "$editor" &&
>>> +	simple=t &&
>>> +	case "$editor" in
>>> +	*/* | core_editor | [A-Z]*)
>> 
>> Hmm, what are the latter two cases designed to catch?
>
> Both are meant to allow the test to work without too many changes.

Honestly speaking, my preference is to see if the built-in editor is
exactly spelled as 'v' 'i', and skip this test altogether if it isn't.
Then the patch only needs to insert these lines (and reword "default
editor name too complicated" to "using customized default editor") without
touching the rest.  It simply does not look worth the complication.

You _might_ be able to skip only the "vi" part of the test when you see
that the built-in default is customized, though.  I didn't look closely
enough.

> diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
> ...
> +unset EDITOR VISUAL GIT_EDITOR
> +
> +test_expect_success 'determine default editor' '
> +
> +	editor=$(TERM=vt100 git var GIT_EDITOR) &&
> +	test -n "$editor"
> +
> +'
> +
> +if ! test -z "$(printf '%s\n' "$editor" | sed '/^[a-z]*$/d')"
> +then
> +	say 'skipping editor tests, default editor name too complicated'
> +	test_done
> +fi
> +
