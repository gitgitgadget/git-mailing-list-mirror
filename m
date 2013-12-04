From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Teaching "git push" to map pushed refs
Date: Tue,  3 Dec 2013 16:39:51 -0800
Message-ID: <1386117594-22062-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 01:40:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo0VY-00055C-2v
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 01:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab3LDAkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 19:40:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64786 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754361Ab3LDAj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 19:39:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D60358EEB
	for <git@vger.kernel.org>; Tue,  3 Dec 2013 19:39:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=8y7vhM+6vtO/SS7D+oF2DvazVA4
	=; b=MKRUkFJp/2x72o6hdEiry/Y6xbIPqzojTw0I2W9R2rwsZThBXZRRiY0i65Q
	+ZxvGPHsRDk8B+x+0UovngHeWmqW2ldCaO0DgKNNjQHITtdeBoFnHlS6lTuk2gpV
	myfOn9hi1c0f2tIRjTemC9Ffa2R1Jbd0rnGR/yr9Bh57myKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=woAYx/kZxbRF33oADNfe79AZDJL5B
	RE+3WVP5qykITDN8Hlq9wZp4/7Xe6Q1k9Gh/Sb6uR5s5crxZDhwl2JU2GznnKbXL
	xJu3m0bnm7xaJg8OJ+U0rL5tWdmR5YiZAEawWar9tYu6BKDC+7RCpguyR+7uKCoy
	rXW1AR6E7h4Zhc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DE0458EEA
	for <git@vger.kernel.org>; Tue,  3 Dec 2013 19:39:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C92C58EE7
	for <git@vger.kernel.org>; Tue,  3 Dec 2013 19:39:57 -0500 (EST)
X-Mailer: git-send-email 1.8.5.1-400-gbc1da41
X-Pobox-Relay-ID: 99AC9DAE-5C7C-11E3-B8E9-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238744>

Earlier, Peff taught "git fetch origin master" to update a
remote-tracking branch by internally mapping the colon-less refspec
'master' to '+refs/heads/master:refs/remotes/origin/master'.  Both

	git fetch origin
	git fetch origin master

would update the same refs/remotes/origin/master, which avoids
surprises.

However, we did not have a similar refspec mapping on the push
side.  This three-patch series does just that, and would help
triangular workflow by making these two:

	git checkout master && git push origin
	git push origin master

update the same ref at the 'origin'.

Junio C Hamano (3):
  builtin/push.c: use strbuf instead of manual allocation
  push: use remote.$name.push as a refmap
  push: also use "upstream" mapping when pushing a single ref

 Documentation/git-push.txt |  9 ++++--
 builtin/push.c             | 79 ++++++++++++++++++++++++++++++++--------------
 remote.c                   |  8 ++---
 remote.h                   |  2 ++
 t/t5516-fetch-push.sh      | 75 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 144 insertions(+), 29 deletions(-)

-- 
1.8.5.1-400-gbc1da41
