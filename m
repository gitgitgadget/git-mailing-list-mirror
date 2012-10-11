From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: Rebase doesn't restore branch pointer back on out of memory
Date: Wed, 10 Oct 2012 23:54:02 -0400
Message-ID: <1349927643-7195-1-git-send-email-andrew.kw.w@gmail.com>
References: <7vtxu4io7o.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, alex.kostikov@gmail.com,
	Andrew Wong <andrew.kw.w@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 11 05:54:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM9qq-0003Hk-3C
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 05:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933148Ab2JKDyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 23:54:13 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:63300 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385Ab2JKDyM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 23:54:12 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so923010iag.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 20:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=eCmELxEWQpZcdLAqov57gjh3vkL80+Kw1kN4rI/jgzU=;
        b=PQW2f7Ownl+e4U4hY1sJEWqH4ruQ4h+mp7Wwb7xBvdA3U6USuzIjilshuJ9FbpNBXQ
         1W1vhLZkF/D6opG6ZUtqxX4swcAFk5cNGZEoaDzv9sbS6M3dg1tWhzsEjvMwqJ0S4ny5
         274Mb18UwbpLWVreZjzkiu0m/Dh8ow4dJwtyltDxfCxV8Y/i/bX7hmPD9TbAcrFF8BfG
         PwpVq620TPv702Y++Dv3wcIC05DPf3H88aJyL8s/tgAOc7GrQUBpllSDKkreyk+VJFmJ
         0++6iSzWSKm3+5+Q2ZWdx5WOpTTXZbqhvUmADQUAeIbV1NSmU7P3LkwuERGabYvUU+57
         a67w==
Received: by 10.50.45.226 with SMTP id q2mr7466316igm.56.1349927652218;
        Wed, 10 Oct 2012 20:54:12 -0700 (PDT)
Received: from localhost.localdomain ([69.165.255.59])
        by mx.google.com with ESMTPS id bg2sm7675702igb.1.2012.10.10.20.54.09
        (version=SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 20:54:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc0.19.gc58a63a.dirty
In-Reply-To: <7vtxu4io7o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207460>

For the 'format-patch' part, originally I was going to do something like:

	git format-patch ... || {
		...
	}

But later I thought it's better to use a consistent style as the following
'am' part.

For the 'am' part, if we kept the following line at the end of the if-block:

	fi && move_to_original_branch

then, before exiting the if-block, we would have to do something like:

	test 0 != $ret && false

which seems a bit ugly to me. So I removed the use of '&&', and rearrange the
'write_basic_state' and 'move_to_original_branch' to make the logic flow a bit
better and easier to read.

Andrew Wong (1):
  rebase: Handle cases where format-patch fails

 git-rebase--am.sh | 51 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 6 deletions(-)

-- 
1.8.0.rc0.19.gc58a63a.dirty
