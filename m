From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] log: "--no-show-signature" commmand-line option
Date: Mon, 06 Jun 2016 11:50:51 -0700
Message-ID: <xmqq37oqxib8.fsf@gitster.mtv.corp.google.com>
References: <20160605153933.15231-1-mehul.jain2029@gmail.com>
	<20160605153933.15231-3-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 20:51:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9zc3-0000vJ-4l
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 20:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbcFFSu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 14:50:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751313AbcFFSuz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 14:50:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 87CBF22B03;
	Mon,  6 Jun 2016 14:50:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WFxzwkWuHAOlo7sv+RNvg/cM+l8=; b=wwJGek
	9O1fJiZOTCaZ5drT3ukatPS/dSSqdLnzSty8mHo6BeM8/tYoBzLkIY+uVYwaVbmC
	NPgvFYr7vatvPt/bex3WSyZDMNlgGfeDGLBfYX+58cZD4f546ZXkE4milhnzJ8nI
	64biohqMRs2yAfQqj2dusiZfg08GBSZA1ab84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HqILQE7KFIMNgib+1WBjYW8KFNq+GxSM
	xC8uP0GZYmBjjVMygdGyl68Em+jxF83US+cgGgFhL08xHuAT1Zbnx2yTb18Wxe/F
	TOujq9TWxOk1/Z5kTF2eN2CUw1DP6ePlEsA7VDfiNV3vqmbnRrTEvbONBDVnhZJw
	7Yt/kIWTD1c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E09D22B02;
	Mon,  6 Jun 2016 14:50:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E1C5D22B01;
	Mon,  6 Jun 2016 14:50:52 -0400 (EDT)
In-Reply-To: <20160605153933.15231-3-mehul.jain2029@gmail.com> (Mehul Jain's
	message of "Sun, 5 Jun 2016 21:09:33 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 981E78E6-2C17-11E6-96CC-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296549>

Mehul Jain <mehul.jain2029@gmail.com> writes:

> If "log.showSignature=true", then there is no way to override it using
> command line switch.
>
> Teach git-log and related commands about "--no-showSignature" command
> line option.

Doesn't that suggest that 1/2 alone will cause users problems?  The
users can by mistake set the configuration variable and there is no
way for them to override it from the command line.

If you swap the order of the two patches, the topic makes more
sense.  I.e.

    [1/2] log: add "--no-show-signature" command line option

makes "git log --show-signature --no-show-signature" to run without
GPG checks, which by itself is a worthy change.  And then

    [2/2] log: add log.showSignature configuration variable

makes revs->show_signature default to the configured value, instead
of always initializing it to false.
