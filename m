From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/19] completion: use __gitdir() in _git_log()
Date: Wed, 09 May 2012 11:41:13 -0700
Message-ID: <7vr4utryd2.fsf@alter.siamese.dyndns.org>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
 <1336524290-30023-4-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 09 20:41:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSBpd-0006eF-Q9
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 20:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006Ab2EISlQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 14:41:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60669 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752939Ab2EISlP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 14:41:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3059279F7;
	Wed,  9 May 2012 14:41:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BlWWHMIBawwG
	xjD4udKP6IOggGE=; b=ad1YgFde9V0gVHHlewoiQl5daC9G4ueTXUpXnHJVBEEJ
	oW35A5fZz9Uv2XrC0pdbwBVAYw8jPAvTYgNC0yHvy8sXsU9+vCGtWYcuq0BkupHY
	7mCmakXuF9F8LOQqFAv1rkv0mkFYR9FL5/Znln01AQI1JYy2tnfQe1tLa7Z2jIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=olaHFe
	RQeRxzVMaDd2Z5GocmX+SI+2fSZz6fkvoiOf7osG2k6S+rIbPd+12Js6nCMD0wXW
	4Rks5w432y4VCi8GVLU6TlwsJ9ivslg1ubGkxwRkqnbHuhPpB7YkAvVJfTf4DG1b
	96ZPsX5QA3qFw2elGtrcj9FD2Z+uJiC+xkJkA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27DF779F6;
	Wed,  9 May 2012 14:41:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B428479F5; Wed,  9 May 2012
 14:41:14 -0400 (EDT)
In-Reply-To: <1336524290-30023-4-git-send-email-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?= message of "Wed, 9 May 2012 02:44:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E67DCC2-9A06-11E1-A8A7-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197489>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> The standard way to find out the path to the repository in the
> completion script is the __gitdir() helper function, because that
> handles the repository path given on the command line (i.e. git
> --git-dir=3D/path/to/repo log --<TAB>).  However, there is one
> exception: the completion function for 'git log' still uses 'git
> rev-parse --git-dir' directly, and could offer (or not) the '--merge'
> option erroneously when the repository is specified on the command
> line.

Here `--merge` is the visible symptom, and the real issue you fixed is
that it used to be looking into a repository that is different from the
user is working with, right [*1*]?

Well spotted, and the fix sounds correct.

Thanks.

[Footnote]

*1* I am just making sure I am reading the above right; I am not
suggesting to omit description of visible symptom at all---quite
the opposite, I do want to see these visible symptom descriptions
in the log messages.
