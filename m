From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 04/13] Add documentation of the index-v5 file
 format
Date: Thu, 09 Aug 2012 16:13:44 -0700
Message-ID: <7vfw7vmzfb.fsf@alter.siamese.dyndns.org>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com>
 <1344424681-31469-5-git-send-email-t.gummerer@gmail.com>
 <7vobmjn0wv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 01:13:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzbvN-0005qQ-RS
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 01:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759861Ab2HIXNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 19:13:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40361 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754093Ab2HIXNr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 19:13:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED93E9D92;
	Thu,  9 Aug 2012 19:13:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tWZxL5W5UXHY/UxnED/uJKFgRGA=; b=F6BMUq
	uiPX2pAg5uvDF5cYgMC0Rl3MQUb2yq8Wr3TvV4n84P8Z3WN/N0LxJDonDAhKvfG3
	VsakWfVEtrKWoxTapdUQoS1h19cHBqJIiPKZzU/FrDFHx5dds3pjJA/iqGHogCKW
	ZgGksI/1dXKOasv6HA4ivEKi6CgGkGwx3hUlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OL1ndicO8lgTqdc8RvDzKsOlpj8homdd
	1NIDQpy/GaGtvGUrYRUHTkiTPPy7fr8urfLVqbJrCJLZGIFLI+22e3mGllAe2Vj3
	0ErkMkszbltnK9fvLRytJfm8oFQ3im8nHC5PHgJK3oNUKSRRI+a/aEbfW863HvdC
	1KuAKzDXUVk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBA409D91;
	Thu,  9 Aug 2012 19:13:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 584359D90; Thu,  9 Aug 2012
 19:13:46 -0400 (EDT)
In-Reply-To: <7vobmjn0wv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 09 Aug 2012 15:41:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DEBEF46C-E277-11E1-ADA3-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203189>

Junio C Hamano <gitster@pobox.com> writes:

>> +== Design explanations
>> + ...
>> +[3] The data of the cache-tree extension and the resolve undo
>> +    extension is now part of the index itself, but if other extensions
>> +    come up in the future, there is no need to change the index, they
>> +    can simply be added at the end.
>
> Interesting.  When we added extensions, we said that there is no
> need to change the index to add new features, they can simply be
> added at the end.  Perhaps the file offset table can be added as an
> extension to v2 to give us the same bisectability, allowing us a
> single entry in-place replacementability, without defining an
> entirely different format?

Just to avoid wasting people's time, in case they try to respond to
this part which was tongue-in-cheek.

There is a valid technical reason why the above cannot be done with
the original index format and why a new extension does not make
sense. There is no quick way to locate the extensions section in the
file without reading all the entries first, so by the time you know
where the extensions are, you already know all the paths, and have
enough information to build a table necessary to do the bisection
without a separate data in a new extension.
