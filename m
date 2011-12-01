From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/5] Bulk Check-in
Date: Wed, 30 Nov 2011 16:27:38 -0800
Message-ID: <1322699263-14475-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 01:27:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVuVF-0003qv-Nl
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 01:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253Ab1LAA1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 19:27:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64840 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599Ab1LAA1q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 19:27:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0FC95D7F
	for <git@vger.kernel.org>; Wed, 30 Nov 2011 19:27:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=gfF8yTjn1RvwxEJLzu4hCQpgCAo
	=; b=eaqeuF3klaBdVFmjwT6oP/4DDLoYELAbDnYUfJpiNCCKXBJRlwDCgFMneCA
	M25vU51KH4XzWoaEY1sgqM0df0OrWrVX/nmpFuhLyICZHBEFPXxbYHzDilQKou0t
	8A0yr3dr0zjDVV0604dPtuefFp0fOMYT09I4QA2drveyzVF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=k8YSP4TM5Wyley44j7eLl+I7+D6WA
	hXU78azhJSmTjwqWMULyOuLZGjCbgKr3I0hLi9AQD+nbY9+MimfSjdaIjLmBNV9a
	YZ/9Hn+g/fsznnd9PxXGpFXAb2vIiTS4qDjYxLP34hrzevHny+dOLkY2otI4Joeu
	KQii+6kU4to3lI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6DF25D7E
	for <git@vger.kernel.org>; Wed, 30 Nov 2011 19:27:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 273575D7C for
 <git@vger.kernel.org>; Wed, 30 Nov 2011 19:27:45 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc4.177.g4d64
X-Pobox-Relay-ID: 49F4F70E-1BB3-11E1-8B39-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186146>

This is a re-roll of the earlier bulk-check-in series. The only change is
that the last one is a bit re-structured to pay attention to the packsize
limit from the get-go and also not write objects that already exist in the
repository, instead of "oops, I forgot to do that, and here is a fix".

Junio C Hamano (5):
  write_pack_header(): a helper function
  create_tmp_packfile(): a helper function
  finish_tmp_packfile(): a helper function
  csum-file: introduce sha1file_checkpoint
  bulk-checkin: replace fast-import based implementation

 Makefile               |    2 +
 builtin/add.c          |    5 +
 builtin/pack-objects.c |   62 +++--------
 bulk-checkin.c         |  275 ++++++++++++++++++++++++++++++++++++++++++++++++
 bulk-checkin.h         |   16 +++
 cache.h                |    2 +
 config.c               |    4 +
 csum-file.c            |   20 ++++
 csum-file.h            |    9 ++
 environment.c          |    1 +
 fast-import.c          |   25 ++---
 pack-write.c           |   53 +++++++++
 pack.h                 |    6 +
 sha1_file.c            |   67 +-----------
 t/t1050-large.sh       |   94 +++++++++++++++--
 zlib.c                 |    9 ++-
 16 files changed, 516 insertions(+), 134 deletions(-)
 create mode 100644 bulk-checkin.c
 create mode 100644 bulk-checkin.h

-- 
1.7.8.rc4.177.g4d64
