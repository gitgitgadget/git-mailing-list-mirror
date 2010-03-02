From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Better cooperation between checkouts and stashing
Date: Tue, 02 Mar 2010 09:50:29 -0800
Message-ID: <7vvdde62ai.fsf@alter.siamese.dyndns.org>
References: <4B67227A.7030908@web.de>
 <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> <4B898F97.90706@web.de>
 <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> <4B8B9BF1.10408@web.de>
 <7v1vg4ufas.fsf@alter.siamese.dyndns.org>
 <4b8c0420.5544f10a.2eb2.ffffb4c4@mx.google.com>
 <7vk4tvsu6x.fsf@alter.siamese.dyndns.org> <4B8C2F90.8080104@web.de>
 <b4087cc51003011741w29023914wec78f9acd6efb516@mail.gmail.com>
 <4B8CDBCA.4030101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 02 18:50:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmWF4-000578-8P
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 18:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885Ab0CBRuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 12:50:40 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61196 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab0CBRuj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 12:50:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB4D19EE00;
	Tue,  2 Mar 2010 12:50:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ljgW7dEbvWbG+jlT4HuZJEVe1is=; b=VeVsn/
	wQH1zysTw8Vj+X6jFCHRVEDVY5rPfAU6KlsQlCmn4WIh1+h1ldByctU008GcFpYZ
	uaS9jXRs+lO9hcWyQMQTzusdb+gfxOuyyRgd8/jdM9QuQvSPX10SOEIesHz38roJ
	kBbsOble4MaJhDXgymhEZmasgPt3LdDW0SHdA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qqUoZoP1Qc0ZpBvqx1b8O4j1odVVgh9E
	1E/hkLZl8LDKnZDrXMcgZLXiDZnkh9gPVI4uvn9T6qd9EfMXuSN3vg0bBxSksgnM
	lP77ZMmzv66jaNSOK0CJPzkKiKEUVKGBGCHDwG3K6XSdjtQtoT5KhjRCleuYoFml
	aWgWSx+ZPn4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B18419EDFC;
	Tue,  2 Mar 2010 12:50:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A9FA9EDFB; Tue,  2 Mar
 2010 12:50:30 -0500 (EST)
In-Reply-To: <4B8CDBCA.4030101@web.de> (Markus Elfring's message of "Tue\, 02
 Mar 2010 10\:35\:06 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1A56286E-2624-11DF-B45B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141407>

Markus Elfring <Markus.Elfring@web.de> writes:

> How are the chances to make unfinished and uncommitted content updates sticky
> for a particular branch (or a selection of branches) so that changes will not be
> mixed more as it will be really required for an editing task?

Traditionally the right way to do this has been to make a temporary commit
on the branch, i.e.

    $ git checkout topic
    work work work... yikes, I cannot get this working
    $ git commit -a -m 'wip: does not work yet' ;# temporary commit
    $ git checkout other-topic
    work work work....
    $ git checkout topic
    $ git reset --soft HEAD^ ;# drop the temporary commit

I didn't re-read our documentation set for some time, but don't we teach
this anymore?
