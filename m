From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: push: point to 'git pull' and 'git push --force' in
 case of non-fast forward
Date: Thu, 06 Aug 2009 14:32:13 -0700
Message-ID: <7vprb8d3xe.fsf@alter.siamese.dyndns.org>
References: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
 <7v7hxgk8c9.fsf@alter.siamese.dyndns.org> <20090806211610.GB12924@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Aug 06 23:32:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZAZd-00010a-QA
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 23:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756789AbZHFVcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 17:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756311AbZHFVcX
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 17:32:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58343 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756788AbZHFVcU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 17:32:20 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5E44323849;
	Thu,  6 Aug 2009 17:32:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0BD4C23848; Thu, 
 6 Aug 2009 17:32:15 -0400 (EDT)
In-Reply-To: <20090806211610.GB12924@vidovic> (Nicolas Sebrecht's message of
 "Thu\, 6 Aug 2009 23\:16\:10 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9F37D85E-82D0-11DE-8D95-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125129>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

>> +Note about fast-forwards
>> +------------------------
>> +
>> +When an update changes a branch (or more in general, a ref) that used to
>> +point at commit A to point at another commit B, it is called a
>> +fast-forward update if and only if B is a descendant of A.
>> +
>> +In a fast-forward update from A to B, the set of commits that the original
>> +commit A built on top of is a subset of the commits the new commit B
>> +builds on top of.  Hence, it does not lose any history.
>> +
>> +In contrast, a non-fast-forward update will lose history.
>
> I believe that this sentence a bit too much scaring for the beginner.
> There are two kinds of update (push and pull). We loose history only
> when pushing.

Three points that makes me think your suggested update is not appropriate
are:

 (1) This patch is about git-push documentation;

 (2) The opposite of git-push is git-fetch, not git-pull; and a non
     fast-forward fetch does lose history if you start building on a
     now-rewound tip of the remote tracking branch; and

 (3) We _do_ want this section to be scary.  We want the readers to be
     fully aware of the implications before tempting them with the --force
     option.

>> +Alternatively, you can rebase your change between X and B on top of A,
>> +with "git pull --rebase", and push the result back.  The rebase will
>> +create a new commit D that builds the change between X and B on top of
>> +A.
>> +
>> +----------------
>> +
>> +      B   D
>> +     /   /
>> + ---X---A
>> +
>> +----------------
>
> Wouldn't "git pull --rebase" loose B? Shouldn't we have this
>
>   ----------------
>   
>             D
>            /
>    ---X---A
>   
>   ----------------
>
> instead?

This makes B _loose_ (or, dangling), but does not _lose_ it.  It is still
reachable from the reflog.

We could choose to not draw it for simplicity, or we could annotate it
like this for completeness (and to give a warm-fuzzy feeling to the reader
that nothing is lost).

----------------

       branch@{1} (reachable from reflog)
             branch
      B      D
     /      /
 ---X------A

----------------

I don't know which is better.  If we were printing in colours in the
documentation, I would keep B but draw it in light gray.
