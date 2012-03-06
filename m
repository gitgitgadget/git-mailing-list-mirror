From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: Not add stripped contents for translation
Date: Mon, 05 Mar 2012 22:46:20 -0800
Message-ID: <7v399mw7k3.fsf@alter.siamese.dyndns.org>
References: <1330910494-17216-1-git-send-email-worldhello.net@gmail.com>
 <7v7gyz7pei.fsf@alter.siamese.dyndns.org>
 <CANYiYbGdJ0yFmPnsK_JdABwmFraVdNi08QgFKRmGzJt-DA9tBw@mail.gmail.com>
 <7vobsb67dn.fsf@alter.siamese.dyndns.org>
 <CANYiYbHGAG5ijeL3yW5SKYAfMNwtme5ELPeGNPhNyKBPGTONMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 07:46:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4oAb-0004g0-SD
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 07:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481Ab2CFGqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 01:46:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49047 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752776Ab2CFGqX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 01:46:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A62687C4A;
	Tue,  6 Mar 2012 01:46:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pnXBLVwMX5hlA3R6OVwDiN2196I=; b=g0huew
	upImRwVZ43PzFRT5V/QQYEXQs/BiYSLHnfwqGWkcqU+dW79rXRcYIhB+9Zh/C21b
	XgA2mPIBi/ZOulxYAdnwEAFoTagp9vU2q9TWpyZOrEEIiQCwx7lf2wHthOe0KlOX
	o8jHvQeRoNGfz95dx5e8eziMQh1FJujIOgNBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XSCX5KOgl/RzttuMBVn5pLa7evEEL6bF
	LNxE5vJSpwpuoTvTx9QQ+kBOSQhmXaBpm/EfjeO85oOqp6vZsLUT0BKWwxOwQwZ7
	tpWI94qV5NPIZx+0NHvZshPwBCOVfSkvPxBxV9wN/N8jnk6RVEJz9yoKUNn9UJ59
	BvSr8t/7Hj8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BAEB7C49;
	Tue,  6 Mar 2012 01:46:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFBB27C48; Tue,  6 Mar 2012
 01:46:21 -0500 (EST)
In-Reply-To: <CANYiYbHGAG5ijeL3yW5SKYAfMNwtme5ELPeGNPhNyKBPGTONMg@mail.gmail.com> (Jiang
 Xin's message of "Tue, 6 Mar 2012 12:16:06 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15E4E370-6758-11E1-9893-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192302>

Jiang Xin <worldhello.net@gmail.com> writes:

>> This is a tangent and I am just showing aloud my ignorance, but I wonder
>> if there is a reasonably generic and "best current practice" way to
>> structure code to show an enumeration in human languages, for example,
> ...
> I write a function for this.

It is not a very good API design to use static array in a function
like your code.

You will often want to walk list of lists in a nested loop and want
to have two "appends" running in parallel.  Imagine you are merging
three branches A, B and C in an octopus merge, and want to say
"commits A1 and A2 were merged from A".  You would want to structure
the caller like this:

        clear_list(&list_of_branches);
        # this walks branches A, B and C
        foreach branch
                append_item(&list_of_branches, branch);

                clear_list(&list_of_commits);
                # this walks commits on the branch
                foreach commit on branch
                        append_item(&list_of_commits, commit);
                # this shows e.g. "commits A1 and A2"
                format_list_as_human_string(&list_of_commits);
        # this shows e.g. "branches A, B and C"
        format_list_as_human_string(&list_of_branches);

In any case, I was not asking anybody to come up with an original
solution. Rather, I was asking if somebody knew an already widely
used library-ish implementation we can just reuse.  If there is no
such thing, we may end up designing one ourselves, but we shouldn't
be doing so if we don't have to.
