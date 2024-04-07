Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205E413AF9
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712486943; cv=none; b=Rv4KetI+cN8/ofqiw6DwwG6S5M75tI3qKquPtLPZ39BMK6Fdmpa6qJdYkvbisT0BTmT4mAEeTWG1qiuBOSXmJBIITfjf/9ddJDKqk1tn0l7oPHmJCj8oQNjN5h6Kvj7lcRpzmAKGRyFmt3dBy9G9VW9+v85v82/4eEodV1qAhYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712486943; c=relaxed/simple;
	bh=5h/P9l5eGgtrPrByDajM3btLDlmeRxvckHO7lw11FeU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IhVm/VITP+AmmO8LbpObZOvJbe81DqTl3+JrtN7RNV2op0jOA4A4rhZ1j3QiS/3pJtwMk4UNRjtZq3hOiXULZYlBWqO7Rw6v3J4113JYXtLK7ndv7f9w3AxAH1CTdQRdOjvNf/v3i4tDkKvxEb0+k0wbs+5W2cRs+6kMXbgQHgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=CtuTHrRM; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="CtuTHrRM"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712486939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zLsw4RCMsyHWH7bEa3Vdpfcf1vvtM9ikwkcjKqiC2Gw=;
	b=CtuTHrRMRTcYrXxSe2raUz5dSiOeTX6TJV6ObURVAiO6778a+nKRGh/ZXERFXlhyLcbx8b
	nuWMfJYclpbTo6VhLipcglzc9ragnl4h4Zgktv+NlXN951kuUf8IDHeBapWXI1ycHoXLHR
	Rtp6HwkBCyBhrs3KE3bYdTktnJYFr70CBMm1abGiDz8pAmY1sufL5tLkOwyBeG2ovHTuUL
	A++Lg5StpgMZyVagmwBP9SfOa8Dn3XHa54xCpp4LJt+/20kUfpQvs/7PyY3RTBU3sQkmmZ
	fdEorpaEND7WZTfwr7cDvu325iSRGwEYFjhVqeZyoMACFyHP//R8FwuthNaAjQ==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	code@khaugsbakk.name
Subject: [PATCH v5 0/3] send-email: make produced outputs more readable
Date: Sun,  7 Apr 2024 12:48:49 +0200
Message-Id: <cover.1712486910.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

 * send-email: make produced outputs more readable by separating
   the result statuses and prompts from the subsequent messages

This series makes the outputs of "git send-mail" more readable, by
adding vertical whitespace to make discerning the messages produced
for each patch easy, and by adding vertical whitespace to separate the
emitted prompts from the other produced messages.  Having the prompts
and some of the produced messages bunched together made the navigation
through the produced outputs unnecessarily hard.

Making the outputs of "git send-mail" more readable is quite important,
because the Git users rather regularly complain about the workflows that
require project patches to be sent to various mailing lists.  Making the
produced outputs more readable can only help there.

Changes in v5:
    - Split into a three-patch series, because changes introduced in
      some versions of this patch made the original assumptions about
      squashing the changes together no longer apply [1]
    - Updated and extended the patch descriptions, to hopefully describe
      the changes performed in each patch a bit better

Changes in v4:
    - Dropped the changes to the styling of the produced prompts, as
      reasonably requested by Junio, [2] because it extended the scope
      of the patch with no good reason, and may also create issues on
      some platforms, whose Perl packages may actually not support the
      "->ornaments()" feature of Term::ReadLine
    - Updated the patch description and the "what's cooking" summary
      to cover the changes

Changes in v3:
    - Removed a redundant comment, as suggested by Junio [3]
    - Did the right thing and made the vertical separators emitted as
      message separators, instead of having them emitted as message
      terminators, as suggested by Junio [3]
    - Additional vertical whitespace is now also emitted after the
      prompt for sending emails, to "de-bunch" it from the subsequent
      messages and make discerning the messages easier
    - The above-mentioned prompt no longer uses underlined text, to make
      it significantly easier on the eyes
    - Fixed one indentation by spaces to use tabs and removed one stray
      newline in the source code, as spotted
    - Updated and extended the patch description to cover the changes
    - Updated the "what's cooking" summary to cover the changes
    - Cleaned up the older notes a bit

Changes in v2:
    - Improved the way additional newline separators are introduced to
      the source code, as suggested by Junio, [4], to help a bit with
      the translation efforts
    - Improved the patch subject and description a bit, to provide some
      additional information, as suggested by Junio [4]
    - Added a Helped-by tag

Notes for v1:
    - This is a resubmission of the patch I submitted about a week and
      a half ago; [5]  the patch subject in the original submission was
      selected in a bit unfortunate way, which this submission corrects,
      and also improves the patch description a bit
    - There are no changes to the patch itself, vs. the original patch

Link to v1: https://lore.kernel.org/git/62553db377c28458883b66bcdc0c58cc0f32d15b.1712250366.git.dsimic@manjaro.org/T/#u
Link to v2: https://lore.kernel.org/git/0e087ed992def0746f3d437253248904c2126464.1712262791.git.dsimic@manjaro.org/T/#u
Link to v3: https://lore.kernel.org/git/e3212c0a4ad331685c68c13afcdbced20982ab32.1712364420.git.dsimic@manjaro.org/T/#u
Link to v4: https://lore.kernel.org/git/8a9f4927aab96f2f62e2467e59fb6150d7e931fc.1712367983.git.dsimic@manjaro.org/T/#u

[1] https://lore.kernel.org/git/713c28cfc9dff2d01159105ddd2fd0f5@manjaro.org/
[2] https://lore.kernel.org/git/xmqq8r1rs39g.fsf@gitster.g/
[3] https://lore.kernel.org/git/xmqqzfu8yc40.fsf@gitster.g/
[4] https://lore.kernel.org/git/xmqqy19tylrm.fsf@gitster.g/
[5] https://lore.kernel.org/git/6ee28707b9eb8bd8fdfc8756c351455c6bc3bb62.1711447365.git.dsimic@manjaro.org/

Dragan Simic (3):
  send-email: move newline character out of a translatable string
  send-email: make it easy to discern the messages for each patch
  send-email: separate the confirmation prompts from the messages

 git-send-email.perl | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

