From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/4] status: allow label strings to be translated
Date: Wed, 12 Mar 2014 14:19:30 -0700
Message-ID: <1394659174-9143-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 22:19:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNqYx-0001pU-Hg
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 22:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbaCLVTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 17:19:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64991 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299AbaCLVTi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 17:19:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9260974970;
	Wed, 12 Mar 2014 17:19:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=MU5tvW8HxiS3yknxFaVHFx7nZtw
	=; b=pjSNxrcweUxJxHSeKb4S5q28Anhsc5qi1GzIa3vGVSt7EYSN+1VYe5TNeRA
	a/sjEn9GAVA6HzBHcJkd3KRMZzufnefE1jvqhJ3MrPz4Evw6WRXnv/SZRw2/K9u7
	7SZdYB+C8u7+9Wiof8z6312f/frIb2+KVU0KfMvmSYc7ZuSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=BEztJ6v+7iRCSEsDPMebkPdsA6JPx
	KyNx6U6lXDr1WEcW9urR71TpdFrrETJ48A0HfYyEMPSI0E+dWueeEvzPGjk8yuaw
	PqNzLXbUm/ueTdh+aaTfo4V7RRORYZ8L41mdUlSeZi61F9ffzt793pGLmydiheAG
	nymRrA+RFgkrg4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CAFE7496F;
	Wed, 12 Mar 2014 17:19:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4B507496D;
	Wed, 12 Mar 2014 17:19:36 -0400 (EDT)
X-Mailer: git-send-email 1.9.0-293-gd838d6f
X-Pobox-Relay-ID: 03AC540E-AA2C-11E3-9290-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243995>

So here is my attempt to clean-up what Jonathan posted in
$gmane/239537 as "how about this?" patch.

The first one (full label string) fixes up 3651e45c (wt-status: take
the alignment burden off translators, 2013-11-05) to include colon
back to translatable string again, while retaining its label alignment
logic.

The second (extract the code) is taken from Jonathan's $gmane/239537
as a separate patch.

The third is essentially the remainder of Jonathan's $gmane/239537,
with one small fix s/strlen/utf8_width/; to teach the code that
shows unmerged paths the same label alignment logic Duy added in
3651e45c for the tracked paths, while retaining the "at least 20
columns" floor to avoid the churn to the tests.

And the last lifts the "at least 20 columns" floor.

Jonathan Nieder (2):
  wt-status: extract the code to compute width for labels
  wt-status: i18n of section labels

Junio C Hamano (2):
  wt-status: make full label string to be subject to l10n
  wt-status: lift the artificual "at least 20 columns" floor

 t/t7060-wtstatus.sh    |  14 +++---
 t/t7512-status-help.sh |  12 ++---
 wt-status.c            | 117 +++++++++++++++++++++++++++++++------------------
 3 files changed, 88 insertions(+), 55 deletions(-)

-- 
1.9.0-293-gd838d6f
