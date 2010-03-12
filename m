From: Junio C Hamano <gitster@pobox.com>
Subject: Re: re-running merge on a single file
Date: Thu, 11 Mar 2010 22:56:36 -0800
Message-ID: <7viq92rpsr.fsf@alter.siamese.dyndns.org>
References: <a038bef51003111054n5bcecd2eud531dcc80509f952@mail.gmail.com>
 <201003112129.52596.markus.heidelberg@web.de>
 <a038bef51003111408g38698837ldcf1d0f5995f4f30@mail.gmail.com>
 <m3hbomla3u.fsf@localhost.localdomain>
 <a038bef51003111631n38f7e50cp79d8335109f3ed0@mail.gmail.com>
 <a038bef51003111633v5d5d418bu332b63bb3874e3ef@mail.gmail.com>
 <4B99E309.2070603@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, GIT <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 12 07:56:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npynk-00081c-UC
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 07:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729Ab0CLG4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 01:56:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48299 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578Ab0CLG4r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 01:56:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 04C52A19DB;
	Fri, 12 Mar 2010 01:56:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tgZvwY/KXXEERmha8cFRqatSd7A=; b=ldvStI
	NDBgttumw97ksVYp847RA8m/V02jmZIlPtwgifQBlcx4XJL42U9/DvBkSoCVqWK4
	zsnZhuULofHNXaBXKBunPMrpjsQgD/CN7dtJQv1UGsDsZOKJobgPAVkFZxoP/dzH
	LTxh4waFAAlatzDJbD+SYG9UWxukLtQluQMRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qdnA9BPZ9Ofca82nPvXm/qjBYFhT+zD4
	6k6qtrOJqRaNDiDsyvxIep07ymtcYFpMH7w19MSEIXt8SO3yqA8dGv8T/FHX4AvX
	TPCk79Uga/sE5YQfnbnuuT8f8hQJGHk3dp2S290mrQBNmyX0GrN7hqPIw2NLYJKe
	/PbmTLUJo4c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B81E1A19D1;
	Fri, 12 Mar 2010 01:56:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F368BA19CE; Fri, 12 Mar
 2010 01:56:37 -0500 (EST)
In-Reply-To: <4B99E309.2070603@viscovery.net> (Johannes Sixt's message of
 "Fri\, 12 Mar 2010 07\:45\:29 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6A64079A-2DA4-11DF-B2BB-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142025>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Chris Packham schrieb:
>> $ git checkout --merge -- cpu/mpc83xx/start.S
>> $ git show :1:$(git rev-parse --show-prefix)cpu/mpc83xx/start.S
>> fatal: Path 'cpu/mpc83xx/start.S' is in the index, but not at stage 1.
>> Did you mean ':0:cpu/mpc83xx/start.S'?
>
> Both of these work only as long as the index still records the conflicted
> state. If you (or one of your tools) has git-added the file, or you have
> git-checked-out some version of the file, the conflict stages are lost,
> and you must reset --hard and redo the entire merge.

If the merge textually autoresolves cleanly, you might not even have any
conflicted state to begin with.  In such a case you would need to grab

	MERGE_HEAD:path-to-that-thing
        HEAD:path-to-that-thing

yourself.
