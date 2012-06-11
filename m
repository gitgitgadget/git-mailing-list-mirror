From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2] Warnings before rebasing -i published history
Date: Mon, 11 Jun 2012 12:55:54 +0200
Message-ID: <vpq1ulm86dh.fsf@bauges.imag.fr>
References: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1339409091-28150-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 11 12:56:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se2Hz-0006Jn-2p
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 12:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806Ab2FKKz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 06:55:58 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36857 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451Ab2FKKz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 06:55:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5BAl2QV016698
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2012 12:47:02 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Se2Hr-0000Kb-Hg; Mon, 11 Jun 2012 12:55:55 +0200
In-Reply-To: <1339409091-28150-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	(Lucien Kong's message of "Mon, 11 Jun 2012 12:04:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 11 Jun 2012 12:47:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5BAl2QV016698
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340016422.65352@xZ29yuY4sDlcvd8WNhjViw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199642>

Lucien Kong <Lucien.Kong@ensimag.imag.fr> writes:

> "git rebase -i" can be very dangerous if used on an already published
> history. This code detects that one is rewriting a commit that is an
> ancestor of a remote-tracking branch, and warns the user through the
> editor. This feature is controlled by a new config key
> rebase.checkremoterefs.

For the lazy, you could provide an example of result in the commit
message. People don't want to review how the patch is written if they
disagree with the result.

> +		two_sha1=$(echo "$tmp" | sed -n 1p) &&
> +		three_sha1=$(echo "$tmp" | sed -n 2p) &&
> +		four_sha1=$(echo "$tmp" | sed -n 3p) &&

IIRC, the test suite was made to give reproducible sha1, so you
shouldn't need these.

> +		echo "pick $two_sha1 two_commit" >expected &&
> +		echo "# Commit above this line appear in: origin/master" >>expected &&
> +		echo "pick $three_sha1 three_commit" >>expected &&
> +		echo "# Commit above this line appear in: origin/master" >>expected &&
> +		echo "pick $four_sha1 four_commit" >>expected &&
> +		test_cmp expected actual

You don't want to repeat "Commit above this line" for each commit. What
I meant in my previous suggestion was

pick foo
pick bar
# Commits above this line appear in origin/master
pick boz

i.e. just show where the remote points once.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
