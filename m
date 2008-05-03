From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH v2 0/5] Make boundary characters for --color-words configurable
Date: Sat,  3 May 2008 19:57:03 +0800
Message-ID: <1209815828-6548-1-git-send-email-pkufranky@gmail.com>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 13:58:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsGNa-0004et-0R
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 13:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbYECL5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 07:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752983AbYECL5T
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 07:57:19 -0400
Received: from mail.qikoo.org ([60.28.205.235]:41306 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754236AbYECL5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 07:57:16 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 40817470AE; Sat,  3 May 2008 19:57:08 +0800 (CST)
X-Mailer: git-send-email 1.5.5.1.121.g26b3
In-Reply-To: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81068>

Ping Yin (5):
      diff.c: Remove code redundancy in diff_words_show
      diff.c: Use show variable name in fn_out_diff_words_aux
      diff.c: Fix --color-words showing trailing deleted words at another line
      Make boundary characters for --color-words configurable
      fn_out_diff_words_aux: Handle common diff line more carefully

 Documentation/config.txt       |    4 ++
 Documentation/diff-options.txt |    1 +
 diff.c                         |   83 +++++++++++++++++++++++++++-------------
 3 files changed, 61 insertions(+), 27 deletions(-)

The first two patches are just code refactor

The 3rd patch fixes following problem 2
The 4th patch introduces diff.nonwordchars
The 5th patch fixes following problem 1

> Oh, there are some problems, assuming "{}" are set as diff.nonwordchars
> 
> 1. Trailing boundary character lost, for example
> ----------------------------
> $ git diff-
> - foo{
> + foo
> $ git diff --color-words
> foo
> ----------------------------
> With --color-words,  i can't know the trailing '{' is removed. This
> problem exists even without my patch. In that case, only trainling
> spaces are  lost.
> 
> 2. Trailing removed words shows at new line instead of the same line
> ----------------------------
> $ git diff
> - foo bar
> + foo
> (note: no space after foo)
> $ git diff --color-words
> foo
> <red>bar</red>
> --------------------------------
> bar should show in the same line with bar. This is not related to my patch.
