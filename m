From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/8] git-rebase.sh: Fix --merge --abort failures when
 path contains whitespace
Date: Wed, 09 Apr 2008 08:55:31 +0200
Message-ID: <47FC6863.8070704@viscovery.net>
References: <> <cover.1207702130.git.bdonlan@fushizen.net> <1207704604-30393-1-git-send-email-bdonlan@fushizen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	gitster@pobox.com
To: Bryan Donlan <bdonlan@fushizen.net>
X-From: git-owner@vger.kernel.org Wed Apr 09 08:56:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjUEG-0003ch-7e
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 08:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbYDIGzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 02:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbYDIGzg
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 02:55:36 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8275 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbYDIGzg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 02:55:36 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JjUDT-0005bI-Qt; Wed, 09 Apr 2008 08:55:32 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9550D546; Wed,  9 Apr 2008 08:55:31 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1207704604-30393-1-git-send-email-bdonlan@fushizen.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79082>

Bryan Donlan schrieb:
> -dotest=$GIT_DIR/.dotest-merge
> +dotest="$GIT_DIR/.dotest-merge"

This is not strictly necessary: The RHS expression of an assignment does
not undergo IFS splitting; but better safe than sorry. (But note that
'export foo=$bar', which is not POSIX, is *not* an assignment, and
different shells that support this construct treat it differently.)

> +### Test that we handle strange characters properly
> +work_dir="$(pwd)/test \" ' \$ \\ dir"

In effect, you modify only this test to stress-test strange characters,
but other tests in the test suite still run in a "sane" environment. IOW,
I don't think you should go to this extreme for this one test only. The
better approach would be to rename 'trash' in test-lib.sh to this strange
name so that all tests suffer from a challenging environment.

> -		git reset --hard pre-rebase
> -		test_must_fail git rebase'"$type"' master &&
> -		test -d '$dotest' &&
> +		git reset --hard pre-rebase &&
> +		test_must_fail git rebase$type master &&
> +		test -d \"\$dotest\" &&

I could imagine that the missing && after the git reset is deliberate. Mike?

> +		git reset --hard pre-rebase &&

Ditto.

Apart from that, this looks good.

-- Hannes
