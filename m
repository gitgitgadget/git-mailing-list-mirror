From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segfault in the attr stack
Date: Wed, 01 Jun 2016 15:35:08 -0700
Message-ID: <xmqqlh2ownab.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79ka_4vZfNhgOyMeFKdossO-S5Q7RVnvEzB8YAJNc1YQ+uQ@mail.gmail.com>
	<xmqqpos0wodp.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZ6dh7AP5b5N_2RRHQmq=OKpr05JEwyOCbfOj6KWjFC2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 00:35:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8EjQ-0005SV-Es
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 00:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbcFAWfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 18:35:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53077 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751010AbcFAWfN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 18:35:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 25B332126E;
	Wed,  1 Jun 2016 18:35:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LrGGbID7SobNcWIFLf/Gg5JLDbg=; b=QCrsnV
	AZbW3wy5Met5X9+g5cMVRPVZnlbjbbxRv7UQ6oHxNt5JOs7eg7IoPd0l+XSp+4HS
	kpoXUH8hwxd4e1K/dAMMOz/qIVmNU6KX/hcVjqBAwW5wVUE4DshnE05EJpZQtSah
	lnHGhlgogos2z5PuzZCG46NcsxUc4syZOsKds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ngxh2PO7UTaL29uB7Gs9Eese/UGWADf1
	YzbFKtmlSxFlDA/mTqsz0X3GI4vsV/Mg0KAyk2fNH55mfO3/Jio29nxkBg0sjEFl
	hMQ74ntlG56Tr7UUH62O8cu7mYcodqJcc+EQuFNrPV/TCJ0Q598YGoyQ2gsYlQz4
	xxbMFMeTRdk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DEAA2126D;
	Wed,  1 Jun 2016 18:35:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9A12F2126C;
	Wed,  1 Jun 2016 18:35:11 -0400 (EDT)
In-Reply-To: <CAGZ79kZ6dh7AP5b5N_2RRHQmq=OKpr05JEwyOCbfOj6KWjFC2A@mail.gmail.com>
	(Stefan Beller's message of "Wed, 1 Jun 2016 15:29:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1A10F0B8-2849-11E6-9A4B-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296174>

Stefan Beller <sbeller@google.com> writes:

> I propose to not escape commas, but use
> white spaces instead, i.e.
>
>     git status ':(attr:whitespace=indent trail space,attr:label=with
> more values)' ':attr(attr:foo:bar)'
>
> would match
> * all files that have the whitespace AND the label setting (matching
> exactly the values)

"attr:whitespace=indent trail ..whatever other stuff.." is already a
non-starter.  In the example in the message you are responding to, I
want to find paths whose "whitespace" attribute is set to the exact
string "indent,trail,space".  And I do not want the pathspec magic
code to know how the interpretation of "whitespace" attribute treats
comma in the string.  It may or may not have any special meaning, so
if you meant "whitespace=indent trail ..whatever other stuff.."  to
mean "either whitespace is set to indent, or whitespace is set to
trail", then that is already unacceptable.
