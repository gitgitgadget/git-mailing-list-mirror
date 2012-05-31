From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove perl dependency from git-submodule.sh
Date: Thu, 31 May 2012 12:26:08 -0700
Message-ID: <7v7gvs6tkf.fsf@alter.siamese.dyndns.org>
References: <1338454126-30441-1-git-send-email-iveqy@iveqy.com>
 <4FC73788.6070805@viscovery.net>
 <20120531104036.GB30500@paksenarrion.iveqy.com>
 <7vpq9k6y16.fsf@alter.siamese.dyndns.org>
 <20120531184841.GA32131@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu May 31 21:26:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaB0i-0007aj-Mc
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 21:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933133Ab2EaT0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 15:26:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58049 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933116Ab2EaT0L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 15:26:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6B7D891D;
	Thu, 31 May 2012 15:26:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yH5rPyRaiXVt0ivZIU9+4JcVU7Q=; b=flg3sQ
	9/m3z02269vUaknwzeXLkpGvdSlYJ3AXPKZzdT89M32ld1TVPibiLrnHdWbWJaPt
	0s6H4SVhG7hRPnqOe+fkwQMNEMLZOaAg4Y09GgiBYh6QggqAmRBDYxDvswwRci+6
	+kJHQ+1uie+KocvCEPQQa954vlbMkt1w6xfvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TpDMapw1cqoLyj5Z5xaSqWsWyQ3tm30M
	430rdiXjbxdI+WiKNFvSsUZNuvLLg87JgCuGZYKsIRN3xrb9Xwf6ZsGCobUpVLVq
	vVGyKu2EbUpRRNPmB7PuRmOoQdFqt0oCBVao0ZFIfXDsOef3+T92TdeHpaEW3p40
	sYXGbB8k5Ds=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A923891B;
	Thu, 31 May 2012 15:26:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2AAEE8917; Thu, 31 May 2012
 15:26:10 -0400 (EDT)
In-Reply-To: <20120531184841.GA32131@paksenarrion.iveqy.com> (Fredrik
 Gustafsson's message of "Thu, 31 May 2012 20:48:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A199222-AB56-11E1-B2EE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198941>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> On Thu, May 31, 2012 at 10:49:41AM -0700, Junio C Hamano wrote:
>> Having said that, in the longer term, I think the right direction to
>> go is the opposite.  It would be better to make "git-submodule.sh"
>> work better with paths with funny characters in them, and one
>> obvious approach is to read "ls-files -z" output with something
>> capable of parsing NUL-terminated records, e.g. a Perl scriptlet.
>> Adding a new shell loop like this patch only adds one place that
>> needs to be fixed later when that happens, so I am not sure I like
>> this patch.
>
> Is perl really a dependency that git wants?

It depends on your definition of "want"; I'd say "if alternative is
to lose things like functionality, performance, etc., we would
rather live with it."

It is one of the more widely available scripting languages whose
scripts are more portable across platforms (sadly, we ought to be
able to use sed and awk which are more available but we have seen
portability issues with them); if we want to step outside of what
can be done with POSIX shell scripts (e.g. handling NUL terminated
stream) but are not ready to rewrite everything in C, I would say it
is the least evil among others.  So the short answer is yes.

> Today only a few bit (often
> non critical) are in perl. I thought the way was to get rid of those and
> replace them with c?

But your patch does not help us bring ourselves any closer to
replace anything with C at all.

> I'm very critical to dependencies when they are not needed.

The key-phrase is "when they are not needed".  

If the patch were to replace it with awk, sed or shell *without*
losing functionality, performance, readability, portability &
maintainability, it would be giving us one less dependency without
losing anything.  It may not be replacing everything with C, but at
least it would not be going backwards.

On the other hand, if the patch were to replace Perl scriptlet with
ruby or python, that would be adding unnecessary extra dependencies,
as we do not have anything written in them in the core.  To such a
patch, we can confidently say "It adds unnecessary dependency
without value" and reject it.
