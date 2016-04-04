From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] imap-send.c: implements the GIT_CURL_DEBUG environment variable
Date: Mon, 04 Apr 2016 09:50:08 -0700
Message-ID: <xmqqr3el5nen.fsf@gitster.mtv.corp.google.com>
References: <1459507482-36678-1-git-send-email-gitter.spiros@gmail.com>
	<xmqqtwjljq97.fsf@gitster.mtv.corp.google.com>
	<CA+EOSBkY-Tsz3ZAfK3uAXJsrE585cOhyxjsU4FhgDMFC-ypkUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 18:50:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an7hj-0006dt-SA
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 18:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854AbcDDQuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 12:50:13 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53477 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755471AbcDDQuL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 12:50:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 919384F06E;
	Mon,  4 Apr 2016 12:50:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EJGRseHAdpNWt3MCDpjAfc/aYXs=; b=q7f9tP
	zBW5etvywnXdf6TJG/RpWJoGJbTCzQhOyBr5c6bgWTcaQ6ie0CVIt1MLSjffNsg/
	rV2FGuhercwDlgAWQg+yHIYVFo2gbTiH5lEbePXv47F/uAe4qcYQdTxL98hc++Ho
	Z6lxU1039CRBs2wifbpmJRltxri3PWBrXltP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ofMhLXmbYGlKPE5hkugsuuksZXRPntaX
	Nt/Y02b5MuvuhndnjOyNi44cBwrbRSmo0BDNPTRM4/Q5kpHu/HMHEwOuaRfoR6Kw
	bJ9wEwefdziW6uwJAHUBXHvSI4kgtUMHy7nsbRlci16kOw6z9LyFst5pFddKUqnk
	XGQx94IuF/s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 88F664F06D;
	Mon,  4 Apr 2016 12:50:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E7C214F06C;
	Mon,  4 Apr 2016 12:50:09 -0400 (EDT)
In-Reply-To: <CA+EOSBkY-Tsz3ZAfK3uAXJsrE585cOhyxjsU4FhgDMFC-ypkUg@mail.gmail.com>
	(Elia Pinto's message of "Mon, 4 Apr 2016 18:08:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4AF181DA-FA85-11E5-BB81-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290697>

Elia Pinto <gitter.spiros@gmail.com> writes:

>> My impression is that using GIT_TRACE_* is the more mainstream
>> trend, and it may be beneficial to work any new debugging aid like
>> this one to fit within that mechanism.
>
> I thought about it, and I agree with you. The idea could be
>
> - Call the variable GIT_TRACE_CURL_DEBUG instead

I think GIT_TRACE_CURL_DEBUG is overly verbose; tracing by
definition is a debugging aid.

> - Add the new GIT_TRACE_CURL_VERBOSE variable, keeping
> GIT_CURL_VERBOSE for compatibility

I do not care too deeply either way.

 - GIT_CURL_VERBOSE can stay the same as-is and show its output to
   whatever output channel it spits things out.

 - Or it can be a synonym for GIT_TRACE_CURL=2 (as I understand that
   the VERBOSE output goes to the standard error stream)

If you want tracing as debugging aid and existing CURL_VERBOSE
orthogonal, it would probably make more sense to go the former
route, not linking this new "DEBUG" thing with the existing
"VERBOSE" thing.

> - Documenting these GIT_TRACE_CURL_XXX variables (GIT_CURL_VERBOSE
> it is not even documented i think)

If we decide to leave them untangled, this is not necessary.

> - perhaps use the git trace api in doing these new patches
>
> Look reasonable? It seems reasonable? I'd like your own opinion

Not really sensible as long as you have that "perhaps" in the list.

Something that does not use the trace API shouldn't pretend to by
using GIT_TRACE_* names.

GIT_TRACE_CURL could be your new thing and would decide where to
show its output by using the GIT_TRACE_* api.
