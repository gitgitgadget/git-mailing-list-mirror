From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7502-commit.sh: test_must_fail doesn't work with	inline
 environment variables
Date: Thu, 19 Jun 2008 11:40:06 -0700
Message-ID: <7vd4mduv3t.fsf@gitster.siamese.dyndns.org>
References: <JvISWq5uUteLVQOl-3QkroLV8SsQufGuWrfseMUjpYY@cipher.nrlssc.navy.mil>
 <20080619173932.GA32593@glandium.org>
 <gASAIyn4TvarEmVo9rWtEKa6eROfKXwowHxH6j05FzPARJ-CDBCHLw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jun 19 20:41:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9P4d-0007u1-R6
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 20:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755772AbYFSSk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 14:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755666AbYFSSk1
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 14:40:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511AbYFSSk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 14:40:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 15DF71B7E5;
	Thu, 19 Jun 2008 14:40:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 320421B7E2; Thu, 19 Jun 2008 14:40:13 -0400 (EDT)
In-Reply-To: <gASAIyn4TvarEmVo9rWtEKa6eROfKXwowHxH6j05FzPARJ-CDBCHLw@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Thu, 19 Jun 2008 12:44:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2BD50B3E-3E2F-11DD-AEA4-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85509>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Mike Hommey wrote:
>> On Thu, Jun 19, 2008 at 12:32:02PM -0500, Brandon Casey wrote:
>>> -	test_must_fail GIT_EDITOR="$(pwd)/.git/FAKE_EDITOR" git commit &&
>>> +	# We intentionally do not use test_must_fail on the next line since the
>>> +	# mechanism does not work when setting environment variables inline
>>> +	! GIT_EDITOR="$(pwd)/.git/FAKE_EDITOR" git commit &&
>> 
>> Doesn't GIT_EDITOR="$(pwd)/.git/FAKE_EDITOR" test_must_fail git commit
>> work ?
>
> That leaves GIT_EDITOR set to the new value after the command completes.
>
> -brandon

A Subshell?

@@ -212,6 +212,7 @@ test_expect_success 'do not fire
 	# Must fail due to conflict
 	test_must_fail git cherry-pick -n master &&
 	echo "editor not started" >.git/result &&
-	test_must_fail GIT_EDITOR="$(pwd)/.git/FAKE_EDITOR" git commit &&
+	( GIT_EDITOR="$(pwd)/.git/FAKE_EDITOR" && export GIT_EDITOR &&
+	  test_must_fail git commit ) &&
 	test "$(cat .git/result)" = "editor not started"
 '
