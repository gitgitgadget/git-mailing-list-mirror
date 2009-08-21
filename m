From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v4 04/19] Teach Git to respect skip-worktree bit 
 (reading part)
Date: Fri, 21 Aug 2009 10:32:07 -0700
Message-ID: <7vd46pf4yw.fsf@alter.siamese.dyndns.org>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
 <1250776033-12395-2-git-send-email-pclouds@gmail.com>
 <1250776033-12395-3-git-send-email-pclouds@gmail.com>
 <1250776033-12395-4-git-send-email-pclouds@gmail.com>
 <1250776033-12395-5-git-send-email-pclouds@gmail.com>
 <fcaeb9bf0908210219h1c2a4702i81661ced00f39232@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 19:34:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeY0w-0004ye-0a
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 19:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932898AbZHURcN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2009 13:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbZHURcN
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 13:32:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41761 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbZHURcM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2009 13:32:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CE9C1353E;
	Fri, 21 Aug 2009 13:32:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HAXVnYA6epiS
	56AgFMLU57G+eWg=; b=jteSLk3ud6g1qEUU/VyrS4uLeuyknC+hBvq+Fomiowcb
	Kjxn/NQqRkw/BIKg+bdnVh4Rwu3u/dnAeaSfQ+k/OxX2czi3utZosufJh7m9IwIw
	o7KVwoqlo9tT89EsMVZXHXEoheiAVeQayt1kjlI3fnp80vI/vah7YydQajjNihg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KsWg8s
	aefyGJJzKVNFHx/sbxWvcorVT0cAKkLOe1s6ycubNZriDF1g0sLs2//PWwvy3+Us
	8FzCF8nvEpRSdfbfBzd88+Y8W8Yrm/FQFr9Lx+wzxGzu7aWgUHXcWdBNJi8apt4b
	yypXr1FNXA0NKGwdIRquiJoYwe4XoVCM42LLM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E5FD1353B;
	Fri, 21 Aug 2009 13:32:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8403813539; Fri, 21 Aug
 2009 13:32:08 -0400 (EDT)
In-Reply-To: <fcaeb9bf0908210219h1c2a4702i81661ced00f39232@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Fri\, 21 Aug 2009 16\:19\:01 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8ECFEFB6-8E78-11DE-A2E9-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126736>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2009/8/20 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>:
>> grep: turn on --cached for files that is marked skip-worktree
>> ls-files: do not check for deleted file that is marked skip-worktree
>> update-index: ignore update request if it's skip-worktree, while sti=
ll allows removing
>> diff*: skip worktree version
>
> I kept reminding myself and still managed to miss it. skip-worktree
> bit is not completely independent from assume-unchanged. It shares
> CE_MATCH_IGNORE_VALID flag in ie_match_stat(). Should have mentioned
> that in commit log.

Yeah, that is why I feel uneasy reading your response to my other messa=
ge:

  This series does not fix assume-unchanged bit. I'd like to focus on
  skip-worktree bit now. ... I don't know if I understand assume-unchan=
ged
  semantics correctly anymore :-)
