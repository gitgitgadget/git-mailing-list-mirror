From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2010, #01; Wed, 2)
Date: Sat, 05 Jun 2010 21:00:38 -0700
Message-ID: <7vaar8yfmh.fsf@alter.siamese.dyndns.org>
References: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
 <20100604211811.GA7471@progeny.tock>
 <7v39x1z72z.fsf@alter.siamese.dyndns.org>
 <AANLkTimKwCDlW_uaCusZcmV2IttqORlUwSqkVnD3no6q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Gary V. Vaughan" <git@mlists.thewrittenword.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 06 06:01:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OL72i-0002oa-M2
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 06:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787Ab0FFEAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 00:00:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65506 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702Ab0FFEAy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 00:00:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CEB3B9E1E;
	Sun,  6 Jun 2010 00:00:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=p90K0NrbOowb2qg2CXzcjyLVYBo=; b=QP5hVqGgMXY9FZqHo6ED0vF
	ZGJ367QSYdgIg7ZDVrB+r4HHb7VsbKnWlON53FOZJtFZRauNcTIdLNjgm6ulzr/5
	nl81YDd/Qdkh/Ax8IeiH3JzX5Hp53YjbaWpmWl/2MV0CCuTCbH83pqX777IaaglB
	AELBiH5AModnSECbcyf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=R1tgEAKG/AVx1WrA3LTCqK08TnTBlUl23JAGvgCkh0vZ4fIxl
	yq6pPeHFe4gSFCyu1AqHqPOxsTKiO3jjX0hF3mKdNMoEFhDs4HdAVZelTghDQ3x8
	xpAJaRBHzo5l0HkXZEzOLcNMRmBU3ASXZPUC48wH+PqjiAHsguVc3BNnCY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C106B9E1D;
	Sun,  6 Jun 2010 00:00:48 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A53C9B9E1C; Sun,  6 Jun
 2010 00:00:39 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 171804F0-7120-11DF-BDB2-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148507>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> No addition to the test suite to catch this in the future?

If we had a test like this:

    test_expect_success 'run resolve' '
	... set up something to merge ...
        (
        	unset DIFF;
                git merge -s resolve ...
	)
    '

it would have caught this particular breakage, but

 (1) nobody could have anticipated before the problematic patch that $DIFF
     would be an exported variable that could cause trouble, so nobody
     could have written it before the $DIFF patch;

 (2) with the knowledge necessary to write the above test, the $DIFF patch
     wouldn't have made the misconversion, so it is unreasonable to say
     that the $DIFF patch should have come with the above test; and

 (3) having the above test in the test suite may catch exactly the same
     mistake in git-merge-one-file.sh, but that is not a guarantee that
     nobody will break another scripted Porcelain that is not triggered in
     the "resolve" codepath.

Other than doing "! git grep -e '$DIFF' 'git-\*.sh'" at the toplevel of
the source tree, I don't think it is possible to catch future bugs of this
sort.
