From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Some information that git diff saves and that git status does
 not
Date: Mon, 08 Mar 2010 22:56:35 -0800
Message-ID: <7vmxyi0yqk.fsf@alter.siamese.dyndns.org>
References: <loom.20100308T111146-322@post.gmane.org>
 <7vpr3emr3s.fsf@alter.siamese.dyndns.org> <4B95EC43.2040705@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergio <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:30:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyVn-0001Do-3F
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300Ab0CIG4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 01:56:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab0CIG4p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 01:56:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 96EF4A0A72;
	Tue,  9 Mar 2010 01:56:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NkSSJkg7wJoJNnsXmt1bNPSc89o=; b=jU1p62
	PLSgLOLtVfmqIqDsWJNaM/SrpYm+rOnonEVeoyca4whZe3cLCGTiOK740TAp7cZd
	9dn547Be+ae9XD3yd4WkYMdUJ5rta7uLsSNtRSm5zKeCOm159i0OeaPvbSZMXeMO
	XvNJAt1ARLoCKovWUv7m6wMbPuWBEIGBDt3/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pKGeIM6ggunR4KUHjmT+BmgIsumIhvE1
	rpCn0Q3YsvAZdIeK2hiMV+1kVgC9TfHedWHQ6WNiB+ixpxuz+znxEI+MwdX6dehy
	ZoZRnyOiTmac6cnX7h5QVnZ//fqrKmIWnsJZAzxK2rMRCPVa+dbMIYIXZTSnKgnV
	nWhbk/YCZmA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 34B2BA0A70;
	Tue,  9 Mar 2010 01:56:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 876C1A0A6D; Tue,  9 Mar
 2010 01:56:36 -0500 (EST)
In-Reply-To: <4B95EC43.2040705@viscovery.net> (Johannes Sixt's message of
 "Tue\, 09 Mar 2010 07\:35\:47 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E9A39FCE-2B48-11DF-B59D-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141806>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
>> I didn't fully read what you wrote but after you copy a repository from
>> one to another outside git (be it done with unison or rsync), you should
>> run "update-index --refresh".
>
> And the reason for this is that git also looks at the inode numbers, and I
> guess that unison does not go as far as to preserve them between machines...

True; we used to (and you can still configure git to) check st_dev too but
we stopped to doing that by default as it is unstable even in a normal use
case (read: no "cp" involved) on some networked file systems.

I wonder how stable inum is on inode-less filesystems (say FAT).  I guess
it is not usually a problem because carrying repositories on USB keychains
is typically done as a sneakernet and with bare repositories.
