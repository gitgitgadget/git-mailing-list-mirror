From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] git-remote-mediawiki: bugfix for pages w/ >500 revisions
Date: Mon, 23 Sep 2013 16:17:46 -0400
Message-ID: <CAPig+cSVeJX2wHo7TTJe2oa+_pD7EPdmMo_BGO_Bj-ZKgRD6wA@mail.gmail.com>
References: <1379957175-8606-1-git-send-email-benoit.person@gmail.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Benoit Person <benoit.person@gmail.fr>
To: Benoit Person <benoit.person@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 23 22:17:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOCZu-0005AM-5D
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 22:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657Ab3IWURt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 16:17:49 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:54270 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653Ab3IWURs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 16:17:48 -0400
Received: by mail-la0-f52.google.com with SMTP id ev20so2826941lab.39
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 13:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VWJSHDrcMAYx5bnBvOvAzSS+dBLPP0+hoxE0T56ZLWg=;
        b=e7MAFOOtDKR4+Vkh/YBrVgVSthbgaJnifTu5dp3f04s4f1+H/TB+fGrGdVqvUvH2+J
         AXhV9ZigJzdi3LCS40GBWfowyw23WZFl2c/XfI9QDV8N24g55su+qz38Gg0G62iewcg/
         mGOJMKLQ9tEUaUrv+Lko5pmgcJb0BS/pL22Rz3cW53O2IL5oNf0j5CLmR8Ne1YDqkZP7
         o4sdP7ipYWNBckYCjflLHcVEj6LmBU/X2ssShXhClEoHrXDlaYeAhgTHt2yWU76srjub
         xKvQzWJXnpVXueqMvw/2rL7wLHJhbNNT0uZV/6FOy/p51eU9qXmoGgJkkdL7AZoVNluK
         rsYA==
X-Received: by 10.112.158.225 with SMTP id wx1mr2723649lbb.37.1379967466938;
 Mon, 23 Sep 2013 13:17:46 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Mon, 23 Sep 2013 13:17:46 -0700 (PDT)
In-Reply-To: <1379957175-8606-1-git-send-email-benoit.person@gmail.fr>
X-Google-Sender-Auth: b0SIRZ14RCcwi-kTgPmudEn5c08
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235239>

On Mon, Sep 23, 2013 at 1:26 PM, Benoit Person <benoit.person@gmail.com> wrote:
> diff --git a/contrib/mw-to-git/t/t9365-continuing-queries.sh b/contrib/mw-to-git/t/t9365-continuing-queries.sh
> new file mode 100755
> index 0000000..6fb5df4
> --- /dev/null
> +++ b/contrib/mw-to-git/t/t9365-continuing-queries.sh
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +
> +test_description='Test the Git Mediawiki remote helper: queries w/ more than 500 results'
> +
> +. ./test-gitmw-lib.sh
> +. ./push-pull-tests.sh
> +. $TEST_DIRECTORY/test-lib.sh
> +
> +test_check_precond
> +
> +test_expect_success 'creating page w/ >500 revisions' '
> +       wiki_reset &&
> +       for i in $(seq 1 501)

s/seq/test_seq/

d17cf5f3a32f07bf (tests: Introduce test_seq;  2012-08-03)

> +       do
> +               echo "creating revision $i"

Do you want to end this line with '&&'?

> +               wiki_editpage foo "revision $i<br/>" true
> +       done
> +'
> +
> +test_expect_success 'cloning page w/ >500 revisions' '
> +       git clone mediawiki::'"$WIKI_URL"' mw_dir
> +'
> +
> +test_done
> --
