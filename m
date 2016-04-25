From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] travis-ci: build documentation
Date: Mon, 25 Apr 2016 12:03:46 -0700
Message-ID: <xmqq37q9ldd9.fsf@gitster.mtv.corp.google.com>
References: <1461314042-3132-1-git-send-email-larsxschneider@gmail.com>
	<vpq37qeovu4.fsf@anie.imag.fr>
	<xmqqinz9pl3l.fsf@gitster.mtv.corp.google.com>
	<EDD0757C-2BD3-476F-B703-147D35BB1FAC@gmail.com>
	<xmqqh9epmxtj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 21:03:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aulna-00042t-D6
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 21:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933281AbcDYTDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 15:03:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932969AbcDYTDw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 15:03:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 21A5C15A3B;
	Mon, 25 Apr 2016 15:03:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rlRD8Z/e0pYtXlE4fMoEeidDVDY=; b=jQkuIT
	kfmPzCCspSvSGoCaW8gvhahL4JMGveQg98tJnoZ7aSS/hF4pfsa/fmOUESgaxtky
	Foy7BxR23vsv6PgoUi6NCQAL5V9TojeOSQkbBmTUevEGM+r5t1d2YN20omeuy30E
	w5JC29tNJwMkcMfeS3vh3hhSJh5xKg+uFP148=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pbeOOC859Bu0TFB0qyRCpFUpaCwWyaDc
	x4r/YWG1kcvr1tYrVjzxDrLs2p9DrnzuiH/QbzRDMxZoOedc6Wpk0+aDZuik15Cd
	9X79S5Td0eAV8BHJ0Yf9hSTctiYiyirwgtcHvtJKzdYehP81WDUVZdnk5LAsxIYu
	4/1K1CzbYxc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A17C15A3A;
	Mon, 25 Apr 2016 15:03:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7EAB615A38;
	Mon, 25 Apr 2016 15:03:48 -0400 (EDT)
In-Reply-To: <xmqqh9epmxtj.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 25 Apr 2016 09:56:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 710F97AA-0B18-11E6-867A-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292546>

Junio C Hamano <gitster@pobox.com> writes:

> Lars Schneider <larsxschneider@gmail.com> writes:
>
>>> There also are existing instances of "useless ;" that would want to
>>> be cleaned up regardless of portability issues.
>> Unfortunately it seems to be required. Travis CI generates a shell script
>> out of the yml file and I think they don't respect newlines or something...
>
> If they squash all the lines into a single long line before
> executing, these semicolons do indeed become necessary (we have to
> write a logical single line shell script in our Makefiles with ';',
> and I'd imagine Travis's scriptlets are done similarly).
>
> Thanks.

... but the above does not quite explain it.  The newlines are
mostly honoured as logical end-of-line in existing .travis.yml e.g.
we do not see a semicolon before "pushd".

            case "${TRAVIS_OS_NAME:-linux}" in
            linux)
              mkdir --parents custom/p4
              pushd custom/p4
            ...
            esac;
            echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)";
            ...

everything outside the big "case/esac" seems to have ';' in the
current incarnation of the script.

Puzzled...
