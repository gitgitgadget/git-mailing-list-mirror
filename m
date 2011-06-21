From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/13] advice: Introduce error_resolve_conflict
Date: Tue, 21 Jun 2011 11:43:58 -0700
Message-ID: <7vtybj81ox.fsf@alter.siamese.dyndns.org>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-2-git-send-email-artagnon@gmail.com>
 <20110621155555.GF15461@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 20:44:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ5vl-0006fm-Q4
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 20:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757183Ab1FUSoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 14:44:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61008 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756933Ab1FUSoC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 14:44:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7841E416E;
	Tue, 21 Jun 2011 14:46:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KLsuVeoKM5/PsmB9BQ8I24Cmu4I=; b=r7vW5w
	nXA9h3H+Ai4paVSAinW8u3/3QVuNDGTzsikjKVRHIdkMnqQ8aabRThvZm+Gv9fkk
	i87hUAGFjQajikyh5Vu+uF8GJpCpnDdxrvnbJUhZdqr6usZ7jMDnS/nk+dloyvHh
	xEecNINGKbh9OgAT6mvkti6831eUJePkoGU7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y1b6DrpJ3U22uyWYpy5NUFMoXYZphgca
	Nd+kuOckz5x0aoKsxDhiqaUIcuqK2YyPCoTyD0EjJMB/EnzLkX+vs6LxzIZB7qR3
	xk6sekVrUb3QndgoFKUr/HL14bHTkbu0yi0dHi/G7sGgqFfAjwBNaoJqZ6wbz2lc
	6B5W4W427GU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7147C416D;
	Tue, 21 Jun 2011 14:46:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B80B4416C; Tue, 21 Jun 2011
 14:46:12 -0400 (EDT)
In-Reply-To: <20110621155555.GF15461@elie> (Jonathan Nieder's message of
 "Tue, 21 Jun 2011 10:55:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BCA199D0-9C36-11E0-915F-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176181>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ramkumar Ramachandra wrote:
>
>> Introduce error_resolve_conflict corresponding to
>> die_resolve_conflict, and implement the latter function in terms of
>> the former.  The only trade-off is that die_resolve_conflict is a
>> little noisier now.
>
> The above doesn't tell me what I would want to know, namely:
>
>  1. The impact of this patch is to change an error message.
>
>  2. The change is from
>
> 	fatal: 'commit' is not possible because you have unmerged files.
> 	Please, fix them up in the work tree ...
> 	... etc, etc ...
>
>     to
>
> 	error: 'commit' is not ...
> 	error: Please, fix them up...
> 	... etc, etc ...
> 	fatal: Exiting because of an unresolved conflict.
>
>  3. The intended benefit is that new, future callers may want the "error"
>     without exiting.

Your good suggestions for inexperienced people are always appreciated.

> Notice that after writing the above, a little detail jumps out:
> namely, the second "error:" line is giving advice, so it might make
> sense to make it say "hint:" instead.

Yes, and also I suspect that it shouldn't be hard to do this refactoring
without changing the output.
