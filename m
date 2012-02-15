From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3 v4] Update diff --stat output in tests and tutorial
Date: Tue, 14 Feb 2012 17:21:52 -0800
Message-ID: <7vpqdg3n7z.fsf@alter.siamese.dyndns.org>
References: <7vsjie9q77.fsf@alter.siamese.dyndns.org>
 <1329263146-19215-1-git-send-email-zbyszek@in.waw.pl>
 <1329263146-19215-3-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	pclouds@gmail.com
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Feb 15 02:22:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxTZI-0004th-Kx
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 02:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761424Ab2BOBV4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 20:21:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50912 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757516Ab2BOBVz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2012 20:21:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1257668BE;
	Tue, 14 Feb 2012 20:21:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=IiPRzUw5fcJKH3VWNdPU08DyE
	3g=; b=av6e9IlNfbqleE58tNUy2P5OYzl3T6b+csdrPVRVvvAdVCS/pazyiV+xL
	6HKcX8+YDWN4omJKTaLYDhGbFMRM4CJLKcsMrUU9/Ho4wJOtbR3+0wEa2E/hvXgh
	ifqIjGtxVrd6RqdKVhNNMSfnYGzrTmDnnN+Yaubw7YtRlaq12s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Vrov1JJNv/0uRAaNayN
	FP3qIfzTbF1wGtTmbQ2xAdg0LsRaa+ltvNRe/OWZ4L6DF/bIzEmpC+plwMsnvwke
	7MeArMt+2YkRiP+fluHqHs3HX0hl4V1KjZ3Pjet8Cx0IuGz3ynAdUh694Kp/cjMP
	fpa1iRBaSxKprkcobxPkkYck=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 082EF68BD;
	Tue, 14 Feb 2012 20:21:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5834D68BB; Tue, 14 Feb 2012
 20:21:54 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7206F23C-5773-11E1-9171-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190806>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
> ---
> All tests pass for me after this change.

Err, this is not what I meant when I said "split that part to a differe=
nt
patch".

If you didn't have this bit in [PATCH 1/3]

        -               fprintf(options->file, "%5"PRIuMAX"%s", added +=
 deleted,
        -                               added + deleted ? " " : "");
        +               fprintf(options->file, " %*"PRIuMAX"%s",
        +                       number_width, added + deleted,

then I think most of the changes in [PATCH 3/3] is unnecessary when usi=
ng
the default 80-column output, which is how the test is run.

In other words, ideally, the [PATCH 1/3] should improve the diffstat
generation code in such a way that it produces output that is identical=
 to
the existing test vectors when COLUMNS is set to 80 but takes advantage=
 of
wider terminal when available.  So either the above change should not b=
e
part of [PATCH 1/3] at all, or you still chnage this fprintf(), but use
number_width that is hardcoded to 4 instead of using the value computed
with decimal_width(max_change).  As to the test part, when a wider COLU=
MNS
is given, the code would obviously take advantage of it, so it may:

 - contain a change to the test suite somewhere, probably t/test-lib.sh=
,
   to set COLUMNS=3D80 and export it, to make sure that the existing te=
st
   won't be broken when the number of columns learned from ioctl(1) is
   different from 80; and

 - add a new test that explicitly sets wider COLUMNS and makes sure you
   get a wider diffstat graph.

and almost no other changes to the expected output.

If you do not arrange [PATCH 1/3] that way, we cannot verify that it do=
es
not introduce any regression to existing users.  Just applying [1/3] wo=
uld
start failing tests, and we cannot tell which failure is a false alarm =
due
to this change, and which ones is a real regression that you are produc=
ing
wrong output when COLUMNS is set to 80.

And then as a separate patch [PATCH 3/3] at the very end of the series,
you would either introduce the above change to fprintf(), or if you
changed fprintf() in [PATCH 1/3] but used hardcoded number_width, then
change it to use decimal_width().

That change in turn makes the bulk of this patch to update the expected
output necessary.

If your series is organized that way, we can weigh pros-and-cons of the
change to use decimal_width() a lot more easily.

Thanks.
