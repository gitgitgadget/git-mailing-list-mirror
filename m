From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-config support for diff.relative setting
Date: Sun, 21 Dec 2014 14:46:16 -0800
Message-ID: <xmqqppbcbozr.fsf@gitster.dls.corp.google.com>
References: <54954054.7080201@shysecurity.com>
	<CFEBFB254713492C988FED7E11475227@PhilipOakley>
	<xmqq61d5d7yn.fsf@gitster.dls.corp.google.com>
	<54972281.9050603@shysecurity.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: kelson@shysecurity.com
X-From: git-owner@vger.kernel.org Sun Dec 21 23:46:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2pGa-0004oI-6Y
	for gcvg-git-2@plane.gmane.org; Sun, 21 Dec 2014 23:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129AbaLUWqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 17:46:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58796 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752581AbaLUWqT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 17:46:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 80E1C26072;
	Sun, 21 Dec 2014 17:46:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EMr7XcJ+RtPZ76WkPTEj90mlB9o=; b=dC6LeP
	nshFdKlTwrkCBSXfSqVI+2xjrER847JyE116EwHgOgkunXsXROnMGnsBNydnnWGT
	lFDhr2eeIT1+po3QXaPEJSc8MaxGcsDBXeN8E3/Z9exYZJ1z2icQ7nZT9AIhJ6gi
	bBTqD0TUZAC14S65qGxjL094D1hXQ9K79REks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GuWq/TpBFJoXDXdO+gxC0bo6Z0cM+LZE
	BKybMNNjekhiJiAmCxqATOVyp5whWvSQUVP+sDCDxNHs2GFVUfcdCsUWjZugHxj3
	ETSbzt3Wrk/dUvPRR4+JOTYd+bev/iC7dUW2ChpGELJJ6hSITqKYlRUuORsXQjQg
	K0wxCUpf7hc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 74CD926071;
	Sun, 21 Dec 2014 17:46:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9E582606F;
	Sun, 21 Dec 2014 17:46:17 -0500 (EST)
In-Reply-To: <54972281.9050603@shysecurity.com> (kelson@shysecurity.com's
	message of "Sun, 21 Dec 2014 14:41:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2D1E60A4-8963-11E4-B982-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261633>

kelson@shysecurity.com writes:

>> "Philip Oakley" <philipoakley@iee.org> wrote:
>> Shouldn't this `(identical to "git diff --relative")` also be
>>included in the documentation change? It would truly clarify the
>> intenbt for the reader.
>
> Updated as follows:
> +diff.relative::
> +	Show pathnames relative to the current directory and exclude
> +	changes outside this directory; equivalent to the 'git diff'
> +	option '--relative'.
>
>> "Junio C Hamano" <gitster@pobox.com> wrote:
>> There should be a way to run non-relative diff in a repository that
>> has the configuration set, perhaps by overriding with some command
>> line option (e.g. "--no-relative").
>
> Good idea; I'll put together a second patch for a "--no-relative"
> option to disable diff.relative.

The order should be first to add --no-relative, which should allow
you to say

	$ alias gd "git diff --relative"
        $ gd --no-relative

which would expand to "git diff --relative --no-relative" to defeat
the earlier one on the command line, and then add diff.relative in
the second patch, I would think.  A natural consequence of the
latter would be that these would steps work as expected:

	$ git config diff.relative no
        $ git diff
        $ git diff --relative
        $ git diff --no-relative
        $ git config diff.relative yes
        $ git diff
        $ git diff --relative
        $ git diff --no-relative

which should be tested in a new set of tests added to t4045.

For the first patch, I would expect a new set of tests added to
t4045 to check at least the following:

	$ git diff --no-relative
	$ git diff --no-relative --relative
	$ git diff --relative --no-relative

Thanks.
