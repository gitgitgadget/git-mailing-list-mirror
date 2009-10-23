From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tar: on extract, -o is --no-same-owner
Date: Fri, 23 Oct 2009 14:26:53 -0700
Message-ID: <7vocnxajj6.fsf@alter.siamese.dyndns.org>
References: <1256328943-22136-1-git-send-email-rep.dot.nop@gmail.com>
 <20091023202524.GE4615@mx.loc> <20091023210648.GA23122@mx.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: vda.linux@googlemail.com, busybox@busybox.net, git@vger.kernel.org
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 23:27:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1RfJ-0000cd-Mh
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 23:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbZJWV1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 17:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbZJWV1D
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 17:27:03 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbZJWV1C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 17:27:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E580064EAA;
	Fri, 23 Oct 2009 17:27:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iG3iwptP1qIEaa/eCuVnr86Nw40=; b=YwLac5
	T54DnLvwNeAfwSsATdo/gEuOfzHhcbRZNVoDkcExtb/YY/4E09Uliwyj5B49ZOtw
	7s359efbJpavWknJp2CsqYiEpMHTbdYWLWrE79viJHxSOsE9GaZw0bHmslU/q0fr
	mB+F9aNUSAX+aqE1raWIebkxVdBai/T8Qd3Cs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JMitVBA+zPi3eWx0g++acQyWS06RE+Qv
	nH1X1+w+FpK0WYdXSq9EF9Ri/UuJTdPEGPUkM8iUOWmjAuVkrLyG840dSQQTgMsk
	WiRIQqfA0Vh29YUi19t55nmPP2n4hDQNopEh7IR2tw8uyvCojs70xLTnGfAmyhpB
	FoEBmsDI0vM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ADCBB64EA9;
	Fri, 23 Oct 2009 17:26:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD3C864EA8; Fri, 23 Oct
 2009 17:26:54 -0400 (EDT)
In-Reply-To: <20091023210648.GA23122@mx.loc> (Bernhard Reutner-Fischer's
 message of "Fri\, 23 Oct 2009 23\:06\:48 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CC490ACA-C01A-11DE-BF53-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131135>

Bernhard Reutner-Fischer <rep.dot.nop@gmail.com> writes:

> On Fri, Oct 23, 2009 at 10:25:24PM +0200, Bernhard Reutner-Fischer wrote:
>>On Fri, Oct 23, 2009 at 10:15:43PM +0200, Bernhard Reutner-Fischer wrote:
>>>GNU tar-1.22 handles 'o' as no-same-owner only on extract,
>>>on create, 'o' would be --old-archive.
>>
>>FYI this was prompted by:
>>
>>Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
>>
>>diff -rdup git-1.6.5.oorig/templates/Makefile git-1.6.5/templates/Makefile
>>--- git-1.6.5.oorig/templates/Makefile	2009-10-11 03:42:04.000000000 +0200
>>+++ git-1.6.5/templates/Makefile	2009-10-23 21:43:06.000000000 +0200
>>@@ -50,4 +50,4 @@ clean:
>> install: all
>> 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
>> 	(cd blt && $(TAR) cf - .) | \
>>-	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xfo -)
>>+	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) x --no-numeric-owner -f -)
>
> argh, sorry! --no-same-owner of course.

Either way, your change would break non-GNU tar implementations that are
properly POSIX.1, isn't it?
