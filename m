From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Allow core.askpass to override SSH_ASKPASS.
Date: Fri, 27 Aug 2010 10:28:43 -0700
Message-ID: <7v4oeghsms.fsf@alter.siamese.dyndns.org>
References: <201008271251.23136.k.franke@science-computing.de>
 <AANLkTik5eMLCKK7muBW9k8-0ZAxraATCs5hHVcX-Zutn@mail.gmail.com>
 <201008271445.26098.k.franke@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, git@vger.kernel.org,
	Frank Li <lznuaa@gmail.com>
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Fri Aug 27 19:29:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op2jm-0001NU-7W
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 19:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754997Ab0H0R24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 13:28:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64285 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754966Ab0H0R2y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 13:28:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 794E9D01A9;
	Fri, 27 Aug 2010 13:28:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=6XzF6eHhzuv2ruUumVTkAuB23l4=; b=Q/61+dfgOLcgdvMkJgoS6Ss
	Zpx/aMf6JFizCTnsKYwomRMZPqGhAQt1DYV3oCIIT3Eh5EziQM0V7KbemTDTBgTt
	dMUvSugyVo+EKLaAbsLZn0BY8JCdgLGAdVeuN/qiBMbsFT1Q5JwPWkFyh0B4YVm1
	MKW+8vVx6XLxCHbeXuGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=bUNfpuFFcyih+BrynfvDmkZtw4g4rxcfNWVnIftN5OyGy+mId
	G6fe85YMZvVwLEknZhrDhhOsISfGHp1AX0EMDuVufliF8nKQ9j9esZfojnYqsmH2
	TFAnWfPjzJQ1jtnN3wpKg/3yFx/DDOLL0HXq0qKUPCz8I4KGfsIeCPbnNA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 32E3FD01A4;
	Fri, 27 Aug 2010 13:28:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4374FD01A0; Fri, 27 Aug
 2010 13:28:45 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8E5095DE-B200-11DF-B58D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154610>

Knut Franke <k.franke@science-computing.de> writes:

>> > diff --git a/connect.c b/connect.c
>> > index e296bfc..f97b84c 100644
>> > --- a/connect.c
>> > +++ b/connect.c
>> > @@ -627,9 +627,13 @@ char *git_getpass(const char *prompt)
>> >        static struct strbuf buffer = STRBUF_INIT;
>> >
>> >        askpass = getenv("GIT_ASKPASS");
>> > +
>>
>> Why?
>
> Considering the check for SSH_ASKPASS added below, I believe this improves 
> legibilty since all of the "if (!askpass..." blocks are similar in intention.

I think Erik is asking about the extra blank line.  You could have
achieved the same consistency by removing, no?

diff --git a/connect.c b/connect.c
index e296bfc..f97b84c 100644
--- a/connect.c
+++ b/connect.c
@@ -627,9 +627,10 @@ char *git_getpass(const char *prompt)
 	static struct strbuf buffer = STRBUF_INIT;
 
 	askpass = getenv("GIT_ASKPASS");
 	if (!askpass)
 		askpass = askpass_program;
-
+	if (!askpass)
+		askpass = getenv("SSH_ASKPASS");
 	if (!askpass || !(*askpass))
 		return getpass(prompt);
 
