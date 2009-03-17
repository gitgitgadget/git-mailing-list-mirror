From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-tag.c: remove global variable to use the
 callback  data of git-config.
Date: Tue, 17 Mar 2009 11:45:41 -0700
Message-ID: <7vljr4q97u.fsf@gitster.siamese.dyndns.org>
References: <1237301031.10001.13.camel@equipo-loli>
 <alpine.DEB.1.00.0903171646140.6393@intel-tinevez-2-302>
 <1b46aba20903171057r4fb4697eo3b8abc62a45fe858@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 19:47:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjeJt-0006HI-Mv
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 19:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929AbZCQSpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 14:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756397AbZCQSpw
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 14:45:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54121 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489AbZCQSpv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 14:45:51 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C7BF26625;
	Tue, 17 Mar 2009 14:45:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F0F5A6623; Tue,
 17 Mar 2009 14:45:43 -0400 (EDT)
In-Reply-To: <1b46aba20903171057r4fb4697eo3b8abc62a45fe858@mail.gmail.com>
 (Carlos Rica's message of "Tue, 17 Mar 2009 18:57:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D51F7930-1323-11DE-A13C-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113516>

Carlos Rica <jasampler@gmail.com> writes:

> On Tue, Mar 17, 2009 at 4:47 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>> On Tue, 17 Mar 2009, Carlos Rica wrote:
>>> @@ -164,11 +162,10 @@ static int do_sign(struct strbuf *buffer)
>>>       int len;
>>>       int i, j;
>>>
>>> -     if (!*signingkey) {
>>> -             if (strlcpy(signingkey, git_committer_info(IDENT_ERROR_ON_NO_NAME),
>>> -                             sizeof(signingkey)) > sizeof(signingkey) - 1)
>>> -                     return error("committer info too long.");
>>> -             bracket = strchr(signingkey, '>');
>>> +     if (!signingkey->buf[0]) {
>>
>> It is probably better to ask for !signingkey->len (think of trying to
>> understand the code in 6 months from now).
>
> I was in doubt here. By avoiding the use of signingkey->len  I was
> trying to say that you cannot rely in such field if we touch the
> buffer directly, as it happens below:
>
>    bracket = strchr(signingkey->buf, '>');
>    if (bracket)
>       bracket[1] = '\0';

That's a wrong use of strbuf, isn't it?
