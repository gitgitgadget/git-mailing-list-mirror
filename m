From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/12] ref-filter: use parsing functions
Date: Mon, 01 Feb 2016 14:25:54 -0800
Message-ID: <xmqqr3gwt6dp.fsf@gitster.mtv.corp.google.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 23:26:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQMv2-0006j2-T3
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 23:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbcBAWZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 17:25:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751210AbcBAWZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 17:25:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EF8D64133D;
	Mon,  1 Feb 2016 17:25:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CcwYizwpr/1EDyQCcbUj08ZKnNI=; b=QE9V3F
	jgvDIRqpHeBXpOqXMccn7xX8gbdT3V1LR0BqQM3fLP5QL4Xqi6UKjBt6y5MZQAob
	ZEwyeEY1T43NFzCReQHbqwf4CaxR+NMYxpUYhvXqqt+iPJV5oZIFo6WlKEGOw4nf
	xwWFH46yVdH67xrrIHQjIXRXFlRLNT6Ra7kHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cDlvqIeHAKSgaMAl2EKH/Ta9i1/sGAOt
	F6y2CPhyIlUn95OzSS4KVzYZk5PLIIl3BeoxcPabS9ScotHsPJ7cs1iP2Z2mEsvt
	f3qTjCQbalopbmUob0CnJkTQwfkIK/Di33bPm4tlr9qv+QXeVOkiMb4zSN985Zl8
	QfcFA0/7MHU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E7BC84133C;
	Mon,  1 Feb 2016 17:25:55 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 68D164133B;
	Mon,  1 Feb 2016 17:25:55 -0500 (EST)
In-Reply-To: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Sun, 31 Jan 2016 23:12:44 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C28FF020-C932-11E5-A1B8-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285222>

Karthik Nayak <karthik.188@gmail.com> writes:

> This series cleans up populate_value() in ref-filter, by moving out
> the parsing part of atoms to separate parsing functions. This ensures
> that parsing is only done once and also improves the modularity of the
> code.
>
> v1: http://thread.gmane.org/gmane.comp.version-control.git/281180
> v2: http://thread.gmane.org/gmane.comp.version-control.git/282563
> v3: http://thread.gmane.org/gmane.comp.version-control.git/283350
>
> Changes:
> * The parsing functions now take the arguments of the atom as
> function parameteres, instead of parsing it inside the fucntion.
> * Rebased on top of pu:jk/list-tag-2.7-regression
> * In strbuf use a copylen variable rather than using multiplication
> to perform a logical operation.
> * Code movement for easier review and general improvement.
> * Use COLOR_MAXLEN as the maximum size for the color variable.
> * Small code changes.
> * Documentation changes.
> * Fixed incorrect style of test (t6302).
>
> Karthik Nayak (12):
>   strbuf: introduce strbuf_split_str_omit_term()
>   ref-filter: use strbuf_split_str_omit_term()
>   ref-filter: bump 'used_atom' and related code to the top
>   ref-filter: introduce struct used_atom
>   ref-filter: introduce parsing functions for each valid atom
>   ref-filter: introduce color_atom_parser()
>   ref-filter: introduce parse_align_position()
>   ref-filter: introduce align_atom_parser()
>   ref-filter: align: introduce long-form syntax
>   ref-filter: introduce remote_ref_atom_parser()
>   ref-filter: introduce contents_atom_parser()
>   ref-filter: introduce objectname_atom_parser()

Hmm, 10/12 didn't make it to the list?
