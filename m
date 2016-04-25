From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update git-p4 to be compatible with git-lfs 1.2
Date: Mon, 25 Apr 2016 10:24:17 -0700
Message-ID: <xmqq8u01mwji.fsf@gitster.mtv.corp.google.com>
References: <E230B4FD-79B5-4CA7-9F0D-A4F8F3470296@gmail.com>
	<20160425162502.31558-1-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Ben Woosley <Ben.Woosley@gmail.com>,
	Luke Diamand <luke@diamand.org>,
	Git Users <git@vger.kernel.org>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Apr 25 19:24:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aukFL-0006Xo-B1
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 19:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764AbcDYRY1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 13:24:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61449 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754456AbcDYRY0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 13:24:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2178C14D27;
	Mon, 25 Apr 2016 13:24:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Fhf6S0q550DY
	fxmytt5ko9GcF6c=; b=e8cxhgHArffzpD/ESMRNsTgUzWcfpmnMtwCBWJfqqbmQ
	H6dg/dTQW+WNpo48GomBUk/Qv3jaTRpa8xWqhvjv167H8lKIF3QOw2H6LRMLMUJl
	dGY+Eluy/nI4C9ZqdyKnqTfntDh39JaIXk5paiq/H/c+NsCIcZVaDaP3+r5m7SM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ByBbiP
	HJQLHW0vWDEj3I0BZ0tYzBHp9+NasYNIP9aHvrXjxF93ifu3DM1Q880lyMgqdD0L
	vr8fZmJm/OsU7UNbpthQ1+A4R0kNLrEjmA00BjG44458e2w9DYGUQkBws51wetjU
	saTt6Gap74svRW9e6TfDLnxffv8gfwNDgtXgU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 199C814D26;
	Mon, 25 Apr 2016 13:24:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5DB8C14D22;
	Mon, 25 Apr 2016 13:24:19 -0400 (EDT)
In-Reply-To: <20160425162502.31558-1-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
	message of "Mon, 25 Apr 2016 18:25:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8B370504-0B0A-11E6-A105-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292528>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> You can have a look at these patches at
>
>   https://github.com/szeder/git completion-test-multiple-bash-version=
s
>
> and perhaps you could even adapt it to LFS and/or p4 somehow.
>
>> Plus if we want to be consistent we would
>> need to do the same for LFS 1.0, 1.2, and for pretty much every othe=
r
>> dependency... =20
>
> I'm not sure we should be consistent in this case, at least not solel=
y
> for consistency's sake and not in git.git. Taking what I did for Bash
> and doing it for different versions of LFS, p4, etc. could perhaps
> keep the runtime under control, but t/Makefile would surely get out
> of control rather quickly.  Putting these into a travis-ci matrix is
> so much simpler, but the runtime makes it infeasible, of course.

I took a brief look of your branch, and I like its approach.  If I
understood your approach correctly, you:

 * Group selected tests in t/ as "these are bash related tests I
   care about" in t/Makefile;

 * Add Travis test target to build Git with specific versions of
   bash, and run the above target instead of the full test to
   exercise the version of bash you are testing.

And I agree that the same can be done for LFS versions and P4
versions.  Only a handful tests in t/ are about these niches.

> I think the best we can do is to keep this out of git.git and let
> (hope?) developers interested in a particular subsystem do this
> "multiple version compatibility" tests as they see fit.
