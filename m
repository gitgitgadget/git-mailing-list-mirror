From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] diff --shortstat --dirstat: remove duplicate output
Date: Thu, 05 Mar 2015 13:38:21 -0800
Message-ID: <xmqq8ufb2khe.fsf@gitster.dls.corp.google.com>
References: <20150302020009.Horde.9sATpKnsrWQkGadaRTvxkA3@webmail.informatik.kit.edu>
	<1425308739-13082-1-git-send-email-marten.kongstad@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, szeder@ira.uka.de, tboegi@web.de,
	johan@herland.net
To: =?utf-8?Q?M=C3=A5rten?= Kongstad <marten.kongstad@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 22:38:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTdTS-0005F9-Vg
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 22:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbbCEVi0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2015 16:38:26 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750906AbbCEViZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2015 16:38:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B127A3DCD1;
	Thu,  5 Mar 2015 16:38:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=RYLOzUatVKE8MV3okztTKag4R
	Ao=; b=mD7w/nfbfs7o8vE6yh3KSdZ7FGI2L4Wsmro1VxzPWx9asv4in0ezmB+2E
	GN3Uv5pnFHaMoeh5sAzOy1cY/heU2h0JGNIROpQsofhYpSK+eDQi6JeXfh8yothT
	ELahG92BXL1JSESaObhVNtuw4rhCRxT9n3o8/CvXFeH2RNcvPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=XLtB8EEkOxFgFqCHtYk
	1zvYe7oTXrTSN2oAQOvU/0fT9wZNmGhbqqOYZgG76qRyXsWrkgijctQBn3PiWX8s
	01833jXXpAFM/tZ0xArRNz0CS89Qnd1YfRoO+xQrHysAfstJYyxeHefWzV0OPKif
	PNH2Rzl7Bemz8yPqog9eunKo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A38C83DCCF;
	Thu,  5 Mar 2015 16:38:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 128E93DCCE;
	Thu,  5 Mar 2015 16:38:24 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F381DA9A-C37F-11E4-A764-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264870>

M=C3=A5rten Kongstad <marten.kongstad@gmail.com> writes:

> v3: change how tests count (part of) the dirstat number of lines: ins=
tead of
> 'grep -c', use 'grep >filename && test_line_count'. Thanks to Torsten
> B=C3=B6gershausen and SZEDER G=C3=A1bor for pointing out how to impro=
ve the tests.

Thanks.

I'd squash the following on top before queuing it.

The overlong lines that ignores the exit status from "git diff"
looked problematic to me.

 t/t4047-diff-dirstat.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t4047-diff-dirstat.sh b/t/t4047-diff-dirstat.sh
index 065d74f..0d50dce 100755
--- a/t/t4047-diff-dirstat.sh
+++ b/t/t4047-diff-dirstat.sh
@@ -974,13 +974,16 @@ test_expect_success 'diff.dirstat=3Dfuture_param,=
0,lines should warn, but still wo
 '
=20
 test_expect_success '--shortstat --dirstat should output only one dirs=
tat' '
-	git diff --shortstat --dirstat=3Dchanges HEAD^..HEAD | grep " dst/cop=
y/changed/$" >actual_diff_shortstat_dirstat_changes &&
+	git diff --shortstat --dirstat=3Dchanges HEAD^..HEAD >out &&
+	grep " dst/copy/changed/$" out >actual_diff_shortstat_dirstat_changes=
 &&
 	test_line_count =3D 1 actual_diff_shortstat_dirstat_changes &&
=20
-	git diff --shortstat --dirstat=3Dlines HEAD^..HEAD | grep " dst/copy/=
changed/$" >actual_diff_shortstat_dirstat_lines &&
+	git diff --shortstat --dirstat=3Dlines HEAD^..HEAD >out &&
+	grep " dst/copy/changed/$" out >actual_diff_shortstat_dirstat_lines &=
&
 	test_line_count =3D 1 actual_diff_shortstat_dirstat_lines &&
=20
-	git diff --shortstat --dirstat=3Dfiles HEAD^..HEAD | grep " dst/copy/=
changed/$" >actual_diff_shortstat_dirstat_files &&
+	git diff --shortstat --dirstat=3Dfiles HEAD^..HEAD >out &&
+	grep " dst/copy/changed/$" out >actual_diff_shortstat_dirstat_files &=
&
 	test_line_count =3D 1 actual_diff_shortstat_dirstat_files
 '
=20
