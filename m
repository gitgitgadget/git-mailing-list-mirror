From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Introduce pathspec struct
Date: Tue, 28 Sep 2010 21:29:01 -0700
Message-ID: <7vvd5pqik2.fsf@alter.siamese.dyndns.org>
References: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
 <7v7hi6us35.fsf@alter.siamese.dyndns.org> <4CA2789A.7090306@ripton.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>
To: David Ripton <dripton@ripton.net>
X-From: git-owner@vger.kernel.org Wed Sep 29 06:29:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0oIC-0000x1-2O
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 06:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091Ab0I2E3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 00:29:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab0I2E3O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 00:29:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D92B3DA2E9;
	Wed, 29 Sep 2010 00:29:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9aUVUn5gQ3inntfE9eKjb6DXeNI=; b=pYy1Nc
	3ftYMU1iWNmeM4QARwH28jHJhiEN30mzTCMYlNmKhUlE9vidZj41+CwAYj/KUGwn
	VCHJEcAxYecuUP2Wu/oM/kArgrdjBSQzZdQtGgsAvV9H6hAJrz6C0VvcNaWXFno4
	pBn1Kn2NUx//wosDiQpYI1e2JJwRRNpiNeoNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fq+u6OdEZsnIv7vceO5srLxJTAXCcjAq
	xj4D/kiIeMw2NGMCpfKXVC7yQKzdzwEExgmQpAWaQ+kfrc2kNT+B64SETGZ+oY3Y
	PL7mXIBwRTdlElPo4/wI+EbkGq7/CeAv27ABySRsJk27Ndnv+6ywl2O07wAJgMGL
	HP3NhiPdANU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 96182DA2E5;
	Wed, 29 Sep 2010 00:29:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4433DA2E1; Wed, 29 Sep
 2010 00:29:03 -0400 (EDT)
In-Reply-To: <4CA2789A.7090306@ripton.net> (David Ripton's message of "Tue\,
 28 Sep 2010 18\:22\:02 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1A8A6BA2-CB82-11DF-A1FA-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157527>

David Ripton <dripton@ripton.net> writes:

> On 09/28/10 04:37, Junio C Hamano wrote:
>
>>   - David's "git grep --exclude-dir D" topic should be able to internally
>>     use the same negative pathspec mechanism.  At the command line level,
>>     it allows (and needs to allow) only the leading prefix (which is how
>>     GNU grep's --exclude-dir works), but it makes tons of sense for us to
>>     allow "--exclude $pattern" from the command line, and share the
>>     mechanism internally between the two.
>
> I don't think GNU grep's --exclude-dir only allows the leading
> prefix.

Heh, I was half expecting to hear that after I wrote it ;-) What I meant
was "pattern matches against the leading path, excluding the basename
part" (as the option is exclude-DIR, that is more or less by definition).
