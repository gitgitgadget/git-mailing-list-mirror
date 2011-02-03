From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] Support quoting in .gitattributes, .gitignore
Date: Thu, 03 Feb 2011 11:03:26 -0800
Message-ID: <7vbp2t0wld.fsf@alter.siamese.dyndns.org>
References: <AANLkTikHNKmcapVWBAcufq8ONVWOWHbnL-H8Nf2WmKM5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 03 20:03:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl4T0-0002Al-M2
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 20:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453Ab1BCTDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 14:03:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932437Ab1BCTDg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 14:03:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3977F4619;
	Thu,  3 Feb 2011 14:04:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uKyapAWUsYTkOQrVJn15KlFpr08=; b=IFFNBi
	ACxqXNg/aY/PlczaSl4zrKjbF3YsRoPBIC7/zahB4M2mjKONsPARehNksS+s4pKH
	58sknx33kunIB6Tjth+PzK+Wctuq6/GMy/Vfqb8brXSF8S9FJ9Y0tXt/IMDSBMmJ
	97Uuumn21tgcU6UB9f/DkQQ1yF//W+gTx5vLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AnUKhxmlYwliBFVhfvGOyy4kQlVY6y+L
	K+/G4Z0BxiDIk4wW2A+KLy9xuowphTh9EeUGL5iShUVcQRIsBJ+2GK4ZkNgfOWg8
	oy2NpRqC5GUcL5FbdzBiSb5z2Tpm1sSdJ/yJSJAHV+C5LZDUS2KysuCkpXBGzafF
	/xogrpoZyVg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 18B164616;
	Thu,  3 Feb 2011 14:04:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 33D0C4611; Thu,  3 Feb 2011
 14:04:21 -0500 (EST)
In-Reply-To: <AANLkTikHNKmcapVWBAcufq8ONVWOWHbnL-H8Nf2WmKM5@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Thu\, 3 Feb 2011 18\:51\:18 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6AAA3A54-2FC8-11E0-8B5F-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165990>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Migration plan:
>
> I think a release note mentioning this is enough. No migration needed.
>
> But to be safe, we can make post-1.7.5 warn users about patterns with
> leading double quote. By 1.8.0, the new behavior will be used.

That's obviously not a migration plan, and it is worse than not having the
warning at all.  People with paths that begin with dq (which I suspect
would be an empty set) will get wraning every time they do anything with
git, and until 1.8.0 there is no way to turn that warnings off without
breaking their pattern (like removing the entry from the attributes file),
and when 1.8.0 comes their patterns will break.

How about introducing a new feature in .gitattributes file so that the
parser can tell if the file is (1) written pre-1.7.5 that depends on the
old behaviour, (2) written post-1.7.5 by a person who is aware of the dq
convention, but still relying on the old behaviour, (3) written post-1.7.5
to take advantage of the new behaviour?  E.g., you can explicitly mark
your .gitattributes file by putting "# feature: no-cq-pattern" as the
first line that the patterns in the file relies on the traditional
behaviour, or "# feature: cq-pattern" to cause the parser to interpret
cquoted patterns, and the last 1.7.x will warn if a file does not have
this explicit marking, but has a pattern that would change the behaviour.
Then 1.8.0 would flip the default.
