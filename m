From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH 0/2] Commits with ancient timestamps
Date: Thu,  2 Feb 2012 13:41:41 -0800
Message-ID: <1328218903-5681-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 22:41:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt4Ph-0007Fx-O4
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 22:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757459Ab2BBVls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 16:41:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65336 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757339Ab2BBVlq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 16:41:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 347906467;
	Thu,  2 Feb 2012 16:41:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=dDGYO9oj2YusnirBvrKNqaVAL6w
	=; b=kz8hpjBSp8BhMXloUJGs6HSF2rbtuCc/3hszC9+F1/c6FtcxlVtpquRU+II
	tNqHTYQiK8Ao/FNWP1qz7kLENUNtOB4ls9FNW9BgOYi5QA0ujd3s98jSVINIVmnI
	uThD5LA2q8DGErxxP+7GyVhP5aK7FDm8tKZPFi6BRcqxVgrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=I2SqYT6xpVmju2lmMJkiOphDy+16T
	2lvtH8ot+OLIiNPzGpDzNjR80si7kzOBmLoxOc9zefS/FIW+y93jQOrrqKNJBWMv
	2jh67B3Rtk/aAU3TiG25lLQOg9auWwamzlKjB2BVd9MrxBx3ht7rcu0gHW9ddP7A
	ADFKrWUtLKFJ+Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B63E6465;
	Thu,  2 Feb 2012 16:41:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E68D6461; Thu,  2 Feb 2012
 16:41:44 -0500 (EST)
X-Mailer: git-send-email 1.7.9.172.ge26ae
X-Pobox-Relay-ID: B3778C90-4DE6-11E1-BF1E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189711>

Result of conversion of ancient history from other SCMs, and output from
other third-party tools, can record timestamps that predates inception of
Git. They can cause "git am", "git rebase" and "git commit --amend" to
misbehave, because the raw git timestamp e.g.

	author <a.u.thor@example.com> 1328214896 -0800

are read from the commit object and passed to parse_date() machinery,
which rejects raw git timestamps without sufficient number of digits to
avoid misinterpreting human-written timestamp in other formats, and
timestamps before 1975 do not have enough number of digits in them.

Here is a two-patch series that may improve the situation.

Note that this is not meant for direct application, unless somebody uses
this extensively to make sure there is no regression.


Junio C Hamano (2):
  parse_date(): allow ancient timestamps in in-header format
  parse_date(): '@' prefix forces git-timestamp interpretation

 date.c          |   30 ++++++++++++++++++++++++++++++
 git-sh-setup.sh |    2 +-
 2 files changed, 31 insertions(+), 1 deletions(-)

-- 
1.7.9.172.ge26ae
