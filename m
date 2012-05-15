From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ls-tree and wildcards
Date: Tue, 15 May 2012 08:35:23 -0700
Message-ID: <7vd365foec.fsf@alter.siamese.dyndns.org>
References: <4FAE7CBD.3020605@rotorised.com>
 <7vbolqiuh1.fsf@alter.siamese.dyndns.org>
 <CACsJy8AdoOcUxq+pmhAPxiPAiQc60aCLf7Jt31YFW4+6OHZEEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ryan McCue <lists@rotorised.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 17:35:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUJmm-0004K6-J5
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 17:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965260Ab2EOPff convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 May 2012 11:35:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50078 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965021Ab2EOPfe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 May 2012 11:35:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 101A5708B;
	Tue, 15 May 2012 11:35:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pi+LU6phhpBi
	mJMlNu64sxHKKtI=; b=gHbjv7YdheT36HH+GzgNTLyseai7K8awC9ylB4Pgd9Z8
	sCTJL0eliQQARfgDJopk2y4iTVriRcKbKOVnYSMx8n+7ziu7uGSMeZvl9qMCgtW8
	tk8nYxjSnUpklLdN9R1of/eA1qWIHwpmfVA4shrWHVgez5VSZ1C6FdVDlaNSF2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=plKUBa
	j4mIIdYmuA/OX+Bwa3KWv0xv3xdyVs6CJx8xyd5CRpYBWHU0clkoGzYeI7Dy005E
	bJzwZxnUdjsM9MyJ1TCB0KX8TKysIy4kqTsA22B2ihDEr7DC1HgFAq2jmcuaNblh
	Q31vSQq4cslNrRhKAgiZiWEYD/j0rO5RYQtcY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06BCE708A;
	Tue, 15 May 2012 11:35:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C398F7085; Tue, 15 May 2012
 11:35:29 -0400 (EDT)
In-Reply-To: <CACsJy8AdoOcUxq+pmhAPxiPAiQc60aCLf7Jt31YFW4+6OHZEEg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 15 May 2012 18:29:53 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 99FC3320-9EA3-11E1-A7F5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197839>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Mon, May 14, 2012 at 11:43 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Later Nguyen and others started working on unifying the two separate
>> "pathspec" semantics and we are probably halfway there. =C2=A0Many o=
f the
>> commands from "diff/log" family now can take wildcard (there may be =
new
>> bugs in the codepaths, though), but "ls-tree" has not been converted=
=2E
>
> Do we break backward compatibility by teaching ls-tree new pathspec
> semantics? I guess directories with wildcards in the name are rare,
> the chance of someone doing "ls-tree a*" is low. But I may miss
> something.

If you change ls-tree to use its paths arguments as pathspec, you will
break backward compatibility.

But nobody stops us from _adding_ an option to ls-tree to tell it to
switch between the two, i.e.

	git ls-tree HEAD -- '*.c'
	git ls-tree --pathspec HEAD -- '*.c'

The former will use the traditional "leading path match only" while the
latter uses the (to-be) unified "pathspec" semantics.

Internally, the implementation could very well do something like this
after parsing the options:

	if (!opt_pathspec)
        	prefix ":(noglob)" to all paths args

and use the updated code with magic pathspec support to handle both cas=
es.
