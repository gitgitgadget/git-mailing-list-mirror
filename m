From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Dokumenting api-paths.txt
Date: Thu, 22 Aug 2013 10:29:02 -0700
Message-ID: <xmqqy57tr5wh.fsf@gitster.dls.corp.google.com>
References: <1376864786-21367-1-git-send-email-stefanbeller@googlemail.com>
	<1376954619-24314-1-git-send-email-stefanbeller@googlemail.com>
	<52136F9C.6030308@kdbg.org> <5213DE72.3000308@googlemail.com>
	<20130820213452.GI4110@google.com> <5213E240.9080106@googlemail.com>
	<20130820215911.GJ4110@google.com> <52154282.60701@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 19:29:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCYh8-0002mq-5A
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 19:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941Ab3HVR3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 13:29:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52075 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753429Ab3HVR3H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 13:29:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BFF43BC35;
	Thu, 22 Aug 2013 17:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PQiSsip+3JsAE/QnD9Tq2f5V/P8=; b=MyyoIm
	5yUQjdriDhu/fJYa8ftcV2ODIDPGGfJQA2Jg8xoMa4oQmsthPnhr6oLnG2gxXouM
	52qNpbbgqfaF2ez0B5CboX7xddRJdnGKr0FmuwSUxTCYS5JUas9X2jbr1yCLpogv
	CTenS4muQ2z42KpJ+2Ylnz70Nj0orxOtIz5AQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XKvmHFZN5SwoMhdiyTtz6J6e0gTl6PsT
	esNZx7WroqVh6RB8SHv951GGAOZD3bGpQJMUf94kjiL2lb6fI3gFU720kel/BVew
	9tSsLeRAoltGmBcnsj60OakWMfeCU4ns9bs9vNWqWh3iVoNLEyCRVqezXduJzsfO
	BVLOvWZBLkU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E68A3BC32;
	Thu, 22 Aug 2013 17:29:05 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60F613BC2D;
	Thu, 22 Aug 2013 17:29:04 +0000 (UTC)
In-Reply-To: <52154282.60701@googlemail.com> (Stefan Beller's message of "Thu,
	22 Aug 2013 00:43:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 57992126-0B50-11E3-8C3E-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232769>

Stefan Beller <stefanbeller@googlemail.com> writes:

>> git_path is for resolving paths within GIT_DIR, such as
>> git_path("config") and git_path("COMMIT_EDITMSG").
>> 
>> Jonathan
>
> Before we're doing double work, I just wrote down my understanding
> so far. Feel free to tweak it, or remove obvious parts.

> path API
> ========

I am not sure if they deserve to be called "API"; it is just a
set of simple helper functions.

> `mkpath`::
> 	The parameters are in printf format. This function can be
> 	used to construct short-lived filename strings. It is meant
> 	to be used for direct use in system functions such as
> 	dir(mkpath("%s/pack", get_objects_directory())).
> 	The return value is a pointer to such a sanitized filename
> 	string, but it resides in a static buffer, so it will
> 	be overwritten by the next call to mkpath (or other functions?)
> 	This function only does string handling. It doesn't actually
> 	change anything on the filesystem. (This is not Gits mkdir -p)
>
> `mkpathdup`::
> 	The same as mkpath, but the memory is duplicated into a new
> 	buffer, so it is not short-lived, but stays as long as the
> 	caller doesn't free the memory, which the caller is supposed
> 	to do.

Good.

> `xstrdup`::
> 	Duplicates the given string, making the caller responsible
> 	to free the return value. Basically the same as strdup(2)
> 	with errorhandling.
>
> 	I am not sure if this belongs into the path api documentation,
> 	but it's not documented anywhere else.

This does not belong.  It should be grouped together with xmalloc(),
xcalloc(), xrealloc(), etc. and these are not "path" functions.

> `git_path`::
> 	git_path is for resolving paths within GIT_DIR, such as
> 	git_path("config") and git_path("COMMIT_EDITMSG").
> 	This is similar to mkpath, returning a pointer to a static
> 	buffer, which may be overwritten soon.
>
> `git_pathdup`::
> 	The same as git_path, but creating a new buffer. The caller
> 	is responsible to free the returned buffer.

OK.

> `git_path_submodule`::

Similar to git_path() but is run for a submodule specified by the
"path" given as its first parameter.
